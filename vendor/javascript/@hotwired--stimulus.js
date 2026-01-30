// Simplified Stimulus core - compatible with importmap
// Based on @hotwired/stimulus v3.2.2

class Controller {
  constructor(context) {
    this.context = context
  }

  get application() {
    return this.context.application
  }

  get scope() {
    return this.context.scope
  }

  get element() {
    return this.scope.element
  }

  get identifier() {
    return this.scope.identifier
  }

  initialize() {}
  connect() {}
  disconnect() {}

  dispatch(eventName, { target = this.element, detail = {}, prefix = this.identifier, bubbles = true, cancelable = true } = {}) {
    const type = prefix ? `${prefix}:${eventName}` : eventName
    const event = new CustomEvent(type, { detail, bubbles, cancelable })
    target.dispatchEvent(event)
    return event
  }
}

class Application {
  constructor() {
    this.controllers = new Map()
    this.debug = false
    this.started = false
  }

  static start() {
    return new Application().start()
  }

  start() {
    if (!this.started) {
      this.started = true
      this.scanForControllers()
      
      // Watch for new elements
      const observer = new MutationObserver(() => this.scanForControllers())
      observer.observe(document.documentElement, {
        childList: true,
        subtree: true,
        attributes: true,
        attributeFilter: ['data-controller']
      })
    }
    return this
  }

  register(identifier, controllerConstructor) {
    this.controllers.set(identifier, controllerConstructor)
    if (this.started) {
      this.scanForControllers()
    }
  }

  scanForControllers() {
    const elements = document.querySelectorAll('[data-controller]')
    
    elements.forEach(element => {
      const identifiers = (element.getAttribute('data-controller') || '').split(' ')
      
      identifiers.forEach(identifier => {
        identifier = identifier.trim()
        if (!identifier) return
        
        const controllerConstructor = this.controllers.get(identifier)
        if (!controllerConstructor) {
          if (this.debug) {
            console.warn(`Controller "${identifier}" not registered`)
          }
          return
        }

        // Check if already connected
        if (element.__stimulusControllers && element.__stimulusControllers[identifier]) {
          return
        }

        const context = {
          application: this,
          scope: {
            element,
            identifier
          }
        }

        const controller = new controllerConstructor(context)
        
        // Store controller instance
        if (!element.__stimulusControllers) {
          element.__stimulusControllers = {}
        }
        element.__stimulusControllers[identifier] = controller

        // Setup values
        if (controllerConstructor.values) {
          Object.keys(controllerConstructor.values).forEach(key => {
            const attr = `data-${identifier}-${key.replace(/([A-Z])/g, '-$1').toLowerCase()}-value`
            const value = element.getAttribute(attr)
            if (value !== null) {
              const type = controllerConstructor.values[key]
              let parsed = value
              if (type === Number) parsed = Number(value)
              if (type === Boolean) parsed = value === 'true'
              if (type === Object || type === Array) {
                try { parsed = JSON.parse(value) } catch(e) {}
              }
              controller[`${key}Value`] = parsed
            }
          })
        }

        // Setup actions
        element.querySelectorAll('[data-action]').forEach(actionElement => {
          const actions = actionElement.getAttribute('data-action').split(' ')
          actions.forEach(action => {
            const [event, handler] = action.includes('->') 
              ? action.split('->') 
              : ['click', action]
            
            const [targetIdentifier, method] = handler.includes('#')
              ? handler.split('#')
              : [identifier, handler]

            if (targetIdentifier === identifier && controller[method]) {
              actionElement.addEventListener(event, (e) => {
                controller[method](e)
              })
            }
          })
        })

        // Initialize and connect
        if (controller.initialize) controller.initialize()
        if (controller.connect) controller.connect()

        if (this.debug) {
          console.log(`[Stimulus] ${identifier} controller connected`, element)
        }
      })
    })
  }
}

const application = {
  start() {
    return new Application().start()
  }
}

export { Application, Controller, application as default }

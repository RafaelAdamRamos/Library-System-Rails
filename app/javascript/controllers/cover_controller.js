// app/javascript/controllers/cover_controller.js
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cover"
export default class extends Controller {
  static targets = ["result"]
  
  connect() {
    console.log("✅ Cover controller conectado")
    this.coverUrl = null
  }

  async search() {
    console.log("✅ search() executado")
    
    const title = document.getElementById("book_title")?.value
    const author = document.getElementById("book_author")?.value
    const publisher = document.getElementById("book_publisher")?.value

    if (!title) {
      alert("Informe o título do livro")
      return
    }

    try {
      const response = await fetch(
        `/books/search_cover?title=${encodeURIComponent(title)}&author=${encodeURIComponent(author || '')}&publisher=${encodeURIComponent(publisher || '')}`
      )

      const data = await response.json()

      if (!data.cover_url) {
        alert("Nenhuma capa encontrada")
        return
      }

      // Armazena a URL da capa
      this.coverUrl = data.cover_url

      // Mostra preview
      const preview = document.getElementById("cover-preview")
      const img = document.getElementById("cover-image")
      
      img.src = this.coverUrl
      preview.style.display = "block"
      
    } catch (error) {
      console.error("Erro ao buscar capa:", error)
      alert("Erro ao buscar capa. Tente novamente.")
    }
  }

  async apply() {
    if (!this.coverUrl) {
      alert("Nenhuma capa selecionada")
      return
    }

    try {
      // Usa o proxy do Rails para baixar a imagem e evitar CORS
      const response = await fetch(`/books/proxy_image?url=${encodeURIComponent(this.coverUrl)}`)
      const data = await response.json()
      
      if (data.error) {
        throw new Error(data.error)
      }
      
      // Converte base64 em blob
      const base64Data = data.data.split(',')[1]
      const byteCharacters = atob(base64Data)
      const byteNumbers = new Array(byteCharacters.length)
      
      for (let i = 0; i < byteCharacters.length; i++) {
        byteNumbers[i] = byteCharacters.charCodeAt(i)
      }
      
      const byteArray = new Uint8Array(byteNumbers)
      const blob = new Blob([byteArray], { type: 'image/jpeg' })
      
      // Cria um arquivo a partir do blob
      const file = new File([blob], "cover.jpg", { type: "image/jpeg" })
      
      // Cria um DataTransfer para simular upload
      const dataTransfer = new DataTransfer()
      dataTransfer.items.add(file)
      
      // Aplica o arquivo no input file
      const fileInput = document.getElementById("book_cover")
      fileInput.files = dataTransfer.files
      
      // Esconde o preview
      document.getElementById("cover-preview").style.display = "none"
      
      alert("Capa aplicada! Clique em 'Create Book' para salvar.")
      
    } catch (error) {
      console.error("Erro ao aplicar capa:", error)
      alert("Erro ao aplicar capa. Tente novamente.")
    }
  }
}

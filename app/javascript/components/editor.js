import EditorJS from '@editorjs/editorjs';
import Header from '@editorjs/header';
import ImageTool from '@editorjs/image';
import Table from '@editorjs/table';

document.addEventListener('turbolinks:load', () => {
  let editorElement = document.getElementById('editorjs');

  if (editorElement) {

    let data = editorElement.dataset.jsonData || '{}';
    let id = editorElement.dataset.id;

    const editor = new EditorJS({
      holder: 'editorjs',
      data: JSON.parse(data),
      tools: {
        header: {
          class: Header,
          config: {
            placeholder: 'Header',
            levels: [2, 3, 4],
            defaultLevel: 3
          }
        },
        image: {
          class: ImageTool,
          config: {
            endpoints: {
              byFile: 'uploadFile', // Your backend file uploader endpoint
              byUrl: 'uploadUrl' // Your endpoint that provides uploading by Url
            }
          }
        },
        table: {
          class: Table,
          inlineToolbar: true,
          config: {
            rows: 2,
            cols: 3
          }
        }
      }
    })

  }
})

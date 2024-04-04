import { Controller } from '@hotwired/stimulus'
import Sortable from 'sortablejs'

export default class extends Controller {
  connect() {
    console.log('sortable connected')
    this.sortableUrl = this.data.get('url')
    this.sortableHandle = this.data.get('handle') || '.cursor-move'
    this.sortableDirection = this.data.get('direction') || 'vertical'
    this.sortable()
  }

  disconnect() { }

  sortable() {
    new Sortable(this.element, {
      animation: 150,
      direction: 'vertical',
      handle: this.sortableHandle,

      onUpdate: event => this._onUpdate(event)
      // onChange: (event) => this._onChange(event)
    })
  }

  _onChange(event) {
    console.log('sortable changed')
  }

  _onUpdate(event) {
    const url = this.data.get('url')
    var el = event.item // dragged HTMLElement
    // console.log(event.to);    // target list
    // console.log(event.from);  // previous list
    // console.log(event.oldIndex);  // element's old index within old parent
    // console.log(event.newIndex);  // element's new index within new parent
    // console.log(event.oldDraggableIndex); // element's old index within old parent, only counting draggable elements
    // console.log(event.newDraggableIndex); //

    const sendingID = el.dataset.id
    const position = event.newIndex
    const data = { item: { send: sendingID, position: position } }

    $.ajax({
      url: url,
      type: 'post',
      dataType: 'script',
      data: data,
      // beforeSend: () => this._beforeSend(),
      success: response => this._success(response),
      error: response => this._error(response)
    })
  }

  _success(response) {
    console.log('Items sorted')
  }

  _error(response) {
    console.log("failed sorting item")
  }
}

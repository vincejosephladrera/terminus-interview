import { Controller } from '@hotwired/stimulus';
import debounce from 'debounce';
// Connects to data-controller="table"
export default class extends Controller {
	initialize() {
		this.submitFilter = debounce(this.submitFilter.bind(this), 300);
	}

	submitFilter() {
		this.element.requestSubmit();
	}

	sortByColumn(e) {
		const clickedBtn = e.currentTarget;
		const orderByField = document.querySelector('[data-order-by]');
		orderByField.value = clickedBtn.value;
	}
}

<template>
	<div class="relative flex flex-col min-w-0 break-words w-full shadow-lg rounded bg-white">
		<div class="rounded-t bg-white mb-0 px-6 py-6">
			<div class="text-center flex justify-between">
				<h6 class="text-gray-800 text-xl font-bold">{{ title }}</h6>
				<form 
					id="search-input-container"
					class="shadow flex"
					@submit.prevent="clickSearchButton"
				>
					<input id="search-input" type="search" class="w-full rounded p-2" v-model="searchInput" :placeholder="lang['search_data']">
					<button 
						type="submit"
						class=" w-auto flex justify-end items-center text-blue p-2 hover:text-blue-light"
					>
						<i class="fas fa-search"></i>
					</button>
				</form>
				<div class="actions">
					<button v-for="(button, index) in customButtons"
						:key="index"
						class="bg-green-500 text-white active:bg-green-600 font-bold uppercase text-xs px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-none mr-1 mb-1 ease-linear transition-all duration-150"
						@click="button.onclick"
					>
						<i class="material-icons">{{ button.icon }}</i>
					</button>
					
					<button v-if="printable"
						class="bg-green-500 text-white active:bg-green-600 font-bold uppercase text-xs px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-none mr-1 mb-1 ease-linear transition-all duration-150"
						@click="print"
					>
						<i class="fas fa-print"></i>
					</button>
					<button v-if="exportable"
						class="bg-green-500 text-white active:bg-green-600 font-bold uppercase text-xs px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-none mr-1 mb-1 ease-linear transition-all duration-150"
						@click="exportExcel"
					>
						<i class="fas fa-file-excel"></i>
					</button>
					<button
					class="bg-green-500 text-white active:bg-green-600 font-bold uppercase text-xs px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-none mr-1 ease-linear transition-all duration-150"
					type="button"
					>
						<i class="fas fa-plus"></i> Create New
					</button>
				</div>
			</div>
		</div>
		<div class="block w-full overflow-x-auto">
		<table class="items-center w-full bg-transparent border-collapse" ref="table">
			<thead>
				<tr>
					<th
						class="px-6 align-middle border border-solid py-3 text-xs uppercase border-l-0 border-r-0 whitespace-no-wrap font-semibold text-left bg-gray-100 text-gray-600 border-gray-200"
						v-for="(column, index) in columns"
						:key="index"
						:class="(sortable ? 'sorting ' : '')
							+ (sortColumn === index ?
								(sortType === 'desc' ? 'sorting-desc' : 'sorting-asc')
								: '')
							+ (column.numeric ? ' numeric' : '')"
						:style="{width: column.width ? column.width : 'auto'}"
						@click="sort(index)"
					>
						{{ column.label }}
					</th>
					<slot name="thead-tr" />
				</tr>
			</thead>

			<tbody>
				<tr v-for="(row, index) in paginated"
					:key="index"
					:class="{ clickable : clickable }"
					@click="click(row)"
				>
					<td
						class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-no-wrap p-4"
						v-for="(column, columnIndex) in columns"
						:key="columnIndex"
						:class="{ numeric : column.numeric }"
					>
						<div v-if="!column.html">
							{{ collect(row, column.field) }}
						</div>
						<div v-if="column.html" v-html="collect(row, column.field)" />
					</td>
					<slot name="tbody-tr" :row="row" />
				</tr>

				<template v-if="rows.length === 0 && loadingAnimation === true">
					<tr v-for="n in (currentPerPage === -1 ? 10 : currentPerPage)"
						:key="n"
					>
						<td :colspan="columns.length">
							<tb-skeleton :height="15" theme="opacity" bg-color="#dcdbdc" shape="radius" />
						</td>
					</tr>
				</template>
			</tbody>
		</table>
				<div v-if="paginate" class="table-footer">
			<div :class="{'datatable-length': true, 'rtl': lang.__is_rtl}">
				<label>
					<span>{{ lang['rows_per_page'] }}:</span>
					<select class="browser-default" @change="onTableLength">
						<option v-for="(option, index) in perPageOptions"
							:key="index"
							:value="option"
							:selected="option == currentPerPage"
						>
							{{ option === -1 ? lang['all'] : option }}
						</option>
					</select>
				</label>
			</div>
			<div :class="{'datatable-info': true, 'rtl': lang.__is_rtl}">
				<span>{{ (currentPage - 1) * currentPerPage ? (currentPage - 1) * currentPerPage : 1 }}
					-{{ Math.min(processedRows.length, currentPerPage * currentPage) }}
				</span>
				<span>
					{{ lang['out_of_pages'] }}
				</span>
				<span>
					{{ processedRows.length }}
				</span>
			</div>
			<div>
				<ul class="material-pagination">
					<li>
						<a href="javascript:undefined"
							class="waves-effect btn-flat"
							tabindex="0"
							@click.prevent="previousPage"
						>
							<i class="fas fa-angle-double-left"></i>
						</a>
					</li>
					<li>
						<a href="javascript:undefined"
							class="waves-effect btn-flat"
							tabindex="0"
							@click.prevent="nextPage"
						>
							<i class="fas fa-angle-double-right"></i>
						</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
	</div>
</template>

<script>
	import 'tb-skeleton/dist/skeleton.css';

	import Fuse from 'fuse.js';
	import locales from './locales';
	import { TbSkeleton } from 'tb-skeleton';

	export default {
		components: {
			TbSkeleton,
		},

		props: {
			title: {
				type: String,
				required: true,
			},

			columns: {
				type: Array,
				required: true,
			},

			rows: {
				type: Array,
				required: true,
			},

			clickable: {
				type: Boolean,
				required: false,
				default: true,
			},

			customButtons: {
				type: Array,
				required: false,
				default: () => [],
			},

			perPage: {
				type: Array,
				required: false,
				default: () => [10, 20, 30, 40, 50],
			},

			defaultPerPage: {
				type: Number,
				required: false,
				default: null,
			},

			sortable: {
				type: Boolean,
				required: false,
				default: true,
			},

			searchable: {
				type: Boolean,
				required: false,
				default: true,
			},

			exactSearch: {
				type: Boolean,
				required: false,
				default: false,
			},

			serverSearch: {
				type: Boolean,
				required: false,
				default: false,
			},

			serverSearchFunc: {
				type: Function,
				required: false,
				default: () => {},
			},

			paginate: {
				type: Boolean,
				required: false,
				default: true,
			},

			exportable: {
				type: Boolean,
				required: false,
				default: true,
			},

			printable: {
				type: Boolean,
				required: false,
				default: true,
			},

			locale: {
				type: String,
				required: false,
				default: 'en',
			},

			initSortCol: {
				type: Number,
				required: false,
				default: -1,
			},

			loadingAnimation: {
				type: Boolean,
				required: false,
				default: true,
			},

		},

		data: () => ({
			currentPage: 1,
			currentPerPage: 10,
			sortColumn: -1,
			sortType: 'asc',
			searching: false,
			searchInput: '',
		}),

		methods: {
			clickSearchButton() {
				if (this.serverSearch && this.serverSearchFunc)
					this.serverSearchFunc(this.searchInput);
			},
			nextPage() {
				if (this.processedRows.length > this.currentPerPage * this.currentPage)
					++this.currentPage;
			},

			previousPage() {
				if (this.currentPage > 1)
					--this.currentPage;
			},

			onTableLength(e) {
				this.currentPerPage = parseInt(e.target.value);
			},

			sort(index) {
				if (!this.sortable)
					return;
				if (this.sortColumn === index) {
					this.sortType = this.sortType === 'asc' ? 'desc' : 'asc';
				} else {
					this.sortType = 'asc';
					this.sortColumn = index;
				}
			},

			search() {
				this.searching = !this.searching;
			},

			click(row) {
				if(!this.clickable){
					return;
				}

				if(getSelection().toString()){
					// Return if some text is selected instead of firing the row-click event.
					return;
				}

				this.$emit('row-click', row);
			},

			exportExcel() {
				const mimeType = 'data:application/vnd.ms-excel';
				const html = this.renderTable().replace(/ /g, '%20');

				// eslint-disable-next-line eqeqeq
				const documentPrefix = this.title != '' ? this.title.replace(/ /g, '-') : 'Sheet';
				const d = new Date();

				const dummy = document.createElement('a');
				dummy.href = mimeType + ', ' + html;
				dummy.download = documentPrefix
					+ '-' + d.getFullYear() + '-' + (d.getMonth() + 1) + '-' + d.getDate()
					+ '-' + d.getHours() + '-' + d.getMinutes() + '-' + d.getSeconds()
					+ '.xls';
				document.body.appendChild(dummy);
				dummy.click();
			},

			print() {
				const clonedTable = this.$refs.table.cloneNode(true);
				this.synchronizeCssStyles(this.$refs.table, clonedTable, true);

				clonedTable.style.maxWidth = '100%';
				clonedTable.style.boxShadow = '0px 0px 0px 1px rgba(0,0,0,0.2)';
				clonedTable.style.margin = '8px auto';
				// console.log(clonedTable.querySelector('.actions'))
				// clonedTable.querySelector('.actions').remove();
				// clonedTable.querySelector('material-pagination').remove();
				// clonedTable.querySelector('.datatable-length').remove();

				// clonedTable.querySelectorAll('button').forEach(n => n.remove());

				let win = window.open('', '');


				win.document.body.style.fontFamily = '-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen-Sans, Ubuntu, Cantarell, "Helvetica Neue", sans-serif';
				win.document.body.innerHTML = (clonedTable.outerHTML);

				win.print();

				win.close();
			},

			renderTable() {
				let table = '<table><thead>';

				table += '<tr>';
				for (let i = 0; i < this.columns.length; i++) {
					const column = this.columns[i];
					table += '<th>';
					table += 	column.label;
					table += '</th>';
				}
				table += '</tr>';

				table += '</thead><tbody>';

				for (let i = 0; i < this.rows.length; i++) {
					const row = this.rows[i];
					table += '<tr>';
					for (let j = 0; j < this.columns.length; j++) {
						const column = this.columns[j];
						table += '<td>';
						table +=	this.collect(row, column.field);
						table += '</td>';
					}
					table += '</tr>';
				}

				table += '</tbody></table>';

				return table;
			},

			dig(obj, selector) {
				let result = obj;
				const splitter = selector.split('.');

				for (let i = 0; i < splitter.length; i++) {
					if (result == undefined)
						return undefined;

					result = result[splitter[i]];
				}

				return result;
			},

			collect(obj, field) {
				if (typeof(field) === 'function')
					return field(obj);
				else if (typeof(field) === 'string')
					return this.dig(obj, field);
				else
					return undefined;
			},

			/* https://codebottle.io/s/31b70f5391
			 *
			 * @author: Luigi D'Amico (www.8bitplatoon.com)
			 */
			synchronizeCssStyles(src, destination, recursively) {
				destination.style.cssText = this.getComputedStyleCssText(src);

				if (recursively) {
					const vSrcElements = src.getElementsByTagName('*');
					const vDstElements = destination.getElementsByTagName('*');

					for (var i = vSrcElements.length; i--;) {
						const vSrcElement = vSrcElements[i];
						const vDstElement = vDstElements[i];
						vDstElement.style.cssText = this.getComputedStyleCssText(vSrcElement);
					}
				}
			},

			// https://gist.github.com/johnkpaul/1754808
			//
			// Please delete Firefox.
			getComputedStyleCssText(element) {
				const cssObject = window.getComputedStyle(element);
				const cssAccumulator = [];

				if (cssObject.cssText !== ''){
					return cssObject.cssText;
				}

				for (let prop in cssObject){
					if (typeof cssObject[prop] === 'string'){
						cssAccumulator.push(prop + ' : ' + cssObject[prop]);
					}
				}

				return cssAccumulator.join('; ');
			},
		},

		watch: {
			perPageOptions(newOptions) {
				// If defaultPerPage is provided and it's a valid option, set as current per page
				if (newOptions.indexOf(this.defaultPerPage) > -1) {
					this.currentPerPage = parseInt(this.defaultPerPage);
				} else {
					// Set current page to first value
					this.currentPerPage = newOptions[0];
				}
			},
			rows(newRows, oldRows) {
				// If the number of rows change, reset the currentPage to 1
				if(newRows !== oldRows)
					this.currentPage = 1;
			},
		},

		computed: {
			perPageOptions() {
				let options = (Array.isArray(this.perPage) && this.perPage) || [10, 20, 30, 40, 50];

				// Force numbers
				options = options.map(v => parseInt(v));


				// Sort options
				options.sort((a,b) => a - b);

				// And add "All"
				options.push(-1);


				return options;
			},

			processedRows() {
				let computedRows = this.rows;

				if (this.sortable !== false)
					computedRows = computedRows.sort((x,y) => {
						if (!this.columns[this.sortColumn])
							return 0;

						const cook = x => {
							x = this.collect(x, this.columns[this.sortColumn].field);
							if (typeof(x) === 'string') {
								x = x.toLowerCase();
								if (this.columns[this.sortColumn].numeric)
									x = x.indexOf('.') >= 0 ? parseFloat(x) : parseInt(x);
							}
							return x;
						};

						x = cook(x);
						y = cook(y);

						return (x < y ? -1 : (x > y ? 1 : 0)) * (this.sortType === 'desc' ? -1 : 1);
					});

				if (this.searching && !this.serverSearch && this.searchInput) {
					const searchConfig = { keys: this.columns.map(c => c.field) };

					// Enable searching of numbers (non-string)
					// Temporary fix of https://github.com/krisk/Fuse/issues/144
					searchConfig.getFn = (obj, path) => {
						const property = this.dig(obj, path);
						if(Number.isInteger(property))
							return JSON.stringify(property);
						return property;
					};

					if (this.exactSearch) {
						//return only exact matches
						searchConfig.threshold = 0,
						searchConfig.distance = 0;
					}

					computedRows = (new Fuse(computedRows, searchConfig)).search(this.searchInput);
				}

				return computedRows;
			},

			paginated() {
				let paginatedRows = this.processedRows;

				if (this.paginate && this.currentPerPage !== -1)
					paginatedRows = paginatedRows.slice(
						(this.currentPage - 1) * this.currentPerPage,
						this.currentPerPage === -1 ? paginatedRows.length + 1 : this.currentPage * this.currentPerPage
					);

				return paginatedRows;
			},

			lang() {
				return this.locale in locales ? locales[this.locale] : locales['en'];
			},
		},

		mounted() {
			if (!(this.locale in locales))
				console.error(`vue-materialize-datable: Invalid locale '${this.locale}'`);
			this.sortColumn = this.initSortCol;
		},
	};
</script>

<style scoped>
	.table-footer {
		height: 56px;
		padding-left: 24px;
		padding-right: 14px;
		display: -webkit-flex;
		display: flex;
		-webkit-flex-direction: row;
		flex-direction: row;
		-webkit-justify-content: flex-end;
		justify-content: flex-end;
		-webkit-align-items: center;
		align-items: center;
		font-size: 12px !important;
		color: rgba(0, 0, 0, 0.54);
	}

	.table-footer .datatable-length {
		display: -webkit-flex;
		display: flex;
	}

	.table-footer .datatable-length select {
		outline: none;
	}

	.table-footer label {
		font-size: 12px;
		color: rgba(0, 0, 0, 0.54);
		display: -webkit-flex;
		display: flex;
		-webkit-flex-direction: row;
		/* works with row or column */

		flex-direction: row;
		-webkit-align-items: center;
		align-items: center;
		-webkit-justify-content: center;
		justify-content: center;
	}

	.table-footer .select-wrapper {
		display: -webkit-flex;
		display: flex;
		-webkit-flex-direction: row;
		/* works with row or column */

		flex-direction: row;
		-webkit-align-items: center;
		align-items: center;
		-webkit-justify-content: center;
		justify-content: center;
	}

	.table-footer .datatable-info,
	.table-footer .datatable-length {
		margin-right: 32px;
	}

	.table-footer .material-pagination {
		display: flex;
		-webkit-display: flex;
		margin: 0;
	}

	.table-footer .material-pagination li a {
		color: rgba(0, 0, 0, 0.54);
		padding: 0 8px;
		font-size: 24px;
	}

	.table-footer .select-wrapper input.select-dropdown {
		margin: 0;
		border-bottom: none;
		height: auto;
		line-height: normal;
		font-size: 12px;
		width: 40px;
		text-align: right;
	}

	.table-footer select {
		background-color: transparent;
		width: auto;
		padding: 0;
		border: 0;
		border-radius: 0;
		height: auto;
		margin-left: 20px;
	}

	.table-title {
		font-size: 20px;
		color: #000;
	}

	table tr td {
		padding: 0 0 0 56px;
		height: 48px;
		font-size: 13px;
		color: rgba(0, 0, 0, 0.87);
		border-bottom: solid 1px #DDDDDD;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}

	table td, table th {
		border-radius: 0;
	}

	table tr td a {
		color: inherit;
	}

	table tr td a i {
		font-size: 18px;
		color: rgba(0, 0, 0, 0.54);
	}

	table tr {
		font-size: 12px;
	}

	table th {
		font-size: 12px;
		font-weight: 500;
		color: #757575;
		cursor: pointer;
		white-space: nowrap;
		padding: 0;
		height: 56px;
		padding-left: 56px;
		vertical-align: middle;
		outline: none !important;

		overflow: hidden;
		text-overflow: ellipsis;
	}

	table th:hover {
		overflow: visible;
		text-overflow: initial;
	}

	table th.sorting-asc,
	table th.sorting-desc {
		color: rgba(0, 0, 0, 0.87);
	}

	table th.sorting:after,
	table th.sorting-asc:after {
		font-family: 'Font Awesome 5 Free';
		font-weight: 900;
		font-size: 16px;
		line-height: 1;
		letter-spacing: normal;
		text-transform: none;
		display: inline-block;
		word-wrap: normal;
		-webkit-font-smoothing: antialiased;
		display: none;
		vertical-align: middle;
	}

	table th.sorting:hover:after,
	table th.sorting-asc:after,
	table th.sorting-desc:after {
		display: inline-block;
	}
	table th.sorting-desc:after {
		content: "\f062"!important;
	}
	table th.sorting-asc:after {
		content: "\f063"!important;
	}

	table th.sorting:after {
		content: "\f0dc";
	}

	table tbody tr:hover {
		background-color: #EEE;
	}

	table th:last-child,
	table td:last-child {
		padding-right: 14px;
	}

	table th:first-child, table td:first-child {
		padding-left: 24px;
	}

	.rtl {
		direction: rtl;
	}
</style>

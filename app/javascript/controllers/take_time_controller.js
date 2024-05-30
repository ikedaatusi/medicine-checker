import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="take-time"
export default class extends Controller {
  static targets = ["fields"]

  addField() {
    const newField = document.createElement("div")
    newField.classList.add("form-group")
    newField.innerHTML = `
      <label for="drug_take_times_attributes_new_take_time">タイミング</label>
      <select name="drug[take_times_attributes][new][take_time]" id="drug_take_times_attributes_new_take_time" class="text-[#9A7E7E] form-select min-w-[120px] ml-4 rounded-[3px] border-[#9A7E7E]">
        <option value="">未選択</option>
        <% TakeTime.take_times.keys.each do |k| %>
          <option value="<%= k %>"><%= t("enum.take_time.take_time.#{k}") %></option>
        <% end %>
      </select>
    `
    this.fieldsTarget.appendChild(newField)
  }
}
module ApplicationHelper
  include Pagy::Frontend

  def icon(name, classname=nil)
    render("icons/#{name}", locals: {classname: classname})
  rescue
    render "icons/empty", locals: {classname: classname}
  end

  def sort_button(column, label)
    button_class = params[:order_by] == "#{column}_asc" ? 'sort--desc' : params[:order_by] == "#{column}_desc" ? 'sort--asc' : ''
    button_value = params[:order_by] == "#{column}_asc" ? "#{column}_desc" : "#{column}_asc"

    content_tag(:button, label, class: button_class.present? ? "sort #{button_class}" : "sort", data: { action: 'click->table#sortByColumn', 'button-type': column }, value: button_value) do
      content_tag(:span, label) + 
      icon('sort')
    end
  end

  def page_entries(collection, pagy, options = {})
    entry_name =
      options[:entry_name] ||
        (
          if collection.empty?
            "item"
          else
            collection.first.class.name.split("::").last.titleize
          end
        )
    if pagy.last < 2
      case pagy.count
      when 0
        "No #{entry_name.pluralize} found"
      when 1
        "Displaying <strong>#{pagy.count}</strong> #{entry_name}".html_safe
      else
        "Displaying all <strong>#{pagy.count}</strong> #{entry_name.pluralize}".html_safe
      end
    else
      format(%(Displaying <strong>%d - %d</strong> of %d #{entry_name.pluralize}), pagy.offset + 1, pagy.offset + pagy.in, pagy.count).html_safe
    end
  end

  def pagy_nav(pagy, pagy_id: nil, link_extra: '', **vars)
    # Generate an id attribute if pagy_id is provided
    p_id = %( id="#{pagy_id}") if pagy_id
    # Previous and next page numbers
    p_prev = pagy.prev
    p_next = pagy.next

    # Start the navigation container
    html = +%(<nav#{p_id} class="pagy-nav pagination" aria-label="pager">)

    # Previous page link
    html << if p_prev
              %(<span class="page prev"><a href="#{pagy_url_for(pagy, p_prev)}" #{link_extra} aria-label="previous">&lt;</a></span>)
            else
              %(<span class="page prev disabled">&lt;</span>)
            end

    # Render page items in the pagy series
    pagy.series(**vars).each do |item|
      html << case item
              when Integer # For numeric pages
                %(<span class="page"><a href="#{pagy_url_for(pagy, item)}" #{link_extra}>#{item}</a></span>)
              when String # For the current page
                %(<span class="page active">#{pagy.label_for(item)}</span>)
              when :gap # For gaps
                %(<span class="page gap">...</span>)
              else
                raise Pagy::InternalError, "Unexpected item type in series: #{item.inspect}"
              end
    end

    # Next page link
    html << if p_next
              %(<span class="page next"><a href="#{pagy_url_for(pagy, p_next)}" #{link_extra} aria-label="next">&gt;</a></span>)
            else
              %(<span class="page next disabled">&gt;</span>)
            end

    # Close the navigation container
    html << %(</nav>)

    # Return the complete HTML
    html.html_safe
  end

  def display_market_value(value)
    if value.present?
      "$#{value}.00"
    else
      "Market value not stated"
    end
  end

  def handle_nil (value)
    value.presence || "N/A"
  end
end

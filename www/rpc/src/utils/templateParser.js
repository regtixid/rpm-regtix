/**
 * Template Parser untuk XML templates
 * Menggunakan Handlebars-like syntax untuk placeholder replacement
 */

/**
 * Parse template XML dan replace placeholders dengan data
 */
export const parseTemplate = async (templatePath, data) => {
  try {
    // Fetch template XML
    const response = await fetch(templatePath);
    if (!response.ok) {
      throw new Error(`Failed to load template: ${templatePath}`);
    }
    
    let template = await response.text();
    
    // Extract HTML content dari XML wrapper
    const htmlMatch = template.match(/<html[^>]*>[\s\S]*<\/html>/i);
    if (htmlMatch) {
      template = htmlMatch[0];
    }
    
    // Replace placeholders dengan data
    template = replacePlaceholders(template, data);
    
    return template;
  } catch (error) {
    console.error('Error parsing template:', error);
    throw error;
  }
};

/**
 * Replace placeholders dalam template
 * Support untuk:
 * - {{variable}} - simple replacement
 * - {{variable.property}} - nested property
 * - {{#each array}} ... {{/each}} - array iteration
 */
const replacePlaceholders = (template, data) => {
  let result = template;
  
  // Handle {{#each}} blocks (support untuk participants array)
  result = result.replace(/\{\{#each\s+(\w+)\}\}([\s\S]*?)\{\{\/each\}\}/g, (match, arrayName, content) => {
    const array = getNestedValue(data, arrayName);
    if (!Array.isArray(array)) {
      return '';
    }
    
    return array.map((item, index) => {
      let itemContent = content;
      // Replace {{@index}} atau {{index}}
      itemContent = itemContent.replace(/\{\{@index\}\}/g, index + 1);
      itemContent = itemContent.replace(/\{\{index\}\}/g, index + 1);
      // Replace item properties (support untuk {{item.property}} atau {{property}})
      itemContent = itemContent.replace(/\{\{item\.(\w+)\}\}/g, (m, prop) => {
        return item[prop] !== undefined && item[prop] !== null ? String(item[prop]) : '';
      });
      // Replace direct properties ({{name}}, {{registration_code}}, etc.)
      itemContent = replaceObjectPlaceholders(itemContent, item);
      return itemContent;
    }).join('');
  });
  
  // Replace simple placeholders
  result = replaceObjectPlaceholders(result, data);
  
  return result;
};

/**
 * Replace placeholders untuk object data
 */
const replaceObjectPlaceholders = (template, data) => {
  let result = template;
  
  // Match {{variable.property.subproperty}} patterns
  const placeholderRegex = /\{\{([^}]+)\}\}/g;
  
  result = result.replace(placeholderRegex, (match, path) => {
    const value = getNestedValue(data, path.trim());
    return value !== undefined && value !== null ? String(value) : '';
  });
  
  return result;
};

/**
 * Get nested value from object using dot notation
 */
const getNestedValue = (obj, path) => {
  const keys = path.split('.');
  let value = obj;
  
  for (const key of keys) {
    if (value === undefined || value === null) {
      return '';
    }
    value = value[key];
  }
  
  return value;
};

/**
 * Format date helper
 */
export const formatDate = (dateString, format = 'DD-MM-YYYY') => {
  if (!dateString) return '';
  
  const date = new Date(dateString);
  if (isNaN(date.getTime())) return dateString;
  
  const day = String(date.getDate()).padStart(2, '0');
  const month = String(date.getMonth() + 1).padStart(2, '0');
  const year = date.getFullYear();
  
  if (format === 'DD-MM-YYYY') {
    return `${day}-${month}-${year}`;
  }
  
  return dateString;
};


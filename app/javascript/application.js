// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails';
import 'controllers';

// Import jQuery (add the specific version you need)
import jQuery from 'jquery';
window.jQuery = jQuery;
window.$ = jQuery;

// Import Bootstrap JavaScript (add the specific version you need)
import 'bootstrap';

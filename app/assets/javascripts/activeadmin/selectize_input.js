function active_selectize (element) {
  var remote = $(element).attr( 'data-opt-remote' ) ? $(element).attr( 'data-opt-remote' ) : '';
    var field_text = $(element).attr( 'data-opt-text' ) ? $(element).attr( 'data-opt-text' ) : 'name';
    var field_value = $(element).attr( 'data-opt-value' ) ? $(element).attr( 'data-opt-value' ) : 'id';
    var opts = {
      closeAfterSelect: true,
      create: false,
      hideSelected: true,
      labelField: field_text,
      options: [],
      plugins: ['remove_button'],
      searchField: field_text,
      valueField: field_value
    };

    if (!$(element).data('opts') ) {
      $.each( element.attributes, function( i, attr ) {
        if( attr.name.startsWith( 'data-opt-' ) ) {
          var name = attr.name.substr( 9 );
          if( name != 'remote' && name != 'text' && name != 'value' ) opts[name] = ( attr.value == 'true' ) ? true : ( ( attr.value == 'false' ) ? false : attr.value );
        }
      });
    }
    else {
      opts = $.extend({}, opts, $(element).data('opts'));
    }

    opts['load'] = function( query, callback ) {
      if( !query.length ) return callback();
      $.ajax({
        url: remote + '?q[' + field_text + '_contains]=' + encodeURIComponent( query ),
        type: 'GET',
        error: function() {
          callback();
        },
        success: function(res) {
          callback( res.slice( 0, 10 ) );
        }
      });
    };
    $(element).selectize( opts );
}

$(document).ready(function() {
  $('.selectized').each(function() {
    active_selectize(this);
  });

  var document_mutation = new MutationObserver(function(mutationRecords) {
    mutationRecords.forEach(function(record) {
      console.log(record);
      record.addedNodes.forEach(function(node) {
        if (node.tagName === 'FIELDSET') {
          var target = $(node).find('select.selectized');
          active_selectize(target);
        }
      });
    });
  });
  
  document_mutation.observe(document, { childList: true, subtree: true });  
});
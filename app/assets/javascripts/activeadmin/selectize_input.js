function initSelectizeInputs() {
  $('[data-selectize-input]').each( function() {
    var remote = $(this).attr( 'data-opt-remote' ) ? $(this).attr( 'data-opt-remote' ) : '';
    var field_text = $(this).attr( 'data-opt-text' ) ? $(this).attr( 'data-opt-text' ) : 'name';
    var field_value = $(this).attr( 'data-opt-value' ) ? $(this).attr( 'data-opt-value' ) : 'id';
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

    if (!$(this).data('opts') ) {
      $.each( this.attributes, function( i, attr ) {
        if( attr.name.startsWith( 'data-opt-' ) ) {
          var name = attr.name.substr( 9 );
          if( name != 'remote' && name != 'text' && name != 'value' ) opts[name] = ( attr.value == 'true' ) ? true : ( ( attr.value == 'false' ) ? false : attr.value );
        }
      });
    }
    else {
      opts = $.extend({}, opts, $(this).data('opts'));
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
    $(this).selectize( opts );
  });
}

$(document).on('has_many_add:after', function () {
  initSelectizeInputs();
});

$(document).ready( function() {
  initSelectizeInputs();
});

var Albums = {
  init: function() {
    $('a#edit-albums').click(function() { Albums.editAlbums(); return false; });
    $('.album .controls .delete a').bind('ajax:complete', Albums.deleteComplete);
  },

  editAlbums: function() {
    $('.album .controls').addClass('visible');
  },

  deleteComplete: function() {
    $(this).closest('.album').remove();
    if ($('.album').length == 0) {
      window.location = '/';
    };
  }
};

$(document).ready(Albums.init)
$(window).bind('page:change', Albums.init)

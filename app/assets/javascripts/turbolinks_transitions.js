var $document = $(document);

console.log('turbolinks_transitions.js');

$document.on('page:fetch', function() {
    console.log('page:fetch');

    $document.find('.loading-spinner')
        .removeClass('fadeOut')
        .addClass('animated fadeIn');
    $document.find('.container.content').hide();
});

$document.on('page:change', function() {
    console.log('page:change');

    $document.find('.loading-spinner')
        .removeClass('fadeIn')
        .addClass('animated fadeOut');
    $document.find('.container.content').show();
});
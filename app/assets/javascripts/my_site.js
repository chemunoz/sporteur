var phrases = [
  '"Paddle tennis is a game adapted from tennis and played for over a century".',
  '"Its up to you how far you go. If you dont try, youll never know!"',
  '"Compared to tennis, the court is smaller and has no doubles lanes, and the net is lower."',
  '"The same court is used for both singles and doubles."',
  '"The ball used is a standard tennis ball with its internal pressure reduced."',
  '"All padlle rules are similar to tennis rules."'
];


  $(document).on("ready", show_phrase);
  function show_phrase(){
    // $('#phrase').text(phrases[Math.floor(Math.random() * phrases.length)]);
    $('.carousel-caption h2')[0].innerText = phrases[Math.floor(Math.random() * phrases.length)];
    $('.carousel-caption h2')[1].innerText = phrases[Math.floor(Math.random() * phrases.length)];
    $('.carousel-caption h2')[2].innerText = phrases[Math.floor(Math.random() * phrases.length)];
  }  

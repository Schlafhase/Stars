require "sweetbread"

task "build", "Compile everything", ()->
  compile "everything", ()->
    rm "public"
    write "public/stars.js", coffee concat readAll "source/script/**/*.coffee"
    copy "source/script/perlin.js", "public/perlin.js"
    copy "source/index.html", "public/index.html"

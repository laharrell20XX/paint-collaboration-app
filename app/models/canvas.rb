class Canvas < ApplicationRecord
    def self.add_slugs
        Canvas.all.each {|canvas| canvas.update(slug: to_slug(canvas.name))}
    end
end

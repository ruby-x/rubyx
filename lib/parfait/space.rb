
# A Space is a collection of pages. It stores objects, the data for the objects,
# not references. See Page for more detail.

# Pages are stored by the object size they represent in a hash.

# Space and Page work together in making *new* objects available.
# "New" is slightly misleading in that normal operation only ever
# recycles objects.

require "register/builtin/object"

module Parfait
  # The Space contains all objects for a program. In functional terms it is a program, but in oo
  # it is a collection of objects, some of which are data, some classes, some functions

  # The main entry is a function called (of all things) "main", This _must be supplied by the compling
  # There is a start and exit block that call main, which receives an List of strings

  # While data ususally would live in a .data section, we may also "inline" it into the code
  # in an oo system all data is represented as objects

  class Space < Object

    def initialize
      super()
      Parfait::Space.set_object_space self
      @classes = Parfait::Dictionary.new_object
      # this is like asking for troubles, but if the space instance is not registered
      # and the @classes up, one can not register classes.
      # all is good after this init
      #global objects (data)
      @objects = Parfait::List.new_object
    end
    attr_reader :classes , :objects , :frames, :messages, :next_message , :next_frame

    # need a two phase init for the object space (and generally parfait) because the space
    # is an interconnected graph, so not everthing is ready
    def late_init
      @frames = List.new_object
      @messages = List.new_object
      counter = 0
      while( counter < 5)
        @frames.push Frame.new_object
        @messages.push Message.new_object
        counter = counter + 1
      end
      @next_message = @messages.first
      @next_frame = @frames.first
    end

    @@object_space = nil
    # Make the object space globally available
    def self.object_space
      @@object_space
    end
    # TODO Must get rid of the setter
    def self.set_object_space space
      @@object_space = space
    end

    # Objects are data and get assembled after functions
    def add_object o
      return if @objects.include?(o)
      @objects.push o
    end

    def get_main
      kernel = get_class_by_name "Kernel"
      kernel.get_instance_method "main"
    end

    # this is the way to instantiate classes (not Parfait::Class.new)
    # so we get and keep exactly one per name
    def get_class_by_name name
      raise "uups #{name}.#{name.class}" unless name.is_a?(Word) or name.is_a?(String)
      c = @classes[name]
      puts "MISS, no class #{name} #{name.class}" unless c # " #{@classes}"
      c
    end

    def create_class name , superclass
      raise "uups " if name.is_a? String
      c = Class.new_object(name , superclass)
      @classes[name] = c
    end
  end
  # ObjectSpace
  # :each_object, :garbage_collect, :define_finalizer, :undefine_finalizer, :_id2ref, :count_objects
end

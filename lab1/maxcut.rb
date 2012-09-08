require 'set'

class Vertex
	attr_accessor :id, :edges
	
	def initialize(id)
		@id = id
	end

	def eql?(other)
		@id == other.id
	end

	def hash
		@id.hash
	end
end

class Edge
	attr_accessor :v1, :v2, :weight
	def initialize(v1, v2, weight)
		@v1 = v1
		@v2 = v2
		@weight = weight
	end

	def between?(set1, set2)
		set1.include? @v1 and not set2.include? @v2 or not set1.include? @v1 and set2.include? @v2
	end
end

vertices = Set.new
edges = Set.new
File.foreach(ARGV[0]){ |line|
	values = line.split(' ')
	if values.size == 3
		v1 = Vertex.new(values[0])
		v2 = Vertex.new(values[1])
		vertices.add(v1)
		vertices.add(v2)
		edges.add(Edge.new(v1, v2, values[2].to_i))
	end
}
results = []
100.times do
	v_a = Set.new
	vertices.each{ |v|
		if [true,false].sample
			v_a.add(v)
		end
	}
	v_b = vertices - v_a
	cut = Set.new
	edges.each { |e|
		if e.between?(v_a, v_b)
			cut.add(e)
		end
	}
	total_weight = 0
	cut.each { |e|
		total_weight += e.weight
	}
	results.push(total_weight)
end
puts results
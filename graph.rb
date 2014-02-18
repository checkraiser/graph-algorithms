require 'set'
class Graph
	
	def initialize(edge = nil, ver = nil, color = nil)
		@g = edge || Hash.new
		@v = ver || Set.new
		@color = color || Hash.new
	end
	def get_edge
		@g
	end
	def get_v
		@v
	end
	def get_colors
		@color
	end
	def add_edge(v, w)
		@g[[v, w]] = true
		@g[[w, v]] = true
		@v.add(v)
		@v.add(w)
	end
	def get_color(v)
		@color[v]
	end
	def edge?(mU, v, w)
		return false if !mU.include?(v) or !mU.include?(w)
		return true if @g[[v, w]] == true
		return false
	end
	def assign_color(v, k)
		@color[v] = k
	end
	def degree(mU, mv)
		@g.select {|k,v| v == true and mU.include?(mv) and mU.include?(k[1])}.count
	end
	def max_item_degree(mU, mV)
		v_a = mV.to_a
		max_item = v_a[0]
		max_value = degree(mU, max_item)
		v_a.each do |v|
			tmp = degree(mU, v)
			if tmp > max_value
				max_item = v
				max_value = tmp
			end
		end
		max_item
	end
	def get_u1(u)
		res = Set.new
		t = get_uncolored_nodes(u)
		t.each do |v|
			tmp = false
			get_colored_nodes(u).each do |w|
				if edge?(u, v, w)
					tmp = true
				end
			end
			if tmp == false
				res.add(v)
			end
		end
		res
	end
	def get_u2(u)
		res = Set.new
		t = get_uncolored_nodes(u)
		t.each do |v|
			get_colored_nodes(u).each do |w|
				if edge?(u, v, w)
					res.add(v)
				end
			end
		end
		res
	end

	
	def get_colored_nodes(mU)
		mU.select {|v| @color[v] != nil}
	end
	def get_uncolored_nodes(mU)
		mU.select {|v| @color[v].nil? }
	end
	def color!
		k = 0
		@v.count.times do |t1|
			k = k + 1
			un = get_uncolored_nodes(get_v)
			@v.count.times do |t|
				al(un, k + 1)
			end
		end
	end
	private
	def al(u, k)
		u1 = get_u1(u)
		u2 = get_u2(u)
		unless u1.empty?
			vi1 = max_item_degree(u2, u1)
			assign_color(vi1, k)
		end	
	end
end
	

def test
	graph = Graph.new
	k = 1
	graph.add_edge(1, 3)
	graph.add_edge(1, 4)
	graph.add_edge(2, 4)
	graph.add_edge(2, 5)
	graph.add_edge(3, 4)
	graph.add_edge(3, 6)
	graph.assign_color(1, 1)
	graph.color!
	
	puts graph.get_colors.inspect
end
test
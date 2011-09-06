require 'statsample'

inp_array = (1..100).collect{rand(100)}
max_error = 0.50*inp_array.to_scale.sd

print inp_array
print "\n"
print max_error
print "\n"

def improvement_splitting_at(input_array,i)
   first_part_mean = input_array[0..i].to_scale.mean
   second_part_mean = input_array[i+1..input_array.length-1].to_scale.mean
   #puts "later #{i}"
   return second_part_mean - first_part_mean
end

def calculate_error(array_segment)
   return array_segment.to_scale.sd
end

def merge(x,y)
	return x + y
end

def bottom_up(input_array,max_error)
	segments = Array.new
	merge_cost = Array.new
	i =0
	while i<input_array.length-1
		segments.push([input_array[i],input_array[i+1]])
		i = i + 2
 	end
	for i in 0..segments.length-2 
		merge_cost[i] = calculate_error(merge(segments[i],segments[i+1]))
	end

	while merge_cost.min < max_error
		index = merge_cost.index(merge_cost.min)
		print index
		segments[index] = merge(segments[index],segments[index+1])
		segments.delete_at(index+1)
		merge_cost.delete_at(index)
		if segments.length-1 != index
			merge_cost[index] = calculate_error(merge(segments[index],segments[index+1]))
		end
		if index != 0
			merge_cost[index-1] = calculate_error(merge(segments[index-1],segments[index]))
		end
	end
	print segments
	print "\n"
	print merge_cost
	print "\n"
end

bottom_up(inp_array,max_error)



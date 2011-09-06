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

def top_down(input_array,max_error)
	#puts "length	#{input_array.length}"	
	if(input_array.length < 2)
		return
	end
	best_so_far = 999999999  #should be infinity to start with
	for i in 0..(input_array.length-2)
		improvement_in_approximation = 1/improvement_splitting_at(input_array, i).abs
		if improvement_in_approximation < best_so_far
			breakpoint = i
			best_so_far = improvement_in_approximation
		end
	end

	if calculate_error(input_array[0..breakpoint]) > max_error
		top_down = top_down(input_array[0..breakpoint],max_error)
	else
		print input_array[0..breakpoint]
		print "\n"
	end

	if calculate_error(input_array[breakpoint+1..input_array.length-1]) > max_error
		top_down = top_down(input_array[breakpoint+1..input_array.length-1],max_error)
	else
		print input_array[breakpoint+1..input_array.length]
		print "\n"
	end
end

top_down(inp_array,max_error)

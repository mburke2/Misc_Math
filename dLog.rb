require '/users/mikeburke/desktop/primes.rb'

=begin
	a^2 + b^2 = r^2
	a + bi = val

	a = val - bi
	
	(val - bi)^2 + b^2 = r^2
	val^2 - 2val * bi + b^2i^2 + b^2 = r^2
	
	val^2 - 2val * bi = r^2
	-2val * bi = r^2 - val^2
	
	2 * val * bi = val^2 - r^2
	b = (val^2 - r^2) / (2 * val * i)
=end

def convertToPointOnCircle(base, exp, mod, rad = 1)
	if (mod - 1) % 4 != 0
		puts "bad mod"
		return nil
	end


	i = modExp(base, (mod - 1) / 4, mod)
	
	val = modExp(base, exp, mod)

	
	num = (val * val - rad * rad) % mod
	
	den = (2 * val * i) % mod

	b = (num * modularInverse(den, mod)) % mod
	
	a = (val - b * i) % mod

	[a, b]
	
end


def slope(p1, p2, mod)
	rise = p2[1] - p1[1]
	run  = p2[0] - p1[0]

	(rise * modularInverse(run, mod)) % mod
end



def distance2(p1, p2, mod)
	((p2[0] - p1[0]) ** 2 + (p2[1] - p1[1]) ** 2) % mod
end



#JUNK METHODS BEGIN HERE
def circleSlopes
	slopes = []
	101.times do |i|
		p1 = convertToPointOnCircle(2, i + 1, 101)
		p2 = convertToPointOnCircle(2, i, 101)
		
		slopes.push(slope(p1, p2, 101))
	end	

	slopes
end


def expSlopes
	slopes = []
	101.times do |i|
		p1 = [i + 1, modExp(2, i + 1, 101)]
		p2 = [i, modExp(2, i, 101)]

		slopes.push(slope(p1, p2, 101))
	end

	slopes
end



def quotients(list, mod)
	res = []
	(list.length - 1).times do |i|
		
		v1 = list[i + 1]
		v2 = list[i]
		
		q = (v1 * modularInverse(v2, mod)) % mod

		res.push(q)
	end
		
	res
end



def circleDistances
	res = []
	101.times do |i|
		p1 = convertToPointOnCircle(2, i + 1, 101)
		p2 = convertToPointOnCircle(2, i, 101)
		res.push(distance2(p1, p2, 101))
	end

	res
end


def expDistances
	res = []
	101.times do |i|
		p1 = [i + 1, modExp(2, i + 1, 101)]
		p2 = [i, modExp(2, i, 101)]
		res.push(distance2(p1, p2, 101))
	end

	res
end



def originCircleSlopes
	res = []
	p = [1, 0]
	100.times do |i|
		p2 = convertToPointOnCircle(2, i + 1, 101)
		res.push(slope(p, p2, 101))
	end
	res
		
end

def originExpDistances
	res = []
	p = [0, 1]
	100.times do |i|
		p2 = [i + 1, modExp(2, i + 1, 101)]
		res.push(distance2(p, p2, 101))
	end
	res
end



def allSlopeDistancePairs
	pairs = []
	101.times do |x1|
		y1 = modExp(2, x1, 101)
		p1 = convertToPointOnCircle(2, x1, 101)
		(101 - x1).times do |aaa|
			x2 = aaa + x1 + 1
			y2 = modExp(2, x2, 101)
			p2 = convertToPointOnCircle(2, x2, 101)
			
			m = slope(p1, p2, 101)
			d = distance2([x1, y1], [x2, y2], 101)

			pairs.push([m, d])
			
		end
	end

	pairs
			
end


=begin
	y - y1 = m(x - x1)
	y = mx - mx1 + y1
	y = mx + (y1 - mx1)
=end

def line(p1, p2, mod)
	if p1[0] == p2[0]
		return [-1, -1]
	end
	
	m = slope(p1, p2, mod)
	b = (p1[1] - m * p1[0]) % mod

	[m, b]
	
	
end


def linePoints(line, mod)
	points = []	
	
	mod.times do |x|
		y = (line[0] * x + line[1]) % mod
		
		points.push([x, y])
	end
	points
end
=begin
stump = (0, 0)
tree = (1, 0)
L1 = (x1, y1)
L2 = (x2, y2)






L1:stump
d = sqrt(x1^2 + y1^2)
m = (y1 / x1)

turn 90 degrees

m = -x1 / y1

y = (-x1/y1) * x 

(-x1/y1) * x^2 + x^2 = x1^2 + y1^2

x^2(1 - x1/y1^2)

x^2 = (x1^2 + y1^2) / (1 - x1/y1^2)

x^2 = (x1^2 + y1^2) / (y1^2 - x1^2)/y1^2

x^2 = (x1^2 + y1^2) * y1^2 / (y1^2 - x1^2)


y - y1 = m * (x - x1)

y = m * x - m * x1 + y1

y = m * x + (y1 - m * x1)


=end



Class Point
	attr_accessor :x
	attr_accessor :y	
	
	def initialize(px, py)
		@x = px
		@y = py
	end

end


class Line
	attr_accessor :m
	attr_accessor :b

	def initialize(m, b)
		@slope = m
		@int = b
	end

	def Line.lineWithPoints(p1, p2)
		m = (p2.y - p1.y) / (p2.x - p1.x)
		
		b = p1.y - m * p1.x

		return Line(m, b)
		
	end

	def intersection(line)
		x = (line.intercept - self.intercept) / (self.slope - line.slope)
		y = self.slope * x + self.intercept

		return Point(x, y)

	end


	
end
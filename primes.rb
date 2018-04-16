
def primeList(n)
	list = []
	if n > 2
		list.push(2)
	end
	
	k = 3
	while k < n
		if mrtest(k) == true
			list.push(k)
		end
		k = k + 2
	end
	list
end


def convertToBase(num, base)
	result = []
	while num > 0
		result.push(num % base)
		num = num / base
	end
	result.reverse
end	

def convertFromBase(arr, base)
	exp = 0
	res = 0
	arr.each do |elt|
		res = base * res + elt
	end
	res
end	


def modExp(base, exp, mod = 0)
	p = 1
	multiplier = base

	while exp > 0
		if exp % 2 == 1
			if mod == 0
				p = p * multiplier
			else
				p = (p * multiplier) % mod
			end
			exp = exp - 1
		end
		
		if mod == 0
			multiplier = (multiplier * multiplier)
		else
			multiplier = (multiplier * multiplier) % mod
		end

		exp = exp / 2
	end
		
	p

end


def gcd(a, b)
	if a < 0 || b < 0
		return gcd(a.abs, b.abs)
	end

	if b < a
		return gcd(b, a)
	end

	if a == 0
		return b
	end

	gcd(b % a, a)
end	



def randomNumberWithDigits(n)
	result = 1 + rand(9)
	(n-1).times do |i|
		result = result * 10 + rand(10)
	end
	result
end	


def fastDigits(n)

	minDigs = 1
	maxDigs = 1
	
	while (modExp(10, maxDigs)< n)
		maxDigs = maxDigs * 10
	end


	while maxDigs - minDigs > 1
		gDigs = (maxDigs + minDigs) / 2	

		testVal = modExp(10, gDigs)
		
		if testVal > n
			maxDigs = gDigs
		else
			minDigs = gDigs
		end

	end

#	[minDigs, maxDigs]
	maxDigs	

end	

def digits(n)
	k = 0
	while n > 0
		k = k + 1
		n = n / 10
	end
	k
end


def divisors(n)
	max = squareRootFloor(n)
	
	list = []
	p = 2
	while p < max
		if n % p == 0
			list.push(p)
			list.push(n / p)
		end
		p = p + 1
	end

	if max ** 2 == n
		list.push(max)
	end
	list
end

def getFactors(n, facts = [])
	if n < 1
		return facts
	end

	while n % 2 == 0
		facts.push(2)
		n = n / 2
	end

	p = 3
	max = squareRootFloor(n) + 1
	while p < max
		changed = false
		while n % p == 0
			changed = true
			n = n / p
			facts.push(p)
		end
		if changed == true
			max = squareRootFloor(n) + 1
		end
		p = p + 2
	end
	


	if n >= max
		facts.push(n)
	end	


	facts
		
end

def factors(n)
	list = []

	if n < 1
		return list
	end

	while n % 2 == 0
		list.push(2)
		n = n / 2
	end

	p = 3

	max = squareRootFloor(n) + 1
	while p < max
		flag = false
		while n % p == 0
			n = n / p
			list.push(p)
			flag = true
		end

		if n == 1
			return list
		end

		if flag == true
			max = squareRootFloor(n) + 1
		end

		p = p + 2
	end
	
	if n != 1
		list.push(n)
	end
	
	list
end

def product(list)
	p = 1
	list.each do |elt|
		p = p * elt
	end
	p
end	


def factorial(n)
	p = 1
	n.times do |i|
		p = p * (i + 1)
	end
	p
end

def squareRootFloor(n)
	min = 1
	max = n

	while max - min > 1
		guess = (max + min) / 2
		g2 = guess ** 2
		if g2 == n
			return guess
		end

		if g2 > n
			max = guess
		else
			min = guess
		end
	end
	
	min
		
end


def modularInverse(n, mod)
	s = 0
	oldS = 1

	t = 1
	oldT = 0
	
	r = mod
	oldR = n

	while r != 0
		q = oldR / r

		newR = oldR - q * r
		oldR = r
		r = newR

		newS = oldS - q * s
		oldS = s
		s = newS

		newT = oldT - q * t
		oldT = t
		t = newT
	end

	return (oldS % mod)
#	puts "oldS = #{oldS}, oldT = #{oldT}, oldR = #{oldR}"
#	puts "s = #{s}, t = #{t}, r = #{r}"
end


def bruteForcePrimeTest(n)
	
	facts = factors(n)
	if facts.length == 1
		return true
	end
	false

end

def mrtest(n, g = 100)
	if n == 2 || n == 3
		return true
	end

	if n % 2 == 0
		return false
	end

	if n < 3
		return false
	end

 	d = n - 1
 	s = 0
 	while d % 2 == 0
   		d = d / 2
   		s = s + 1
 	end


 	g.times do
   		a = 2 + rand(n - 4)
   		x = modExp(a, d, n) # x = (a**d) % n
   		next if x == 1 || x == n - 1
   		for r in (1..s - 1)
     			x = modExp(x, 2, n) # x = (x**2) % n
      			return false if x == 1
     			break if x == n - 1
   		end
  		return false if x != n - 1
 	end
 	true
end

def randomPrimeWithDigits(n)
	p = randomNumberWithDigits(n - 1)

	lastDigits = [1, 3, 7, 9].shuffle
	p = p * 10 + lastDigits[0]

	while mrtest(p) == false
		p = randomNumberWithDigits(n - 1)
		lastDigits.shuffle!
		p = p * 10 + lastDigits[0]
	end

	p
end	


def choose(n, k)
	factorial(n) / (factorial(k) * factorial(n - k))
end
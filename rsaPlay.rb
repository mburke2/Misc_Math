def getExps(p, q)	
	
	if mrtest(p) == false || mrtest(q) == false
		puts "not prime"
	end
	
	tot = (p - 1) * (q - 1)

	result = Hash.new
	
	(p * q).times do |e|
		if e >= 2 && e % p != 0 && e % q != 0
			div = gcd(e, tot)
			while div != 1
				e = e / div
				div = gcd(e, tot)
			end

			if e != 1 && result[e] == nil
				list = getDecList(p, q, e)
				result[e] = list
			end
			
		end
	end
	result
end

def getDecList(p, q, e)
	
	msg = 2
	
	cipher = modExp(msg, e, p * q)
	list = []
	(p * q).times do |i|
		if modExp(cipher, i, p * q) == msg
			list.push(i)
		end
	end
	list
	
end


def hashToList(hash)
	list = []
	hash.keys.each do |k|
		list.push([k, hash[k]])
	end

	list.sort{|x, y| x[0] <=> y[0]}
end


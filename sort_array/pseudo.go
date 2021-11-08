
func InsertionSort(data []int) *big.Int {
	var i, key, j int
	n := len(data)
	num_of_comparissons := big.NewInt(0)

	for i = 1; i < n; i++ {
		key = data[i]
		j = i - 1
		num_of_comparissons = big.NewInt(0).Add(num_of_comparissons, big.NewInt(1))
		for ; j >= 0 && data[j] > key; j-- {
			num_of_comparissons = big.NewInt(0).Add(num_of_comparissons, big.NewInt(1))
			data[j+1] = data[j]
		}
		data[j+1] = key
	}

	return num_of_comparissons
}


quitProgram = False
while quitProgram == False:
    try:
        #Get zombie population on day 0
        startingPopulation = int(input("Enter starting zombie population: "))
        if startingPopulation <= 1:
            quitProgram = True

        #Get zombie growth rate
        growthRate = float(input("Enter zombie growth rate% (example 2.5): "))
        if growthRate <= 0:
            quitProgram = True

        #Get number of days to predict  
        daysOFPredictor = int(input("Enter number of days for predictor to run: "))
        if daysOFPredictor <= 0:
            quitProgram = True
    except:
        print("Error: That is not a number!")
        quitProgram = True

    #Print input data
    print("\nStarting with %d zombies and growing at %.1f" % (startingPopulation, growthRate))

    #Print Formating
    print("\n\t\t  New\t        Total")
    print("  Day\t      Zombies\t      Zombies")
    print("===== =============== ===============\n", end='')

    #Define Other Variables
    runningTotal = startingPopulation

    #For Loop
    for i in range(1, daysOFPredictor + 1):
        #Find Number of New Zombies
	    newZombies = int(runningTotal * (growthRate / 100))
	    #Find Total Number of Zombies
	    totalZombies = newZombies + runningTotal
	    #Update Variable newZombies
	    newZombies = totalZombies - runningTotal
	    #Update Variable runningTotal
	    runningTotal = totalZombies

	    #Print Results 
	    print("%5d %15d %15d" % (i,newZombies,totalZombies))
    
    #Quit Program
    quitProgram = True

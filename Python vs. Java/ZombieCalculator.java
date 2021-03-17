import java.util.Scanner;

public class ZombieCalculator {

    public static void main(String[] args) {
	int startingPopulation, daysOFPredictor, totalZombies, runningTotal, newZombies;
	double growthRate;

    Scanner keyboard = new Scanner(System.in);
	

    //Get zombie population on day 0
    System.out.print("Enter starting zombie population: ");
    startingPopulation = keyboard.nextInt();

	if (startingPopulation <= 1) {
		System.out.println("\nError: Starting Population must be at least 2");
		System.exit(0);
	}

        //Get zombie growth rate
        System.out.print("Enter zombie growth rate% (example 2.5): ");
        growthRate = keyboard.nextDouble();

	if (growthRate <= 0) {
		System.out.println("\nError: Zombie Growth Rate must be at least 0.0");
		System.exit(0);
	}

    //Get number of days to predict
    System.out.print("Enter number of days for predictor to run: ");
    daysOFPredictor = keyboard.nextInt();
	
	if (daysOFPredictor <= 0) {
		System.out.println("\nError: number of days for predictor must be at least 1");
		System.exit(0);
	}

    //Print input data
    System.out.printf("\nStarting with %d zombies and growing at %.1f",
            startingPopulation, growthRate);
    System.out.println("%");

	//Print Formating
	System.out.print("\n\t\t  New\t        Total\n");
	System.out.println("  Day\t      Zombies\t      Zombies");
	System.out.print("=====");
	System.out.print(" ===============");
	System.out.print(" ===============\n");

	//Define Other Variables	
	runningTotal = startingPopulation;

	//For Loop
        for (int i = 1; i <= daysOFPredictor; i++)
        {
		//Find Number of New Zombies
		newZombies = ((int)(((double)runningTotal) * growthRate/100.0));
		//Find Total Number of Zombies
		totalZombies = newZombies + runningTotal;
		//Update Variable newZombies
		newZombies = totalZombies - runningTotal;
		//Update Variable runningTotal
		runningTotal = totalZombies;

		//Print Results 
		System.out.printf("%,5d %,15d %,15d\n",i,newZombies,totalZombies);
	
        }

    }

}

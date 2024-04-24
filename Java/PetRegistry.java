import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;


public class PetRegistry implements AutoCloseable {

    private List<Animals> animals = new ArrayList<>();

    private static Counter counter = new Counter();

    public void addNewAnimal(Animals animal) {
        animals.add(animal);
        counter.add();
    }

    public void teachCommand(Animals animal, String command) {
        animal.setCommand(command);

        // Запись данных в базу данных
        try (FileWriter writer = new FileWriter("Base.csv", true)) {
            String animalType = getAnimalType(animal);
            String animalName = animal.getName();
            String line = animalType + "," + animalName + "," + command + "\n";
            writer.write(line);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private String getAnimalType(Animals animal) {
        if (animal instanceof Dog) {
            return "Собака";
        } else if (animal instanceof Cat) {
            return "Кошка";
        } else if (animal instanceof Hamster) {
            return "Хомяк";
        } else if (animal instanceof Horse) {
            return "Лошадь";
        } else if (animal instanceof Camel) {
            return "Верблюд";
        } else if (animal instanceof Donkey) {
            return "Осел";
        }
        return "";
    }

    public List<String> getCommands(Animals animal) {
        List<String> commands = new ArrayList<>();
        commands.add(animal.getCommand());
        return commands;
    }

    public void readDatabase() {
        // Создание файла базы данных, если он не существует
        File databaseFile = new File("Base.csv");
        if (!databaseFile.exists()) {
            try {
                databaseFile.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        // Чтение данных из базы данных
        try (BufferedReader reader = new BufferedReader(new FileReader(databaseFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length >= 2) {
                    String animalName = data[0];
                    String command = data[1];
                    Animals animal = animals.stream().filter(a -> a.getName().equals(animalName)).findFirst().orElse(null);
                    if (animal != null) {
                        animal.setCommand(command);
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) throws Exception {
        try (PetRegistry petRegistry = new PetRegistry()) {
            Scanner scanner = new Scanner(System.in);
            while (true) {
                System.out.println("1. Добавить новое животное");
                System.out.println("2. Научить команде");
                System.out.println("3. Получить команды");
                System.out.println("4. Выход");
                int choice = scanner.nextInt();
                scanner.nextLine();
                switch (choice) {
                    case 1:
                        System.out.println("Введите вид животного (Собака, Кошка, Хомяк, Верблюд, Лошадь, Осел): ");
                        String type = scanner.nextLine();
                        System.out.println("Введите имя животного: ");
                        String name = scanner.nextLine();
                        Animals animal;
                        switch (type) {
                            case "Собака":
                                animal = new Dog(name);
                                break;
                            case "Кошка":
                                animal = new Cat(name);
                                break;
                            case "Хомяк":
                                animal = new Hamster(name);
                                break;
                            case "Лошадь":
                                animal = new Horse(name);
                                break;
                            case "Верблюд":
                                animal = new Camel(name);
                                break;
                            case "Осел":
                                animal = new Donkey(name);
                                break;
                            default:
                                throw new IllegalStateException("Недопустимое значение: " + type);
                        }
                        petRegistry.addNewAnimal(animal);
                        break;
                    case 2:
                        System.out.println("Введите имя животного: ");
                        String animalName = scanner.nextLine();
                        Animals foundAnimal = petRegistry.animals.stream()
                                .filter(a -> a.getName().equals(animalName))
                                .findFirst()
                                .orElse(null);
                        if (foundAnimal == null) {
                            System.out.println("Животных нет");
                            break;
                        }
                        System.out.println("Введите команду: ");
                        String command = scanner.nextLine();
                        petRegistry.teachCommand(foundAnimal, command);
                        break;
                    case 3:
                        System.out.println("Введите имя животного: ");
                        String aName = scanner.nextLine();
                        Animals fAnimal = petRegistry.animals.stream()
                                .filter(a -> a.getName().equals(aName))
                                .findFirst()
                                .orElse(null);
                        if (fAnimal == null) {
                            System.out.println("Животных нет");
                            break;
                        }
                        List<String> commands = petRegistry.getCommands(fAnimal);
                        for (String cmd : commands) {
                            System.out.println(cmd);
                        }
                        break;
                    case 4:
                        return;
                }
            }
        } catch (Exception e) {
            throw e;
        }
    }

    @Override
    public void close() throws Exception {
        if (counter.getCount() == 0) {
            throw new Exception("Counter was not used in try-with-resources block (Счетчик не был использован в блоке try-with-resources)");
        } else {
            counter.resetCount();
        }
    }

}

class Counter {

    private int count;

    public void add() {
        count++;
    }

    public int getCount() {
        return count;
    }

    public void resetCount() {
        count = 0;
    }

}

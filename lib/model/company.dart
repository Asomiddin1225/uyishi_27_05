class Company {
  String company;
  String location;
  List<Employee> employees;
  List<Product> products;

  Company({
    required this.company,
    required this.location,
    required this.employees,
    required this.products,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      company: json['company'],
      location: json['location'],
      employees: List<Employee>.from(
          json['employees'].map((x) => Employee.fromJson(x))),
      products:
          List<Product>.from(json['products'].map((x) => Product.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company': company,
      'location': location,
      'employees': List<dynamic>.from(employees.map((x) => x.toJson())),
      'products': List<dynamic>.from(products.map((x) => x.toJson())),
    };
  }
}

class Employee {
  String name;
  int age;
  String position;
  List<String> skills;

  Employee({
    required this.name,
    required this.age,
    required this.position,
    required this.skills,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      name: json['name'],
      age: json['age'],
      position: json['position'],
      skills: List<String>.from(json['skills'].map((x) => x.toString())),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'position': position,
      'skills': List<dynamic>.from(skills.map((x) => x)),
    };
  }
}

class Product {
  String name;
  double price;
  bool inStock;

  Product({
    required this.name,
    required this.price,
    required this.inStock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      price: json['price'],
      inStock: json['inStock'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'inStock': inStock,
    };
  }
}

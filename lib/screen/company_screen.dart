import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:uyishi_27_05/controllers/company_controllers.dart';
import 'package:uyishi_27_05/model/company.dart';

class CompanyScreen extends StatefulWidget {
  @override
  _CompanyScreenState createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  CompanyController? _companyController;

  @override
  void initState() {
    super.initState();
    loadCompany();
  }

  void loadCompany() {
    String jsonData = '''
    {
      "company": "Tech Solutions",
      "location": "San Francisco",
      "employees": [
        {
          "name": "Alice",
          "age": 30,
          "position": "Developer",
          "skills": ["Dart", "Flutter", "Firebase"]
        },
        {
          "name": "Bob",
          "age": 25,
          "position": "Designer",
          "skills": ["Photoshop", "Illustrator"]
        }
      ],
      "products": [
        {
          "name": "Product A",
          "price": 29.99,
          "inStock": true
        },
        {
          "name": "Product B",
          "price": 49.99,
          "inStock": false
        }
      ]
    }
    ''';

    setState(() {
      Company company = Company.fromJson(jsonDecode(jsonData));
      _companyController = CompanyController(company);
    });
  }

  void _showAddEmployeeDialog() {
    String name = '';
    int age = 0;
    String position = '';
    List<String> skills = [];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Xodim Qo'shish"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'F.I.Sh'),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Yosh'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  age = int.parse(value);
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Lavozim'),
                onChanged: (value) {
                  position = value;
                },
              ),
              TextField(
                decoration:
                    InputDecoration(labelText: 'Skills (comma separated)'),
                onChanged: (value) {
                  skills =
                      value.split(',').map((skill) => skill.trim()).toList();
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Bekor Qilish'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Qo'shish"),
              onPressed: () {
                setState(() {
                  _companyController!.addEmployee(Employee(
                      name: name,
                      age: age,
                      position: position,
                      skills: skills));
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showAddProductDialog() {
    String name = '';
    double price = 0.0;
    bool inStock = false;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Maxsulod Qo'shish"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Maxsulod nomi'),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Narxi'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  price = double.parse(value);
                },
              ),
              CheckboxListTile(
                title: Text('Sotuvda mavjud'),
                value: inStock,
                onChanged: (value) {
                  setState(() {
                    inStock = value!;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Bekor Qilish'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Qo'shish"),
              onPressed: () {
                setState(() {
                  _companyController!.addProduct(
                      Product(name: name, price: price, inStock: inStock));
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditEmployeeDialog(int index, Employee employee) {
    String name = employee.name;
    int age = employee.age;
    String position = employee.position;
    List<String> skills = employee.skills;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Xodimni tahrirlash'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'F.I.SH'),
                onChanged: (value) {
                  name = value;
                },
                controller: TextEditingController(text: name),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Yosh'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  age = int.parse(value);
                },
                controller: TextEditingController(text: age.toString()),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Lavozim'),
                onChanged: (value) {
                  position = value;
                },
                controller: TextEditingController(text: position),
              ),
              TextField(
                decoration:
                    InputDecoration(labelText: 'Skills (comma separated)'),
                onChanged: (value) {
                  skills =
                      value.split(',').map((skill) => skill.trim()).toList();
                },
                controller: TextEditingController(text: skills.join(', ')),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Bekor Qilish'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Saqlash'),
              onPressed: () {
                setState(() {
                  _companyController!.editEmployee(
                      index,
                      Employee(
                          name: name,
                          age: age,
                          position: position,
                          skills: skills));
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditProductDialog(int index, Product product) {
    String name = product.name;
    double price = product.price;
    bool inStock = product.inStock;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Mahsulotni tahrirlash'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Mahsulod nomi'),
                onChanged: (value) {
                  name = value;
                },
                controller: TextEditingController(text: name),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Narxi'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  price = double.parse(value);
                },
                controller: TextEditingController(text: price.toString()),
              ),
              CheckboxListTile(
                title: Text('Omborda mavjud'),
                value: inStock,
                onChanged: (value) {
                  setState(() {
                    inStock = value!;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Bekor Qilish"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Saqlash"),
              onPressed: () {
                setState(() {
                  _companyController!.editProduct(index,
                      Product(name: name, price: price, inStock: inStock));
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.grey,
          centerTitle: true,
          title: Text(
            "Company Ma'lumodi",
            style: TextStyle(color: Colors.red, fontSize: 30),
          ),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'Ishchi Kirtish') {
                  _showAddEmployeeDialog();
                } else if (value == "Mahsulot qo'shish") {
                  _showAddProductDialog();
                }
              },
              itemBuilder: (BuildContext context) {
                return {'Ishchi Kirtish', "Mahsulot qo'shish"}
                    .map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: _companyController == null
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  SizedBox(height: 10),
                  Card(
                    color: Colors.red[200],
                    child: ListTile(
                      title: Text(
                        _companyController!.company.company,
                        textAlign: TextAlign.center,
                      ),
                      subtitle: Text(
                        _companyController!.company.location,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  ..._companyController!.company.employees
                      .asMap()
                      .entries
                      .map((entry) {
                    int index = entry.key;
                    Employee employee = entry.value;
                    return Card(
                      color: Colors.green[200],
                      child: ListTile(
                        title: Text(employee.name),
                        subtitle: Text(
                            'Yosh: ${employee.age},\nLavozim: ${employee.position}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _showEditEmployeeDialog(index, employee);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  _companyController!.removeEmployee(index);
                                });
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("${employee.name}Sotuvda mavjud"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: employee.skills
                                      .map((skill) => Text(skill))
                                      .toList(),
                                ),
                                actions: [
                                  TextButton(
                                    child: Text('Bekor Qilish'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    );
                  }).toList(),
                  ..._companyController!.company.products
                      .asMap()
                      .entries
                      .map((entry) {
                    int index = entry.key;
                    Product product = entry.value;

                    return Card(
                      color: Colors.yellow[100],
                      child: ListTile(
                        title: Text(product.name),
                        subtitle: Text(
                            'Narxi: \$${product.price},\nSotuvda bor: ${product.inStock ? "Yes" : "No"}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _showEditProductDialog(index, product);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  _companyController!.removeProduct(index);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ));
  }
}

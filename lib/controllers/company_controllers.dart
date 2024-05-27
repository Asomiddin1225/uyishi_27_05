import 'package:uyishi_27_05/model/company.dart';

class CompanyController {
  Company company;

  CompanyController(this.company);

  void addEmployee(Employee employee) {
    company.employees.add(employee);
  }

  void editEmployee(int index, Employee employee) {
    company.employees[index] = employee;
  }

  void removeEmployee(int index) {
    company.employees.removeAt(index);
  }

  void addProduct(Product product) {
    company.products.add(product);
  }

  void editProduct(int index, Product product) {
    company.products[index] = product;
  }

  void removeProduct(int index) {
    company.products.removeAt(index);
  }
}

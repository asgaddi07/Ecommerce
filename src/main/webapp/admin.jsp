<%-- 
    Document   : admin
    Created on : 26-Jun-2022, 5:04:47 AM
    Author     : Ankit Kumar Singh
--%>

<%@page import="java.util.Map"%>
<%@page import="com.project.ecommerce.other.getDetails"%>
<%@page import="java.util.List"%>
<%@page import="com.project.ecommerce.DataAccessObject.CategoryDao"%>
<%@page import="com.project.ecommerce.sessionFactory.FactoryProvider"%>
<%@page import="com.project.ecommerce.table.CategoryTable"%>
<%@page import="com.project.ecommerce.table.UserTable"%>
<% 


    UserTable user=(UserTable)session.getAttribute("current-user");
   if(user==null){
   session.setAttribute("message", "you are not loged user");
   response.sendRedirect("login.jsp");
   return;
    }
    else{
    if(user.getUserType().equals("Normal")){
     session.setAttribute("message", "you are Admin");
   response.sendRedirect("login.jsp");
    }
    }

%>
 <%  CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
 List<CategoryTable> list = categoryDao.getCategories();

//getting product & user count
 Map<String,Long> map=getDetails.getCounts(FactoryProvider.getFactory());

 %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
 
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel</title>
          <%@include file="Css/commonCss.jsp" %>
        <%@include file="JavaScript/commonJavaScript.jsp" %>
    </head>
    <body>
        <%@include file="CommonDesign/navigationBar.jsp" %>

        <div class="container admin">
            <div class="container-fluid mt-3">
                <%@include file="CommonDesign/displayMessage.jsp" %>
            </div>
            
         <div class="row mt-3">

                <!--first col-->
                <div class="col-md-4">

                    <!--first box-->
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="image/user1.png" alt="user_icon">

                            </div> 
                            <h1><%= map.get("userCount") %></h1>
                            <h1 class="text-uppercase text-muted">Users</h1>

                        </div>

                    </div>



                </div>

                <!--second col-->

                <div class="col-md-4">


                    <div class="card text-center">

                        <div class="card-body">

                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="image/category.png" alt="user_icon">

                            </div> 

                            <h1><%= list.size() %></h1>
                            <h1 class="text-uppercase text-muted">Categories</h1>

                        </div>

                    </div>


                </div>


                <!--third col-->
                <div class="col-md-4">


                    <div class="card">

                        <div class="card-body text-center">

                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="image/product.png" alt="user_icon">

                            </div> 

                            <h1><%= map.get("productCount") %></h1>
                            <h1 class="text-uppercase text-muted">Products</h1>

                        </div>

                    </div>


                </div>





            </div>

            <!--second row-->

            <div class="row mt-3">

                <!--second :row first col-->
                <div class="col-md-6">


                    <div class="card" data-toggle="modal" data-target="#add-category-modal">

                        <div class="card-body text-center">

                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="image/addcat.png" alt="user_icon">

                            </div> 

                            <p class="mt-2">Click here to add new category</p>
                            <h1 class="text-uppercase text-muted">Add Category</h1>

                        </div>

                    </div>
                </div>

                <!--second row : second col-->

                <div class="col-md-6">

                    <div class="card" data-toggle="modal" data-target="#add-product-modal">

                        <div class="card-body text-center">

                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="image/addpro1.png" alt="user_icon">

                            </div> 

                            <p class="mt-2">Click here to add new Product</p>
                            <h1 class="text-uppercase text-muted">Add Product</h1>

                        </div>

                    </div>

                </div>




            </div>



        </div>



        <!--add category modal-->



        <!-- Modal -->
        <div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Fill category details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="CategoryAddServlet" method="post">


                            <div class="form-group">
                                <input type="text" class="form-control" name="categoryName" placeholder="Enter Category Name...." required />

                            </div>


                            <div class="form-group">
                                <textarea style="height: 300px;" class="form-control" placeholder="Enter Category Description...." name="categoryDescription" required></textarea>

                            </div>

                            <div class="cotnainer text-center">

                                <button class="btn btn-outline-success">Add Category</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>

                            </div>



                        </form>




                    </div>

                </div>
            </div>
        </div>




        <!--End add category modal-->

        <!--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

        <!--product modal-->

        <!-- Modal -->
        <div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Product details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <!--form-->

                        <form action="ProductAddServlet" method="post" enctype="multipart/form-data">

                            <!--product title-->

                            <div class="form-group">
                                <input type="text" class="form-control" placeholder="Enter name of product...." name="productName" required />
                            </div>

                            <!--product description-->

                            <div class="form-group">
                                <textarea style="height: 150px;" class="form-control" placeholder="Enter product description...." name="productDescription"></textarea>

                            </div>

                            <!--product price-->

                            <div class="form-group">
                                <input type="number" class="form-control" placeholder="Enter price of product...." name="productPrice" required />
                            </div>

                            <!--product discount-->

                            <div class="form-group">
                                <input type="number" class="form-control" placeholder="Enter product discount...." name="productDiscount" required />
                            </div>


                            <!--product quantity-->

                            <div class="form-group">
                                <input type="number" class="form-control" placeholder="Enter product Quantity...." name="productQuantity" required />
                            </div>


                            <!--product category-->
                           

                            <div class="form-group">
                                <select name="categoryId" class="form-control">
                                   <% 
                                   for (CategoryTable category : list) {
                                   %>
                                   <option value="<%= category.getCategoryId()%>">  <%= category.getCategoryName()%> </option>
                                     <%}%> 
                                </select>
                                
                            </div>
                          


                            <!--product file-->

                            <div class="form-group">
                                <label for="pPic">Select Picture of product</label>  
                                <br>
                                <input type="file" id="pPic" name="productPhoto" required />

                            </div>


                            <!--submit button-->
                            <div class="container text-center">

                                <button class="btn btn-outline-success">Add product</button>

                            </div>



                        </form>
                        <!--end form-->
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!--End product modal-->
        <%@include  file="CommonDesign/modals.jsp" %>

    </body>
</html>

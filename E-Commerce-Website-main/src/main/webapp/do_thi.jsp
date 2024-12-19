<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.eazydeals.entities.Message"%>
<%@page import="com.eazydeals.helper.ConnectionPoolImpl"%>
<%@page import="com.eazydeals.entities.*"%>
<%@page import="java.util.List"%>
<%@page import="com.eazydeals.dao.*"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.TreeSet"%>
<%@page import="com.eazydeals.dao.*"%>
<%@page import="com.eazydeals.entities.*"%>
<%@page import="java.time.*"%>
<!DOCTYPE html>
<html lang="en">
<%
List<Category> categoryList = (List<Category>) session.getAttribute("category");
%>

<%
	
	OrderDao od = new OrderDaoImpl(null);
	List<Order> li = od.getOrderByStatus();
	Map<LocalDate, Long> mapDay = od.getOrderPricePerDayByStatus();
	Map<YearMonth, Long> mapMonth = od.getRevenueMonth(mapDay);
	Map<Integer, Long> mapYear = od.getRevenueYear(mapMonth);
	Map<Integer, String> getMonthOfYear = od.getRevenue12Month(mapYear, mapMonth);
	
	StringBuilder s = new StringBuilder();
	s.append("{");
	for (Map.Entry<Integer, String> x : getMonthOfYear.entrySet()) {
		s.append("\"" + x.getKey() + "\"" + " : " + x.getValue() + ", ");
	}
	s.delete(s.length() - 2, s.length() - 1);
	s.append("}");
	String obj = s.toString().trim(); 
	
	StringBuilder s1 = new StringBuilder();
	s1.append("{");
	for (Map.Entry<LocalDate, Long> x : mapDay.entrySet()) {
		s1.append("\"" + x.getKey() + "\"" + " : " + x.getValue() + ", ");
	}
	s1.delete(s1.length() - 2, s1.length() - 1);
	s1.append("}");
	String obj1 = s1.toString().trim();
	%>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>Quản lý</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- Favicons -->


<!-- Google Fonts -->
<link href="https://fonts.gstatic.com" rel="preconnect">
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
	rel="stylesheet">

<!-- Vendor CSS Files -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
<link href="vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
<link href="vendor/quill/quill.snow.css" rel="stylesheet">
<link href="vendor/quill/quill.bubble.css" rel="stylesheet">
<link href="vendor/remixicon/remixicon.css" rel="stylesheet">
<link href="vendor/simple-datatables/style.css" rel="stylesheet">

<!-- Template Main CSS File -->
<link href="CSS/style_admin.css" rel="stylesheet">


</head>

<body>

	<!-- ======= Header ======= -->
	<%@include file="Components/header_admin.jsp"%>

	<!-- ======= Sidebar ======= -->
	<%@include file="Components/sidebar_admin.jsp"%>
	<!-- End Sidebar-->

	<main id="main" class="main">
		<div class="pagetitle">
			<h1>Thống kê</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item">Trang chủ</li>
					<li class="breadcrumb-item">Thống kê</li>
				</ol>
			</nav>
		</div>
		<!-- End Page Title -->

		

		<section class="section">
			<div class="row">

				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<div class="d-flex">
							  <div><h5 class="card-title me-4">Biểu đồ doanh thu các tháng trong năm:</h5></div>
							  <div>
								 	<div  id="obj" class="d-none"> <%= obj %></div>
									<select id="colorSelect" onchange="Change()" class="mt-3">
										<%for (int x : mapYear.keySet())  {%>
											<option value="<%= x %>"><%= x %></option>
										<%} %>	
									</select>
								</div> 
							</div>
							 
							<!-- Line Chart -->
							<div  id="obj1" class="d-none"> <%= obj1 %></div>
							<div id="lineChart"></div>
 
							 <script>
                (function() {
                    var chart; // Declare chart variable outside

                    function drawChart(data) {
                        if (chart) {
                            chart.destroy(); // Destroy the old chart before creating a new one
                        }
                        chart = new ApexCharts(document.querySelector("#lineChart"), {
                            series: [{
                                name: "Doanh thu",
                                data: data
                            }],
                            chart: {
                                height: 350,
                                type: 'line',
                                zoom: {
                                    enabled: false
                                }
                            },
                            dataLabels: {
                                enabled: false
                            },
                            stroke: {
                                curve: 'straight'
                            },
                            grid: {
                                row: {
                                    colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
                                    opacity: 0.5
                                },
                            },
                            xaxis: {
                                categories: ['1', '2', '3', '4', '5', '6', '7', '8', '9','10','11','12'],
                            }
                        });
                        chart.render();
                    }

                    function changeChart() {
                        var data = document.getElementById("obj").innerHTML.trim();
                        var obj = JSON.parse(data);
                        var year = document.getElementById('colorSelect').value;
                        if (obj[year]) {
                            drawChart(obj[year]);
                        } else {
                            console.error('Year not found in data:', year);
                        }
                    }

                    document.getElementById('colorSelect').addEventListener('change', changeChart);

                    document.addEventListener("DOMContentLoaded", () => {
                        changeChart(); // Initialize the chart when the document is ready
                    });
                })();
            </script>
							<!-- End Line Chart -->

						</div>
					</div>
				</div>


				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">Biểu đồ doanh thu theo năm</h5>

							<!-- Bar Chart -->
							<div id="barChart"></div>

							<script>
                document.addEventListener("DOMContentLoaded", () => {
                  new ApexCharts(document.querySelector("#barChart"), {
                    series: [{
                      name: "Doanh thu",
                      data: <%=Order.listLongString(mapYear)%>
                    }],
                    chart: {
                      type: 'bar',
                      height: 350
                    },
                    plotOptions: {
                      bar: {
                        borderRadius: 4,
                        horizontal: true,
                      }
                    },
                    dataLabels: {
                      enabled: false
                    },
                    xaxis: {
                      categories:<%=Order.listSetString(mapYear)%>,
                    }
                  }).render();
                });
              </script>
							<!-- End Bar Chart -->

						</div>
					</div>
				</div>
			</div>
			
		<!-- thống kê theo ngày -->	
	<div class="col-lg-12">
          <div class="card">
            <div class="card-body">
              
              <div id="dateList"></div>

              <h5 class="card-title">Thống kê doanh thu theo ngày</h5>
              <label for="begin">Ngày bắt đầu:</label>
              <input type="date" id="begin" value="2024-06-10">
              <label for="end">Ngày kết thúc:</label>
              <input type="date" id="end" value="2024-06-15">
              <!-- Area Chart -->
              <div id="areaChart"></div>
            </div>
          </div>
        </div>
        <script>
        var data1 = document.getElementById("obj1").innerHTML.trim();
        var obj1 = JSON.parse(data1);
          /* var obj = {
              "2024-06-10": 100, "2024-06-11": 110, "2024-06-12": 200, "2024-06-13": 140, "2024-06-14": 160,
              "2024-06-15": 120, "2024-06-16": 100, "2024-06-17": 100, "2024-06-18": 100, "2024-06-19": 100,
              "2024-06-20": 150, "2024-06-21": 100, "2024-06-22": 160, "2024-06-23": 100, "2024-06-24": 100
          }; */
          var beginDateInput = document.getElementById("begin");
          var endDateInput = document.getElementById("end");
          var dateListDiv = document.getElementById("dateList");
          var arrDay = [];
          var value = [];
          var areaChart = null;
  
          beginDateInput.addEventListener("change", updateDateList);
          endDateInput.addEventListener("change", updateDateList);
  
          document.addEventListener("DOMContentLoaded", () => {
              updateDateList();
          });
  
          function updateDateList() {
              arrDay = [];
              value = [];
              var beginDate = new Date(beginDateInput.value);
              var endDate = new Date(endDateInput.value);
              dateListDiv.innerHTML = '';
  
              if (isNaN(beginDate) || isNaN(endDate)) {
                  return; // Nếu một trong hai ngày không hợp lệ thì thoát
              }
  
              if (endDate < beginDate) {
                  alert("Ngày kết thúc phải lớn hơn hoặc bằng ngày bắt đầu.");
                  return;
              }
  
              var currentDate = new Date(beginDate);
  
              while (currentDate <= endDate) {
                  var formattedDate = currentDate.toISOString().split('T')[0];
                  arrDay.push(formattedDate);
                  if (formattedDate in obj1) {
                	  value.push(obj1[formattedDate]);
                	} else {
                	    value.push(0);
                	}
                  currentDate.setDate(currentDate.getDate() + 1);
              }
              updateAreaChart();
              console.log(value); // Hiển thị mảng value trong console
          }
  
          function updateAreaChart() {
              if (areaChart) {
                  areaChart.updateOptions({
                      series: [{
                          data: value
                      }],
                      labels: arrDay
                  });
              } else {
                  areaChart = new ApexCharts(document.querySelector("#areaChart"), {
                      series: [{
                          name: "Doanh thu",
                          data: value
                      }],
                      chart: {
                          type: 'area',
                          height: 350,
                          zoom: {
                              enabled: false
                          }
                      },
                      dataLabels: {
                          enabled: false
                      },
                      stroke: {
                          curve: 'straight'
                      },
                      subtitle: {
                          text: 'Doanh thu',
                          align: 'left'
                      },
                      labels: arrDay,
                      xaxis: {
                          type: 'date',
                      },
                      yaxis: {
                          opposite: true
                      },
                      legend: {
                          horizontalAlign: 'left'
                      }
                      
                  });
  
                  areaChart.render();
              }
          }
      </script>
		</section>

	</main>
	<!-- End #main -->



	<a href="#"
		class="back-to-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>

	<script>
		var element = document.getElementById("dothi");
		element.classList.remove("collapsed");
	</script>
	<!-- Vendor JS Files -->
	<script src="vendor/apexcharts/apexcharts.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="vendor/chart.js/chart.umd.js"></script>
	<script src="vendor/echarts/echarts.min.js"></script>
	<script src="vendor/quill/quill.js"></script>
	<script src="vendor/simple-datatables/simple-datatables.js"></script>
	<script src="vendor/tinymce/tinymce.min.js"></script>
	<script src="vendor/php-email-form/validate.js"></script>

	<!-- Template Main JS File -->


</body>

</html>
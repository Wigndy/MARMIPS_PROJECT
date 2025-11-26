Tuyệt vời! Dưới đây là hai phiên bản của file README, một bằng tiếng Việt và một bằng tiếng Anh, dựa trên nội dung báo cáo của bạn.

---

# 💻 README: Bài Tập Lớn Kiến Trúc Máy Tính (Vietnamese Version)

## [cite_start]🎓 Thông Tin Chung [cite: 1, 6, 8]

* [cite_start]**Đơn vị thực hiện:** Trường Đại học Bách Khoa TP.HCM [cite: 1, 13]
* [cite_start]**Khoa:** Khoa Khoa học và Kỹ thuật Máy tính [cite: 2, 13]
* [cite_start]**Môn học:** Kiến Trúc Máy Tính [cite: 4]
* [cite_start]**Sinh viên thực hiện:** Lê Nguyễn Kim Khôi - 2311671 [cite: 6]
* [cite_start]**Lớp:** TN01 [cite: 8]
* [cite_start]**Thời gian:** Tháng 11/2024 [cite: 9]

---

## [cite_start]💡 Giới Thiệu Đề Tài: Phép Tích Chập (Convolution) [cite: 14]

[cite_start]Đề tài tập trung vào việc hiện thực hóa phép toán **tích chập** (convolution) trên ma trận ảnh [cite: 21][cite_start], một phép toán cơ bản trong **Mạng Nơ-ron Tích chập (CNN)**[cite: 16]. [cite_start]CNN được sử dụng rộng rãi trong phân tích hình ảnh và video[cite: 16].

[cite_start]Chương trình thực hiện tính toán tích chập trên ma trận ảnh bằng cách dịch chuyển ma trận kernel trên ma trận ảnh với bước di chuyển (**stride** $s$) được quy định[cite: 21]. [cite_start]Trước khi dịch chuyển, cần xác định có cần mở rộng ma trận ảnh ra không bằng chỉ số **padding** ($p$) được cung cấp ban đầu[cite: 22].

### [cite_start]📥 Định dạng File Đầu Vào (`input_matrix.txt`) [cite: 23]

[cite_start]File đầu vào chứa các thông tin sau, được ghi trên cùng 1 hàng và cách nhau bởi dấu cách[cite: 23]:

* **N:** Kích thước ma trận ảnh (image). ($3 \le N \le 7$) [cite_start][cite: 24]
* **M:** Kích thước ma trận kernel. ($2 \le M \le 4$) [cite_start][cite: 25]
* **p:** Giá trị mở rộng (padding). ($0 \le p \le 4$) [cite_start][cite: 26]
* **s:** Giá trị dịch chuyển (stride). ($1 \le s \le 3$) [cite_start][cite: 27]

[cite_start]Hai hàng tiếp theo lần lượt là các giá trị của ma trận **image** và ma trận **kernel**[cite: 28]. [cite_start]Tất cả các số đều là số chấm động với **1 chữ số thập phân duy nhất**[cite: 29].

### [cite_start]📤 Yêu Cầu Đầu Ra [cite: 30]

[cite_start]Yêu cầu xuất ra file ma trận kết quả sau theo cách tính toán trên[cite: 30].

---

## ⚙️ Ý Tưởng Thực Hiện Chi Tiết

### [cite_start]1. Bước 1: Đọc dữ liệu từ file đầu vào [cite: 36]
* [cite_start]Đọc và phân tích các tham số **N, M, p, s**[cite: 41].
* [cite_start]**Kiểm tra điều kiện:** Nếu $N+2p < M$, chương trình sẽ xuất ra thông báo `Error: size not match` trong file đầu ra và bỏ qua các bước tính toán tiếp theo[cite: 44].
* [cite_start]Đọc ma trận ảnh và ma trận kernel từ file và lưu vào vùng nhớ `image` và `kernel`[cite: 46, 49].

### [cite_start]2. Bước 2: Tạo ma trận đệm từ padding [cite: 51]
* [cite_start]Khởi tạo ma trận đệm với kích thước mở rộng là $N+2p$ và tất cả các phần tử thành 0[cite: 52, 53].
* [cite_start]Sao chép các phần tử của ma trận ảnh vào vị trí thích hợp trong ma trận đệm[cite: 55].

### [cite_start]3. Bước 3: Thực hiện phép tích chập (Convolution) [cite: 56]
* [cite_start]Duyệt qua từng phần tử của ma trận kết quả[cite: 60].
* [cite_start]Tính tổng tích chập của các phần tử tương ứng trong ma trận đệm và ma trận kernel[cite: 61].
* [cite_start]**Làm tròn thập phân:** Các số thập phân được làm tròn để có **một chữ số thập phân sau dấu chấm**[cite: 67].
    * [cite_start]Ví dụ: $4.54 \to 4.5$, còn $4.56 \to 4.6$[cite: 68].
    * [cite_start]Cần quản lý trường hợp đặc biệt: các giá trị nhỏ hơn $-0.05$ sau khi làm tròn phải được trả về **0.0** thay vì `-0.0`[cite: 70, 71].

### [cite_start]4. Bước 4: Lưu ma trận kết quả vào file đầu ra [cite: 74]
* [cite_start]Duyệt qua từng phần tử của ma trận kết quả và ghi vào buffer[cite: 76].
* [cite_start]Phương pháp xử lý cần phân biệt ra từng thành phần của số thực bao gồm: dấu, phần nguyên, dấu chấm động, và phần thập phân[cite: 77].
* [cite_start]Mở file và xuất buffer ra file kết quả, sau đó đóng file[cite: 79].

---

## [cite_start]✅ Kết Quả Chạy Thử (Test Cases) [cite: 83]

| Testcase | Tham số (N M p s) | Kết quả Đầu ra | Ghi chú |
| :---: | :---: | :--- | :--- |
| **1** | [cite_start]5.0 3.0 1.0 1.0 [cite: 85] | [cite_start]-0.2 2.5 -0.1 -1.0 -1.0 -2.4... [cite: 88] | |
| **3** | [cite_start]4.0 4.0 0.0 3.0 [cite: 95] | [cite_start]-334.6 [cite: 98] | |
| **5** | [cite_start]3.0 4.0 0.0 1.0 [cite: 109] | [cite_start]Error: size not match [cite: 113] | [cite_start]Điều kiện $N+2p < M$ không thỏa mãn [cite: 44] |

---

## [cite_start]📝 Tổng Kết và Đánh giá [cite: 117]

### [cite_start]Ưu điểm [cite: 118]
* [cite_start]Hiện thực hiệu quả, bao quát gần như đầy đủ tất cả các trường hợp[cite: 119].
* [cite_start]Cách làm phân từng đoạn code ra thành từng phân mục nhỏ giúp dễ dàng quản lý và tránh bị lỗi trong quá trình hiện thực[cite: 121].

### [cite_start]Khuyết điểm [cite: 122]
* [cite_start]Số lượng lệnh được gọi ra sẽ bị nhiều hơn do hiện thực code theo từng phân đoạn nhỏ để dễ quản lý[cite: 123].
* [cite_start]Code chưa được tối ưu về mặt tốc độ nếu chạy ở các testcase vượt ngoài phạm vi của bài toán đã đề ra[cite: 124].

---
---

# 💻 README: Computer Architecture Term Project (English Version)

## [cite_start]🎓 General Information [cite: 1, 6, 8]

* [cite_start]**Institution:** Ho Chi Minh City University of Technology (HCMUT) [cite: 1, 13]
* [cite_start]**Faculty:** Faculty of Computer Science and Engineering [cite: 2, 13]
* [cite_start]**Course:** Computer Architecture [cite: 4]
* [cite_start]**Student:** Lê Nguyễn Kim Khôi - 2311671 [cite: 6]
* [cite_start]**Class:** TN01 [cite: 8]
* [cite_start]**Date:** November 2024 [cite: 9]

---

## [cite_start]💡 Project Introduction: Convolution Operation [cite: 14]

[cite_start]This project focuses on implementing the **convolution** operation on an image matrix [cite: 21][cite_start], a fundamental operation in **Convolutional Neural Networks (CNNs)**[cite: 16]. [cite_start]CNNs are widely used in image and video analysis[cite: 16].

[cite_start]The program computes convolution by sliding the **kernel matrix** over the image matrix with a specified movement step (**stride** $s$)[cite: 21]. [cite_start]Before sliding, it must be determined whether the image matrix needs to be extended based on the initial **padding** ($p$) value provided[cite: 22].

### [cite_start]📥 Input File Format (`input_matrix.txt`) [cite: 23]

[cite_start]The input file contains the following information, written on the same line and separated by spaces[cite: 23]:

* **N:** Image matrix size. ($3 \le N \le 7$) [cite_start][cite: 24]
* **M:** Kernel matrix size. ($2 \le M \le 4$) [cite_start][cite: 25]
* **p:** Padding value. ($0 \le p \le 4$) [cite_start][cite: 26]
* **s:** Stride value. ($1 \le s \le 3$) [cite_start][cite: 27]

[cite_start]The next two lines contain the values of the **image** matrix and the **kernel** matrix, respectively[cite: 28]. [cite_start]All numbers are floating-point numbers with a **single decimal place**[cite: 29].

### [cite_start]📤 Output Requirement [cite: 30]

[cite_start]The requirement is to output the resulting matrix to a file based on the calculation method[cite: 30].

---

## ⚙️ Implementation Strategy (4 Steps)

### [cite_start]1. Step 1: Read Input Data [cite: 36]
* [cite_start]Read and parse the parameters **N, M, p, s**[cite: 41].
* [cite_start]**Condition Check:** If $N+2p < M$, the program skips all subsequent calculations and outputs an `Error: size not match` message to the output file[cite: 44].
* [cite_start]Read the image and kernel matrices from the file and store them in the `image` and `kernel` memory regions (using `word` type)[cite: 46, 49].

### [cite_start]2. Step 2: Create Padded Matrix [cite: 51]
* [cite_start]Initialize the padded matrix with the expanded size $N+2p$, setting all elements to 0[cite: 52, 53].
* [cite_start]Copy the elements of the image matrix into the appropriate positions within the padded matrix[cite: 55].

### [cite_start]3. Step 3: Perform Convolution [cite: 56]
* [cite_start]Iterate through each element of the result matrix[cite: 60].
* [cite_start]Calculate the convolution sum (dot product) of the corresponding elements in the padded matrix and the kernel matrix[cite: 61].
* [cite_start]**Decimal Rounding:** The results must be rounded to have **exactly one decimal digit** after the point[cite: 67].
    * [cite_start]Example: $4.54 \to 4.5$, while $4.56 \to 4.6$[cite: 68].
    * [cite_start]A special case must be handled: values smaller than $-0.05$ after rounding should be output as **0.0** instead of `-0.0`[cite: 70, 71].

### [cite_start]4. Step 4: Save Result Matrix to Output File [cite: 74]
* [cite_start]Iterate through each element of the result matrix and write it to a buffer[cite: 76].
* [cite_start]The output process for floating-point numbers must parse the number into its components: sign, integer part, decimal point, and fractional part[cite: 77].
* [cite_start]Open the output file, write the buffer content, and close the file[cite: 79].

---

## [cite_start]✅ Test Results (Test Cases) [cite: 83]

| Testcase | Parameters (N M p s) | Output Result | Notes |
| :---: | :---: | :--- | :--- |
| **1** | [cite_start]5.0 3.0 1.0 1.0 [cite: 85] | [cite_start]-0.2 2.5 -0.1 -1.0 -1.0 -2.4... [cite: 88] | |
| **3** | [cite_start]4.0 4.0 0.0 3.0 [cite: 95] | [cite_start]-334.6 [cite: 98] | |
| **5** | [cite_start]3.0 4.0 0.0 1.0 [cite: 109] | [cite_start]Error: size not match [cite: 113] | [cite_start]Condition $N+2p < M$ is violated [cite: 44] |

---

## [cite_start]📝 Conclusion and Evaluation [cite: 117]

### [cite_start]Strengths [cite: 118]
* [cite_start]The implementation is effective, covering almost all possible cases[cite: 119].
* [cite_start]The modular approach, segmenting the code into smaller parts, helps with easy management and prevents errors during implementation[cite: 121].

### [cite_start]Weaknesses [cite: 122]
* [cite_start]The modularity for easy management results in a higher number of instructions called[cite: 123].
* [cite_start]The code is not optimized for speed when run with test cases exceeding the scope of the problem statement[cite: 124].

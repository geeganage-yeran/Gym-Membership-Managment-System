//showing main content

let header = document.getElementById("header-title");
function showSection(sectionId) {
    header.innerHTML = sectionId.charAt(0).toUpperCase() + sectionId.slice(1);
    header.style.color="#f5540f";
    header.style.fontWeight="700";
    document.querySelectorAll('.content').forEach(section => {
        section.classList.remove('active');
    });
    document.querySelectorAll('.navLinks a').forEach(link => {
        link.classList.remove('active');
    });
    document.getElementById(sectionId).classList.add('active');
    document.querySelector(`.navLinks a[onclick="showSection('${sectionId}')"]`).classList.add('active');
}
showSection('Schedule-Classes');
function HeaderVisibility() {
    header.style.display = (window.innerWidth <= 768) ? "none" : "block";
}
HeaderVisibility();
window.addEventListener("resize",HeaderVisibility);

//Ham menue
const hambMenu = document.getElementById("hambMenu");
const sideBar = document.getElementById("sidebar");
const closeMenue = document.getElementById("closeMenue");

hambMenu.addEventListener("click", function () {
    sideBar.classList.toggle("show");
});
closeMenue.addEventListener("click", function () {
    sideBar.classList.remove("show");
});



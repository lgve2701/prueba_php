const headers = document.querySelectorAll(".accordion-header");

headers.forEach(header => {
header.addEventListener("click", () => {
    const content = header.nextElementSibling;

    // Colapsar otros
    document.querySelectorAll(".accordion-content").forEach(item => {
    if (item !== content) {
        item.style.display = "none";
    }
    });

    // Alternar actual
    content.style.display = (content.style.display === "block") ? "none" : "block";
});
});

function toggleInfo(card) {
card.classList.toggle("active");
}

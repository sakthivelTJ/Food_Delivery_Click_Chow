/**
 * Click Chow - Main JavaScript Application
 */

document.addEventListener("DOMContentLoaded", () => {
    initHeroSlider();
    initFoodSearch();
    initThemeToggle();
});

/**
 * Hero Showcase Food Picture Auto-Slider
 */
function initHeroSlider() {
    const heroShowcaseItems = [
        { img: "assets/images/burger.png", title: "Gourmet Burger", price: "₹199", rating: "4.9" },
        { img: "assets/images/pizza.png", title: "Pepperoni Pizza", price: "₹349", rating: "4.8" },
        { img: "assets/images/biryani.png", title: "Special Biryani", price: "₹299", rating: "5.0" },
        { img: "assets/images/sushi.png", title: "Salmon Sushi", price: "₹450", rating: "4.9" },
        { img: "assets/images/paneertikka.png", title: "Paneer Tikka", price: "₹240", rating: "4.7" },
        { img: "assets/images/dessert.png", title: "Choco Lava Cake", price: "₹150", rating: "4.9" }
    ];

    let heroIdx = 0;
    const imgEl = document.getElementById("hero-slider-img");
    const titleEl = document.getElementById("hero-badge-title");
    const priceEl = document.getElementById("hero-badge-price");
    const ratingEl = document.getElementById("hero-badge-rating");

    if (imgEl && titleEl && priceEl && ratingEl) {
        setInterval(() => {
            heroIdx = (heroIdx + 1) % heroShowcaseItems.length;
            const current = heroShowcaseItems[heroIdx];

            imgEl.style.opacity = "0.2";
            imgEl.style.transform = "scale(0.92) rotate(-5deg)";

            setTimeout(() => {
                imgEl.src = current.img;
                titleEl.innerText = current.title;
                priceEl.innerText = current.price;
                ratingEl.innerHTML = '<i class="fa-solid fa-star"></i> ' + current.rating;
                imgEl.style.opacity = "1";
                imgEl.style.transform = "scale(1) rotate(0deg)";
            }, 250);
        }, 3000);
    }
}

/**
 * Real-time Hero Food & Restaurant Search with Live Dropdown Results
 */
function initFoodSearch() {
    const searchInput = document.getElementById("food-search");
    const searchBox = document.querySelector(".search-box");
    const searchBtn = document.querySelector(".search-btn");

    if (!searchInput || !searchBox) return;

    // Sample catalogue of food items
    const foodCatalogue = [
        { name: "Gourmet Cheeseburger", category: "Burger", price: "₹199", rating: "4.9 ★", img: "assets/images/burger.png", keywords: ["burger", "cheeseburger", "beef", "fast food"] },
        { name: "Pepperoni Cheese Pizza", category: "Pizza", price: "₹349", rating: "4.8 ★", img: "assets/images/pizza.png", keywords: ["pizza", "pepperoni", "cheese", "italian"] },
        { name: "Special Hyderabadi Biryani", category: "Biryani", price: "₹299", rating: "5.0 ★", img: "assets/images/biryani.png", keywords: ["biryani", "rice", "chicken", "pulao", "hyderabadi"] },
        { name: "Fresh Salmon Sushi", category: "Asian", price: "₹450", rating: "4.9 ★", img: "assets/images/sushi.png", keywords: ["sushi", "salmon", "japanese", "asian", "fish"] },
        { name: "Tandoori Paneer Tikka", category: "Starters", price: "₹240", rating: "4.7 ★", img: "assets/images/paneertikka.png", keywords: ["paneer", "tikka", "tandoori", "starter", "veg"] },
        { name: "Choco Lava Cake & Desserts", category: "Dessert", price: "₹150", rating: "4.9 ★", img: "assets/images/dessert.png", keywords: ["cake", "dessert", "chocolate", "sweet", "ice cream"] }
    ];

    // Create live dropdown container
    let dropdown = document.createElement("div");
    dropdown.className = "search-results-dropdown";
    dropdown.style.display = "none";
    searchBox.appendChild(dropdown);

    // Filter and render dropdown results
    const renderSearchResults = (query) => {
        if (!query) {
            dropdown.style.display = "none";
            dropdown.innerHTML = "";
            filterPageCards("");
            return;
        }

        const matches = foodCatalogue.filter(item => 
            item.name.toLowerCase().includes(query) ||
            item.category.toLowerCase().includes(query) ||
            item.keywords.some(k => k.toLowerCase().includes(query))
        );

        if (matches.length > 0) {
            dropdown.innerHTML = `
                <div style="font-size:13px; font-weight:700; color:#ff5a36; margin-bottom:8px; padding-left:4px;">
                    🍕 ${matches.length} Food Item(s) Found:
                </div>
                ` + matches.map(item => `
                    <a href="#restaurants-section" onclick="handleSearchItemClick('${item.name}')" class="search-item-card">
                        <img src="${item.img}" alt="${item.name}" class="search-item-img" />
                        <div class="search-item-details">
                            <h4>${item.name}</h4>
                            <p>${item.category} • ${item.rating}</p>
                        </div>
                        <div class="search-item-price">${item.price}</div>
                    </a>
                `).join("");
        } else {
            dropdown.innerHTML = `
                <div style="padding:15px; text-align:center; color:#9ea8bc; font-size:14px;">
                    🔍 No food items found matching "<strong>${query}</strong>"
                </div>
            `;
        }

        dropdown.style.display = "flex";
        filterPageCards(query);
    };

    // Filter restaurant & menu cards rendered on page
    const filterPageCards = (query) => {
        const restaurantCards = document.querySelectorAll(".restaurant-card");
        const menuCards = document.querySelectorAll(".menu-card");

        restaurantCards.forEach((card) => {
            const text = card.innerText.toLowerCase();
            card.style.display = (!query || text.includes(query)) ? "" : "none";
        });

        menuCards.forEach((card) => {
            const text = card.innerText.toLowerCase();
            card.style.display = (!query || text.includes(query)) ? "" : "none";
        });
    };

    // Input listener
    searchInput.addEventListener("input", (e) => {
        const query = e.target.value.toLowerCase().trim();
        renderSearchResults(query);
    });

    searchInput.addEventListener("focus", (e) => {
        const query = e.target.value.toLowerCase().trim();
        if (query) renderSearchResults(query);
    });

    // Search button click action
    if (searchBtn) {
        searchBtn.addEventListener("click", (e) => {
            e.preventDefault();
            const query = searchInput.value.toLowerCase().trim();
            filterPageCards(query);
            dropdown.style.display = "none";
            const target = document.getElementById("restaurants-section");
            if (target) {
                target.scrollIntoView({ behavior: "smooth" });
            }
        });
    }

    // Hide dropdown when clicking outside
    document.addEventListener("click", (e) => {
        if (!searchBox.contains(e.target)) {
            dropdown.style.display = "none";
        }
    });
}

function handleSearchItemClick(itemName) {
    const target = document.getElementById("restaurants-section");
    if (target) {
        target.scrollIntoView({ behavior: "smooth" });
    }
}

/**
 * Theme Toggle Functionality (Dark <-> Light)
 */
function initThemeToggle() {
    const themeBtn = document.getElementById("theme-toggle-btn");
    if (!themeBtn) return;

    // Load saved theme from localStorage
    const savedTheme = localStorage.getItem("clickchow_theme") || "dark";
    applyTheme(savedTheme);

    themeBtn.addEventListener("click", () => {
        const currentTheme = document.documentElement.getAttribute("data-theme") || (document.body.classList.contains("light-theme") ? "light" : "dark");
        const nextTheme = currentTheme === "light" ? "dark" : "light";
        applyTheme(nextTheme);
        localStorage.setItem("clickchow_theme", nextTheme);
    });
}

function applyTheme(theme) {
    const themeBtn = document.getElementById("theme-toggle-btn");
    const icon = themeBtn ? themeBtn.querySelector("i") : null;

    if (theme === "light") {
        document.documentElement.setAttribute("data-theme", "light");
        document.body.classList.add("light-theme");
        if (icon) {
            icon.className = "fa-solid fa-sun";
        }
    } else {
        document.documentElement.setAttribute("data-theme", "dark");
        document.body.classList.remove("light-theme");
        if (icon) {
            icon.className = "fa-solid fa-moon";
        }
    }
}

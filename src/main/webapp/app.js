/**
 * Click Chow - Main JavaScript Application
 */

document.addEventListener("DOMContentLoaded", () => {
    initHeroSlider();
    initFoodSearch();
    initTopHeaderSearch();
    initThemeToggle();
    handleMenuHighlight();
    initSearchResultClickAnimations();
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
 * Helper to resolve appropriate local food asset image by dish name
 */
function resolveFoodImage(itemName, imagePath) {
    if (imagePath && imagePath.trim() !== "" && !imagePath.startsWith("images/menu/") && !imagePath.contains("biryani.png")) {
        return imagePath;
    }
    const name = (itemName || "").toLowerCase();
    if (name.includes("biryani") || name.includes("rice") || name.includes("pulao") || name.includes("thali") || name.includes("tiffin") || name.includes("dosa") || name.includes("idli")) {
        return "assets/images/biryani.png";
    }
    if (name.includes("burger") || name.includes("sandwich") || name.includes("wrap") || name.includes("roll")) {
        return "assets/images/burger.png";
    }
    if (name.includes("pizza") || name.includes("naan") || name.includes("roti") || name.includes("bread") || name.includes("pasta") || name.includes("kulcha")) {
        return "assets/images/pizza.png";
    }
    if (name.includes("paneer") || name.includes("tikka") || name.includes("tandoori") || name.includes("kebab") || name.includes("chicken") || name.includes("mutton") || name.includes("lamb") || name.includes("starter") || name.includes("curry") || name.includes("masala") || name.includes("fry") || name.includes("rasam") || name.includes("chukka") || name.includes("roast")) {
        return "assets/images/paneertikka.png";
    }
    if (name.includes("sushi") || name.includes("noodle") || name.includes("ramen") || name.includes("fish") || name.includes("seafood") || name.includes("asian") || name.includes("prawn") || name.includes("lobster")) {
        return "assets/images/sushi.png";
    }
    if (name.includes("dessert") || name.includes("cake") || name.includes("ice cream") || name.includes("sweet") || name.includes("shake") || name.includes("coffee") || name.includes("tea") || name.includes("drink") || name.includes("lassi") || name.includes("payasam") || name.includes("kesari") || name.includes("jamun") || name.includes("chocolate")) {
        return "assets/images/dessert.png";
    }
    return "assets/images/paneertikka.png";
}

/**
 * Top Right Header Search Bar & Autocomplete Dropdown
 */
let globalFoodList = null;

function initTopHeaderSearch() {
    const wrapper = document.getElementById("header-search-wrapper");
    const triggerBtn = document.getElementById("header-search-trigger");
    const searchInput = document.getElementById("top-food-search");
    const closeBtn = document.getElementById("header-search-close");
    const dropdown = document.getElementById("top-search-dropdown");

    if (!wrapper || !triggerBtn || !searchInput || !dropdown) return;

    // Toggle search bar expansion
    triggerBtn.addEventListener("click", (e) => {
        e.stopPropagation();
        wrapper.classList.add("active");
        setTimeout(() => searchInput.focus(), 150);
        if (searchInput.value.trim().length > 0) {
            performTopSearch(searchInput.value.trim());
        }
    });

    if (closeBtn) {
        closeBtn.addEventListener("click", (e) => {
            e.stopPropagation();
            closeTopSearch();
        });
    }

    function closeTopSearch() {
        wrapper.classList.remove("active");
        dropdown.classList.remove("active");
        searchInput.value = "";
    }

    // Input event for live filtering
    searchInput.addEventListener("input", (e) => {
        const query = e.target.value.trim();
        if (query.length > 0) {
            performTopSearch(query);
        } else {
            dropdown.classList.remove("active");
            dropdown.innerHTML = "";
        }
    });

    searchInput.addEventListener("keydown", (e) => {
        if (e.key === "Enter") {
            e.preventDefault();
            const query = searchInput.value.trim();
            if (query.length > 0) {
                window.location.href = 'searchFood?q=' + encodeURIComponent(query);
            }
        }
    });

    searchInput.addEventListener("focus", () => {
        const query = searchInput.value.trim();
        if (query.length > 0) {
            performTopSearch(query);
        }
    });

    // Close on escape key
    document.addEventListener("keydown", (e) => {
        if (e.key === "Escape") {
            closeTopSearch();
        }
    });

    // Close when clicking outside
    document.addEventListener("click", (e) => {
        if (!wrapper.contains(e.target)) {
            dropdown.classList.remove("active");
        }
    });

    // Load full food list asynchronously
    fetchFoodItemsList();
}

/**
 * Fetch food list from /searchFood endpoint with fallback
 */
function fetchFoodItemsList() {
    fetch("searchFood?ajax=true")
        .then(response => {
            if (!response.ok) throw new Error("Search API HTTP " + response.status);
            return response.json();
        })
        .then(data => {
            if (Array.isArray(data) && data.length > 0) {
                globalFoodList = data;
            } else {
                useFallbackFoodList();
            }
        })
        .catch(err => {
            console.warn("Using fallback food index:", err);
            useFallbackFoodList();
        });
}

function useFallbackFoodList() {
    globalFoodList = [
        { menuId: 1, restaurantId: 1, restaurantName: "Paati Veedu", itemName: "Mini Tiffin", description: "Delicious Mini Tiffin", price: 120, rating: 4.8, imagePath: "assets/images/biryani.png" },
        { menuId: 2, restaurantId: 1, restaurantName: "Paati Veedu", itemName: "Kambu Dosa", description: "Delicious Kambu Dosa", price: 150, rating: 4.7, imagePath: "assets/images/biryani.png" },
        { menuId: 3, restaurantId: 1, restaurantName: "Paati Veedu", itemName: "Mutton Chukka", description: "Delicious Mutton Chukka", price: 180, rating: 4.9, imagePath: "assets/images/paneertikka.png" },
        { menuId: 4, restaurantId: 1, restaurantName: "Paati Veedu", itemName: "Chicken Curry", description: "Delicious Chicken Curry", price: 200, rating: 4.8, imagePath: "assets/images/paneertikka.png" },
        { menuId: 5, restaurantId: 1, restaurantName: "Paati Veedu", itemName: "Filter Coffee", description: "Delicious Filter Coffee", price: 300, rating: 4.8, imagePath: "assets/images/dessert.png" },
        { menuId: 11, restaurantId: 2, restaurantName: "Avartana", itemName: "Smoked Tomato Rasam", description: "Delicious Smoked Tomato Rasam", price: 120, rating: 4.9, imagePath: "assets/images/paneertikka.png" },
        { menuId: 12, restaurantId: 2, restaurantName: "Avartana", itemName: "Truffle Dosa", description: "Delicious Truffle Dosa", price: 150, rating: 4.8, imagePath: "assets/images/biryani.png" },
        { menuId: 13, restaurantId: 2, restaurantName: "Avartana", itemName: "Lobster Curry", description: "Delicious Lobster Curry", price: 180, rating: 5.0, imagePath: "assets/images/sushi.png" },
        { menuId: 21, restaurantId: 3, restaurantName: "J Hind", itemName: "Paneer Butter Masala", description: "Delicious Paneer Butter Masala", price: 120, rating: 4.8, imagePath: "assets/images/paneertikka.png" },
        { menuId: 22, restaurantId: 3, restaurantName: "J Hind", itemName: "Veg Biryani", description: "Delicious Veg Biryani", price: 150, rating: 4.7, imagePath: "assets/images/biryani.png" },
        { menuId: 24, restaurantId: 3, restaurantName: "J Hind", itemName: "Butter Naan", description: "Delicious Butter Naan", price: 200, rating: 4.6, imagePath: "assets/images/pizza.png" },
        { menuId: 29, restaurantId: 3, restaurantName: "J Hind", itemName: "Gulab Jamun", description: "Delicious Gulab Jamun", price: 350, rating: 4.8, imagePath: "assets/images/dessert.png" },
        { menuId: 31, restaurantId: 4, restaurantName: "Dakshin", itemName: "Appam & Vegetable Stew", description: "Delicious Appam", price: 120, rating: 4.8, imagePath: "assets/images/biryani.png" },
        { menuId: 34, restaurantId: 4, restaurantName: "Dakshin", itemName: "Kerala Parotta", description: "Delicious Kerala Parotta", price: 200, rating: 4.8, imagePath: "assets/images/pizza.png" },
        { menuId: 41, restaurantId: 5, restaurantName: "Southern Spice", itemName: "Ghee Roast Dosa", description: "Delicious Ghee Roast Dosa", price: 120, rating: 4.9, imagePath: "assets/images/biryani.png" },
        { menuId: 44, restaurantId: 5, restaurantName: "Southern Spice", itemName: "Mutton Biryani", description: "Delicious Mutton Biryani", price: 200, rating: 4.9, imagePath: "assets/images/biryani.png" },
        { menuId: 53, restaurantId: 6, restaurantName: "Pumpkin Tales", itemName: "Veg Sandwich", description: "Delicious Veg Sandwich", price: 180, rating: 4.6, imagePath: "assets/images/burger.png" },
        { menuId: 54, restaurantId: 6, restaurantName: "Pumpkin Tales", itemName: "Pasta Alfredo", description: "Delicious Pasta Alfredo", price: 200, rating: 4.8, imagePath: "assets/images/pizza.png" },
        { menuId: 55, restaurantId: 6, restaurantName: "Pumpkin Tales", itemName: "Margherita Pizza", description: "Delicious Margherita Pizza", price: 220, rating: 4.9, imagePath: "assets/images/pizza.png" },
        { menuId: 58, restaurantId: 6, restaurantName: "Pumpkin Tales", itemName: "Brownie & Lava Cake", description: "Delicious Brownie", price: 300, rating: 4.9, imagePath: "assets/images/dessert.png" },
        { menuId: 72, restaurantId: 8, restaurantName: "Madras Spice", itemName: "Hyderabadi Biryani", description: "Delicious Hyderabadi Biryani", price: 150, rating: 4.9, imagePath: "assets/images/biryani.png" },
        { menuId: 76, restaurantId: 8, restaurantName: "Madras Spice", itemName: "Butter Chicken", description: "Delicious Butter Chicken", price: 250, rating: 4.9, imagePath: "assets/images/paneertikka.png" },
        { menuId: 95, restaurantId: 10, restaurantName: "Broken Bridge Cafe", itemName: "Veg Cheeseburger", description: "Delicious Veg Burger", price: 220, rating: 4.7, imagePath: "assets/images/burger.png" },
        { menuId: 99, restaurantId: 10, restaurantName: "Broken Bridge Cafe", itemName: "Blueberry Cheesecake", description: "Delicious Blueberry Cheesecake", price: 350, rating: 4.9, imagePath: "assets/images/dessert.png" }
    ];
}

/**
 * Filter & Render results in the top search dropdown
 */
function performTopSearch(query) {
    const dropdown = document.getElementById("top-search-dropdown");
    if (!dropdown) return;

    const q = query.toLowerCase();
    const list = globalFoodList || [];

    const matches = list.filter(item => {
        const name = (item.itemName || "").toLowerCase();
        const desc = (item.description || "").toLowerCase();
        const rest = (item.restaurantName || "").toLowerCase();
        return name.includes(q) || desc.includes(q) || rest.includes(q);
    });

    if (matches.length === 0) {
        dropdown.innerHTML = `
            <div style="padding: 18px 12px; text-align: center; color: #9ea8bc; font-size: 0.88rem;">
                <i class="fa-solid fa-magnifying-glass" style="font-size:1.4rem; color:#ff5a36; margin-bottom:8px; display:block;"></i>
                No food items found matching "<strong>${escapeHtml(query)}</strong>"
            </div>
        `;
    } else {
        dropdown.innerHTML = `
            <div style="font-size:0.75rem; font-weight:700; color:#ff5a36; padding: 4px 8px; text-transform: uppercase; letter-spacing:0.5px;">
                🍕 ${matches.length} Food Result(s)
            </div>
            ` + matches.slice(0, 10).map(item => {
                const img = resolveFoodImage(item.itemName, item.imagePath);
                const priceStr = typeof item.price === "number" ? "₹" + item.price : item.price;
                const ratingStr = item.rating ? "★ " + item.rating : "★ 4.8";
                const targetUrl = `menu?restaurantId=${item.restaurantId}#menu-item-${item.menuId}`;
                return `
                    <a href="${targetUrl}" class="top-search-item" onclick="onTopSearchResultClick(event, '${targetUrl}')">
                        <img src="${img}" alt="${escapeHtml(item.itemName)}" class="top-search-item-img" onerror="this.onerror=null; this.src='assets/images/paneertikka.png';" />
                        <div class="top-search-item-info">
                            <h4 class="top-search-item-title">${escapeHtml(item.itemName)}</h4>
                            <p class="top-search-item-sub"><i class="fa-solid fa-store" style="font-size:0.7rem; color:#ff5a36;"></i> ${escapeHtml(item.restaurantName || "ClickChow")}</p>
                        </div>
                        <div class="top-search-item-meta">
                            <span class="top-search-item-price">${priceStr}</span>
                            <span class="top-search-item-rating">${ratingStr}</span>
                        </div>
                    </a>
                `;
            }).join("");
    }

    dropdown.classList.add("active");
}

function onTopSearchResultClick(e, targetUrl) {
    e.preventDefault();

    const clickedItem = e.target.closest('.top-search-item') || e.target.closest('.search-item-card');

    // If currently already on menu page with same restaurant, scroll directly
    if (window.location.pathname.endsWith("/menu") || window.location.pathname.endsWith("menu.jsp")) {
        const urlObj = new URL(targetUrl, window.location.origin);
        const targetRestId = urlObj.searchParams.get("restaurantId");
        const currentRestId = new URLSearchParams(window.location.search).get("restaurantId");

        if (targetRestId && currentRestId && targetRestId === currentRestId) {
            const dropdown = document.getElementById("top-search-dropdown");
            if (dropdown) dropdown.classList.remove("active");
            const hash = urlObj.hash;
            if (hash) {
                window.location.hash = hash;
                handleMenuHighlight();
            }
            return;
        }
    }

    // Play glow burst animation, then navigate
    if (clickedItem) {
        clickedItem.classList.add('search-item-selected');
        createClickEffects(clickedItem, e);
    }

    setTimeout(() => {
        window.location.href = targetUrl;
    }, 700);
}

/**
 * Creates ripple + flash visual effects on a clicked element
 */
function createClickEffects(element, event) {
    // Ensure element has relative/absolute positioning for overlay children
    const style = window.getComputedStyle(element);
    if (style.position === 'static') {
        element.style.position = 'relative';
    }
    element.style.overflow = 'hidden';

    // Create ripple circle at click position
    const ripple = document.createElement('span');
    ripple.className = 'click-ripple';
    const rect = element.getBoundingClientRect();
    const x = (event.clientX || rect.left + rect.width / 2) - rect.left;
    const y = (event.clientY || rect.top + rect.height / 2) - rect.top;
    ripple.style.left = x + 'px';
    ripple.style.top = y + 'px';
    element.appendChild(ripple);

    // Create flash overlay
    const flash = document.createElement('span');
    flash.className = 'click-flash';
    element.appendChild(flash);

    // Clean up after animation
    setTimeout(() => {
        if (ripple.parentNode) ripple.remove();
        if (flash.parentNode) flash.remove();
    }, 800);
}

/**
 * Intercept clicks on search results page cards (.btn-view-menu)
 */
function initSearchResultClickAnimations() {
    document.addEventListener('click', function(e) {
        const viewMenuBtn = e.target.closest('.btn-view-menu');
        if (!viewMenuBtn) return;

        const card = viewMenuBtn.closest('.menu-card');
        if (!card || card.classList.contains('card-selected')) return;

        e.preventDefault();
        const targetUrl = viewMenuBtn.getAttribute('href');

        // Apply glow burst to the card
        card.classList.add('card-selected');
        createClickEffects(card, e);

        // Scroll the card to center of viewport during animation
        card.scrollIntoView({ behavior: 'smooth', block: 'center' });

        // Navigate after animation completes
        setTimeout(() => {
            window.location.href = targetUrl;
        }, 750);
    });

    // Also handle hero search dropdown item clicks
    document.addEventListener('click', function(e) {
        const heroItem = e.target.closest('.search-item-card');
        if (!heroItem || heroItem.classList.contains('search-item-selected')) return;

        // Only intercept if it has an href (is a link)
        const href = heroItem.getAttribute('href');
        if (!href) return;

        e.preventDefault();
        heroItem.classList.add('search-item-selected');
        createClickEffects(heroItem, e);

        setTimeout(() => {
            window.location.href = href;
        }, 700);
    });
}

function escapeHtml(str) {
    if (!str) return "";
    return String(str)
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;");
}

/**
 * Handles scrolling to & highlighting target menu card on menu.jsp
 */
function handleMenuHighlight() {
    let highlightId = null;
    const hash = window.location.hash;
    if (hash && hash.startsWith("#menu-item-")) {
        highlightId = hash.replace("#menu-item-", "");
    } else {
        const params = new URLSearchParams(window.location.search);
        highlightId = params.get("highlightId") || params.get("menuId");
    }

    if (highlightId) {
        const targetCard = document.getElementById(`menu-item-${highlightId}`);
        if (targetCard) {
            setTimeout(() => {
                targetCard.scrollIntoView({ behavior: "smooth", block: "center" });
                targetCard.classList.add("highlight-pulse");
                setTimeout(() => {
                    targetCard.classList.remove("highlight-pulse");
                }, 3600);
            }, 300);
        }
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

    // Create live dropdown container
    let dropdown = document.createElement("div");
    dropdown.className = "search-results-dropdown";
    dropdown.style.display = "none";
    searchBox.appendChild(dropdown);

    const renderSearchResults = (query) => {
        if (!query) {
            dropdown.style.display = "none";
            dropdown.innerHTML = "";
            filterPageCards("");
            return;
        }

        const list = globalFoodList || [];
        const matches = list.filter(item => {
            const name = (item.itemName || "").toLowerCase();
            const desc = (item.description || "").toLowerCase();
            const rest = (item.restaurantName || "").toLowerCase();
            return name.includes(query) || desc.includes(query) || rest.includes(query);
        });

        if (matches.length > 0) {
            dropdown.innerHTML = `
                <div style="font-size:13px; font-weight:700; color:#ff5a36; margin-bottom:8px; padding-left:4px;">
                    🍕 ${matches.length} Food Item(s) Found:
                </div>
                ` + matches.slice(0, 8).map(item => {
                    const img = resolveFoodImage(item.itemName, item.imagePath);
                    const targetUrl = `menu?restaurantId=${item.restaurantId}#menu-item-${item.menuId}`;
                    return `
                        <a href="${targetUrl}" class="search-item-card">
                            <img src="${img}" alt="${escapeHtml(item.itemName)}" class="search-item-img" onerror="this.onerror=null; this.src='assets/images/paneertikka.png';" />
                            <div class="search-item-details">
                                <h4>${escapeHtml(item.itemName)}</h4>
                                <p>${escapeHtml(item.restaurantName || "ClickChow")} • ★ ${item.rating || 4.8}</p>
                            </div>
                            <div class="search-item-price">₹${item.price}</div>
                        </a>
                    `;
                }).join("");
        } else {
            dropdown.innerHTML = `
                <div style="padding:15px; text-align:center; color:#9ea8bc; font-size:14px;">
                    🔍 No food items found matching "<strong>${escapeHtml(query)}</strong>"
                </div>
            `;
        }

        dropdown.style.display = "flex";
        filterPageCards(query);
    };

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

    searchInput.addEventListener("input", (e) => {
        const query = e.target.value.toLowerCase().trim();
        renderSearchResults(query);
    });

    searchInput.addEventListener("keydown", (e) => {
        if (e.key === "Enter") {
            e.preventDefault();
            const query = searchInput.value.trim();
            if (query.length > 0) {
                window.location.href = 'searchFood?q=' + encodeURIComponent(query);
            }
        }
    });

    searchInput.addEventListener("focus", (e) => {
        const query = e.target.value.toLowerCase().trim();
        if (query) renderSearchResults(query);
    });

    if (searchBtn) {
        searchBtn.addEventListener("click", (e) => {
            e.preventDefault();
            const query = searchInput.value.trim();
            if (query.length > 0) {
                window.location.href = 'searchFood?q=' + encodeURIComponent(query);
            }
        });
    }

    document.addEventListener("click", (e) => {
        if (!searchBox.contains(e.target)) {
            dropdown.style.display = "none";
        }
    });
}

/**
 * Theme Toggle Functionality (Dark <-> Light)
 */
function initThemeToggle() {
    const themeBtn = document.getElementById("theme-toggle-btn");
    if (!themeBtn) return;

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

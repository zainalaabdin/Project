  window.onload = function () {
    const token = localStorage.getItem("token");
    const name = localStorage.getItem("name");
    
    const usernameSpan = document.getElementById("usernamePlaceholder");
    const accountLink = document.getElementById("accountLink");
    if (token && name) {
    
    usernameSpan.textContent = `${name} | Logout`;
    accountLink.href = "#"; 
    accountLink.onclick = function () {
      localStorage.removeItem("token");
      localStorage.removeItem("name");
      localStorage.removeItem("isLoggedIn");
      window.location.href = "login.html";
    };
    } else {
    
    usernameSpan.textContent = "Account";
    accountLink.href = "login.html";
    }
    
    if (token) {
      fetch("http://localhost:3000/api/validateToken", {
        method: "POST",
        headers: {
          'Authorization': `Bearer ${token}`
        }
      })
      .then(response => {
        if (!response.ok) {
          localStorage.clear();
          window.location.href = "login.html";
        }
      })
      .catch(err => {
        console.error("Token check error:", err);
        localStorage.clear();
        window.location.href = "login.html";
      });
    }
  };


  $(document).ready(function () {
    $("#logoutBtn").on("click", function () {
      localStorage.removeItem("token");
      localStorage.removeItem("name");
      localStorage.removeItem("isLoggedIn");
      
      window.location.href = "login.html";
    });
  });

  //FETCH MENU JS CODE
  
  function getMenu() {
  $.ajax({
    url: 'http://localhost:3000/api/getMenu',
    method: 'GET',
    success: function (data) {
      let menuHtml = '';

      // const slugMap = {
      //   "Home": "index.html",
      //   "Shop": "shop.html",
      //   "Men": "men.html",
      //   "Women": "women.html",
      //   "Kids": "kids.html",
      //   "Accessories": "accessories.html",
      //   "About Us": "about.html",
      //   "FAQ": "faq.html",
      //   "Size Guide": "size-guide.html",
      //   "Return & Exchange": "return.html",
      //   "Privacy Policy": "privacy.html",
      //   "Contact Us": "contact.html"
      // };

      for (let i = 0; i < data.length; i++) {
        const parent = data[i];
        const parentSlug = parent.slug || "#";

        if (parent.children && parent.children.length > 0) {
          menuHtml += `
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="${parentSlug}" role="button" data-bs-toggle="dropdown">
                ${parent.title}
              </a>
              <ul class="dropdown-menu custom-dropdown">
          `;

          menuHtml = populateChidern(parent.children, menuHtml);

          menuHtml += `</ul></li>`;
        } else {
          menuHtml += `<li class="nav-item"><a class="nav-link" href="${parentSlug}">${parent.title}</a></li>`;
        }
      }

      $('#dynamicMenu').html(menuHtml);
    },
    error: function (jqXHR, textStatus, errorThrown) {
      console.log("Status Code:", jqXHR.status);
      console.log("Status Text:", jqXHR.statusText);
      console.log("Response Text:", jqXHR.responseText);
      console.log("Text Status:", textStatus);
      console.log("Error Thrown:", errorThrown);
    }
  });
}

$(document).ready(function () {
  getMenu();
});

function populateChidern(children, menuHtml = '') {
  for (let j = 0; j < children.length; j++) {
    const child = children[j];
    const childSlug = child.slug || "#";

    if (child.children && child.children.length > 0) {
      menuHtml += `
        <li class="dropdown-submenu">
          <a class="dropdown-item dropdown-toggle" href="${childSlug}">${child.title}</a>
          <ul class="dropdown-menu">
            ${populateChidern(child.children)}
          </ul>
        </li>
      `;
    } else {
      menuHtml += `<li><a class="dropdown-item" href="${childSlug}">${child.title}</a></li>`;
    }
  }

  return menuHtml;
}




//FETCH PRODUCT
function fetchProducts() {
  $.ajax({
    url: "http://localhost:3000/api/getProducts",
    method: "GET",
    success: function (products) {
      let html = '';

      products.forEach(product => {
        html += `
        <div class="col-md-3">
          <div class="card border-0 shadow-sm h-100">
            <div class="position-relative">
              ${product.discount_price ? `<span class="badge bg-danger position-absolute top-0 start-0 m-2">Sale</span>` : ''}
              <div class="image-wrapper position-relative">
                <img src="${product.image_url}" class="card-img-top" alt="${product.name}">
                <button class="add-to-cart-btn">Add to Cart</button>
              </div>
            </div>
            <div class="card-body">
              <h6 class="card-title">${product.name}</h6>
              <p class="text-danger fw-bold mb-1">PKR ${product.price}
                ${product.discount_price ? `<del class="text-muted fs-sm">${product.discount_price}</del>` : ''}
              </p>
              <div class="text-warning small">
                ${renderStars(product.rating)} <span class="text-muted">(${product.reviews_count})</span>
              </div>
            </div>
          </div>
        </div>
        `;
      });

      $('#product-list').html(html);
    },
    error: function (xhr, status, error) {
      console.error("Failed to load products", error);
    }
  });
}

function renderStars(rating) {
  let stars = '';
  let r = Math.round(rating);
  for (let i = 0; i < 5; i++) {
    stars += i < r ? '★' : '☆';
  }
  return stars;
}

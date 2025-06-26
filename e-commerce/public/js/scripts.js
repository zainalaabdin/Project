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

function populateChidern(children, menuHtml){

  
  for (let j = 0; j < children.length; j++) {

    const child = children[j];

      if (child.children && child.children.length > 0){
        menuHtml = populateChidern(child.children);
      }


    const childSlug = child.slug || "#";
    menuHtml += `<li><a class="dropdown-item" href="${childSlug}">${child.title}</a></li>`;
  }

    return menuHtml

}
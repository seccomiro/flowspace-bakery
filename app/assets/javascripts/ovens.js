$(document).on("turbolinks:load", () => {
  if ($("h3").data("page") === "oven-show") {
    const url = $("h3").data("url");
    setInterval(() => {
      getStatus(url);
    }, 1000);
  }
});

function getStatus(url) {
  $.ajax({
    url,
    dataType: "json",
  }).done((data) => {
    const field = $(".cookie-data");
    let text = "Cookie in oven: ";
    if (data.count === 0) {
      text += "None";
      $(".retrieve").css("display", "none");
    } else {
      const number = data.count === 1 ? "Cookie" : "Cookies";
      text += `${data.count} ${number} with ${data.fillings || "no fillings"}`;
      if (data.ready) {
        text += " (Your Cookie is Ready)";
        $(".retrieve").css("display", "block");
      }
      field.html(text);
    }
  });
}

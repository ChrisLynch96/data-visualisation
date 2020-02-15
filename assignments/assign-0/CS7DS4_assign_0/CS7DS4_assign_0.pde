PImage img;
Table table;

void setup() {
  fullScreen();
  img = loadImage("images/mapclean.jpg");
  table = loadTable("snow_pixelcoords.csv", "header");
}

void draw() {
  background(0);
  image(img, 0, 0);
  drawCases();
}

void drawCases() {
  for (TableRow row : table.rows()) {

    int count = row.getInt("count");
    int x_screen = row.getInt("x_screen");
    int y_screen = row.getInt("y_screen");

    if (count == -999) {
      fill(0, 0, 0);
      square(x_screen, y_screen, 5);
    } else {
      fill(255,0,0);
      ellipse(x_screen, y_screen, count*3, count*3);
    }
  }
}

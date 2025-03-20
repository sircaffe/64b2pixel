#include <stdio.h>
#include <stdint.h>

#define HEIGHT 32
#define WIDTH 64

typedef struct {
    uint64_t bmap[WIDTH-1];
} Display;

void draw_pixel(Display* display, size_t x, size_t y) {
    for (size_t i = 0; i < WIDTH; ++i) {
        if (i == y) {
            size_t dx = (0x8000000000000000 >> (x - 1));
            display->bmap[i] |= dx;
            break;
        }
    }
}

void update_display(Display* display) {
    for (size_t i = 0; i < HEIGHT; ++i) {
        for (size_t j = 0; j < WIDTH; ++j) {
            if ((display->bmap[i] >> (WIDTH-j)) & 1) {
                printf("█");
            } else {
                printf(".");
            }
        }
        printf("\n");
    }
}

int main(void)
{
    Display display = {0};
    
    // Draw triangle in middle of display
    int c = 1, triangle_size = 10;
    for (int i = 0; i < triangle_size; ++i) {
        for (int j = 0; j < c; ++j) {
            draw_pixel(&display, ((WIDTH-triangle_size)/2) + j, ((HEIGHT/2) - triangle_size/2) + i);
        }
        c++;
    }

    
    update_display(&display);

    return 0;
}

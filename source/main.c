#include <inkview.h>

int MainHandler(int ev, int a, int b)
{
    // avoid unused parameter warning
    (void)b;
    (void)a;

    switch (ev) {
        case EVT_INIT: {
            ifont *font = OpenFont("LiberationSans", 52, 1); // open font
            ClearScreen(); // clear screen
            SetFont(font, BLACK); // use font with black color
            DrawTextRect(0, ScreenHeight() / 2 - 26, ScreenWidth(), 52, "Halo world", ALIGN_CENTER); // draw text at the center of the screen
            FullUpdate(); // update the entire screen
            CloseFont(font); // close the font
            break;
        }
        case EVT_KEYPRESS: {
            // The "a" parameter holds the pressed key
            // when this event gets triggered
            if (a == KEY_OK) {
                CloseApp(); // close app
            }
            break;
        }
    }

    return 0;
}

int main(int argc, char **argv)
{
    (void)argc;
    (void)argv;

    InkViewMain(MainHandler);
    return 0;
}

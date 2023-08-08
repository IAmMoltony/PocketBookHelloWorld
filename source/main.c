#include <inkview.h>

int MainHandler(int ev, int a, int b)
{
    switch (ev) {
        case EVT_INIT: {
            ifont *font = OpenFont("LinerationSans", 52, 1);
            ClearScreen();
            SetFont(font, BLACK);
            DrawTextRect(0, ScreenHeight() / 2 - 26, ScreenWidth(), 52, "Halo world", ALIGN_CENTER);
            FullUpdate();
            CloseFont(font);
            break;
        }
        case EVT_KEYPRESS: {
            if (a == KEY_OK) {
                CloseApp();
            }
            break;
        }
    }

    return 0;
}

int main(int argc, char **argv)
{
    InkViewMain(MainHandler);
    return 0;
}
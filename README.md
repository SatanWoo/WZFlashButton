WZFlashButton
=============

This is a custom button with flash-like effect. Inspired by <a href = "https://github.com/traex/RippleEffect">Ripple Effect</a>.

## Demo

Build the project and run, you will find there are four different kind of WZFlashButton.
  1. Outer flash without text
  2. Outer flash with text
  3. Inner flash without text
  4. Inner flash with text

## Usage
#### Inner Flash Button 
    WZFlashButton *innerFlashButton = [[WZFlashButton alloc] initWithFrame:CGRectMake(100, 200, 200, 60)];
    innerFlashButton.backgroundColor = [UIColor colorWithRed:42.0f/255.0f green:62.0f/255.0f blue:80.0f alpha:1.0f];
    [self.view addSubview:innerFlashButton];
    
#### Outer Flash Button 
    WZFlashButton *outerRoundFlashButton = [[WZFlashButton alloc] initWithFrame:CGRectMake(100, 50, 50, 50)];
    outerRoundFlashButton.buttonType = WZFlashButtonTypeOuter;
    outerRoundFlashButton.layer.cornerRadius = 25;
    outerRoundFlashButton.flashColor = [UIColor colorWithRed:240/255.f green:159/255.f blue:10/255.f alpha:1];
    outerRoundFlashButton.backgroundColor = [UIColor colorWithRed:0 green:152.0f/255.0f blue:203.0f/255.0f alpha:1.0f];
    [self.view addSubview:outerRoundFlashButton];
    
#### Set Click Block Callback
    innerFlashButton.clickBlock = ^(void) {
        NSLog(@"Click Done");
    };
    
## Example
It is very easy to use WZFlashButton while get amazing effect, you can take a look at the following demo
<img src = "http://xuntaimage.qiniudn.com/WZFlashButton.gif" />

## License
MIT License
Copyright © 2015 SatanWoo.

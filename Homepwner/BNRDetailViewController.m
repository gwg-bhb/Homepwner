//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by hello on 16/3/7.
//  Copyright © 2016年 hello. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRDetailViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *labelText;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

@end

@implementation BNRDetailViewController
- (IBAction)takePicture:(id)sender {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [[BNRImageStore sharedStore] setImage:image forkey:self.item.itemKey];
    
    self.imageView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = _item.itemName;
//    self.navigationItem.leftBarButtonItem.title = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BNRItem *item = self.item;
    
    self.nameField.text = item.itemName;
    self.serialField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d",item.valueInDollars];
    
    
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateIntervalFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    
    self.labelText.text = [dateFormatter stringFromDate:item.dateCreated];
    
    NSString *itemkey = self.item.itemKey;
    
    UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:itemkey];
    
    self.imageView.image = imageToDisplay;
    
    self.nameField.delegate = self;
    self.serialField.delegate = self;
    self.valueField.delegate = self;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    
    BNRItem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialField.text;
    item.valueInDollars = [self.valueField.text intValue];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end

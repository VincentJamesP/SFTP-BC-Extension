page 70100 "Test Page"
{
    ApplicationArea = All;
    Caption = 'Test Page';
    PageType = Card;
    
    layout
    {
        area(content)
        {
            group(General)
            {
            }
        }
    }

 
    actions
    {
        area(Navigation)
        {
            action(ExportProductToFile)
            {
                ApplicationArea = All;
                trigger OnAction()

                begin
                    Clear(cduCreateProductFile);
                    cduCreateProductFile.Run();
                end;
            }
        }
    }

    var
        cduCreateProductFile: Codeunit "SF.CreateProductCSVFiles";
}


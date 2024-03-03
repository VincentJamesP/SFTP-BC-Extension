codeunit 70011 "SF.SFTP Webservice Domain"
{
    procedure SendFile(var InStr: InStream; var fileName: Text; fileExt: Text)
    var
        fileMgt: Codeunit "File Management";
        httpClient: HttpClient;
        httpContent: HttpContent;
        jsnObject: JsonObject;
        jsonBody: text;
        httpResponse: HttpResponseMessage;
        httpHeader: HttpHeaders;
        base64Convert: Codeunit "Base64 Convert";
        ResponseText: Text;
        SFTPSetup: Record "SF.SFTP Setup";
    begin
        SFTPSetup.Get();
        // UploadIntoStream('Select a file to upload', '', 'All files (*.*)|*.*', fileName, InStr);
        //fileExt := fileMgt.GetExtension(fileName);

        // jsonBody := ' {"base64":"' + base64Convert.ToBase64(InStr) +
        //             '","fileName":"' + fileName +
        //             '","fileType":"' + 'text/csv' + '", "fileExt":"' + fileMgt.GetExtension(fileName) +
        //                 '"}';

        /*

                //Setup
                jsnObject.Add('BLOBStorageConnectionString', 'BlobEndpoint=https://straightforwardblob.blob.core.windows.net/;QueueEndpoint=https://straightforwardblob.queue.core.windows.net/;FileEndpoint=https://straightforwardblob.file.core.windows.net/;TableEndpoint=https://straightforwardblob.table.core.windows.net/;SharedAccessSignature=sv=2021-12-02&ss=bfqt&srt=sco&sp=rwdlacupiytfx&se=2023-03-28T10:21:01Z&st=2023-03-10T02:21:01Z&spr=https,http&sig=QxMz1JlUpvi5MndatXBmwb6SeNgwp%2FWFCyWnf3SFB%2Bs%3D');
                jsnObject.Add('storageAccountContainer', 'd365bcfiles');
                jsnObject.Add('sftpAddress', '122.54.93.81');
                jsnObject.Add('sftpPort', '22');
                jsnObject.Add('sftpUsername', 'kation');
                jsnObject.Add('sftpPassword', 'kation123');
                jsnObject.Add('sftpPath', '/home/kation');

                //Setup
                //jsnObject.Add('BLOBStorageConnectionString', SFTPSetup."BLOB Storage Connection String");
                //jsnObject.Add('storageAccountContainer', SFTPSetup."BLOB Storage Container Name");
                //jsnObject.Add('sftpAddress', SFTPSetup.Address);
                //jsnObject.Add('sftpPort', SFTPSetup.Port);
                //jsnObject.Add('sftpUsername', SFTPSetup."User Name");
                //jsnObject.Add('sftpPassword', SFTPSetup.Password);
                //jsnObject.Add('sftpPath', SFTPSetup.Path);

                jsnObject.WriteTo(jsonBody);


                httpContent.WriteFrom(jsonBody);
                httpContent.GetHeaders(httpHeader);
                httpHeader.Remove('Content-Type');
                httpHeader.Add('Content-Type', 'application/json');
                //httpClient.Post(SFTPSetup."Function App link", httpContent, httpResponse);
                httpClient.Post('https://sffunctionapp1.azurewebsites.net/api/SFSTPApp?code=nujSyuQ8uf8JRbFiwNQZzChDS6LwRsnJfb77jz-N9Xd1AzFuRB6Tmw==', httpContent, httpResponse);
        */

        jsnObject.Add('base64', base64Convert.ToBase64(InStr));

        jsnObject.Add('fileName', fileName);

        jsnObject.Add('fileType', GetMIME(fileExt));

        jsnObject.Add('fileExt', fileExt);

        //Setup

        jsnObject.Add('BLOBStorageConnectionString', 'BlobEndpoint=https://straightforwardblob.blob.core.windows.net/;QueueEndpoint=https://straightforwardblob.queue.core.windows.net/;FileEndpoint=https://straightforwardblob.file.core.windows.net/;TableEndpoint=https://straightforwardblob.table.core.windows.net/;SharedAccessSignature=sv=2021-12-02&ss=bfqt&srt=sco&sp=rwdlacupiytfx&se=2023-05-20T15:25:59Z&st=2023-04-20T07:25:59Z&spr=https&sig=UOexp4iEOv3UluXkI71ecW0ZOxo02snyd5woLhxuCFI%3D');

        //jsnObject.Add('storageAccountContainer', 'd365bcfiles');
        jsnObject.Add('storageAccountContainer', SFTPSetup."BLOB Storage Container Name");

        //jsnObject.Add('sftpAddress', '122.54.93.81');
        jsnObject.Add('sftpAddress', SFTPSetup.Address);

        //jsnObject.Add('sftpPort', '22');
        jsnObject.Add('sftpPort', SFTPSetup.Port);

        //jsnObject.Add('sftpUsername', 'kation');
        jsnObject.Add('sftpUsername', SFTPSetup."User Name");

        //jsnObject.Add('sftpPassword', 'kation123');
        jsnObject.Add('sftpPassword', SFTPSetup.Password);

        //jsnObject.Add('sftpPath', '/home/kation');
        jsnObject.Add('sftpPath', SFTPSetup.Path);


        jsnObject.WriteTo(jsonBody);


        httpContent.WriteFrom(jsonBody);

        httpContent.GetHeaders(httpHeader);

        httpHeader.Remove('Content-Type');

        httpHeader.Add('Content-Type', 'application/json');

        //httpClient.Post(SFTPSetup."Function App link", httpContent, httpResponse);
        httpClient.Post('https://sffunctionapp1.azurewebsites.net/api/SFSTPApp?code=nujSyuQ8uf8JRbFiwNQZzChDS6LwRsnJfb77jz-N9Xd1AzFuRB6Tmw==', httpContent, httpResponse);


        //Here we should read the response to retrieve the URI
        if httpResponse.IsSuccessStatusCode() then begin
            httpResponse.Content().ReadAs(ResponseText);
        end else
            ResponseText := httpResponse.ReasonPhrase;

        //message(ResponseText);
    end;

    local procedure GetMIME(fileExt: Text): Text
    begin
        case UpperCase(fileExt) of

            'CSV':
                exit('text/csv');

            'JSON':
                exit('application/json');

            'XLS':
                exit('application/vnd.ms-excel');

            'XLSX':
                exit('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        end;
    end;
}

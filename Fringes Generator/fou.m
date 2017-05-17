 img = imread('Ph1.bmp');   %importing pixel information
        figure(1); imshow(img);

        cimg = imcrop(img); %cropping the pixels
        figure(2);ff=imshow(cimg);
        set(ff,'AlphaData',0.3);
        axis on, grid on;
        imgred = cimg(:,:,1);        %just the red channel

        imggrey = (mat2gray(im2double(cimg)));    %greyscale of the cropped image
        figure(3); imshow(imgred);

        dred = double(imgred);
        dgrey = double (imggrey);
        figure(4); mesh(dred);
        
        imgfftred = fftshift(fft2(dred));
        figure(5); surf(abs(imgfftred));
        view(0,0);

        shading interp;

        imgfftgrey = fftshift(fft(dgrey));
        Ishow= mat2gray(abs(double(imgfftgrey)));
        figure(6); surf(abs(imgfftgrey));
        colormap(jet),colorbar
        figure(7);mesh(Ishow)
        view(0,0);
        shading interp;
        
        %close all;
        figure(8); surf(abs(imgfftred));
        %h = streamline(0,0);
        
        % Use ginput to select corner points of a rectangular
        % region by pointing and clicking the mouse twice
        fftselec= ginput(2); 

        % Get the x and y corner coordinates as integers
        sp(1) = min(floor(fftselec(1)), floor(fftselec(2))); %xmin
        sp(2) = min(floor(fftselec(3)), floor(fftselec(4))); %ymin
        sp(3) = max(ceil(fftselec(1)), ceil(fftselec(2)));   %xmax
        sp(4) = max(ceil(fftselec(3)), ceil(fftselec(4)));   %ymax

        % Index into the original image to create the new image
        MM = im(sp(2):sp(4), sp(1): sp(3),:);

        % Display the subsetted image with appropriate axis ratio
        figure(9); mesh(MM); axis image
        
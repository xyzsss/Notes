import os
import urllib2


def download_photo(folder, photo):
    try:
        u = urllib2.urlopen(photo)
        local_file = open(os.path.join(folder, photo.split('/')[-1]), "wb")
        local_file.write(u.read())
        local_file.close()
        u.close()
    except urllib2.HTTPError, e:
        print("HTTPError-404")


import os
import urllib2
import datetime
import imghdr


def download_photo_rename_with_time(folder, photo, filename=None):
    try:
        pic_list = (
            'rgb', 'gif', 'pbm', 'pgm', 'ppm', 'tiff',
            'rast', 'xbm', 'jpeg', 'bmp', 'png')
        origin_file_name = photo.split('/')[-1]
        u = urllib2.urlopen(photo)
        local_file = open(os.path.join(folder, origin_file_name), "wb")
        local_file.write(u.read())
        local_file.close()
        u.close()

        img_type = imghdr.what(local_file)
        if img_type in pic_list:
            return origin_file_name
        else:
            file_name = datetime.datetime.now().strftime("%Y-%m-%d--%H-%M-%S")\
                + ".unknow"
            os.rename(origin_file_name, file_name)
            print "File not image types."
            return file_name

    except urllib2.HTTPError, e:
        print("HTTPError-404")

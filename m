From: David Sommerseth <davids@...515...>
Date: Thu, 11 May 2017 18:36:11 +0200
Message-Id: <20170511163611.32630-1-davids@...515...>
In-Reply-To: <1494358209-4568-2-git-send-email-steffan.karger@...1435...>
References: <1494358209-4568-2-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH applied] Don't assert out on receiving
	too-large control packets (CVE-2017-7478)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: steffan.karger@...1435...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

This resolves the issue in my tests, code looks sane ... so ACK!


Your patch has been applied to the following branches

commit 5774cf4c25e1d8bf4e544702db8f157f111c9d93  (master)
commit 66b99a0753352c5cc43e11e39835b6423112df98  (release/2.4)
Author: Steffan Karger
Date:   Tue May 9 21:30:08 2017 +0200

     Don't assert out on receiving too-large control packets (CVE-2017-7478)

     CVE: 2017-7478
     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <1494358209-4568-2-git-send-email-steffan.karger@...1435...>
     URL: http://www.mail-archive.com/search?l=mid&q=1494358209-4568-2-git-send-email-steffan.karger@...1435...
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZFJLzAAoJEIbPlEyWcf3yMkAP/jQ3M60uZ1i6xcjNiwWlrIbn
UXg7/pWGll62M4lBnr0ePTNkXMDEw74amoHtrmSahVMPZuIzHtLU3P+6q5g7aVES
iuZuvmUJFbrc6QHqjIuUmWLi5DERt3946hKaVuuV/nug6cYURmHgf6Y9q/9lse/M
EVEXqyU5WWqJzcK8ArAyTd0Ade4/PAUtyYdvKVWqAtugbLL+nfJV9hNkZV/iOSiH
T9xpW8mhQyu6iqmdtvPux4bPwVZjODHTeCT5aOnpLaTGhRUQmDu3G4KdhPLYI9H5
TYGrjTI5CPvQ5/gRZx6HD93gYhU/uBq2cQROdzQbFCqQc/yMOqWVy4vkAGey4Kj3
RpFhgwDiClChDFNilV3s6OswW3vCml3Dl992jJVxsasUZDCibp3mEWxHGAbTKnQT
i7pxOL7yTHEaU4U2tfEk+0sKq0ur0qX2JUBQbOIrBg1TVstyhSBxLVAL306qxCPN
GwcgSYtWP0iIOx1/9C3gh3OOex4f6v3rxMFXg0hq1gQbsr9YXoYm0jgE92vADdMc
RAUj9sQRl0J8Uy/u8p8tEQKho0gjkXSlowVgsxaOo96y2kj5lncqGrg2xnk7CRvv
5+Xjho26P9RjiC1GH5z7GvM8hL1jKazMRRVWX8FqYOhf7EwBoxnlMY4ZixEz+3iy
kFEQazOrRBW4gXAPe/N7
=EVP5
-----END PGP SIGNATURE-----


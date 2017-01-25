From: David Sommerseth <davids@...515...>
Date: Wed, 25 Jan 2017 22:16:23 +0100
Message-Id: <20170125211623.2019-1-davids@...515...>
In-Reply-To: <20170125201947.17197-1-list@...1798...>
References: <20170125201947.17197-1-list@...1798...>
Subject: Re: [Openvpn-devel] [PATCH applied] Clean up plugin path handling
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
To: mail@...1798...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

ACK.  This have been through enough rounds, and I currently don't
see a better approach to the openvpn-plugin.h generation either.  If
we find better ways later on, lets fix it then.

I've tested this using gdb and investigating which code paths are
used in different circumstances (--plugin with and without absolute path)
and the expected plug-ins are loaded.

Your patch has been applied to the following branches

commit 4590c3831d0400096fab08aa1ed7f909da870ced  (master)
commit 05baa0ecf841852fbf29ef39ee9cd1d4cac990cf  (release/2.4)
Author: Christian Hesse
Date:   Wed Jan 25 21:19:47 2017 +0100

     Clean up plugin path handling

     Signed-off-by: Christian Hesse <mail@...1798...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20170125201947.17197-1-list@...1798...>
     URL: http://www.mail-archive.com/search?l=mid&q=20170125201947.17197-1-list@...1798...
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYiRWlAAoJEIbPlEyWcf3yQGEP/269/VKw/dW5KU/XrLIfwgT+
N5qzzKvalVnvlb8ki2GE4YaMp0dfjElup28iQi7wCbmAfHYiX9inc0KtQK7ggMHQ
6EMzgRnJla0mTVyKnFecSCVNFuDERcLc1a+K/Qq4JeiRUK3eyHbKZCA766xd3C+G
/7x2SMPdXAqpAexuxO74Nz+GWuu7KLBY+F3LHYHAC4GiTHtd84pi2GpDveaod4K2
ttRqvnnZRn5JiuVl89To20faU1iw9RHvqFqZMOZfEq4fkRTK+0tJiMhJ5NcH1khm
OiS/4x/HQtL79GqjrUkOCr3vyjoMRWd13Lz49eK6U4GFlcsivH09IL8toHfcdMjX
DimgaYNHNo0+rxHOV53Jp6ADd97E93580Xe1drk6CUo7Sf0f4C25dtFzQJm67pkV
L/45suNEL6jq2UvqCj/KR9AnawEVaGkhI9ikEkEJsDFgxi2fXWthuhe8SOXNugPA
j+lyViB9vmTb2OVukEJKartAYBiOKd7dcTUUoE3U/XvEbNKMS7IsBMIDTinTUOlt
la9Vu7DucKGXOeEIhbHHYuNV6Mff1eWNr8l7bx42mE1hSDHba5DwF0r0x2oTDZyn
esew8w+R/ALVqeXCMx5bzwtdBngqAY0W90ePeuK2FyNFRsy83lZYbS6DVhmkXplQ
OpS/rxQtFMDJI09cT+wz
=KBA6
-----END PGP SIGNATURE-----


Message-ID: <4B229FC2.70907@...41...>
Date: Fri, 11 Dec 2009 12:38:42 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <4B220E0D.2090908@...41...> <4B2217BD.6070004@...1114...>
In-Reply-To: <4B2217BD.6070004@...1114...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1.0 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

Yes -- the changes to the tap-win32 source code is only in the comments 
and clarifies that the source is licensed under GPL 2.

James

David Sommerseth wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 11/12/09 10:17, James Yonan wrote:
>> I'm happy to announce the release of OpenVPN 2.1.0.  This release is 
>> basically 2.1_rc22 + some last-minute trivial fixes to documentation and 
>> plugin sample code.  Enjoy!
> 
> This is indeed good news!  Thank you very much for your hard work!
> Today, it's only pure joy! :)
> 
> However, I just checked the differences between 2.1_rc22 and the final
> 2.1.0.  And I do see that there are some unexpected files here ...
> 
> 	tap-win32/filt.py
> 	tap-win32/tmp/
> 	tap-win32/tmp/hexdump.h
> 	tap-win32/tmp/types.h
> 	tap-win32/tmp/error.c
> 	tap-win32/tmp/error.h
> 	tap-win32/tmp/instance.c
> 	tap-win32/tmp/tapdrvr.c
> 	tap-win32/tmp/macinfo.c
> 	tap-win32/tmp/constants.h
> 	tap-win32/tmp/endian.h
> 	tap-win32/tmp/prototypes.h
> 	tap-win32/tmp/dhcp.h
> 	tap-win32/tmp/dhcp.c
> 	tap-win32/tmp/lock.h
> 	tap-win32/tmp/proto.h
> 	tap-win32/tmp/hexdump.c
> 	tap-win32/tmp/macinfo.h
> 	tap-win32/tmp/common.h
> 	tap-win32/tmp/mem.c
> 
> I believe these files are just leftovers after making the license a pure
> GPLv2 license.  Is this a correct assumption?
> 
> Btw!  Good move on the license!
> 
> 
> kind regards,
> 
> David Sommerseth
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
> 
> iEYEARECAAYFAksiF70ACgkQDC186MBRfrqEjACeLYEA2zw+tIC8biANywvDtgcj
> A6oAn2u+LveoFX9+FihPuwBTkj1kbIyG
> =F0iV
> -----END PGP SIGNATURE-----


Message-ID: <4D8C44E3.30805@...1114...>
Date: Fri, 25 Mar 2011 08:31:47 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4D713CD3.3000606@...515...>
	<AANLkTin4QkZ36mi7qHyB9R+i1FdQJi66mi6nhhvYMWmN@...278...>
In-Reply-To: <AANLkTin4QkZ36mi7qHyB9R+i1FdQJi66mi6nhhvYMWmN@...278...>
Subject: Re: [Openvpn-devel] OpenVPN 2.2-RC released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/03/11 22:14, Alon Bar-Lev wrote:
> Hello,
> 
> Any reason why the windows cross compile fix we discussed [1] did not
> made it into mainline?
> 
> Attached again.
> 
> This is trivial patch, which resume the ability to build openvpn using
> cross compiler and autotools.
> 
> Please apply so we don't need to maintain this out of tree.
> 
> You can test build at [2].
> 
> Alon
> 
> [1] http://permalink.gmane.org/gmane.network.openvpn.devel/3991
> [2] https://www.opensc-project.org/opensc/wiki/build
> 

This patch was ACKed by James Yonan yesterday.  Applied to beta2.2 and will
be included in the coming v2.2-RC2 release.

commit aab2f95439c28e2aa9358dbfe1ce7a15c774a766
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Fri Mar 4 23:14:33 2011 +0200

    Windows cross-compile cleanup

    It should be sufficient to just try to see if socklen_t is defined.
    Next, on all platforms it would be int in all other platforms.
    And, there is no need to check for the type in monolitic environment
    like Windows, as it will be always the same.

    Currently it fails cross compile windows in mingw-w64 compiler, as
    winsock.h is as follows:
       """
         /* define WINSOCK_API_LINKAGE and WSAAPI for less
          * diff output between winsock.h and winsock2.h, but
          * remember to undefine them at the end of file */
       """
    And the macro uses these macros which are internal winsock macros and
    should not be used anyway.

    Also, when did the autodefs.h went mandatory? Why is it in
    tap-win32/common.h while no constant is actually used?

    The use of WSA_IO_INCOMPLETE without including winsock2.h is invalid!
    Look at http://msdn.microsoft.com/en-us/library/aa921087.aspx

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: James Yonan <james@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2MROMACgkQDC186MBRfrrNiQCbB4o3dKxKxFSrSJjiDeiViK4Z
aIYAnR0BcNVuvyJjnCTssyvTwVQVH1D9
=7V6N
-----END PGP SIGNATURE-----


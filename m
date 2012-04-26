Message-ID: <4F999EF8.8060503@...1114...>
Date: Thu, 26 Apr 2012 21:16:08 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1333912929-7967-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1333912929-7967-1-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] build: properly detect netinet/ip.h
	structs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/04/12 21:22, Alon Bar-Lev wrote:
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> --- 
> configure.ac |    3 +++ 1 files changed, 3 insertions(+), 0
> deletions(-)

ACK.  Applied to master on -testing and -stable trees.

commit 4025a59575a9a90cb96fde01eba8db3c1cab0b2b
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Sun Apr 8 22:22:09 2012 +0300

    build: properly detect netinet/ip.h structs

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+ZnvgACgkQDC186MBRfrrASwCfa9DU22nYFTwcI0fjv0wt1zsp
ShIAoIic74U8fFmmBrpBESEIztnkr2Yu
=S5iR
-----END PGP SIGNATURE-----


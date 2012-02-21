Message-ID: <4F43A09B.8040007@...1114...>
Date: Tue, 21 Feb 2012 14:48:11 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1313669531-31867-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1313669531-31867-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH] fix warnings in event.c when building
 for win32-64
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

On 18/08/11 14:12, Heiko Hund wrote:
> When compiling for 64-bit Windows gcc warns about
> 
> "cast from pointer to integer of different size"
> 
> on two occasions in file event.c, due to invalid casting. This patch
> removes the type casts and uses the correct format specifier instead.
> 
> Signed-off-by: Heiko Hund <heiko.hund@...1489...> --- event.c |    8
> ++++---- 1 files changed, 4 insertions(+), 4 deletions(-)
> 

Cleaning up some old patches which had slipped the patch queue.  Applied
to master and new master branch is pushed to -stable and -testing trees.

commit 3c19fcc2099d8ddf6bfeec6550d4e3cb1cbf3431
Author: Heiko Hund <heiko.hund@...1489...>
Date:   Thu Aug 18 12:12:11 2011 +0000

    fix warnings in event.c when building for win32-64

    Signed-off-by: Heiko Hund <heiko.hund@...1489...>
    Acked-by: James Yonan <james@...515...>
    URL: http://article.gmane.org/gmane.network.openvpn.devel/4979
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9DoJkACgkQDC186MBRfrrN8gCfdtscvYfl3S4tMAbI3/lPUYmg
COwAmwQyA/13DWVRppNs9Cleo1ov+sdJ
=VUzA
-----END PGP SIGNATURE-----


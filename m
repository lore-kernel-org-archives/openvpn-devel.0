Message-ID: <4F9B1C1E.20302@...1114...>
Date: Sat, 28 Apr 2012 00:22:22 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1335479238-26420-1-git-send-email-alon.barlev@...277...>
	<1335528555-13225-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1335528555-13225-1-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] build: use stdbool.h if available
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

On 27/04/12 14:09, Alon Bar-Lev wrote:
> If stdbool.h is available use it, otherwise create emulation.
> 
> basic.h defines a type 'bool' that conflicts with the altivec
> keyword bool which has to be fixed upstream, see bugs[1][2].
> 
> [1] https://bugs.gentoo.org/show_bug.cgi?id=293840 [2]
> https://bugs.gentoo.org/show_bug.cgi?id=297854
> 
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> --- 
> configure.ac                |    2 +- src/compat/Makefile.am      |
> 1 + src/compat/compat-stdbool.h |   12 ++++++++++++ 
> src/openvpn/basic.h         |   13 ------------- 
> src/openvpn/syshead.h       |    1 + 5 files changed, 15
> insertions(+), 14 deletions(-) create mode 100644
> src/compat/compat-stdbool.h
> 

ACK.  Applied to master branch on -testing and -stable trees.


commit 4029971240b6274b9b30e76ff74c7f689d7d9750
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Fri Apr 27 15:09:15 2012 +0300

    build: use stdbool.h if available

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1335528555-13225-1-git-send-email-alon.barlev@...277...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6363
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+bHB0ACgkQDC186MBRfrrK5gCgnGCVKFuPrqdWw2gRcqb89StD
tqEAnjkgJfTNK3chQiVDjc1y0OHxa43H
=J1ML
-----END PGP SIGNATURE-----


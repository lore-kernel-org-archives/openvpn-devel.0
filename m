Message-ID: <4F72D155.4010706@...1114...>
Date: Wed, 28 Mar 2012 10:52:37 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz06swLVgdoE1GPt2m9EEO7cvB2S8nBstn-a1ktDYtgH-Q@...278...>
	<1332797200-9295-2-git-send-email-alon.barlev@...277...>
In-Reply-To: <1332797200-9295-2-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 1/6] build: openbsd: detect netinet/ip.h
 correctly
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

On 26/03/12 23:26, Alon Bar-Lev wrote:
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> --- configure.ac |
> 3 +++ 1 files changed, 3 insertions(+), 0 deletions(-)
> 

Applied to master branches on -testing and -stable trees.

commit 2a7448912efbba7a246f481566117d6b8f6341c1
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Mon Mar 26 23:26:35 2012 +0200

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Gert Doering <gert@...1296...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9y0VUACgkQDC186MBRfrppLwCgn8MB7/81KoZlWorHYVpYOcRC
QQQAnjdizuTL3++ZyRwMgKJ1NpSrRgui
=tiUq
-----END PGP SIGNATURE-----


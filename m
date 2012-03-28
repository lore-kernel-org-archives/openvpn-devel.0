Message-ID: <4F72D194.5040403@...1114...>
Date: Wed, 28 Mar 2012 10:53:40 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz06swLVgdoE1GPt2m9EEO7cvB2S8nBstn-a1ktDYtgH-Q@...278...>
	<1332797200-9295-3-git-send-email-alon.barlev@...277...>
In-Reply-To: <1332797200-9295-3-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 2/6] build: tap: search for tap header
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
> Windows and solaris has something in common, in both the tap header is
> external. So make the Windows tap-windows.h search common to all
> platform.
> 
> Display an error if we cannot find tap header.
> 
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> --- configure.ac
> |   32 ++++++++++++++++---------------- src/openvpn/Makefile.am |    2
> +- 2 files changed, 17 insertions(+), 17 deletions(-)
> 

ACK.  Applied to master branches on -testing and -stable trees.

commit 7cacdfd4b7f221139e0d2a0334f1f1cd8f2a1b75
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Mon Mar 26 23:26:36 2012 +0200

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9y0ZQACgkQDC186MBRfrpgngCeN885LwzL/On2WpNoaWTS7+c+
/2gAnjKcN4hFKbRWWo77Skt9tJHUyvYZ
=7RkS
-----END PGP SIGNATURE-----


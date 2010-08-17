Message-ID: <4C6AE9F6.3090805@...1114...>
Date: Tue, 17 Aug 2010 21:58:46 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20100709083102.GZ361@...1296...>
In-Reply-To: <20100709083102.GZ361@...1296...>
Subject: Re: [Openvpn-devel] Patch for compile-time problems on NetBSD and
 OpenBSD (trac #17)
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/07/10 10:31, Gert Doering wrote:
> Hi,
> 
> the following patch fixes the IFF_MULTICAST compile-time problems on NetBSD,
> and it should also fix them on OpenBSD (trac entry #17).
> 
> ** important: after applying the patch to configure.ac, you MUST run
> ** "autoreconf" - otherwise the patch won't do anything
> 
> If it still doesn't work for OpenBSD, I need to see the parts from your
> config.log relating to <net/if.h>
> 
> gert
> 

ACK recieved in Trac:
<https://community.openvpn.net/openvpn/ticket/17>

commit eb973e055bc249948351cacf1aa045d878ed041d
Author: Gert Doering <gert@...1296...>
Date:   Fri Jul 9 10:24:46 2010 +0200

    Fix compile problems on NetBSD and OpenBSD

    Configure will not find <net/if.h> due to missing <sys/types.h> in
    the test program, and thus, tun.c will fail to compile with missing
    symbol IFF_MULTICAST.

    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: krzee <jeff@...1394...>
    Signed-off-by: David Sommerseth <dazo@...384...>

Applied to bugfix2.1, merged into allmerged and beta2.2.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkxq6fYACgkQDC186MBRfroFygCff6kL1IMcEqlk3O1tMLwPfL+B
hdEAn08b+W4GLcWxX24dq7XeLHFJJXzO
=oY7H
-----END PGP SIGNATURE-----


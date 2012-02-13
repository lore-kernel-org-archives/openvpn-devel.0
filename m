Message-ID: <4F396AD4.7080106@...1114...>
Date: Mon, 13 Feb 2012 20:56:04 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1328628587-4906-1-git-send-email-janjust@...1147...>
In-Reply-To: <1328628587-4906-1-git-send-email-janjust@...1147...>
Subject: Re: [Openvpn-devel] [PATCH] Made some options connection-entry
	specific
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

On 07/02/12 16:29, Jan Just Keijser wrote:
> Made some options connection-entry specific: fragment mssfix tun-mtu 
> tun-mtu-extra link-mtu mtu_discover_type explicit-exit-notification
> in order to support stuff like <connection> remote host proto udp 
> fragment explicit-exit-notification 3 </connection> <connection> 
> remote host proto tcp </connection>
> 
> Signed-off-by: Jan Just Keijser <janjust@...1147...> --- forward.c | 2
> +- init.c    |   38 ++++++++++--------- occ.c     |    2 +- options.c
> |  125 +++++++++++++++++++++++++++++++------------------------------ 
> options.h |   36 +++++++++--------- sig.c     |    6 +- 6 files 
> changed, 107 insertions(+), 102 deletions(-)

ACK.  Applied to the master branch for -stable and -testing trees.

commit 76809cae0eae07817160b423d3f9551df1a1d68e
Author: Jan Just Keijser <janjust@...1147...>
Date:   Tue Feb 7 16:29:47 2012 +0100

    Made some options connection-entry specific

    Signed-off-by: Jan Just Keijser <janjust@...1147...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk85atQACgkQDC186MBRfrpRcACeOAUc3CWM1ORg2hWBDSwwS4hQ
4B8AoK8lWaZQKO5m589P3TgjUB2IE9/v
=meS6
-----END PGP SIGNATURE-----


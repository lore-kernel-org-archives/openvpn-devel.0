From: David Sommerseth <davids@...515...>
Date: Fri, 14 Oct 2016 14:48:15 +0200
Message-Id: <1476449295-18218-1-git-send-email-davids@...515...>
In-Reply-To: <1476377656-3150-1-git-send-email-arne@...1227...>
References: <1476377656-3150-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH applied] Remove tun-ipv6 Option. Instead
	assume that IPv6 is always supported.
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
To: arne@...1227...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

ACK.  This looks good now, testing looks fine on Linux (SL7.2 x86_64) too.

I've done some editorial changes to the commit message though, nothing changed
except adding and removing whitespaces and fixing a few typos (Ipv6 -> IPv6, etc).

Your patch has been applied to the master branch

commit 86e2fa5597fd1ad8e0102f134c63d6bc8cb7c291
Author: Arne Schwabe
Date:   Thu Oct 13 18:54:16 2016 +0200

     Remove tun-ipv6 Option. Instead assume that IPv6 is always supported.

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1476377656-3150-1-git-send-email-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg12695.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYANQOAAoJEIbPlEyWcf3ye88P/RFci2mayFPpS9pnrXt7A8yT
YXdp99eWH2gvKZNFaC4yg3FQyjeZ0pZBYHU+DHkyZjbWFtX7ctXGioiy7gw+tkgu
UzU6ZUNWPb8c1lmMdftGS2Xgo8IrRaGLbfnVG1NJBK30xPRwc9qplss4qo+LVeU6
92f8477tbM+b1qpD1UP+2yTqubvhmPcPecS1w9qCW48T96friWWDZNx2FEjaee/k
37Xnc3Vqr9ae/uw2tLSt4yfMcC9gT2Gm9D3DehiW3d/VP/qlRGQwBtEmUmXYJbXe
62sD7kVDXAAmidrsFTI6+uo/ubZW8vVTwEYYRcf1GuUsMAlqxYWevuX2ONGSL4Hv
1LnU9ePv1IBno5IRLn5iWube+Ij7SLIZk+NpUx1c37yuawiqz/rYz/rozscGm7P0
W6fv+f2HzdCGxxI4ZMhKUsdnvWkKv6eAa7ce+uCYMUwwI5s8NtS9bOLy2RSdlbmS
rxk88xpeKajgSOy3WVJArBStbp1pj1h4AVqZ8gKFnUBYIbMEz+uAsExB5D/x6Snk
aE9a6Au2d1DDVNoAVAKMrLts9DI7P0LXq7Us7hwZJeDXJKTQlqLgzPoEyvcd3Hj5
GsHVuEBKk+Rlgy3sc9ocgHQNtq8wU09talsyVDwaaEF+TDGyV5XJyba91qKTMr+G
fM/+WSOWHghUA9txU8AG
=zsQ8
-----END PGP SIGNATURE-----


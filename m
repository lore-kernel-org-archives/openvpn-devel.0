References: <1470570245-28327-1-git-send-email-iam@...2070...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <17e0440a-d70c-0003-f18c-d21ae9ac3b95@...2080...>
Date: Mon, 8 Aug 2016 10:34:08 +0200
MIME-Version: 1.0
In-Reply-To: <1470570245-28327-1-git-send-email-iam@...2070...>
Subject: Re: [Openvpn-devel] [PATCH 1/3] Do not pass env for system commands
 on Linux
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ValdikSS <iam@...2070...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


On 07/08/16 13:44, ValdikSS wrote:
> It's possible to have so much routes that they won't fit into stack
> and execve would fail with E2BIG (Argument list too long).
>=20
> This commit fixes this issue by not adding route information into
> execve'd application env. --- src/openvpn/lladdr.c |  2 +-=20
> src/openvpn/route.c  |  8 ++++---- src/openvpn/tun.c    | 12
> ++++++------ 3 files changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/src/openvpn/lladdr.c b/src/openvpn/lladdr.c index
> 57f447b..d537379 100644 --- a/src/openvpn/lladdr.c +++
> b/src/openvpn/lladdr.c @@ -58,7 +58,7 @@ int set_lladdr(const char
> *ifname, const char *lladdr, #endif
>=20
> argv_msg (M_INFO, &argv); -  r =3D openvpn_execve_check (&argv, es,
> M_WARN, "ERROR: Unable to set link layer address."); +  r =3D
> openvpn_execve_check (&argv, NULL, M_WARN, "ERROR: Unable to set
> link layer address.");


I have just very quickly looked through this, and in most cases this
seems fine.  openvpn_execve_check() most of the cases are calling a
somewhat hard coded path to a binary.

Except ... on Linux, configured with --enable-iprout2, OpenVPN can use
the --iproute option which redefines at runtime which iproute2 binary
it should use.  Removing the environment table in these cases may
actually break some setups where the system can have a iproute2
compatible wrapper which needs some of the environment variables.

I have also seen the IRC discussion, where Gert argues that something
else is not optimal when the environment variable space is exhausted.
 I think a better fix would be to consider a way to filter out
unneeded noise instead.


- --=20
kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAleoRAAACgkQDC186MBRfrryMgCfRqqJrrbM9WXzuG/l8EA8P/C9
9rcAn26sippqM0+bMDqwd30I7DOC0346
=3DXLdo
-----END PGP SIGNATURE-----


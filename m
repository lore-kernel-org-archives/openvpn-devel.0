Date: Sun, 20 Jan 2013 19:50:30 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20130120185030.GR22465@...1296...>
References: <20120203084426.GA24955@...1296...>
	<20130120164951.2d335b30@...1801...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="db8DWWv/lfL7k8Nd"
Content-Disposition: inline
In-Reply-To: <20130120164951.2d335b30@...1801...>
Subject: Re: [Openvpn-devel] IPv6 enhancement: non-/64 prefix lengths for
	IPv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Marcel =?iso-8859-1?Q?Pennewi=DF?= <mailinglists@...1145...>
Cc: openvpn-devel@lists.sourceforge.net

--db8DWWv/lfL7k8Nd
Content-Type: multipart/mixed; boundary="nUIyxxw8BSSbt6Ef"
Content-Disposition: inline

--nUIyxxw8BSSbt6Ef
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jan 20, 2013 at 04:49:51PM +0100, Marcel Pennewi=DF wrote:
> > in time for 2.3, one of the remaining open itches for the IPv6 code=20
> > is now fixed :-)  (and the changes needed turned out to be fairly
> > trivial).
>=20
> Using ifconfig-ipv6-pool instead of server-ipv6(-macro) does not allow
> non-/64 prefix (in current 2.3). Bug or Feature?

Smells buggy.  As server-ipv6 is just a macro (not really, but sort of).

Indeed... options.c:

  else if (streq (p[0], "ifconfig-ipv6-pool") && p[1] )
...
      if ( netbits !=3D 64 )
        {
          msg( msglevel, "--ifconfig-ipv6-pool settings: only /64 supported=
 righ
t now (not /%d)", netbits );
          goto err;
        }

... this is a leftover from the initial days, where nothing else was
supported (not for server-ipv6 either).

Patch is trivial, please find attached.  David: 2.3.1 and 2.4.0, please :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--nUIyxxw8BSSbt6Ef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Permit-pool-size-of-64.-112-for-ifconfig-ipv6-pool.patch"
Content-Transfer-Encoding: quoted-printable

=46rom cdfbc8952a01acde0eedf08fa0ebefed38fa2763 Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Sun, 20 Jan 2013 20:50:38 +0200
Subject: [PATCH] Permit pool size of /64.../112 for ifconfig-ipv6-pool

(Leftover check from the early days where --server-ipv6 also only
accepted /64 - nowadays we handle smaller pools just fine)

Signem-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/options.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 8ca41a3..1d89e4b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5484,9 +5484,9 @@ add_option (struct options *options,
 	  msg (msglevel, "error parsing --ifconfig-ipv6-pool parameters");
 	  goto err;
 	}
-      if ( netbits !=3D 64 )
+      if ( netbits < 64 || netbits > 112 )
 	{
-	  msg( msglevel, "--ifconfig-ipv6-pool settings: only /64 supported right=
 now (not /%d)", netbits );
+	  msg( msglevel, "--ifconfig-ipv6-pool settings: only /64../112 supported=
 right now (not /%d)", netbits );
 	  goto err;
 	}
=20
--=20
1.7.3.5


--nUIyxxw8BSSbt6Ef--

--db8DWWv/lfL7k8Nd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUPw8dakuBuNlUUl1AQITxQP/TNybtHZxS1cCPM8iQwDMc4cKWZnKK6TS
ww0KZV5bhFmeVESf4lwGDVZsYypF0MWrlhx2Loevv0i3vefoTiDTSAZuAJumFAf5
dt4dhad1A1TZSEBXAKa2PatMZNLL77jEdm2eEf23cG1oyGZ+z/5+lQSMTU011OCp
s9TVFpHCzdA=
=CPeE
-----END PGP SIGNATURE-----

--db8DWWv/lfL7k8Nd--


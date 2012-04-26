Date: Thu, 26 Apr 2012 15:48:52 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120426134852.GR1359@...1296...>
References: <1335441085-18186-1-git-send-email-davids@...1347...>
	<CAP+U6tKVWNkD0fF8pLyFXUMX2+-yTYTJihoix9bkigzYiEWXkw@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w4FA960qCDcgfw+v"
Content-Disposition: inline
In-Reply-To: <CAP+U6tKVWNkD0fF8pLyFXUMX2+-yTYTJihoix9bkigzYiEWXkw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Presume that Linux is always IPv6
	capable at build time
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Fabian Knittel <fabian.knittel@...1547...>
Cc: David Sommerseth <davids@...1347...>, openvpn-devel@lists.sourceforge.net

--w4FA960qCDcgfw+v
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 26, 2012 at 03:11:54PM +0200, Fabian Knittel wrote:
> Gert appears to be happy, so I'm happy, but I don't quite understand
> what you're saying here. What part broke? HAVE_TUN_PI and HAVE_IPHDR
> aren't always detected although they should be? Or the failed
> detection affects non-Linux systems? Something else? Just curious ...

The actual problem was that the failed detection led to LINUX_IPV6
being set to "0", which in turn led to IPv6 failure on tun interfaces
(due to not taking the extra header bytes on the tun interface into=20
account).

Since this is all legacy stuff anyway, throwing out the #ifdef's and
the detection logic (for stuff we know that *has* to be there on any
Linux version we support) is much easier than trying to make it work.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--w4FA960qCDcgfw+v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT5lSQ6kuBuNlUUl1AQLj+wP/VNloxiu/+sV/2lejsY+2VF8w8zo7unX2
um5uj7/frjDgQ0SAPYc+JhUbXzT5DAZXqYPShivWpkKDsShpwLMhwDc06+83YYJc
jalZ1SJTsmQxl3eyWWN5KmLuQDMiAeMY+ZFL2f8nFARfEO4iCPY0gOMglaT3Y9wK
v/7x7AkgQHc=
=d+hm
-----END PGP SIGNATURE-----

--w4FA960qCDcgfw+v--


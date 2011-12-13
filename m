Date: Tue, 13 Dec 2011 10:22:41 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111213092241.GO18948@...1296...>
References: <A273A2F6519C0D42BFF02CA9C6A825112D003E1E@...1531...>
	<4EE52A57.1040906@...1338...>
	<A273A2F6519C0D42BFF02CA9C6A825112D003F02@...1531...>
	<A273A2F6519C0D42BFF02CA9C6A825112D003F72@...1531...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XbHSybK3LHOYQtWI"
Content-Disposition: inline
In-Reply-To: <A273A2F6519C0D42BFF02CA9C6A825112D003F72@...1531...>
Subject: Re: [Openvpn-devel] Problem with alloc_buf_gc function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tiran Kaskas <Tiran.Kaskas@...1530...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--XbHSybK3LHOYQtWI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Dec 12, 2011 at 09:32:51AM +0000, Tiran Kaskas wrote:
> Is there a problem connecting a client running 2.1.4 (the one with polars=
sl) to a server running 2.0.9?

Well, the default crypto algorithms are not compatible between polarssl
and openssl-using openvpn.  So you'd need to change the crypto settings
on the openssl-openvpn [--cipher] - and upgrade to 2.2, while at it.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--XbHSybK3LHOYQtWI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTucZYakuBuNlUUl1AQJbeAQAhxM0Ve1hbOk0T7BH46C8uKxTLOP4z8E5
afU96u2IfQmzb2H1OIuraGtYMWmT3bC+1wvtfM8bjfQzv8YC9BJlY1wKFq83GJEp
s78cMbp2KUvqpiN8psMDwBlDaxWyZIorg7unJnnXQZQkG8B3U7sfnbDNL2SG8IGr
X0nz5RqiKE0=
=tf4V
-----END PGP SIGNATURE-----

--XbHSybK3LHOYQtWI--


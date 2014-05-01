Date: Thu, 1 May 2014 21:15:14 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140501191514.GQ16637@...1296...>
References: <536262FD.1090105@...1901...> <53627F26.1060208@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="svLj+9oZXALGi5x6"
Content-Disposition: inline
In-Reply-To: <53627F26.1060208@...515...>
Subject: Re: [Openvpn-devel] IRC & Community...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Timothe Litt <litt@...1901...>

--svLj+9oZXALGi5x6
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, May 01, 2014 at 08:06:46PM +0300, Samuli Sepp=E4nen wrote:
> A few notes about where we get our patches from... in the documentation
> we do say that "post the patch to openvpn-devel list". That was a
> decision that was reached some years ago. However, we, in practice, do
> accept patches from Trac, GitHub and IRC. We should probably change the
> documentation to reflect this.

Actually, openvpn-devel *is* the way, with trac being second (due to
the way we reference every commit to a mail on openvpn-devel, trac=20
patches basically need someone re-sending them to the list).

Github and IRC are *not* a welcome input for patches, because it doesn't
match the agreed-upon workflow ("ack or nack on the list, reference that
message in the commit"), and doesn't have the benefit of trac to be
tied to a ticket that can be set to a given milestone, etc.

IRC is very welcome to bounce around ideas ("should we fix this?  if=20
yes, in which way?") but it needs to result in a patch being sent to=20
openvpn-devel.  Actually, this is often the reason why some patches get
ACKed much quicker than others - they have been discussed, the reason
for the change is well-understood, and for complicated stuff, the details
how to tackle it might have been agreed-upon beforehand.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--svLj+9oZXALGi5x6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU2KdQakuBuNlUUl1AQLAfwP+Plwu1vV3a5SimuBv49emK3dDJEZS0Jyg
uG401N4JLdFMfZH3yb98B+1DWbIwCc4gUyHpV9YgnPiWKok4aMJjfp9rdnstwUUW
JzQWwY3v0jKaDmdG+EFFR7QCJNS2hkgz3LWYI852lcTa8MUqENK+bG7kA1a+uKB3
rr6F9nvaevY=
=Fle2
-----END PGP SIGNATURE-----

--svLj+9oZXALGi5x6--


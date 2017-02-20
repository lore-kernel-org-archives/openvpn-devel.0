Date: Mon, 20 Feb 2017 13:37:12 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170220123711.GX93896@...1296...>
References: <cover.1487368114.git.logout@...260...>
	<3b87d588-aad7-433d-f802-ea9f9f7a0a63@...1856...>
	<20170219174934.GK93896@...1296...>
	<CAKh=nwGOyR6reYpPvxqFVRKGDhpn7fLmw-GNBjMy=bJrqKTPmw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X0vpKvTpCy87tk9a"
Content-Disposition: inline
In-Reply-To: <CAKh=nwGOyR6reYpPvxqFVRKGDhpn7fLmw-GNBjMy=bJrqKTPmw@...278...>
Subject: Re: [Openvpn-devel] [RFC PATCH v1 00/15] Add support for OpenSSL
 1.1.x
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Emmanuel Deloget <logout@...260...>
Cc: openvpn-devel@lists.sourceforge.net

--X0vpKvTpCy87tk9a
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Feb 20, 2017 at 12:45:24PM +0100, Emmanuel Deloget wrote:
> * 0.9.8zh --> EVP_PKEY_id() is not defined. I'm adding this to
> openssl_compat.h and will provide a v2 patch with the change. Once
> added, OpenVPN compiled successfully and was able to connect to my
> /2.3 server.

If possible, please do only resend the commit that got changed, not all
of it (easier to keep track when Steffan starts sending reviews).

> * 1.0.0t --> compile OK, connect OK
>=20
> * 1.0.1u --> compile OK, connect OK
>=20
> * 1.0.2.k --> compile OK, connect OK

Great :-)

> * 1.1.0-git --> compile OK, failure to connect. I'm currently
> investigating this issue. I'll  provide a patch as soon as I fix this
> (this is a bit ironic ; I may have forgotten something somewhere...).

Interesting.  Anything useful in openvpn's logs?

> I don't have much time to test with other OpenSSL versions but I guess
> you have the infrastructure that will help.

Well, *I* do not have specific "test across various OpenSSL versions"
infrastructure, but compiling across our buildbot zoo gives us quite a
bit of coverage...  and I assume Steffan has more coverage on SSL library
versions.

thanks for your work!

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--X0vpKvTpCy87tk9a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYquL3AAoJEB2Cnv7KVigSGaMMAKBQMDlUPByh7STq56gXdecW
NxQAUE2nbVff3K4e29Tvtqvh6N5hB+pEwqYKPCzhUYHcTA4YYAt4+Wq65KFGpzcK
qMFXPNgCv/zuCLVavkUw7VlaqXSqkMWgnyNCw2MShWNC6YLF8AH0kzQnkAWSKHYI
otc5f8xDPdguWeqCd0d1X+xPw3KszPPtU9pY4De8gF98h8v9pfDjmT9cpZMKm0bg
dcWo6W6agRqNEj8IbbJ6we3zYMk9vfiZMA/BJgSUqpVvNy+YpM0Q+NkP3+v/OQvj
a4lwKzbUNFp5nbLL+WlAqQcmEtO/Z1uF0QxKmobbK7aVWVZo5oxZTsoW4COH+Two
AIiEeSW3/sQUQebP1S1SeMB/Ywu13GH4t/CdW3tcVsMIqI83XksViTDULmuvMme7
QbPBFgyRuj377uhL7rnCTAEQecHMafb4OW4OGAHnpgol68YVbyChXZFBiKZkeoN4
iHo+0uGwvx9rlpW59FLSQ6+ZxSMqvUUgOtWrY34HZA==
=Wibd
-----END PGP SIGNATURE-----

--X0vpKvTpCy87tk9a--


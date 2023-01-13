Date: Fri, 13 Jan 2023 09:44:03 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y8EZ0x9H7spmBEiJ@...1296...>
References: <20230111235052.24855-1-a@...2181...>
 <Y8EJzGoG6yEJaGmU@...1296...>
 <A4236869-0DD6-48AF-8CD0-3758E2FA4C70@...1376...>
 <22a3c27a-0404-ac58-4ae5-5f8b46ffb75c@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="F5QJGp4fLQiifKjo"
Content-Disposition: inline
In-Reply-To: <22a3c27a-0404-ac58-4ae5-5f8b46ffb75c@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] dco: print proper message in case of
 transport disconnection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Kristof Provost <kp@...1249...>, Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--F5QJGp4fLQiifKjo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jan 13, 2023 at 09:37:49AM +0100, Antonio Quartulli wrote:
> On 13/01/2023 09:32, Kristof Provost wrote:
> > I???m not sure how we???d cope with supporting building on older releas=
es=20
> > though. Not a worry just yet, because FreeBSD main is the only version=
=20
> > with DCO support in it, but it???ll be a problem sooner or later.
>=20
> OpenVPN ships its own "recent"| version of the if_ovpn.h file, no?
> So as long as the file contains all the enums it will compile just fine.

Yes, these defines are mirrored in our dco_freebsd.h - so I could just
add it there, but we need to be careful that we never have conflicting
enums in OpenVPN dco_freebsd.h vs. kernel if_ovpn.h.

Or, as Antonio explained to me how it works on linux uapi headers "enums
are only ever appended to, never ever reordered, nothing is ever deleted".

I'm open for anything that lets me ship rc2+patch as FreeBSD port :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--F5QJGp4fLQiifKjo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjwRnTAAoJEB2Cnv7KVigSrIoMAI1EFe+cBTtQis5UFiah7Rfi
sPrbBlcDTullbURhB95371n62HOUzrdoWH9khC59QICnDutq8TYoYQ7vGjPuzRml
9cEYSqzC5G7IvLbhDOV025IFrsrLwH+p2ZYdCBSzYDC/SxbS2idL873vYaBa0MpT
3Q8WN7hLAG81mjoJ4RqvPr7OdHew4rGCrXPiLzyNDGILZ3LzxSgXFtFc10vUsqv+
iQ9TKq3/Ss74yP0lmywpGwuek/oNlDv7Hq4nPMbBXVo2k8I1+h5nLNVUfd/CazYa
Bxzcdf0wUFcwe+pqEuc6l/7MpNXvKemj/f/y44a5gvbpVjOmkGvmEMkj7UcThw8z
tSLCb2vl/nh/1m23la/8TWUZ6im622LefX2oPOMOCqMuquQ4BlRvAC2XaJ8ihgLZ
BAzPYyw5rnCEC2HH+bOb8a4G68f1B/arZamwoV5DHLOFCYF7oo3Q5GSxJ/y8ueAX
vHyeMyCev0Gn5prOonf+wOFMwz7zFwdjSTb/M4rYRQ==
=L9/G
-----END PGP SIGNATURE-----

--F5QJGp4fLQiifKjo--


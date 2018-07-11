Date: Wed, 11 Jul 2018 19:49:58 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180711174957.GA989@...1296...>
References: <20180711165918.12762-1-a@...2181...>
 <20180711170042.15154-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="kuvcnBQxwPB5D5+v"
Content-Disposition: inline
In-Reply-To: <20180711170042.15154-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] socket: make stream_buf_* functions
 static
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--kuvcnBQxwPB5D5+v
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jul 12, 2018 at 01:00:42AM +0800, Antonio Quartulli wrote:
> stream_buf_init(), stream_buf_close() and stream_buf_added()
> are only used within socket.c, therefore there is noneed to
> have them declared in socket.h.
>=20
> Make them static and remove useless declarations.
> This change required some re-ordering of the functions to
> ensure they were defined before being used, however, no
> this is just a copy/paste and no function change has been
> introduced.

I'm not so happy about the large code move-around here, for small
benefit (code move-around breaks "git blame" to see which commit
introduced something, and why).

Why not just add prototypes at the top?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--kuvcnBQxwPB5D5+v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbRkNFAAoJEB2Cnv7KVigSSNUMAJinSiqw4+WIhkoyoji45cnm
ULNQos0t3E4FwfsXR9/Np9jOwbhuDF9MdxYZDNIh5VSsTt8HfPHEWJPpXFvK5mSM
aqGyt0Z6TMCrfeNPzVt2r74cknrE4Q502zhxKqOeXSYy5WVZrMPbDgWokQ+2kBsm
YITFgjxFgfjV6Mc2P3kq1XujkpOMUVKhEN5BHb+bbchy5NgZ8zLNpnlwtn3jrHvL
QUnSZJhpjvpt7u6fyfoBw5EOKaEtfoPTQsY9PEkqxaK92DChlzpiHY9IeWogTylq
rfZT7h/olEcBIdvdUh8Bdjrw4aOM85jg/+kBbm8iKZjEEXTysSdujAM9fC1m0W2/
he+IH+Y06lpRAeln67M3g42y0nk5zfB5pYV4TTMSrh7nWw2N8P/naxEt1vRXBVP/
0jsDl86fwMvOnTA0c+bY9UHThlQbiEtECCyxGg7xrfootN+v/GQx1eqvVa3QqRGS
KzIRIBzK2xQXyui9R+XGX7vO50LNvcT3+gTHBezqXw==
=XIuN
-----END PGP SIGNATURE-----

--kuvcnBQxwPB5D5+v--


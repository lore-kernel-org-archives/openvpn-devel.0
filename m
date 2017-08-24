Date: Thu, 24 Aug 2017 21:20:38 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170824192038.GI70062@...1296...>
References: <20170824133305.25604-1-a@...2181...>
 <20170824133845.3984-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3LbzE+0aVzOo6fIw"
Content-Disposition: inline
In-Reply-To: <20170824133845.3984-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] bash: substitute legacy `` with
 modern $()
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

--3LbzE+0aVzOo6fIw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 24, 2017 at 09:38:45PM +0800, Antonio Quartulli wrote:
> The backquotes for command substitution in bash are
> considered old-style in favour of the more modern $() [1].
> Substitute them.
>=20
> [1]https://www.gnu.org/software/bash/manual/html_node/Command-Substitutio=
n.html#Command-Substitution
>=20
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>=20
> v2: added overlooked occurrence

Still NAK.

> note: I did not really know how to test this patch.

More reason for NAK.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--3LbzE+0aVzOo6fIw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZnycGAAoJEB2Cnv7KVigScT8L/1zGH/Z7qBTjZV1F3/tvapvn
gA/fBb9L5cdw8dafripnct4T95BJbsmSonnlC4FXtRZVHfIOLA+nsOo/jEoiWkaH
/TEuKmdxRKu3Gh3fIT0mqZOLKKcOu/effi8AeANARpHU6ig6nUbxZM2u5Jpu9pok
HKsSNtCMvTokLpm8EIS7M8FPv5Zb+WI4X75hiCinK91ROhFiM/YN1fOtUu+5leZx
zW4RD/480DmNAg9reSjDIebZYG9738DHT8pV/TIWT6gVMlSWnYuedHBskFVz4lP1
UfaQf8Nys7iWcMGEEH5WEChwfHl6sDk1QWGb2VUoM83hKsVneWx+lGL6lDNBt/Y0
mNQP7z6LagPGwYo4KahQGVfH25qv8RTPcvQqNPeS6llFzthWUUo9G6fxE4O7RtN8
DLH+m8/XpW4Km9ZsFqfJ8RIOlQLmmfI5SkDJFYOvrOQNmQaFgx7FFm/Sg02cSAx8
fOGdbNsPTjjqR5AQeKetEZBUE6z/Grbxzo8x5kM64w==
=ipet
-----END PGP SIGNATURE-----

--3LbzE+0aVzOo6fIw--


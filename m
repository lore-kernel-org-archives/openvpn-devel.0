Date: Sun, 26 Jul 2020 16:38:28 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200726143828.GS1431@...1296...>
References: <20200725235023.22441-1-arne@...1227...>
 <202007261340.06QDeI0c097796@...2054...>
 <35a88fe9-9f72-983a-97ec-ee554bec91c1@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fbU8PLiB7QANBytI"
Content-Disposition: inline
In-Reply-To: <35a88fe9-9f72-983a-97ec-ee554bec91c1@...1227...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Include utun device number
 in utun error messages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--fbU8PLiB7QANBytI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jul 26, 2020 at 04:19:21PM +0200, Arne Schwabe wrote:
> Am 26.07.20 um 15:40 schrieb Gert Doering:
> > I wonder if we could just skip print the error message for this
> > particular call (connect()) if the return is EBUSY?  Or maybe
> > "skip if utunnumber < 10 && EBUSY"?
>=20
> since you can also specify that you want utun9 that would break that.

Only for the "loop from 0 to find the first working one", of course :)

> More realistically we should just skip the interfaces that are already
> present in the system.  Baiscally if 'does interface utunX exist?' =3D>
> skip on trying the first working one.

Yes that was the idea.

gert


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--fbU8PLiB7QANBytI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfHZVjAAoJEB2Cnv7KVigSlJsMAJZhVOfJC18iNW/MSBvc2gO/
kurCY0dLXXG23z+RBvb4kBPhmCYStv3hPse9GdXUpcm0OgK0159QfKZSl/GuTBVX
nkUkuDZBMijSP9wn7biG6FMqigRgjDNu5KJExhknG9c0yRP22ZkNtfDMK3dntBr6
YyQpxLvsOwIPZVMVsm9a9DP9jul97m1zLd+j2HUE02XqBDoufkWk5k6Zj0ksJimF
MEmjycGbgwbD6kZMNifYd252gigtT7w7mXgVdGbj1fA3yMiL3knonMy8jr2IoGdi
nqZa3M9vz2xfmxrLk5fYPhFSQrOLWwcSv3gFW7qssToeHiMn7lT6ZlXpsqe+/GUp
268LFG8q1Bk0BmyOhIOmQvPucRU/jnksdMY+p/E4N2c0PL8tK6amo/IQkYxHm37L
WkJ2+XvuiMS1xkZO+4754A5WxbqQKqeXtOpJDz56ojUMxlYYC9u/UKya6Z8hjGGp
K9ve4MMXtuz3OlMwWioUhSUTOM5SxnGKvHcIu2gFbw==
=L+m3
-----END PGP SIGNATURE-----

--fbU8PLiB7QANBytI--


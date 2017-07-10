Date: Mon, 10 Jul 2017 09:07:07 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170710070707.GG97029@...1296...>
References: <20170221192737.24166-1-davids@...515...>
	<20170221192737.24166-4-davids@...515...>
	<24404f85-157d-6d20-9fb7-8b942360a50d@...2181...>
	<20170710063017.GE97029@...1296...>
	<d8ac12f5-380f-4a1e-0fea-f96df50c1705@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wNfC9q80H5rZrTyg"
Content-Disposition: inline
In-Reply-To: <d8ac12f5-380f-4a1e-0fea-f96df50c1705@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2 3/3] Replace deprecated LZ4 function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net, Christian Hesse <mail@...1798...>

--wNfC9q80H5rZrTyg
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jul 10, 2017 at 02:33:43PM +0800, Antonio Quartulli wrote:
> On 10/07/17 14:30, Gert Doering wrote:
> > On Mon, Jul 10, 2017 at 12:31:31PM +0800, Antonio Quartulli wrote:
> >> Instead of cluttering the code with these ifdefs directly in the main
> >> codebase, how about doing it in compat.h, like this (it's a copy/paste=
 -
> >> code might be wrapper by the mail client):
> >=20
> > Better, but I wonder if we shouldn't fix this in configure.ac - "if the
> > system lz4 is older than what we bundle(*), use our compat-lz4.c instea=
d"
> >=20
> > (*) ... or older than what we need, functionality-wise
>=20
> If we do this, then we jump into the can of worms that David S.
> mentioned earlier, I think.

Uh, what can of worms specifically?  (David mentions lots of worms)

#ifdef in the code, or having funny wrapper functions hidden in .h files
are worms as well - and these two are the ones that make the code hard
to follow, so there's good reason to judge the trade-offs.


> Generally speaking, why not just depending on "libX >=3D a.b.c." and error
> out (at config time) if such lib is not available ?
>=20
> I think many other programs do exactly the same.

We are not "many other programs" :-) - and we decided, when we introduced
lz4, that we want to bundle it as it's not a library installed commonly
(yet).   And the whole point of "compat-*" stuff is "use it if the system is
not adequate", without having to be turned-on explicitly.

We can change this, and remove the bundled compat-lz4* stuff, but that's a=
=20
different discussion.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--wNfC9q80H5rZrTyg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZYyebAAoJEB2Cnv7KVigSYTQL+wfCf5YOeT0QGznG+gk2YTGK
4QsK2VebogP5uA1VTFbrUsJCcB6GgHd6SLqmZskrKmNS3J9wwYwmXvYQmhLB2Qrc
c00aKIr+oxvNDbNiLT8vkdlvPgECs/cF14ko+C3EGpupKV5XMYKhjjmqIvt4xu40
vgZiKAWYo/eUt0Ra2OANVzXg3A5F9KFrLTm8qWvHqgUVa/s+JLMVqzWINzCe9SGB
zMaRq1OyiKmPLYWuIo8uEvUxjAjiThOMtW+SGhp1soQ5W80O/4nsAXcWVb7//OhP
KbO3ZPA1AUn3KYwcDQQw2TeyuX6PmCHkMKZuV57v6UvTEyGcXP68U/QXTZWCmPim
9G/8SOqfF4mdIlzNxU2KSd6Dyn5bJWJha/L2A0FokH0VZYnWp0nt9GDteZRYQ+Di
rBCn8j39T3J/lvRTRGKj6ZugZq3kAbuWykabWmW+Dw+WN9BUs2Q24OuanKCgGR7b
ihwlqlWQOF5AIOfixLDRlgM+sNg1rrPo6viYMSinRg==
=7AY0
-----END PGP SIGNATURE-----

--wNfC9q80H5rZrTyg--


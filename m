Date: Thu, 11 Nov 2021 15:39:58 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YY0rPg+PchEmNW5F@...1296...>
References: <CAAYFXLmcybkvkw0RJ5gPVhkxrYKRr4XkdPUJwB4Cm--jQjdXKQ@...278...>
 <764146725.499610.1636544169460@...2642...>
 <CAAYFXLnJSMBcrN70GnaHRfREEosTPM-J8pZFw98DtkbNaZPKSA@...278...>
 <YY0bykbHVuGLY3DI@...1296...>
 <CAAYFXLnbfBkE7OAwOqdoQJxNt-M1aWLTcYD32Z662h-0Oc-NiA@...278...>
 <e77e551b-91f8-5fe8-2f3d-41751b568e4e@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="CgSMfPs9JzsoHakO"
Content-Disposition: inline
In-Reply-To: <e77e551b-91f8-5fe8-2f3d-41751b568e4e@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] boolean short-circuit auth upon failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Pete Nelson <petiepooo@...277...>, Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--CgSMfPs9JzsoHakO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Nov 11, 2021 at 03:34:19PM +0100, Antonio Quartulli wrote:
> In any case, I'd suggest fixing git-send-email as copy/paste may=20
> introduce all kind of formatting bugs and may make the patch unusable.

Indeed.  Line wraps, tab/space issues, "helpful mail clients", so
git-send-email is really the magic tool.

As a side note, it needs not run on the dev box - so "git format-patch",
copy the result to something that has e-mail, then "git send-email $file"
on that second box - works fine.

("git send-email HEAD" is obviously more convenient, though :-) )

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--CgSMfPs9JzsoHakO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhjSs9AAoJEB2Cnv7KVigSL2YMAJGJRfYSky+pFnr6Cx/pltIG
+0iKp9HKhirzLFZknQ/reXaL1aYAOxQxSCg64iNOspBj6HYqzvUn4aTv0dIzjMAc
8TyC8edo+EanbSrU+vKkCY/7A84XNsA78oUQdVpMzyF43nUBozSj47lAjhXCSZDu
u0xeh/MN7KVDSmgf5EX4BaBkRXX42djK2i9CMzySRERIXaASk9CejbcOVQJkGkQU
eHzayRv5/B6Me8jkkTYIrBALlgPcbOs8n+RX3bP63a/BiTf3inSsudhjod1zdPyJ
I7vsSIsrvSwPRh5lU7YfGN8lyD2BCS0UuQTyrEExhDfsmZxMAMwodtQR87Cw2+7L
mOd7WDEXrcuh/jLQYdrkEZvS5n4MO2cT26c92PGiTHEPx8GVppnPyuvpHy4wNqxr
Ty6M+bE1tpUM1qCWwpDdH8DgUrv34K+S50IzX0INH43u1diMgqZ/SoDwRtGIdtUF
v8+Yvx0dzsnaUXWN5b6lvNvyV05Jkt8zDvINqZL+sQ==
=IQs6
-----END PGP SIGNATURE-----

--CgSMfPs9JzsoHakO--


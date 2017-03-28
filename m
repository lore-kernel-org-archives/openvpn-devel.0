Date: Tue, 28 Mar 2017 08:56:48 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170328065648.GR93896@...1296...>
References: <1490444478-13188-1-git-send-email-chipitsine@...277...>
	<20170325131746.GC93896@...1296...>
	<5cbc00da-6297-c90a-611c-63ed9b0136a0@...2080...>
	<20170328060459.GM93896@...1296...>
	<CAFHpkQEWMDMs9k=6g3e5a2iMuVWMxP6zzOWZayYyL79r1U7vRg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0J9qSbGxnPCuzC2+"
Content-Disposition: inline
In-Reply-To: <CAFHpkQEWMDMs9k=6g3e5a2iMuVWMxP6zzOWZayYyL79r1U7vRg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] resolve format string warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--0J9qSbGxnPCuzC2+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 28, 2017 at 11:43:11AM +0500, ???????? ?????????????? wrote:
> > (See how dangerous "fixing compiler warnings" is?  :-) )
>=20
> this particular warning came from cppcheck, it's not a compiler warning

Same thing.  A tool that issues a warning which is not relevant the
way the variables in question are used (because the values stored are
always way below where signed/unsiged gets relevant) - but trying to fix
it, I've misread the surrounding code and the "fixed" code would quite
likely have crashed, or silently corrupted nearby variables.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--0J9qSbGxnPCuzC2+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJY2gkvAAoJEB2Cnv7KVigS5OUL/AjrhoBs0z+juWVIays9Dbsd
mpHKWoA2z5V+hH9jqRatEVpLFv40BSk0RxPqowJJNguu2/ET89k78ivqcjnpjcff
vDkckvQywBfLSs3q/l24LcqvRmJQLJsPYLT+rj96oFfa9CQLfDtShSX1ohamhH4r
ChrZ2hyFC9/aBeNB6nin0LFTOuu6t4J6yzn8obqDTVa7XhJMVTZcmaUWoaZYFy+r
a5Je9YuACaL470xcwobOYIMVV5gPdjz0xlxJaZwdmv9tcngo9BIX7+BgLRu18oG5
wR/T/hgCaNYRk4trR325t2KWAwKbqbeNDklw7agkzTjeZQq2yZKNOPRygjQdDAS/
qlp4wQ2ftSMnxTRjM0L02IGVG6hhOIo7a1FyCkytwWd1fZFNjbZuJ/CBRUhWTGkS
A5kVT71S9IsIihTTQMNvjuyTWzYxuQZ0x6PfynQORhoXe/BgYhdwGn4xLLk6zObg
ynQ3jkbFoRCCQyk47yzmREL/uv1iLMzuyGN2iDmHng==
=noG7
-----END PGP SIGNATURE-----

--0J9qSbGxnPCuzC2+--


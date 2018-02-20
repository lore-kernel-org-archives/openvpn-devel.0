Date: Tue, 20 Feb 2018 20:44:10 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180220194410.GP69387@...1296...>
References: <20180201154521.7642-1-steffan@...1856...>
 <201802200941.w1K9f8NK054824@...2054...>
 <20180220100026.GI69387@...1296...>
 <81af546a-ae8e-62b1-9f47-54647dda0672@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="NGFy4aho5lLhScak"
Content-Disposition: inline
In-Reply-To: <81af546a-ae8e-62b1-9f47-54647dda0672@...1856...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Enable stricter compiler
 warnings by default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--NGFy4aho5lLhScak
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 20, 2018 at 08:40:31PM +0100, Steffan Karger wrote:
> We could revert to an older version of the macro we ship, or to a
> simpler (though less clear) AC_CHECK_COMPILE-based check.
>=20
> I'm tempted to ditch the macro and go for the AC_CHECK_COMPILE.

The macro seems to be more painful than expected - so I tend to agree
with you :-) - patches welcome.

Though with the state of the sf.net list, patch handling is quite=20
annoying :-/  (read: some mails get through, some mails take ages,
patchwork isn't seeing stuff, the list archive isn't seeing stuff that
I could reference on merging, etc. - gah)

gert

--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--NGFy4aho5lLhScak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJajHqKAAoJEB2Cnv7KVigS5JoL/Rh8RBdX8pEffffTHaqgv4MP
Vg92pxkiJPRr9LMpAvRZBXzcAC16NofuJh3f/FCWbKyUBW9d2jXv6fuupvAe4ezM
4xrhogqGzDaXB7pSX2YNvLvSaG6wyfIkJzry9W1F7BFQ3PLLDRn/c/iCSpm8HKwp
7DAYOzU/JHqVDjs8t7f8yOOarriEeo/z01Y0McYbmlCWIa52nuWQe2/3bZTl8lLC
mLZXfIgRo/2UUw8Cl7RPL3HCqNPRebaCwC67RQ2CjsmRS4/4FwAvOUcj+vXwbS8D
IUkvtyZwbJRYe4dQrTKvlrXIuvrYe7PI5NTNFQfJhRrj9+NHeXWJYQs2l/Daz+Af
98kvxxSkmuStSGGL55+nwZRS3MsBj5TCteJLiQm3MUw/QJj5Tcoz6YX3o/yJA2bn
4o8txF40eyuTTtiMqWEnGoBgkMXRvHqPrrF0BP5HI3rXRdhIDZrFM3CA0qPLr84L
J/cl2ypwHFQsfIX3BCM2wLJy+XsP+m0HIdRv7dNA/g==
=5TW2
-----END PGP SIGNATURE-----

--NGFy4aho5lLhScak--


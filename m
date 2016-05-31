Date: Tue, 31 May 2016 10:48:25 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160531084825.GT53051@...1296...>
References: <1464668569-6480-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nRnhZLCOQLaIZm+a"
Content-Disposition: inline
In-Reply-To: <1464668569-6480-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Add an option to filter options
 received from server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--nRnhZLCOQLaIZm+a
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, May 31, 2016 at 12:22:49AM -0400, Selva Nair wrote:
> filtering stops as soon as a match is found. Full regex support is
> not available but partial matching is used to allow some flexibility.
> Thus
>=20
>   pull-filter accept "ifconfig 10.9.0."
>   pull-filter reject "ifconfig "
>   pull-filter accept "route 10."
>   pull-filter reject "route "

Thinking about this a bit more, without having studied the code - what
do you think about having a third category

   pull-filter accept "route 10."
   pull-filter reject "route 195.30."
   pull-filter ignore "route "

"ignore" would be "if that option shows up, log the fact that we ignored
it, and go on", while "reject" would be "if this shows up, something bad
is happening, so complain loudly, abort the connection and try the next
alternative".

> A maximum of 64 filters are supported.

We briefly discussed this yesterday - 64 should be plenty for about
everything, but a dynamic list might be the way to cope for the *one*
user who then comes up with the 65th rule...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--nRnhZLCOQLaIZm+a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV01P2KkuBuNlUUl1AQIwUgP+M2KF9V3/X0xGAFpXeNNStm6DL/UnybT5
ZS5NqlE9jK6n6HbVQu9oPc50FJyeRDWHp07pE8yToDtp8pzvI4mdtZcdLlBhEdxt
KrGbvKnYYbgUqz4iCb+QJUvjvUoGTXpQ0nDkT/wWmVACJE6ZncT2niRYFkA4gt82
JtHQeaeqlec=
=7GNW
-----END PGP SIGNATURE-----

--nRnhZLCOQLaIZm+a--


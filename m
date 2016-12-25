Date: Sun, 25 Dec 2016 20:58:23 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20161225125823.GI8708@...2182...>
References: <20161219013949.19551-1-a@...2181...>
	<2fc5173c-b27b-3828-f227-e15687831667@...1856...>
	<20161225100901.GG8708@...2182...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nYySOmuH/HDX6pKp"
Content-Disposition: inline
In-Reply-To: <20161225100901.GG8708@...2182...>
Subject: Re: [Openvpn-devel] [PATCH] convert *_inline attributes to bool
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--nYySOmuH/HDX6pKp
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sun, Dec 25, 2016 at 06:09:01PM +0800, Antonio Quartulli wrote:
> On Sun, Dec 25, 2016 at 10:44:45AM +0100, Steffan Karger wrote:
> >=20
> > On 19-12-16 02:39, Antonio Quartulli wrote:
> > > Carrying around the INLINE_TAG is not really efficient,
> > > because it requires a strcmp() to be performed every
> > > time we want to understand if the data is stored inline
> > > or not.
> > >=20
> > > Convert all the *_inline attributes to bool to make the
> > > logic easier and checks more efficient.
> >=20
> > This makes sense, feature-ACK.
> >=20
> > > Signed-off-by: Antonio Quartulli <a@...2181...>
> > > ---
>=20
> [CUT]
>=20
> >=20
> > Seeing the recurring "don't accidentially print key data" issues, I
> > think adding a wrapper function to check for "[[INLINE]]" (and NULL?)
> > would make sense.

Steffan,

do we really need to check for NULL? I see that somewhere we use the np()
function which already does it. But not everywhere.

What is the general rule then? cron2 explained me on IRC that in the past s=
ome C
programs would crash when trying to print NULL, but it should not be
the case anymore (at least on Linux).

I could keep the np() function where it is already used now. With a later p=
atch
I could then remove it completely or add it everywhere.


What do you think?

Cheers,

--=20
Antonio Quartulli

--nYySOmuH/HDX6pKp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYX8JsAAoJEJ6F1zG2JyOsTecP/1/4CLHEXq+NIqxrM4htTJ0n
4/MRWVKfdGLIAtjWb0a6TsntfV1EYv/+HA0EBz30XUBBzI6qDqBH2v7hURztgyh8
Tn5zb/F/TDGzGMDx/sDNxZU9Ctp3mU0Q/naQFCYYoWZKdSKr/di0XdduBk89ZxA4
5o3ZoZAxvQEb+TeagsCiqgPCt3Ga0xX9nIDtv0PcbUNX/gX1cpnC6weK1pBCfFuC
5RYrQkzg/LgzfsZNBpHBTJ0VPTQeTMM9afovjpNlM/Eo9FNM+ywa1vHqL+fatmS0
TgQmgOJWLaB2BL7mnvWf2ikGDiRGehIsvm6ivVcO735XaI3uP7Yc4q8aWXWYU3bt
CGHEGOan9zU6EscEyn7nfO/l2zgiqpXcq/35FyRqgP9BEqpgREC5tTlepL18qArc
AuRtG5a4B54TYJhCGrX7zj8hHCgyu5unZKrUe9Zo0B6pJ1BntPdOO9jr8QKhsqjM
9nxrdGEosC7wkLvd2sldSeBODRu+WAgHsA+/Ewrk+nKY9fATa/zLJj1/UbRMnXQ5
LHNsfiyPEhwh9ZJjtMdcQeqrZdBHBIsC0s+2gLaY49hXQYRH4CMd0bgbCK1FySNL
88/UcH9ZVehSU9pxTEq0ypA+xpoAIkWCcRCredOuradD/btl3Xtf/XqODs+odJs5
4MrdCMxLNfFONj648Krt
=W9Kj
-----END PGP SIGNATURE-----

--nYySOmuH/HDX6pKp--


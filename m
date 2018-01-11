Date: Thu, 11 Jan 2018 15:01:52 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180111140152.GP69387@...1296...>
References: <1514540857-19290-1-git-send-email-steffan.karger@...1435...>
 <201801091431.w09EVeSP070386@...2054...>
 <c2b39501-3ec7-0c62-f1c6-96da33c46173@...1435...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="dUQ3G7okZyz11iOi"
Content-Disposition: inline
In-Reply-To: <c2b39501-3ec7-0c62-f1c6-96da33c46173@...1435...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: travis: use clang's
 -fsanitize=address to catch more bugs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--dUQ3G7okZyz11iOi
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jan 11, 2018 at 02:55:37PM +0100, Steffan Karger wrote:
> On 09-01-18 15:31, Gert Doering wrote:
> > ACK, makes sense.
> >=20
> > Your patch has been applied to the master branch.
>=20
> Thanks.  Can you also cherry-pick this one to release/2.4?  Because
> there the clang builds are now screaming bloody murder (and sometimes
> failing) because of ccache too.

Uh.  Which one?  *this* one is about -fsanitize-address...?

I assume you want this one:

commit 0c1b9864184e609b68c2bb317ee57317ae12a026
Author: Ilya Shipitsin <chipitsine@...277...>
Date:   Fri Jan 5 00:37:10 2018 +0500

    travis-ci: add brew cache, remove ccache
=20=20=20=20


right?

gert

--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--dUQ3G7okZyz11iOi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaV25PAAoJEB2Cnv7KVigSaS4MALM6PspiXYpzeRzc9Lg43PUN
pB+3DA5LZtQRsCRfHVQ369RMyA1oseerdr6hVeZ+JEg1ZCIvFOiRXwt//AwixDNL
FEtIzIalojmn+vcZT56wVCLag5oX3vwGRMqyK6SwaBQrKDeWnP0DfTfXw4o5Usmt
uIE/HxWc0I+34gWcywrCiO/sdg3XgPzIFm2fJqBjqFt9fiYeHLYtM4pn90rEgg+/
8WCmB3F8lPha4KXse4PR8lcCyTU4wV10nzz4N8CYO3a7SQLEtrgMNrH8JvQaeM92
KwL7M5bK8EAZuG1TgpgT+3H0KlwrdvHIaxdMcxK+IEZ/pf2wxvXdaxwFMQw59jfe
Ue6DqbuE/YNczjnCyPtqc2r0Qhge6NR7NAu+J2WxbrtcfnbVcXYNDtxWNyE8yaIf
G/aMAfM52MeUm7RpemDU/3AqJBA/Ip4QrUsOoUnEH0mv2BMYfeiwGq2aHYPPeJ58
cZb3IYsikS+rFDG1UJ0I698/MTeIaojxJrzppKVXAw==
=cJF4
-----END PGP SIGNATURE-----

--dUQ3G7okZyz11iOi--


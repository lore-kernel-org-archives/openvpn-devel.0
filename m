Date: Mon, 30 Mar 2020 18:34:35 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200330163435.GE1431@...1296...>
References: <1585513970-32658-1-git-send-email-selva.nair@...277...>
 <1585513970-32658-2-git-send-email-selva.nair@...277...>
 <CAEsd45RgM7Uh55jKS=Sqz_Wy+0r_j649WvE1w6ki7V4oMjt+UQ@...278...>
 <CAKuzo_hp5ojMrr0KmnHVR335uJ58QTveuqC5C9Brqv-SUq_nTA@...278...>
 <20200330060754.GU1431@...1296...>
 <CAKuzo_gXnxLCFLpQB7Rsg+2VNP4U0jUTAjKLL_4A5nx9rdkBZw@...278...>
 <CAEsd45R3571EMBik_KauVWyfwyjS2oMKkxnbX5hj5UkniS4n3Q@...278...>
 <CAKuzo_jeYoYVMp+BkJWfdEeQ8gsm2W3RenV5UcszYxt-26p_Hg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="U4NVc4IQnsXgIEHQ"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jeYoYVMp+BkJWfdEeQ8gsm2W3RenV5UcszYxt-26p_Hg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] When auth-user-pass file has no
 password, query the management
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "Jonathan K. Bullard" <jkbullard@...277...>, Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--U4NVc4IQnsXgIEHQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 30, 2020 at 12:29:44PM -0400, Selva Nair wrote:
> Personally I would prefer to enable this code for all platforms although
> its a minor regression.
>=20
> That is, if management-query-passwords is enabled and auth file is
> missing password, query the management, not on console irrespective
> of other options and OS. If that's acceptable, I'll submit a v2.

I find this reasonable, and can't really think of a situation where=20
the current behaviour might be desirable.

So, yes, changing user-visible behaviour, but in a way that avoids
one particular hard-to-explain (or even document) corner case.

For master =3D 2.5, I'd definitely do this.

For 2.4, I'm not totally sure, but this is something we can discuss in
the community meeting if people have a strong opposing opinion (*I*
consider the current behaviour to be a bug, and the change a bugfix).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--U4NVc4IQnsXgIEHQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJegh+bAAoJEB2Cnv7KVigSlrIL/i0WrZf97fpfnkiKV6qlMtZ5
q9xrTqdofz3xzeQgIxeiCkb9LiHEFIOhpdne37VG3KCCAVgfkcKD7K4Pcj4orkCZ
Gj8pzSKzRJ8zG+Bwy9LaVbdhqDOrNi0h1F0rHQwhykQop4ZRkp4vSGAIn3SSMjus
EL+/0S6ZNfIdSZquME2d9H+TSZjO2Ph3vlEkTvpqhhMxwmltWrH3g60f67VeS1Zo
JTWO7U/062Jhtrpn0rgLfjpRl2ICYtqLODLbWuThs+VAO0nOss2VukxiBkQAe8BE
flz5ZNPYJldz7UDCryXXiQJ0nKHK3DCY7ucJeGtwhOFY8zL5x8OspKM2ljvdQuTt
RZ1sO4AL7RTFV6bOKsjgmMjGxF8bZGrDrqoHeFXGjKTjQXbt6ZzIDk2gO0FRj0X1
bDQUcQERSVrtG+IuH2lV9BK0Yhk7Ne83mzes9bit+PJZg8fM97mpT5ybrH0G1n6t
SeXCF+pwA96hePzvtDic0O45apdHpPRuMl3WshKC9A==
=2cNP
-----END PGP SIGNATURE-----

--U4NVc4IQnsXgIEHQ--


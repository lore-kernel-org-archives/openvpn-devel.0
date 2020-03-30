Date: Mon, 30 Mar 2020 08:07:54 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200330060754.GU1431@...1296...>
References: <1585513970-32658-1-git-send-email-selva.nair@...277...>
 <1585513970-32658-2-git-send-email-selva.nair@...277...>
 <CAEsd45RgM7Uh55jKS=Sqz_Wy+0r_j649WvE1w6ki7V4oMjt+UQ@...278...>
 <CAKuzo_hp5ojMrr0KmnHVR335uJ58QTveuqC5C9Brqv-SUq_nTA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="nxYNCXDYxq7LsJhQ"
Content-Disposition: inline
In-Reply-To: <CAKuzo_hp5ojMrr0KmnHVR335uJ58QTveuqC5C9Brqv-SUq_nTA@...278...>
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
Cc: "Jonathan K. Bullard" <jkbullard@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nxYNCXDYxq7LsJhQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 29, 2020 at 07:58:15PM -0400, Selva Nair wrote:
> Yes, that's right. However, that logic wont be proper on OS-X, would it?
> Command line users who use --log can still see password
> prompt on /dev/tty. We'll be breaking that behaviour.
>=20
> I considered checking for env vars like IV_UI_VER set by the UI
> client, but that's not readily accessible from auth_user_pass_cr()
> call. Alternatives like checking whether /dev/tty can be opened and/or
> systemd is available didn't appeal to me. If at all, that would have
> to be a separate patch.

Not sure if the case "there is an active management client, and=20
--management-query-passwords is set, but we *could* ask on /dev/tty"=20
is really worth considering.

(There might be cases where the management interface is not used
for password prompting, in which case /dev/tty is the way to go).

Not sure I'd worry too much about systemd here - as far as I understand,
this is somewhat orthogonal to "management interface".  So if run from
systemd, and querying via systemd, you have no management client=20
connected.

Am I making sense?  It's monday morning, halfway through my first cup
of tea :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--nxYNCXDYxq7LsJhQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJegYy5AAoJEB2Cnv7KVigSTl4L/1gf+zun161PoHAdTn8qC1ZS
uwVpsHka/Ms2ryy7ZLSkZlF8/LHRTNyiUu9emzW33Mod3+iWOB/Y02UQ6j2zjLnc
ntU4HJGamsIjgwt1shLM6ygL4ZLiczbvghb98EJyxP+kjePrjdF4t8zuI0I/apJD
596BfMrvfb+ae+xR+35DNJ02AaPpvFSMr6CfvUybjympnZllLTKifxjFDot5OrN/
imWkscdjYXyt9B+xGlFSLeovxl+C4wxhQdhCwpK3Tgu/Fw4Giy9DMhWeX2AIlUxf
V2LXCzLXC6u0dibKdnyi5J3+S3yQUFGPkYJtS18nLx8xaUuCw1eYeumZCN+sLBfU
bsJ31Cc57ryjaYh4rWXPEQPWWzOtC1jbLHnUJWhUmUu+Zd3ipnYRieOV09Pqbvw6
fAiQ8RYRhMfumQxvMOepHDkrjSoRxX5IbIk5MOEhQ9wQaGaFwl+v8kQ7Rpm3ytWT
aEWJmnuOdoK9euh+Jk5b10wPvVq22ftkPGJyiihtWQ==
=glTB
-----END PGP SIGNATURE-----

--nxYNCXDYxq7LsJhQ--


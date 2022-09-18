Date: Sun, 18 Sep 2022 14:20:52 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YycNJDGXjQ/5I0Wn@...1296...>
References: <20220917140818.6155-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="eOfoY1c467o/sawS"
Content-Disposition: inline
In-Reply-To: <20220917140818.6155-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Add common_name to the conv method.
 This allows the common_name to be accessible in PAM.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Michael Karvan <Michael.Karvan@...277...>

--eOfoY1c467o/sawS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Sep 17, 2022 at 04:08:18PM +0200, Antonio Quartulli wrote:
> From: Michael Karvan <Michael.Karvan@...277...>
>=20
> Signed-off-by: Michael Karvan <Michael.Karvan@...277...>
> ---
>  src/plugins/auth-pam/auth-pam.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-=
pam.c
> index 70339445..9f37c8c0 100644
> --- a/src/plugins/auth-pam/auth-pam.c
> +++ b/src/plugins/auth-pam/auth-pam.c
> @@ -746,8 +746,15 @@ my_conv(int n, const struct pam_message **msg_array,
>                      }
>                      break;
>=20=20
> -                case PAM_ERROR_MSG:
>                  case PAM_TEXT_INFO:
> +                    aresp[i].resp =3D strdup(up->common_name);
> +                    if (aresp[i].resp =3D=3D NULL)
> +                    {
> +                        ret =3D PAM_CONV_ERR;
> +                    }
> +                    break;
> +

Not sure I understand the intricaticies of PAM enough, but this seems
hackish and not really correct to me.

Linux' "man pam_conv" suggests that PAM_TEXT_INFO is to "Display some text",
but just having the common_name there only makes sense if you have a PAM
module that actually knows what to do with it, and displays this in a=20
nice way.  No?

Can you elaborate more on this patch, how it is interacting with specific
PAM modules, and what is happening where?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--eOfoY1c467o/sawS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjJw0jAAoJEB2Cnv7KVigSmpgL/2XDv2iVSR5dpUij4dkaSjfd
ptzEUjh+0QOQPD+06hMqfiono5iX9wb5XLrw7oEeh2b8EFgXoI4ZJ4GWN4XpCobu
dRl829b7OWakYfdBKDfViFvm7tb12Hm/2GJlHYEYDN3Bi7IUm77j1EzOUCS8X+/+
UGlPZQEDu6UVV92QN2SUSOjX197WCicPh2A942W7uKR60mNblmlA25EgSsmzD591
PQbrMiJ88jUfeU7sMhOSQvjLRpveOmHRl0pqJLEVKYVJGFMRn1YARClIX4f426LN
dEKvaMNIS1PeDdPD5qFyNfZ0+di4Dg8E22/Mr7p2RBgI9aDFVMXimg1NHjQZXpea
Jl9zWzehOQPlP8nJkN/BHAmkwjNcsxzAmCr+hwhM2iD5BCjfky/+f3840GFy2iUD
taZhmG0RKXfNYISXWpVjsbQuA8UE/H7Cd5zCXDcjxJap1rF44/6d/N6Q6DF/04gI
Yofx+qRlRtB8ASEu8BzCCkVfIZnLX7YVRtXyzGl+1Q==
=S8F2
-----END PGP SIGNATURE-----

--eOfoY1c467o/sawS--


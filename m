Date: Fri, 12 Jun 2020 08:23:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200612062333.GM1431@...1296...>
References: <1590709611.3515.22.camel@...2316...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="wmH8N0UikswiLOvK"
Content-Disposition: inline
In-Reply-To: <1590709611.3515.22.camel@...2316...>
Subject: Re: [Openvpn-devel] [BUG] test_ncp.c failing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Bottomley <James.Bottomley@...2317...>
Cc: openvpn-devel@lists.sourceforge.net

--wmH8N0UikswiLOvK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, May 28, 2020 at 04:46:51PM -0700, James Bottomley wrote:
> diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openv=
pn/test_ncp.c
> index 19432410..f58fa2ea 100644
> --- a/tests/unit_tests/openvpn/test_ncp.c
> +++ b/tests/unit_tests/openvpn/test_ncp.c
> @@ -48,7 +48,7 @@ static void
>  test_check_ncp_ciphers_list(void **state)
>  {
>      struct gc_arena gc =3D gc_new();
> -    bool have_chacha =3D cipher_kt_get("CHACHA20-POLY1305");
> +    bool have_chacha =3D cipher_kt_get(translate_cipher_name_from_openvp=
n("CHACHA20-POLY1305"));

Am I right in assuming that this patch is no longer needed with the
two cipher_kt_ translation patches I merged yesterday?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--wmH8N0UikswiLOvK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe4x9kAAoJEB2Cnv7KVigSZjoL/0WTVFsGE0xjaxhx5QTq5CSg
hFj2EO19SmY2s+3Gq8Mcllev9OGzoGucJuVST4HcjDyWh6t0t/gdXQFfq2wL1CNV
37PI9emCSfU4BzZ2B47uA3WXbRM7kA3/8wgeYboauKcbeO/75clbg3eOLqFyLPWn
74/28oDTPPi3TnfJsls9/TTTd55DjGB26hgiCm41jjHEmMZdCNhKaRI2IdP5DcM3
FCAWvV5qh1Tjt9ifFTwrm2FDvqUV8wlP5vDP99hVHbDpDTYZ2XUlSk0JWJRTGnFS
xCN8Qx2a10GPRjtEwbddUfn4POcdyTNsjElwi4K77fvZgpEoClCcNIhc3lZREH5v
8pjWuYgNJDeFLVlHx9h684YW+2wkehJJyKfoDijUtmwvLvXg3R06uuOsnjI02DlP
fT5AprROkpAOUzfVMxA9zab/4BdxNTy3LcsiXf/UuNYBI400t7t8gScRC25sA3Bs
r0wGGHRV4T7XV9G4HpD1xV2n+Vm6RSHbiCzGm3fQ3w==
=wBaT
-----END PGP SIGNATURE-----

--wmH8N0UikswiLOvK--


References: <1494008642-7239-1-git-send-email-selva.nair@...277...>
	<1494341557-11721-1-git-send-email-selva.nair@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <fc90b284-5cb5-ec0e-3609-1187551aecdb@...2080...>
Date: Tue, 9 May 2017 19:34:00 +0200
MIME-Version: 1.0
In-Reply-To: <1494341557-11721-1-git-send-email-selva.nair@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="q4NlqfVjgVbTmtNgqhJTOsTeOOjjghLB0"
Subject: Re: [Openvpn-devel] [PATCH 1/2 v2] In auth-pam plugin clear the
 password after use
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q4NlqfVjgVbTmtNgqhJTOsTeOOjjghLB0
Content-Type: multipart/mixed; boundary="rJb8E27VujgSUdd5k9Qjvf8wMLx9dhNlu";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: selva.nair@...277...
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <fc90b284-5cb5-ec0e-3609-1187551aecdb@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/2 v2] In auth-pam plugin clear the
	password after use
References: <1494008642-7239-1-git-send-email-selva.nair@...277...>
	<1494341557-11721-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1494341557-11721-1-git-send-email-selva.nair@...277...>

--rJb8E27VujgSUdd5k9Qjvf8wMLx9dhNlu
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 09/05/17 16:52, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> v2: Change the plugin open to use v3 API so that
>   openvpn_secure_memzero() exported from OpenVPN can be used.
>=20
> Note: context is cast as (openvpn_plugin_handle_t *) for consistency
> with the current plugin header. If/when the header is fixed, change
> this cast as well.
>=20
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  src/plugins/auth-pam/auth-pam.c       | 31 ++++++++++++++++++++++++++---=
--
>  src/plugins/auth-pam/auth-pam.exports |  2 +-
>  2 files changed, 27 insertions(+), 6 deletions(-)
>=20
> diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-=
pam.c
> index d3e2c89..f3566c7 100644
> --- a/src/plugins/auth-pam/auth-pam.c
> +++ b/src/plugins/auth-pam/auth-pam.c
> @@ -63,6 +63,9 @@
>  #define RESPONSE_VERIFY_SUCCEEDED 12
>  #define RESPONSE_VERIFY_FAILED    13
>=20=20
> +/* Pointers to functions exported from openvpn */
> +static plugin_secure_memzero_t plugin_secure_memzero =3D NULL;
> +
>  /*
>   * Plugin state, used by foreground
>   */
> @@ -274,8 +277,10 @@ name_value_match(const char *query, const char *matc=
h)
>      return strncasecmp(match, query, strlen(match)) =3D=3D 0;
>  }
>=20=20
> -OPENVPN_EXPORT openvpn_plugin_handle_t
> -openvpn_plugin_open_v1(unsigned int *type_mask, const char *argv[], cons=
t char *envp[])
> +OPENVPN_EXPORT int
> +openvpn_plugin_open_v3(const int v3structver,
> +                       struct openvpn_plugin_args_open_in const *args,
> +                       struct openvpn_plugin_args_open_return *ret)
>  {
>      pid_t pid;
>      int fd[2];
> @@ -285,6 +290,16 @@ openvpn_plugin_open_v1(unsigned int *type_mask, cons=
t char *argv[], const char *
>=20=20
>      const int base_parms =3D 2;
>=20=20
> +    const char **argv =3D args->argv;
> +    const char **envp =3D args->envp;
> +
> +    /* Check API compatibility */
> +    if (v3structver !=3D OPENVPN_PLUGINv3_STRUCTVER)

This generally looks good.  Going to run some tests.  But I think the
if() line above needs a reconsideration.

If the plug-in built and packaged separately and that build is not tied
to OpenVPN itself, this can make this plug-in fail without any
particular real reason if the OpenVPN binary gets updated independently.

Even though not explicitly documented, we should never remove any
information from the plug-in v3 structs, only append to and only append
at the end of the existing structs.  This should help ensure backwards
compatibility.  So if a plug-in is built against
OPENVPN_PLUGINv3_STRUCTVER being 3, that plug-in binary should work
out-of-the-box even if OpenVPN is updating to OPENVPN_PLUGINv3_STRUCTVER
set to 4.

The sample plug-ins do have a strict requirement (v3structver !=3D
OPENVPN_PLUGINv3_STRUCTVER) but that is more meant to be a kind of
sanity check for us when testing the plug-ins during OpenVPN
development.  That tells is instantly if we've remembered to rebuild the
sample plug-in.

The plug-ins in src/plugins should use, which ensures forward
compatibility against the OpenVPN binary:

   if (v3structver < OPENVPN_PLUGINv3_STRUCTVER)

So if OpenVPN gets upgraded the plug-in will still work, new features
exists but the plug-in isn't written to make use of them.  If OpenVPN
gets downgraded with a lesser plug-in API, it will complain as features
are missing.

In fact, if a plug-in only needs the feature-set of
OPENVPN_PLUGINv3_STRUCTVER 2 or 1, it is possible replace the macro
constant with the appropriate integer value.  That can ensure the
plug-in works regardless of which version of the openvpn-plugin.h it is
built against.

(And yes, I do realise we need more proper plug-in documentation)


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc





--rJb8E27VujgSUdd5k9Qjvf8wMLx9dhNlu--

--q4NlqfVjgVbTmtNgqhJTOsTeOOjjghLB0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZEf2JAAoJEIbPlEyWcf3yXvIQAMF0Zu9B0U9rIMS35nfKhlsm
jYorJPbbT/+WKz+DmpitJbmRdkNwNNS1vH/tCq18eP9AfBGnrElbF7yQPjIZxhoX
kAH9weuZwr8WhbPzW3YGOeWcHOhTNnGxKMGIRzExhwGEoxcqnAHaZlM5fO2lg7Mh
HbeuDVcM9WTcJD8bQlD4cjaRREZUqGYoAF4S3pBcUN0gmINapscEXPTnqBdxGXbY
dOeBmc3CG5dW6yAaPJpO62pIKLP/iZCzGiTNmTntEvC4395EAuMd/QMTxKFVdHtD
dBHcn4jElcExMTH2kFAnWWImj+4pKPiJy2uS704KKqt/ihS/4MJOMNVt0HYfgvzQ
guXpEldOZ/Mz5PUCFTXdquU3JHUQryk23Chy4j9oQEfBFZXuPaBlXgDOYrl9u8Sd
wGe+5J4YwVT8VwnyWKS+eMxr/mhOyhKLEvPzBsswRnpD2lYqXBatRs/qa3t9NwA5
lsBjicYPHNyXw7iPxJ3pRqwYeHMc8rG9XZIhErhYhyO8354URa+K3od+itqU75Yp
TYs1+MlQI8S/BnYSabmyuXoKKCZrd78YzB9xEAKKPoSXliteh/5HwsK17V3CrSUc
JyUtP5V2JgGevBxC1mMLBbRQY8/kutx4c8r7zcwbV3rw2Y+Aa3pHaKjacVmRTFTm
ovkgd21YFGm1crNAZORO
=H2M3
-----END PGP SIGNATURE-----

--q4NlqfVjgVbTmtNgqhJTOsTeOOjjghLB0--


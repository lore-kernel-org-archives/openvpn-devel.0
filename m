References: <CACDCbPo_kdRDHe7-zJZnELyBGBpLEan=hKv6ScTHzE1KT=inzg@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <1ba4b18f-1861-f211-42ef-9ee23cb92563@...2181...>
Date: Sun, 1 Jul 2018 01:49:26 +0800
MIME-Version: 1.0
In-Reply-To: <CACDCbPo_kdRDHe7-zJZnELyBGBpLEan=hKv6ScTHzE1KT=inzg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LxVXuWz8sRM79x4dCMhWHhgjZ0AMDalJ5"
Subject: Re: [Openvpn-devel] [PATCH] Remove deprecated plugin functions from
 code samples
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Greg Cox <gcox@...1057...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LxVXuWz8sRM79x4dCMhWHhgjZ0AMDalJ5
Content-Type: multipart/mixed; boundary="KQ2O2JLMx5eAecM8h1H7iuarrnrc89Vp5";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Greg Cox <gcox@...1057...>, openvpn-devel@lists.sourceforge.net
Message-ID: <1ba4b18f-1861-f211-42ef-9ee23cb92563@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Remove deprecated plugin functions from
 code samples
References: <CACDCbPo_kdRDHe7-zJZnELyBGBpLEan=hKv6ScTHzE1KT=inzg@...278...>
In-Reply-To: <CACDCbPo_kdRDHe7-zJZnELyBGBpLEan=hKv6ScTHzE1KT=inzg@...278...>

--KQ2O2JLMx5eAecM8h1H7iuarrnrc89Vp5
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 01/07/18 00:58, Greg Cox wrote:
> While writing up a plugin, I found that the sample plugin code was using
> openvpn_plugin_open_v1.  Since that and openvpn_plugin_func_v1 are listed
> as 'deprecated' in openvpn-plugin.h, it made sense to me that you shouldn=
't
> list those functions as sample code for others to clone.
>=20
> This edits only sample code and since it's my first patch I thought I'd
> limit to that.  src/plugins/auth-pam and src/plugins/down-root have simil=
ar
> 'issues', though, and may need the same treatment, if I have the right id=
ea.
>=20
> Thanks for reading.
> -Greg
>=20

I'd remove the last paragraph and the greetings from the commit message.
But this might be done at commit time.

> ---
>  sample/sample-plugins/defer/simple.c    | 5 +++--
>  sample/sample-plugins/defer/simple.def  | 4 ++--
>  sample/sample-plugins/log/log.c         | 6 ++++--
>  sample/sample-plugins/simple/simple.c   | 6 ++++--
>  sample/sample-plugins/simple/simple.def | 4 ++--
>  5 files changed, 15 insertions(+), 10 deletions(-)
>=20
> diff --git a/sample/sample-plugins/defer/simple.c
> b/sample/sample-plugins/defer/simple.c
> index
> d18695b59d6966e5cc84a19e176ea9ec18d0b452..d55e47be01aa346cfc9c70aa24f8722=
e5a1d67f9
> 100644
> --- a/sample/sample-plugins/defer/simple.c
> +++ b/sample/sample-plugins/defer/simple.c
> @@ -131,11 +131,12 @@ atoi_null0(const char *str)
>  }
>=20
>  OPENVPN_EXPORT openvpn_plugin_handle_t
> -openvpn_plugin_open_v1(unsigned int *type_mask, const char *argv[], const
> char *envp[])
> +openvpn_plugin_open_v2(unsigned int *type_mask, const char *argv[], const
> char *envp[],
> +                       struct openvpn_plugin_string_list **return_list)
>  {
>      struct plugin_context *context;
>=20
> -    printf("FUNC: openvpn_plugin_open_v1\n");
> +    printf("FUNC: openvpn_plugin_open_v2\n");
>=20
>      /*
>       * Allocate our context
> diff --git a/sample/sample-plugins/defer/simple.def
> b/sample/sample-plugins/defer/simple.def
> index
> a87507d1fdc0f0bfd0434de577a818ef0cc62afb..556f362308bc6ce81829253f7a7fae9=
898be221a
> 100755
> --- a/sample/sample-plugins/defer/simple.def
> +++ b/sample/sample-plugins/defer/simple.def
> @@ -1,6 +1,6 @@
>  LIBRARY   OpenVPN_PLUGIN_SAMPLE
>  DESCRIPTION "Sample OpenVPN plug-in module."
>  EXPORTS
> -   openvpn_plugin_open_v1   @1
> -   openvpn_plugin_func_v1   @2
> +   openvpn_plugin_open_v2   @1
> +   openvpn_plugin_func_v2   @2
>     openvpn_plugin_close_v1  @3
> diff --git a/sample/sample-plugins/log/log.c
> b/sample/sample-plugins/log/log.c
> index
> ecf62c0e653c8ec852ab641e75363747b795c1af..efa8e5184db34f36a311fb61436cdfd=
61dd02f78
> 100644
> --- a/sample/sample-plugins/log/log.c
> +++ b/sample/sample-plugins/log/log.c
> @@ -70,7 +70,8 @@ get_env(const char *name, const char *envp[])
>  }
>=20
>  OPENVPN_EXPORT openvpn_plugin_handle_t
> -openvpn_plugin_open_v1(unsigned int *type_mask, const char *argv[], const
> char *envp[])
> +openvpn_plugin_open_v2(unsigned int *type_mask, const char *argv[], const
> char *envp[],
> +                       struct openvpn_plugin_string_list **return_list)
>  {
>      struct plugin_context *context;
>=20
> @@ -164,7 +165,8 @@ show(const int type, const char *argv[], const char
> *envp[])
>  }
>=20
>  OPENVPN_EXPORT int
> -openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type,
> const char *argv[], const char *envp[])
> +openvpn_plugin_func_v2(openvpn_plugin_handle_t handle, const int type,
> const char *argv[], const char *envp[],
> +                       void *per_client_context, struct
> openvpn_plugin_string_list **return_list)
>  {
>      struct plugin_context *context =3D (struct plugin_context *) handle;
>=20
> diff --git a/sample/sample-plugins/simple/simple.c
> b/sample/sample-plugins/simple/simple.c
> index
> 950c547e22c1d44c59812eb90606fbdb52981021..66695950abfcbc6ebb0a4d4fa621627=
a6099ba76
> 100644
> --- a/sample/sample-plugins/simple/simple.c
> +++ b/sample/sample-plugins/simple/simple.c
> @@ -72,7 +72,8 @@ get_env(const char *name, const char *envp[])
>  }
>=20
>  OPENVPN_EXPORT openvpn_plugin_handle_t
> -openvpn_plugin_open_v1(unsigned int *type_mask, const char *argv[], const
> char *envp[])
> +openvpn_plugin_open_v2(unsigned int *type_mask, const char *argv[], const
> char *envp[],
> +                       struct openvpn_plugin_string_list **return_list)
>  {
>      struct plugin_context *context;
>=20
> @@ -97,7 +98,8 @@ openvpn_plugin_open_v1(unsigned int *type_mask, const
> char *argv[], const char *
>  }
>=20
>  OPENVPN_EXPORT int
> -openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type,
> const char *argv[], const char *envp[])
> +openvpn_plugin_func_v2(openvpn_plugin_handle_t handle, const int type,
> const char *argv[], const char *envp[],
> +                       void *per_client_context, struct
> openvpn_plugin_string_list **return_list)
>  {
>      struct plugin_context *context =3D (struct plugin_context *) handle;
>=20
> diff --git a/sample/sample-plugins/simple/simple.def
> b/sample/sample-plugins/simple/simple.def
> index
> a87507d1fdc0f0bfd0434de577a818ef0cc62afb..556f362308bc6ce81829253f7a7fae9=
898be221a
> 100755
> --- a/sample/sample-plugins/simple/simple.def
> +++ b/sample/sample-plugins/simple/simple.def
> @@ -1,6 +1,6 @@
>  LIBRARY   OpenVPN_PLUGIN_SAMPLE
>  DESCRIPTION "Sample OpenVPN plug-in module."
>  EXPORTS
> -   openvpn_plugin_open_v1   @1
> -   openvpn_plugin_func_v1   @2
> +   openvpn_plugin_open_v2   @1
> +   openvpn_plugin_func_v2   @2
>     openvpn_plugin_close_v1  @3
> --
> 2.15.2 (Apple Git-101.1)

did you concatenate two patches? or what happened? It seems that the
part after this is not recognised as proper patch.


Cheers,


--=20
Antonio Quartulli


--KQ2O2JLMx5eAecM8h1H7iuarrnrc89Vp5--

--LxVXuWz8sRM79x4dCMhWHhgjZ0AMDalJ5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAls3wqYACgkQB6U8WA7y
zXRpSw/9EGnygDJ2pXBWsi2Ri0vQageKrtu86g9Zvpx+wBU+4xUevlw0eKb+elFL
qoZ32sdTel20EQIGetqh7U2pUgs5PyNknV93bdKvGTaE+sk4YY8wjAnePHx1tl/2
EEtvHkPoMK8SEZP+e87wgZ0h8Pohyp1XHPiHqjXsxVvZRK44AKm5ngSfoYXv62M8
gw4Db2T+ukIQh/TrEWoG2hh2fOsNuGBNCtXMLQ4q6f9dBEE/lBx3IQCmjJWbxAk6
ZcwCDCpfIQ1+mZBHlr7b/X+1oIw3U+SwoJQOECY+0D2sqGLeuzGsQ7ojTK27bjxe
esmi8ZqmG3dcu5cSGB9aHGwGqFUFAiAVrE11dLplE23BbubV6GinHWnDANNCY39Y
+4W7+uC+BaDF4CWM3Bnth75S0OltdzH3/PK6SOzsDHAiA/eTqPmO/h9SQhd2xNPU
2cPtpFSir0UyEUqoltmVRD+AJ+g/y9MWBU6bHVrGSD230aZOw6Pf54WjSQ/u7d6y
ruhv/5taOGFPr3+e+5Vn72f/HtdIEVu8/4xR6iUg0OPEviqSFXhh8CkVK8TmNF/W
er6wFpEGqUWK0kDYcAB3HHu3Hd2v+i6bn28q6NblCOc0enU2bP3gdlq+KgauRoxw
addNVMqDfzymWYQOAmEr09bs3REDSXC1pyi40JrfkntkFjBBHjg=
=Oxb1
-----END PGP SIGNATURE-----

--LxVXuWz8sRM79x4dCMhWHhgjZ0AMDalJ5--


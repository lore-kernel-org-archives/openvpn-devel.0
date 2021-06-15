MIME-Version: 1.0
References: <20210615104149.149-1-lstipakov@...277...>
In-Reply-To: <20210615104149.149-1-lstipakov@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 15 Jun 2021 13:43:06 +0300
Message-ID: <CAGyAFMU=LxoctGkACVT-udUE9b7L8j8nY9WMKX8OQTATDpB-Lw@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] contrib/vcpkg-ports: add
 pkcs11-helper port
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Cc: Lev Stipakov <lev@...515...>

Oh please disregard this, I've managed to send the wrong patch.

ti 15. kes=C3=A4k. 2021 klo 13.42 Lev Stipakov (lstipakov@...277...) kirjoi=
tti:
>
> From: Lev Stipakov <lev@...515...>
>
> pkcs11-helper is a dependency library used by OpenVPN.
> So far it has been built only by mingw.
>
> Since we're making MSVC build system a first class citizen,
> we need to build depencencies with MSVC, which we do with vcpkg.
> All dependencies are in vcpkg official repo, expect pkcs11-helper.
>
> This provides vcpkg port for building pkcs11-helper.
>
> Example usage:
>
>  vcpkg --overlay-ports=3D<openvpn>\contrib\vcpkg-ports install pkcs11-hel=
per
>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>
>  v3:
>    - use correct OPENSSL_HOME (remove -windows suffix)
>    - remove deprecated "include(vcpkg_common_functions)"
>
>  v2:
>    - add missing dll installation commands to port file
>
>  .../0001-nmake-openssl-1.1.1-support.patch    |  89 +++
>  contrib/vcpkg-ports/pkcs11-helper/CONTROL     |   4 +
>  .../pkcs11-helper-001-RFC7512.patch           | 686 ++++++++++++++++++
>  .../vcpkg-ports/pkcs11-helper/portfile.cmake  |  35 +
>  4 files changed, 814 insertions(+)
>  create mode 100644 contrib/vcpkg-ports/pkcs11-helper/0001-nmake-openssl-=
1.1.1-support.patch
>  create mode 100644 contrib/vcpkg-ports/pkcs11-helper/CONTROL
>  create mode 100644 contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-R=
FC7512.patch
>  create mode 100644 contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
>
> diff --git a/contrib/vcpkg-ports/pkcs11-helper/0001-nmake-openssl-1.1.1-s=
upport.patch b/contrib/vcpkg-ports/pkcs11-helper/0001-nmake-openssl-1.1.1-s=
upport.patch
> new file mode 100644
> index 00000000..8a6750b9
> --- /dev/null
> +++ b/contrib/vcpkg-ports/pkcs11-helper/0001-nmake-openssl-1.1.1-support.=
patch
> @@ -0,0 +1,89 @@
> +From 324026ce179468fcea348e59259dbc5456438ead Mon Sep 17 00:00:00 2001
> +From: Lev Stipakov <lev@...515...>
> +Date: Fri, 14 May 2021 14:35:53 +0300
> +Subject: [PATCH] nmake: openssl 1.1.1 support
> +
> +Starting from version 1.1.1, OpenSSL includes routines
> +like RSA_meth_xxx and DSA_meth_xxx. pkcs11-helper includes
> +implementation of those routines. That code is compiled if
> +they're missing from OpenSSL.
> +
> +nmake build uses pre-generated config-w32-vc.h, which lacks
> +defines which indicate that OpenSSL includes above routines,
> +which causes pkcs11's own implementaion to be compiled. However,
> +pkcs11-helper implementation is not compatible with OpenSSL 1.1.1 -
> +for example, it takes size of opaque struct RSA_METHOD, which
> +has become internal in OpenSSL.
> +
> +This adds necessary defines to config header used by nmake build
> +so that pkcs11-helper code, which is not compatible with OpenSSL 1.1.1,
> +is not compiled.
> +
> +Also libeay is changed to libcrypto.
> +
> +Signed-off-by: Lev Stipakov <lev@...515...>
> +---
> + config-w32-vc.h.in  | 33 +++++++++++++++++++++++++++++++++
> + lib/Makefile.w32-vc |  4 ++--
> + 2 files changed, 35 insertions(+), 2 deletions(-)
> +
> +diff --git a/config-w32-vc.h b/config-w32-vc.h
> +index 6346f02..102b2e3 100644
> +--- a/config-w32-vc.h
> ++++ b/config-w32-vc.h
> +@@ -185,3 +185,36 @@
> + #if _MSC_VER >=3D 1400
> + #define HAVE_CPP_VARARG_MACRO_ISO 1
> + #endif
> ++
> ++/* Define to 1 if you have the `RSA_meth_dup' function. */
> ++#define HAVE_RSA_METH_DUP 1
> ++
> ++/* Define to 1 if you have the `RSA_meth_free' function. */
> ++#define HAVE_RSA_METH_FREE 1
> ++
> ++/* Define to 1 if you have the `RSA_meth_set1_name' function. */
> ++#define HAVE_RSA_METH_SET1_NAME 1
> ++
> ++/* Define to 1 if you have the `RSA_meth_set_flags' function. */
> ++#define HAVE_RSA_METH_SET_FLAGS 1
> ++
> ++/* Define to 1 if you have the `RSA_meth_set_priv_dec' function. */
> ++#define HAVE_RSA_METH_SET_PRIV_DEC 1
> ++
> ++/* Define to 1 if you have the `RSA_meth_set_priv_enc' function. */
> ++#define HAVE_RSA_METH_SET_PRIV_ENC 1
> ++
> ++/* Define to 1 if you have the `DSA_meth_dup' function. */
> ++#define HAVE_DSA_METH_DUP 1
> ++
> ++/* Define to 1 if you have the `DSA_meth_free' function. */
> ++#define HAVE_DSA_METH_FREE 1
> ++
> ++/* Define to 1 if you have the `DSA_meth_set1_name' function. */
> ++#define HAVE_DSA_METH_SET1_NAME 1
> ++
> ++/* Define to 1 if you have the `DSA_meth_set_sign' function. */
> ++#define HAVE_DSA_METH_SET_SIGN 1
> ++
> ++/* Define to 1 if you have the `DSA_SIG_set0' function. */
> ++#define HAVE_DSA_SIG_SET0 1
> +diff --git a/lib/Makefile.w32-vc b/lib/Makefile.w32-vc
> +index 2edab39..b2ac746 100644
> +--- a/lib/Makefile.w32-vc
> ++++ b/lib/Makefile.w32-vc
> +@@ -60,9 +60,9 @@ OPENSSL_HOME =3D ..\..\openssl-0.9.8a
> + !endif
> +
> + !ifdef OPENSSL
> +-OPENSSL_STATIC =3D libeay32.lib
> ++OPENSSL_STATIC =3D libcrypto.lib
> + #OPENSSL_STATIC =3D libeay32sd.lib
> +-OPENSSL_DYNAMIC =3D libeay32.lib
> ++OPENSSL_DYNAMIC =3D libcrypto.lib
> + #OPENSSL_DYNAMIC =3D libeay32d.lib
> +
> + OPENSSL_INC=3D$(OPENSSL_HOME)\include
> +--
> +2.23.0.windows.1
> +
> diff --git a/contrib/vcpkg-ports/pkcs11-helper/CONTROL b/contrib/vcpkg-po=
rts/pkcs11-helper/CONTROL
> new file mode 100644
> index 00000000..01831802
> --- /dev/null
> +++ b/contrib/vcpkg-ports/pkcs11-helper/CONTROL
> @@ -0,0 +1,4 @@
> +Source: pkcs11-helper
> +Version: 1.27-1
> +Homepage: https://github.com/OpenSC/pkcs11-helper
> +Description: pkcs11-helper is a library that simplifies the interaction =
with PKCS#11 providers for end-user applications.
> diff --git a/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.=
patch b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch
> new file mode 100644
> index 00000000..84fba080
> --- /dev/null
> +++ b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch
> @@ -0,0 +1,686 @@
> +commit 90590b02085edc3830bdfe0942a46c4e7bf3f1ab (HEAD -> master)
> +Author: David Woodhouse <David.Woodhouse@...753...>
> +Date:   Thu Apr 30 14:58:24 2015 +0100
> +
> +    Serialize to RFC7512-compliant PKCS#11 URIs
> +
> +    Signed-off-by: David Woodhouse <David.Woodhouse@...753...>
> +
> +commit 4d5280da8df591aab701dff4493d13a835a9b29c
> +Author: David Woodhouse <David.Woodhouse@...753...>
> +Date:   Wed Dec 10 14:00:21 2014 +0000
> +
> +    Accept RFC7512-compliant PKCS#11 URIs as serialized token/certificat=
e IDs
> +
> +    The old format is still accepted for compatibility.
> +
> +    Signed-off-by: David Woodhouse <David.Woodhouse@...753...>
> +
> +commit 14e09211c3d50eb06825090c9765e4382cf52f19
> +Author: David Woodhouse <David.Woodhouse@...753...>
> +Date:   Sun Dec 14 19:42:18 2014 +0000
> +
> +    Stop _pkcs11h_util_hexToBinary() checking for trailing NUL
> +
> +    We are going to want to use this for parsing %XX hex escapes in RFC7=
512
> +    PKCS#11 URIs, where we cannot expect a trailing NUL. Since there's o=
nly
> +    one existing caller at the moment, it's simple just to let the caller
> +    have responsibility for that check.
> +
> +    Signed-off-by: David Woodhouse <David.Woodhouse@...753...>
> +diff --git a/lib/pkcs11h-serialization.c b/lib/pkcs11h-serialization.c
> +index ad275f8..1d077e4 100644
> +--- a/lib/pkcs11h-serialization.c
> ++++ b/lib/pkcs11h-serialization.c
> +@@ -61,29 +61,127 @@
> +
> + #if defined(ENABLE_PKCS11H_TOKEN) || defined(ENABLE_PKCS11H_CERTIFICATE)
> +
> ++#define URI_SCHEME "pkcs11:"
> ++
> ++#define token_field_ofs(field) ((unsigned long)&(((struct pkcs11h_token=
_id_s *)0)->field))
> ++#define token_field_size(field) sizeof((((struct pkcs11h_token_id_s *)0=
)->field))
> ++#define token_field(name, field) { name "=3D", sizeof(name), \
> ++                                 token_field_ofs(field), token_field_si=
ze(field) }
> ++
> ++static struct {
> ++      const char const *name;
> ++      size_t namelen;
> ++      unsigned long field_ofs;
> ++      size_t field_size;
> ++} __token_fields[] =3D {
> ++      token_field ("model", model),
> ++      token_field ("token", label),
> ++      token_field ("manufacturer", manufacturerID ),
> ++      token_field ("serial", serialNumber ),
> ++      { NULL },
> ++};
> ++
> ++#define               P11_URL_VERBATIM      "abcdefghijklmnopqrstuvwxyz=
" \
> ++                                            "ABCDEFGHIJKLMNOPQRSTUVWXYZ=
" \
> ++                                            "0123456789_-."
> ++
> ++static
> ++int
> ++__token_attr_escape(char *uri, char *attr, size_t attrlen)
> ++{
> ++      int len =3D 0, i;
> ++
> ++      for (i =3D 0; i < attrlen; i++) {
> ++              if ((attr[i] !=3D '\x0') && strchr(P11_URL_VERBATIM, attr=
[i])) {
> ++                      if (uri) {
> ++                              *(uri++) =3D attr[i];
> ++                      }
> ++                      len++;
> ++              } else {
> ++                      if (uri) {
> ++                              sprintf(uri, "%%%02x", (unsigned char)att=
r[i]);
> ++                              uri +=3D 3;
> ++                      }
> ++                      len +=3D 3;
> ++              }
> ++      }
> ++      return len;
> ++}
> ++
> ++static
> ++CK_RV
> ++__generate_pkcs11_uri (
> ++      OUT char * const sz,
> ++      IN OUT size_t *max,
> ++      IN const pkcs11h_certificate_id_t certificate_id,
> ++      IN const pkcs11h_token_id_t token_id
> ++) {
> ++      size_t _max;
> ++      char *p =3D sz;
> ++      int i;
> ++
> ++      _PKCS11H_ASSERT (max!=3DNULL);
> ++      _PKCS11H_ASSERT (token_id!=3DNULL);
> ++
> ++      _max =3D strlen(URI_SCHEME);
> ++      for (i =3D 0; __token_fields[i].name; i++) {
> ++              char *field =3D ((char *)token_id) + __token_fields[i].fi=
eld_ofs;
> ++
> ++              _max +=3D __token_fields[i].namelen;
> ++              _max +=3D __token_attr_escape (NULL, field, strlen(field)=
);
> ++              _max++; /* For a semicolon or trailing NUL */
> ++      }
> ++      if (certificate_id) {
> ++              _max +=3D strlen (";id=3D");
> ++              _max +=3D __token_attr_escape (NULL,
> ++                                           (char *)certificate_id->attr=
CKA_ID,
> ++                                           certificate_id->attrCKA_ID_s=
ize);
> ++      }
> ++
> ++      if (!sz) {
> ++              *max =3D _max;
> ++              return CKR_OK;
> ++      }
> ++
> ++      if (sz && *max < _max)
> ++              return CKR_ATTRIBUTE_VALUE_INVALID;
> ++
> ++      p +=3D sprintf(p, URI_SCHEME);
> ++      for (i =3D 0; __token_fields[i].name; i++) {
> ++              char *field =3D ((char *)token_id) + __token_fields[i].fi=
eld_ofs;
> ++
> ++              p +=3D sprintf (p, "%s", __token_fields[i].name);
> ++              p +=3D __token_attr_escape (p, field, strlen(field));
> ++              *(p++) =3D ';';
> ++      }
> ++      if (certificate_id) {
> ++              p +=3D sprintf (p, "id=3D");
> ++              p +=3D __token_attr_escape (p,
> ++                                        (char *)certificate_id->attrCKA=
_ID,
> ++                                        certificate_id->attrCKA_ID_size=
);
> ++      } else {
> ++              /* Remove the unneeded trailing semicolon */
> ++              p--;
> ++      }
> ++      *(p++) =3D 0;
> ++
> ++      *max =3D _max;
> ++
> ++      return CKR_OK;
> ++}
> ++
> + CK_RV
> + pkcs11h_token_serializeTokenId (
> +       OUT char * const sz,
> +       IN OUT size_t *max,
> +       IN const pkcs11h_token_id_t token_id
> + ) {
> +-      const char *sources[5];
> +       CK_RV rv =3D CKR_FUNCTION_FAILED;
> +-      size_t n;
> +-      int e;
> +
> +       /*_PKCS11H_ASSERT (sz!=3DNULL); Not required*/
> +       _PKCS11H_ASSERT (max!=3DNULL);
> +       _PKCS11H_ASSERT (token_id!=3DNULL);
> +
> +-      { /* Must be after assert */
> +-              sources[0] =3D token_id->manufacturerID;
> +-              sources[1] =3D token_id->model;
> +-              sources[2] =3D token_id->serialNumber;
> +-              sources[3] =3D token_id->label;
> +-              sources[4] =3D NULL;
> +-      }
> +-
> +       _PKCS11H_DEBUG (
> +               PKCS11H_LOG_DEBUG2,
> +               "PKCS#11: pkcs11h_token_serializeTokenId entry sz=3D%p, *=
max=3D"P_Z", token_id=3D%p",
> +@@ -92,67 +190,161 @@ pkcs11h_token_serializeTokenId (
> +               (void *)token_id
> +       );
> +
> +-      n =3D 0;
> +-      for (e=3D0;sources[e] !=3D NULL;e++) {
> +-              size_t t;
> +-              if (
> +-                      (rv =3D _pkcs11h_util_escapeString (
> +-                              NULL,
> +-                              sources[e],
> +-                              &t,
> +-                              __PKCS11H_SERIALIZE_INVALID_CHARS
> +-                      )) !=3D CKR_OK
> +-              ) {
> +-                      goto cleanup;
> ++      rv =3D __generate_pkcs11_uri(sz, max, NULL, token_id);
> ++
> ++      _PKCS11H_DEBUG (
> ++              PKCS11H_LOG_DEBUG2,
> ++              "PKCS#11: pkcs11h_token_serializeTokenId return rv=3D%lu-=
'%s', *max=3D"P_Z", sz=3D'%s'",
> ++              rv,
> ++              pkcs11h_getMessage (rv),
> ++              *max,
> ++              sz
> ++      );
> ++
> ++      return rv;
> ++}
> ++
> ++static
> ++CK_RV
> ++__parse_token_uri_attr (
> ++      const char *uri,
> ++      size_t urilen,
> ++      char *tokstr,
> ++      size_t toklen,
> ++      size_t *parsed_len
> ++) {
> ++      size_t orig_toklen =3D toklen;
> ++      CK_RV rv =3D CKR_OK;
> ++
> ++      while (urilen && toklen > 1) {
> ++              if (*uri =3D=3D '%') {
> ++                      size_t size =3D 1;
> ++
> ++                      if (urilen < 3) {
> ++                              rv =3D CKR_ATTRIBUTE_VALUE_INVALID;
> ++                              goto done;
> ++                      }
> ++
> ++                      rv =3D _pkcs11h_util_hexToBinary ((unsigned char =
*)tokstr,
> ++                                                      uri + 1, &size);
> ++                      if (rv !=3D CKR_OK) {
> ++                              goto done;
> ++                      }
> ++
> ++                      uri +=3D 2;
> ++                      urilen -=3D 2;
> ++              } else {
> ++                      *tokstr =3D *uri;
> +               }
> +-              n+=3Dt;
> ++              tokstr++;
> ++              uri++;
> ++              toklen--;
> ++              urilen--;
> ++              tokstr[0] =3D 0;
> +       }
> +
> +-      if (sz !=3D NULL) {
> +-              if (*max < n) {
> +-                      rv =3D CKR_ATTRIBUTE_VALUE_INVALID;
> +-                      goto cleanup;
> ++      if (urilen) {
> ++              rv =3D CKR_ATTRIBUTE_VALUE_INVALID;
> ++      } else if (parsed_len) {
> ++              *parsed_len =3D orig_toklen - toklen;
> ++      }
> ++
> ++ done:
> ++      return rv;
> ++}
> ++
> ++static
> ++CK_RV
> ++__parse_pkcs11_uri (
> ++      OUT pkcs11h_token_id_t token_id,
> ++      OUT pkcs11h_certificate_id_t certificate_id,
> ++      IN const char * const sz
> ++) {
> ++      const char *end, *p;
> ++      CK_RV rv =3D CKR_OK;
> ++
> ++      _PKCS11H_ASSERT (token_id!=3DNULL);
> ++      _PKCS11H_ASSERT (sz!=3DNULL);
> ++
> ++      if (strncmp (sz, URI_SCHEME, strlen (URI_SCHEME)))
> ++              return CKR_ATTRIBUTE_VALUE_INVALID;
> ++
> ++      end =3D sz + strlen (URI_SCHEME) - 1;
> ++      while (rv =3D=3D CKR_OK && end[0] && end[1]) {
> ++              int i;
> ++
> ++              p =3D end + 1;
> ++              end =3D strchr (p, ';');
> ++              if (!end)
> ++                      end =3D p + strlen(p);
> ++
> ++              for (i =3D 0; __token_fields[i].name; i++) {
> ++                      /* Parse the token=3D, label=3D, manufacturer=3D =
and serial=3D fields */
> ++                      if (!strncmp(p, __token_fields[i].name, __token_f=
ields[i].namelen)) {
> ++                              char *field =3D ((char *)token_id) + __to=
ken_fields[i].field_ofs;
> ++
> ++                              p +=3D __token_fields[i].namelen;
> ++                              rv =3D __parse_token_uri_attr (p, end - p=
, field,
> ++                                                           __token_fiel=
ds[i].field_size,
> ++                                                           NULL);
> ++                              if (rv !=3D CKR_OK) {
> ++                                      goto cleanup;
> ++                              }
> ++
> ++                              goto matched;
> ++                      }
> +               }
> ++              if (certificate_id && !strncmp(p, "id=3D", 3)) {
> ++                      p +=3D 3;
> ++
> ++                      rv =3D _pkcs11h_mem_malloc ((void *)&certificate_=
id->attrCKA_ID,
> ++                                                end - p + 1);
> ++                      if (rv !=3D CKR_OK) {
> ++                              goto cleanup;
> ++                      }
> +
> +-              n =3D 0;
> +-              for (e=3D0;sources[e] !=3D NULL;e++) {
> +-                      size_t t =3D *max-n;
> +-                      if (
> +-                              (rv =3D _pkcs11h_util_escapeString (
> +-                                      sz+n,
> +-                                      sources[e],
> +-                                      &t,
> +-                                      __PKCS11H_SERIALIZE_INVALID_CHARS
> +-                              )) !=3D CKR_OK
> +-                      ) {
> ++                      rv =3D __parse_token_uri_attr (p, end - p,
> ++                                                   (char *)certificate_=
id->attrCKA_ID,
> ++                                                   end - p + 1,
> ++                                                   &certificate_id->att=
rCKA_ID_size);
> ++                      if (rv !=3D CKR_OK) {
> +                               goto cleanup;
> +                       }
> +-                      n+=3Dt;
> +-                      sz[n-1] =3D '/';
> ++
> ++                      goto matched;
> +               }
> +-              sz[n-1] =3D '\x0';
> +-      }
> +
> +-      *max =3D n;
> +-      rv =3D CKR_OK;
> ++              /* We don't parse object=3D because the match code doesn'=
t support
> ++                 matching by label. */
> ++
> ++              /* Failed to parse PKCS#11 URI element. */
> ++              return CKR_ATTRIBUTE_VALUE_INVALID;
> +
> ++              matched:
> ++                  ;
> ++      }
> + cleanup:
> ++      /* The matching code doesn't support support partial matches; it =
needs
> ++       * *all* of manufacturer, model, serial and label attributes to be
> ++       * defined. So reject partial URIs early instead of letting it do=
 the
> ++       * wrong thing. We can maybe improve this later. */
> ++      if (!token_id->model[0] || !token_id->label[0] ||
> ++          !token_id->manufacturerID[0] || !token_id->serialNumber[0]) {
> ++              return CKR_ATTRIBUTE_VALUE_INVALID;
> ++      }
> +
> +-      _PKCS11H_DEBUG (
> +-              PKCS11H_LOG_DEBUG2,
> +-              "PKCS#11: pkcs11h_token_serializeTokenId return rv=3D%lu-=
'%s', *max=3D"P_Z", sz=3D'%s'",
> +-              rv,
> +-              pkcs11h_getMessage (rv),
> +-              *max,
> +-              sz
> +-      );
> ++      /* For a certificate ID we need CKA_ID */
> ++      if (certificate_id && !certificate_id->attrCKA_ID_size) {
> ++              return CKR_ATTRIBUTE_VALUE_INVALID;
> ++      }
> +
> +       return rv;
> + }
> +
> ++static
> + CK_RV
> +-pkcs11h_token_deserializeTokenId (
> +-      OUT pkcs11h_token_id_t *p_token_id,
> ++__pkcs11h_token_legacy_deserializeTokenId (
> ++      OUT pkcs11h_token_id_t token_id,
> +       IN const char * const sz
> + ) {
> + #define __PKCS11H_TARGETS_NUMBER 4
> +@@ -161,24 +353,11 @@ pkcs11h_token_deserializeTokenId (
> +               size_t s;
> +       } targets[__PKCS11H_TARGETS_NUMBER];
> +
> +-      pkcs11h_token_id_t token_id =3D NULL;
> +       char *p1 =3D NULL;
> +       char *_sz =3D NULL;
> +       int e;
> +       CK_RV rv =3D CKR_FUNCTION_FAILED;
> +
> +-      _PKCS11H_ASSERT (p_token_id!=3DNULL);
> +-      _PKCS11H_ASSERT (sz!=3DNULL);
> +-
> +-      _PKCS11H_DEBUG (
> +-              PKCS11H_LOG_DEBUG2,
> +-              "PKCS#11: pkcs11h_token_deserializeTokenId entry p_token_=
id=3D%p, sz=3D'%s'",
> +-              (void *)p_token_id,
> +-              sz
> +-      );
> +-
> +-      *p_token_id =3D NULL;
> +-
> +       if (
> +               (rv =3D _pkcs11h_mem_strdup (
> +                       (void *)&_sz,
> +@@ -190,10 +369,6 @@ pkcs11h_token_deserializeTokenId (
> +
> +       p1 =3D _sz;
> +
> +-      if ((rv =3D _pkcs11h_token_newTokenId (&token_id)) !=3D CKR_OK) {
> +-              goto cleanup;
> +-      }
> +-
> +       targets[0].p =3D token_id->manufacturerID;
> +       targets[0].s =3D sizeof (token_id->manufacturerID);
> +       targets[1].p =3D token_id->model;
> +@@ -252,6 +427,51 @@ pkcs11h_token_deserializeTokenId (
> +               p1 =3D p2+1;
> +       }
> +
> ++      rv =3D CKR_OK;
> ++
> ++cleanup:
> ++
> ++      if (_sz !=3D NULL) {
> ++              _pkcs11h_mem_free ((void *)&_sz);
> ++      }
> ++
> ++      return rv;
> ++#undef __PKCS11H_TARGETS_NUMBER
> ++}
> ++
> ++CK_RV
> ++pkcs11h_token_deserializeTokenId (
> ++      OUT pkcs11h_token_id_t *p_token_id,
> ++      IN const char * const sz
> ++) {
> ++      pkcs11h_token_id_t token_id =3D NULL;
> ++      CK_RV rv =3D CKR_FUNCTION_FAILED;
> ++
> ++      _PKCS11H_ASSERT (p_token_id!=3DNULL);
> ++      _PKCS11H_ASSERT (sz!=3DNULL);
> ++
> ++      _PKCS11H_DEBUG (
> ++              PKCS11H_LOG_DEBUG2,
> ++              "PKCS#11: pkcs11h_token_deserializeTokenId entry p_token_=
id=3D%p, sz=3D'%s'",
> ++              (void *)p_token_id,
> ++              sz
> ++      );
> ++
> ++      *p_token_id =3D NULL;
> ++
> ++      if ((rv =3D _pkcs11h_token_newTokenId (&token_id)) !=3D CKR_OK) {
> ++              goto cleanup;
> ++      }
> ++
> ++      if (!strncmp (sz, URI_SCHEME, strlen (URI_SCHEME))) {
> ++              rv =3D __parse_pkcs11_uri(token_id, NULL, sz);
> ++      } else {
> ++              rv =3D __pkcs11h_token_legacy_deserializeTokenId(token_id=
, sz);
> ++      }
> ++      if (rv !=3D CKR_OK) {
> ++              goto cleanup;
> ++      }
> ++
> +       strncpy (
> +               token_id->display,
> +               token_id->label,
> +@@ -264,11 +484,6 @@ pkcs11h_token_deserializeTokenId (
> +       rv =3D CKR_OK;
> +
> + cleanup:
> +-
> +-      if (_sz !=3D NULL) {
> +-              _pkcs11h_mem_free ((void *)&_sz);
> +-      }
> +-
> +       if (token_id !=3D NULL) {
> +               pkcs11h_token_freeTokenId (token_id);
> +       }
> +@@ -281,7 +496,6 @@ cleanup:
> +       );
> +
> +       return rv;
> +-#undef __PKCS11H_TARGETS_NUMBER
> + }
> +
> + #endif                                /* ENABLE_PKCS11H_TOKEN || ENABLE=
_PKCS11H_CERTIFICATE */
> +@@ -295,9 +509,6 @@ pkcs11h_certificate_serializeCertificateId (
> +       IN const pkcs11h_certificate_id_t certificate_id
> + ) {
> +       CK_RV rv =3D CKR_FUNCTION_FAILED;
> +-      size_t saved_max =3D 0;
> +-      size_t n =3D 0;
> +-      size_t _max =3D 0;
> +
> +       /*_PKCS11H_ASSERT (sz!=3DNULL); Not required */
> +       _PKCS11H_ASSERT (max!=3DNULL);
> +@@ -311,42 +522,7 @@ pkcs11h_certificate_serializeCertificateId (
> +               (void *)certificate_id
> +       );
> +
> +-      if (sz !=3D NULL) {
> +-              saved_max =3D n =3D *max;
> +-      }
> +-      *max =3D 0;
> +-
> +-      if (
> +-              (rv =3D pkcs11h_token_serializeTokenId (
> +-                      sz,
> +-                      &n,
> +-                      certificate_id->token_id
> +-              )) !=3D CKR_OK
> +-      ) {
> +-              goto cleanup;
> +-      }
> +-
> +-      _max =3D n + certificate_id->attrCKA_ID_size*2 + 1;
> +-
> +-      if (sz !=3D NULL) {
> +-              if (saved_max < _max) {
> +-                      rv =3D CKR_ATTRIBUTE_VALUE_INVALID;
> +-                      goto cleanup;
> +-              }
> +-
> +-              sz[n-1] =3D '/';
> +-              rv =3D _pkcs11h_util_binaryToHex (
> +-                      sz+n,
> +-                      saved_max-n,
> +-                      certificate_id->attrCKA_ID,
> +-                      certificate_id->attrCKA_ID_size
> +-              );
> +-      }
> +-
> +-      *max =3D _max;
> +-      rv =3D CKR_OK;
> +-
> +-cleanup:
> ++      rv =3D __generate_pkcs11_uri(sz, max, certificate_id, certificate=
_id->token_id);
> +
> +       _PKCS11H_DEBUG (
> +               PKCS11H_LOG_DEBUG2,
> +@@ -360,27 +536,16 @@ cleanup:
> +       return rv;
> + }
> +
> ++static
> + CK_RV
> +-pkcs11h_certificate_deserializeCertificateId (
> +-      OUT pkcs11h_certificate_id_t * const p_certificate_id,
> ++__pkcs11h_certificate_legacy_deserializeCertificateId (
> ++      OUT pkcs11h_certificate_id_t certificate_id,
> +       IN const char * const sz
> + ) {
> +-      pkcs11h_certificate_id_t certificate_id =3D NULL;
> +       CK_RV rv =3D CKR_FUNCTION_FAILED;
> +       char *p =3D NULL;
> +       char *_sz =3D NULL;
> +-
> +-      _PKCS11H_ASSERT (p_certificate_id!=3DNULL);
> +-      _PKCS11H_ASSERT (sz!=3DNULL);
> +-
> +-      *p_certificate_id =3D NULL;
> +-
> +-      _PKCS11H_DEBUG (
> +-              PKCS11H_LOG_DEBUG2,
> +-              "PKCS#11: pkcs11h_certificate_deserializeCertificateId en=
try p_certificate_id=3D%p, sz=3D'%s'",
> +-              (void *)p_certificate_id,
> +-              sz
> +-      );
> ++      size_t id_hex_len;
> +
> +       if (
> +               (rv =3D _pkcs11h_mem_strdup (
> +@@ -393,10 +558,6 @@ pkcs11h_certificate_deserializeCertificateId (
> +
> +       p =3D _sz;
> +
> +-      if ((rv =3D _pkcs11h_certificate_newCertificateId (&certificate_i=
d)) !=3D CKR_OK) {
> +-              goto cleanup;
> +-      }
> +-
> +       if ((p =3D strrchr (_sz, '/')) =3D=3D NULL) {
> +               rv =3D CKR_ATTRIBUTE_VALUE_INVALID;
> +               goto cleanup;
> +@@ -414,7 +575,12 @@ pkcs11h_certificate_deserializeCertificateId (
> +               goto cleanup;
> +       }
> +
> +-      certificate_id->attrCKA_ID_size =3D strlen (p)/2;
> ++      id_hex_len =3D strlen (p);
> ++      if (id_hex_len & 1) {
> ++              rv =3D CKR_ATTRIBUTE_VALUE_INVALID;
> ++              goto cleanup;
> ++      }
> ++      certificate_id->attrCKA_ID_size =3D id_hex_len/2;
> +
> +       if (
> +               (rv =3D _pkcs11h_mem_malloc (
> +@@ -430,21 +596,64 @@ pkcs11h_certificate_deserializeCertificateId (
> +               goto cleanup;
> +       }
> +
> ++      rv =3D CKR_OK;
> ++
> ++cleanup:
> ++
> ++      if (_sz !=3D NULL) {
> ++              _pkcs11h_mem_free ((void *)&_sz);
> ++      }
> ++
> ++      return rv;
> ++
> ++}
> ++
> ++CK_RV
> ++pkcs11h_certificate_deserializeCertificateId (
> ++      OUT pkcs11h_certificate_id_t * const p_certificate_id,
> ++      IN const char * const sz
> ++) {
> ++      pkcs11h_certificate_id_t certificate_id =3D NULL;
> ++      CK_RV rv =3D CKR_FUNCTION_FAILED;
> ++
> ++      _PKCS11H_ASSERT (p_certificate_id!=3DNULL);
> ++      _PKCS11H_ASSERT (sz!=3DNULL);
> ++
> ++      *p_certificate_id =3D NULL;
> ++
> ++      _PKCS11H_DEBUG (
> ++              PKCS11H_LOG_DEBUG2,
> ++              "PKCS#11: pkcs11h_certificate_deserializeCertificateId en=
try p_certificate_id=3D%p, sz=3D'%s'",
> ++              (void *)p_certificate_id,
> ++              sz
> ++      );
> ++
> ++      if ((rv =3D _pkcs11h_certificate_newCertificateId (&certificate_i=
d)) !=3D CKR_OK) {
> ++              goto cleanup;
> ++      }
> ++      if ((rv =3D _pkcs11h_token_newTokenId (&certificate_id->token_id)=
) !=3D CKR_OK) {
> ++              goto cleanup;
> ++      }
> ++
> ++      if (!strncmp(sz, URI_SCHEME, strlen (URI_SCHEME))) {
> ++              rv =3D __parse_pkcs11_uri (certificate_id->token_id, cert=
ificate_id, sz);
> ++      } else {
> ++              rv =3D __pkcs11h_certificate_legacy_deserializeCertificat=
eId (certificate_id, sz);
> ++      }
> ++      if (rv !=3D CKR_OK) {
> ++              goto cleanup;
> ++      }
> ++
> +       *p_certificate_id =3D certificate_id;
> +       certificate_id =3D NULL;
> +       rv =3D CKR_OK;
> +
> + cleanup:
> +-
> +       if (certificate_id !=3D NULL) {
> +               pkcs11h_certificate_freeCertificateId (certificate_id);
> +               certificate_id =3D NULL;
> +       }
> +
> +-      if (_sz !=3D NULL) {
> +-              _pkcs11h_mem_free ((void *)&_sz);
> +-      }
> +-
> +       _PKCS11H_DEBUG (
> +               PKCS11H_LOG_DEBUG2,
> +               "PKCS#11: pkcs11h_certificate_deserializeCertificateId re=
turn rv=3D%lu-'%s'",
> +diff --git a/lib/pkcs11h-util.c b/lib/pkcs11h-util.c
> +index 0743fd1..f90e443 100644
> +--- a/lib/pkcs11h-util.c
> ++++ b/lib/pkcs11h-util.c
> +@@ -110,12 +110,7 @@ _pkcs11h_util_hexToBinary (
> +               p++;
> +       }
> +
> +-      if (*p !=3D '\x0') {
> +-              return CKR_ATTRIBUTE_VALUE_INVALID;
> +-      }
> +-      else {
> +-              return CKR_OK;
> +-      }
> ++      return CKR_OK;
> + }
> +
> + CK_RV
> diff --git a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/v=
cpkg-ports/pkcs11-helper/portfile.cmake
> new file mode 100644
> index 00000000..54a0009d
> --- /dev/null
> +++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
> @@ -0,0 +1,35 @@
> +set(VERSION 1.27)
> +
> +vcpkg_download_distfile(ARCHIVE
> +    URLS "https://github.com/OpenSC/pkcs11-helper/releases/download/pkcs=
11-helper-${VERSION}/pkcs11-helper-${VERSION}.0.tar.bz2"
> +    FILENAME "pkcs11-helper-${VERSION}.tar.bz2"
> +    SHA512 5799342cb755dae8b7ba0880d652e9d4b4f1e52a74043015e1185e1e05932=
6cb2689bb51957db98060ac2257dee34e2f047dcf3d52ad59fd49b91fedcfc5332b
> +)
> +
> +vcpkg_extract_source_archive_ex(
> +    OUT_SOURCE_PATH SOURCE_PATH
> +    ARCHIVE ${ARCHIVE}
> +    REF ${VERSION}
> +    PATCHES
> +        0001-nmake-openssl-1.1.1-support.patch
> +        pkcs11-helper-001-RFC7512.patch
> +)
> +
> +vcpkg_build_nmake(
> +    SOURCE_PATH ${SOURCE_PATH}
> +    NO_DEBUG
> +    PROJECT_SUBPATH lib
> +    PROJECT_NAME Makefile.w32-vc
> +    OPTIONS
> +        OPENSSL=3D1
> +        OPENSSL_HOME=3D${CURRENT_PACKAGES_DIR}/../openssl_${TARGET_TRIPL=
ET}
> +)
> +
> +file(INSTALL ${SOURCE_PATH}/include/pkcs11-helper-1.0 DESTINATION ${CURR=
ENT_PACKAGES_DIR}/include/)
> +file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}/lib/pkcs11-help=
er.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
> +file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}/lib/pkcs11-help=
er.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
> +
> +file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}/lib/libpkcs11-h=
elper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
> +file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}/lib/libpkcs11-h=
elper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
> +
> +file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/=
share/${PORT} RENAME copyright)
> --
> 2.23.0.windows.1
>


--=20
-Lev


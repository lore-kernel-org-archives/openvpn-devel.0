MIME-Version: 1.0
References: <20220423135704.88164-1-becm@...68...>
In-Reply-To: <20220423135704.88164-1-becm@...68...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 25 Apr 2022 10:36:02 +0300
Message-ID: <CAGyAFMWDjim9y9+kTNKw7F8wAG+d8fPhfRtZ28KYqH1r9Fk0Gw@...278...>
Content-Type: multipart/alternative; boundary="00000000000084422a05dd75a137"
Subject: Re: [Openvpn-devel] [PATCH] vcpkg-ports/pkcs11-helper: bump to
 release 1.29
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Marc Becker <becm@...68...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000084422a05dd75a137
Content-Type: text/plain; charset="UTF-8"

I did the same patch last week but didn't send it yet, so you beat me.

Looks like yours has whitespaces stripped and I cannot apply it. In order
to apply, I had to add trailing whitespaces to lines 69, 71, 91 and 100
(line numbers based on https://patchwork.openvpn.net/patch/2412/mbox/)

Otherwise looks good - pkcs11 port download and patching works, and GitHub
Actions are green.

Acked-by: Lev Stipakov <lstipakov@...277...>



la 23. huhtik. 2022 klo 16.59 Marc Becker (becm@...68...) kirjoitti:

> This release has merged win32 support patch,
> so our own patch could be removed from the port.
>
> Upstream archive format changed back to BZIP2.
>
> Signed-off-by: Marc Becker <becm@...68...>
> ---
>  ...config-w32-vc.h.in-indicate-OpenSSL.patch} |  0
>  ...-pkcs11.h-rename-interface-parameter.patch | 32 -------------------
>  contrib/vcpkg-ports/pkcs11-helper/CONTROL     |  2 +-
>  .../vcpkg-ports/pkcs11-helper/portfile.cmake  | 11 +++----
>  4 files changed, 6 insertions(+), 39 deletions(-)
>  rename
> contrib/vcpkg-ports/pkcs11-helper/{0003-config-w32-vc.h.in-indicate-OpenSSL.patch
> => 0002-config-w32-vc.h.in-indicate-OpenSSL.patch} (100%)
>  delete mode 100644
> contrib/vcpkg-ports/pkcs11-helper/0002-pkcs11.h-rename-interface-parameter.patch
>
> diff --git
> a/contrib/vcpkg-ports/pkcs11-helper/0003-config-w32-vc.h.in-indicate-OpenSSL.patch
> b/contrib/vcpkg-ports/pkcs11-helper/0002-config-w32-vc.h.in-indicate-OpenSSL.patch
> similarity index 100%
> rename from
> contrib/vcpkg-ports/pkcs11-helper/0003-config-w32-vc.h.in-indicate-OpenSSL.patch
> rename to
> contrib/vcpkg-ports/pkcs11-helper/0002-config-w32-vc.h.in-indicate-OpenSSL.patch
> diff --git
> a/contrib/vcpkg-ports/pkcs11-helper/0002-pkcs11.h-rename-interface-parameter.patch
> b/contrib/vcpkg-ports/pkcs11-helper/0002-pkcs11.h-rename-interface-parameter.patch
> deleted file mode 100644
> index 13c60d9d..00000000
> ---
> a/contrib/vcpkg-ports/pkcs11-helper/0002-pkcs11.h-rename-interface-parameter.patch
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -From 0c2f862fe23dc6d2c0ca8432d1f6027c922c5a04 Mon Sep 17 00:00:00 2001
> -From: Lev Stipakov <lev@...515...>
> -Date: Tue, 11 Jan 2022 14:24:45 +0200
> -Subject: [PATCH] pkcs11.h: rename "interface" parameter
> -
> -"interface" is defined in cobaseapi.h as
> -
> -  #define interface __STRUCT__
> -
> -so use different name.
> -
> -Signed-off-by: Lev Stipakov <lev@...515...>
> ----
> - include/pkcs11-helper-1.0/pkcs11.h | 2 +-
> - 1 file changed, 1 insertion(+), 1 deletion(-)
> -
> -diff --git a/include/pkcs11-helper-1.0/pkcs11.h
> b/include/pkcs11-helper-1.0/pkcs11.h
> -index 85aa98e..7a7b958 100644
> ---- a/include/pkcs11-helper-1.0/pkcs11.h
> -+++ b/include/pkcs11-helper-1.0/pkcs11.h
> -@@ -1210,7 +1210,7 @@ _CK_DECLARE_FUNCTION (C_GetInterfaceList,
> - _CK_DECLARE_FUNCTION (C_GetInterface,
> -                     (unsigned char *interface_name,
> -                      struct ck_version *version,
> --                     struct ck_interface **interface,
> -+                     struct ck_interface **iface,
> -                      ck_flags_t flags));
> -
> - _CK_DECLARE_FUNCTION (C_LoginUser,
> ---
> -2.23.0.windows.1
> -
> diff --git a/contrib/vcpkg-ports/pkcs11-helper/CONTROL
> b/contrib/vcpkg-ports/pkcs11-helper/CONTROL
> index ff116364..1ead697e 100644
> --- a/contrib/vcpkg-ports/pkcs11-helper/CONTROL
> +++ b/contrib/vcpkg-ports/pkcs11-helper/CONTROL
> @@ -1,4 +1,4 @@
>  Source: pkcs11-helper
> -Version: 1.28-4
> +Version: 1.29-1
>  Homepage: https://github.com/OpenSC/pkcs11-helper
>  Description: pkcs11-helper is a library that simplifies the interaction
> with PKCS#11 providers for end-user applications.
> diff --git a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
> b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
> index 6008f615..a19ea254 100644
> --- a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
> +++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
> @@ -1,9 +1,9 @@
> -set(VERSION 1.28.0)
> +set(VERSION 1.29.0)
>
>  vcpkg_download_distfile(ARCHIVE
> -    URLS "
> https://github.com/OpenSC/pkcs11-helper/releases/download/pkcs11-helper-${VERSION}/pkcs11-helper-${VERSION}.tar.gz
> "
> -    FILENAME "pkcs11-helper-${VERSION}.tar.gz"
> -    SHA512
> 1c1cc7f83ed360fabdcfa68d0eafa7d25be03e68c6a202e7ad2907feb472663bb34e12b9e162344ec221a4298abc02acdc75f0f45d9a89657aa7ac55e59badd5
> +    URLS "
> https://github.com/OpenSC/pkcs11-helper/releases/download/pkcs11-helper-${VERSION}/pkcs11-helper-${VERSION}.tar.bz2
> "
> +    FILENAME "pkcs11-helper-${VERSION}.tar.bz2"
> +    SHA512
> c530f5a4b5826a02bfe787a1293a7595d5a0d6348daa16675bd10c6d6734b1f24a3cc73b5b89433cf1edf8815f8b7298fdfd1ed686f096bb5edfb425e9430eb2
>  )
>
>  vcpkg_extract_source_archive_ex(
> @@ -12,8 +12,7 @@ vcpkg_extract_source_archive_ex(
>      REF ${VERSION}
>      PATCHES
>          0001-nmake-compatibility-with-vcpkg-nmake.patch
> -        0002-pkcs11.h-rename-interface-parameter.patch
> -        0003-config-w32-vc.h.in-indicate-OpenSSL.patch
> +        0002-config-w32-vc.h.in-indicate-OpenSSL.patch
>          pkcs11-helper-001-RFC7512.patch
>  )
>
> --
> 2.30.2
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


-- 
-Lev

--00000000000084422a05dd75a137
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I did the same patch last week but didn&#39;t send it yet,=
 so you beat me.<div><br></div><div>Looks like yours has whitespaces stripp=
ed and I cannot apply it. In order to apply, I had to add trailing whitespa=
ces to lines 69, 71, 91 and 100 (line numbers based on=C2=A0<a href=3D"http=
s://patchwork.openvpn.net/patch/2412/mbox/">https://patchwork.openvpn.net/p=
atch/2412/mbox/</a>)</div><div><br></div><div>Otherwise looks good - pkcs11=
 port download and patching works, and GitHub Actions are green.</div><div>=
<br></div><div>Acked-by: Lev Stipakov &lt;<a href=3D"mailto:lstipakov@...1664...=
7...">lstipakov@...277...</a>&gt;</div><div><br></div><div><br></div></div>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">la 23.=
 huhtik. 2022 klo 16.59 Marc Becker (<a href=3D"mailto:becm@...68...">becm@=
...68...</a>) kirjoitti:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">This release has merged win32 support patch,<br>
so our own patch could be removed from the port.<br>
<br>
Upstream archive format changed back to BZIP2.<br>
<br>
Signed-off-by: Marc Becker &lt;<a href=3D"mailto:becm@...68..." target=3D"_=
blank">becm@...68...</a>&gt;<br>
---<br>
=C2=A0...config-w32-vc.h.in-indicate-OpenSSL.patch} |=C2=A0 0<br>
=C2=A0...-pkcs11.h-rename-interface-parameter.patch | 32 ------------------=
-<br>
=C2=A0contrib/vcpkg-ports/pkcs11-helper/CONTROL=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
2 +-<br>
=C2=A0.../vcpkg-ports/pkcs11-helper/portfile.cmake=C2=A0 | 11 +++----<br>
=C2=A04 files changed, 6 insertions(+), 39 deletions(-)<br>
=C2=A0rename contrib/vcpkg-ports/pkcs11-helper/{0003-config-w32-vc.h.in-ind=
icate-OpenSSL.patch =3D&gt; 0002-config-w32-vc.h.in-indicate-OpenSSL.patch}=
 (100%)<br>
=C2=A0delete mode 100644 contrib/vcpkg-ports/pkcs11-helper/0002-pkcs11.h-re=
name-interface-parameter.patch<br>
<br>
diff --git a/contrib/vcpkg-ports/pkcs11-helper/0003-config-w32-vc.h.in-indi=
cate-OpenSSL.patch b/contrib/vcpkg-ports/pkcs11-helper/0002-config-w32-vc.h=
.in-indicate-OpenSSL.patch<br>
similarity index 100%<br>
rename from contrib/vcpkg-ports/pkcs11-helper/0003-config-w32-vc.h.in-indic=
ate-OpenSSL.patch<br>
rename to contrib/vcpkg-ports/pkcs11-helper/0002-config-w32-vc.h.in-indicat=
e-OpenSSL.patch<br>
diff --git a/contrib/vcpkg-ports/pkcs11-helper/0002-pkcs11.h-rename-interfa=
ce-parameter.patch b/contrib/vcpkg-ports/pkcs11-helper/0002-pkcs11.h-rename=
-interface-parameter.patch<br>
deleted file mode 100644<br>
index 13c60d9d..00000000<br>
--- a/contrib/vcpkg-ports/pkcs11-helper/0002-pkcs11.h-rename-interface-para=
meter.patch<br>
+++ /dev/null<br>
@@ -1,32 +0,0 @@<br>
-From 0c2f862fe23dc6d2c0ca8432d1f6027c922c5a04 Mon Sep 17 00:00:00 2001<br>
-From: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"_blank">=
lev@...515...</a>&gt;<br>
-Date: Tue, 11 Jan 2022 14:24:45 +0200<br>
-Subject: [PATCH] pkcs11.h: rename &quot;interface&quot; parameter<br>
-<br>
-&quot;interface&quot; is defined in cobaseapi.h as<br>
-<br>
-=C2=A0 #define interface __STRUCT__<br>
-<br>
-so use different name.<br>
-<br>
-Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D=
"_blank">lev@...515...</a>&gt;<br>
----<br>
- include/pkcs11-helper-1.0/pkcs11.h | 2 +-<br>
- 1 file changed, 1 insertion(+), 1 deletion(-)<br>
-<br>
-diff --git a/include/pkcs11-helper-1.0/pkcs11.h b/include/pkcs11-helper-1.=
0/pkcs11.h<br>
-index 85aa98e..7a7b958 100644<br>
---- a/include/pkcs11-helper-1.0/pkcs11.h<br>
-+++ b/include/pkcs11-helper-1.0/pkcs11.h<br>
-@@ -1210,7 +1210,7 @@ _CK_DECLARE_FUNCTION (C_GetInterfaceList,<br>
- _CK_DECLARE_FUNCTION (C_GetInterface,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(unsigned char *interface_name,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 struct ck_version *version,<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0struct ck_interface **interface,<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0struct ck_interface **iface,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ck_flags_t flags));<br>
-<br>
- _CK_DECLARE_FUNCTION (C_LoginUser,<br>
---<br>
-2.23.0.windows.1<br>
-<br>
diff --git a/contrib/vcpkg-ports/pkcs11-helper/CONTROL b/contrib/vcpkg-port=
s/pkcs11-helper/CONTROL<br>
index ff116364..1ead697e 100644<br>
--- a/contrib/vcpkg-ports/pkcs11-helper/CONTROL<br>
+++ b/contrib/vcpkg-ports/pkcs11-helper/CONTROL<br>
@@ -1,4 +1,4 @@<br>
=C2=A0Source: pkcs11-helper<br>
-Version: 1.28-4<br>
+Version: 1.29-1<br>
=C2=A0Homepage: <a href=3D"https://github.com/OpenSC/pkcs11-helper" rel=3D"=
noreferrer" target=3D"_blank">https://github.com/OpenSC/pkcs11-helper</a><b=
r>
=C2=A0Description: pkcs11-helper is a library that simplifies the interacti=
on with PKCS#11 providers for end-user applications.<br>
diff --git a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/vcp=
kg-ports/pkcs11-helper/portfile.cmake<br>
index 6008f615..a19ea254 100644<br>
--- a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake<br>
+++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake<br>
@@ -1,9 +1,9 @@<br>
-set(VERSION 1.28.0)<br>
+set(VERSION 1.29.0)<br>
<br>
=C2=A0vcpkg_download_distfile(ARCHIVE<br>
-=C2=A0 =C2=A0 URLS &quot;<a href=3D"https://github.com/OpenSC/pkcs11-helpe=
r/releases/download/pkcs11-helper-$%7BVERSION%7D/pkcs11-helper-$%7BVERSION%=
7D.tar.gz" rel=3D"noreferrer" target=3D"_blank">https://github.com/OpenSC/p=
kcs11-helper/releases/download/pkcs11-helper-${VERSION}/pkcs11-helper-${VER=
SION}.tar.gz</a>&quot;<br>
-=C2=A0 =C2=A0 FILENAME &quot;pkcs11-helper-${VERSION}.tar.gz&quot;<br>
-=C2=A0 =C2=A0 SHA512 1c1cc7f83ed360fabdcfa68d0eafa7d25be03e68c6a202e7ad290=
7feb472663bb34e12b9e162344ec221a4298abc02acdc75f0f45d9a89657aa7ac55e59badd5=
<br>
+=C2=A0 =C2=A0 URLS &quot;<a href=3D"https://github.com/OpenSC/pkcs11-helpe=
r/releases/download/pkcs11-helper-$%7BVERSION%7D/pkcs11-helper-$%7BVERSION%=
7D.tar.bz2" rel=3D"noreferrer" target=3D"_blank">https://github.com/OpenSC/=
pkcs11-helper/releases/download/pkcs11-helper-${VERSION}/pkcs11-helper-${VE=
RSION}.tar.bz2</a>&quot;<br>
+=C2=A0 =C2=A0 FILENAME &quot;pkcs11-helper-${VERSION}.tar.bz2&quot;<br>
+=C2=A0 =C2=A0 SHA512 c530f5a4b5826a02bfe787a1293a7595d5a0d6348daa16675bd10=
c6d6734b1f24a3cc73b5b89433cf1edf8815f8b7298fdfd1ed686f096bb5edfb425e9430eb2=
<br>
=C2=A0)<br>
<br>
=C2=A0vcpkg_extract_source_archive_ex(<br>
@@ -12,8 +12,7 @@ vcpkg_extract_source_archive_ex(<br>
=C2=A0 =C2=A0 =C2=A0REF ${VERSION}<br>
=C2=A0 =C2=A0 =C2=A0PATCHES<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00001-nmake-compatibility-with-vcpkg-nmake=
.patch<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 0002-pkcs11.h-rename-interface-parameter.patch=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 0003-config-w32-vc.h.in-indicate-OpenSSL.patch=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0002-config-w32-vc.h.in-indicate-OpenSSL.patch=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pkcs11-helper-001-RFC7512.patch<br>
=C2=A0)<br>
<br>
--<br>
2.30.2<br>
<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">-Lev</div>

--00000000000084422a05dd75a137--


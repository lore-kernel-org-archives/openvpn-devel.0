MIME-Version: 1.0
References: <20230208001819.244694-1-arne@...1227...>
 <20230208001819.244694-4-arne@...1227...>
In-Reply-To: <20230208001819.244694-4-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 9 Feb 2023 18:01:20 -0500
Message-ID: <CAKuzo_hWg3omNvb06FV9YPpZG4vUNhxa31nO2JP67Vzc6VQv8w@...278...>
Content-Type: multipart/alternative; boundary="000000000000e16ae005f44c5cbc"
Subject: Re: [Openvpn-devel] [PATCH 3/5] Do not run check_engine test when
 crosscompiling
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--000000000000e16ae005f44c5cbc
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, Feb 7, 2023 at 7:19 PM Arne Schwabe <arne@...1227...> wrote:

> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  tests/unit_tests/engine-key/Makefile.am | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tests/unit_tests/engine-key/Makefile.am
> b/tests/unit_tests/engine-key/Makefile.am
> index 246222514..0c2888576 100644
> --- a/tests/unit_tests/engine-key/Makefile.am
> +++ b/tests/unit_tests/engine-key/Makefile.am
> @@ -12,7 +12,9 @@ TESTS_ENVIRONMENT = srcdir="$(abs_srcdir)"; \
>         top_srcdir="$(top_srcdir)"; \
>         export srcdir builddir top_builddir top_srcdir;
>
> +if !CROSS_COMPILING
>  TESTS = check_engine_keys.sh
> +endif
>  check_engine_keys.sh: $(conffiles)
>
>  CLEANFILES = \
>

FTR, this patch is no longer needed (included in #2 below). So, the order
of interdependent patches are: (All acked).

1. [Openvpn-devel,1/3] Conditionally add subdir-objects option to automake
<https://patchwork.openvpn.net/project/openvpn2/patch/20230204004512.250271-1-selva.nair@...277.../>
2. [Openvpn-devel,v3,2/3] Build unit tests in mingw Windows build
<https://patchwork.openvpn.net/project/openvpn2/patch/20230208005925.393200-1-selva.nair@...277.../>
3. [Openvpn-devel,4/5] Add missing stdint.h includes in unit tests files
<https://patchwork.openvpn.net/project/openvpn2/patch/20230208001819.244694-5-arne@...1227.../>
4. [Openvpn-devel,v2,5/5] Add building unit tests with mingw to github
actions
<https://patchwork.openvpn.net/project/openvpn2/patch/20230209163705.466173-1-arne@...1227.../>

Selva

--000000000000e16ae005f44c5cbc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Tue, Feb 7, 2023 at 7:19 PM Arne Schwabe &lt;<a=
 href=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1227...</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Signed-of=
f-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=3D"_blank"=
>arne@...1227...</a>&gt;<br>
---<br>
=C2=A0tests/unit_tests/engine-key/Makefile.am | 2 ++<br>
=C2=A01 file changed, 2 insertions(+)<br>
<br>
diff --git a/tests/unit_tests/engine-key/Makefile.am b/tests/unit_tests/eng=
ine-key/Makefile.am<br>
index 246222514..0c2888576 100644<br>
--- a/tests/unit_tests/engine-key/Makefile.am<br>
+++ b/tests/unit_tests/engine-key/Makefile.am<br>
@@ -12,7 +12,9 @@ TESTS_ENVIRONMENT =3D srcdir=3D&quot;$(abs_srcdir)&quot;;=
 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 top_srcdir=3D&quot;$(top_srcdir)&quot;; \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 export srcdir builddir top_builddir top_srcdir;=
<br>
<br>
+if !CROSS_COMPILING<br>
=C2=A0TESTS =3D check_engine_keys.sh<br>
+endif<br>
=C2=A0check_engine_keys.sh: $(conffiles)<br>
<br>
=C2=A0CLEANFILES =3D \<br></blockquote><div><br></div><div>FTR, this patch =
is no longer needed (included in #2 below). So, the order of interdependent=
 patches are: (All acked).</div><div><br></div>1. <a href=3D"https://patchw=
ork.openvpn.net/project/openvpn2/patch/20230204004512.250271-1-selva.nair@...220...=
..277.../" target=3D"_blank">[Openvpn-devel,1/3] Conditionally add subdir-o=
bjects option to automake</a><br>2. <a href=3D"https://patchwork.openvpn.ne=
t/project/openvpn2/patch/20230208005925.393200-1-selva.nair@...277.../" tar=
get=3D"_blank">[Openvpn-devel,v3,2/3] Build unit tests in mingw Windows bui=
ld</a><br>3. <a href=3D"https://patchwork.openvpn.net/project/openvpn2/patc=
h/20230208001819.244694-5-arne@...1227.../" target=3D"_blank">[Openvpn-deve=
l,4/5] Add missing stdint.h includes in unit tests files</a><br>4. <a href=
=3D"https://patchwork.openvpn.net/project/openvpn2/patch/20230209163705.466=
173-1-arne@...1227.../" target=3D"_blank">[Openvpn-devel,v2,5/5] Add buildi=
ng unit tests with mingw to github actions</a></div><div class=3D"gmail_quo=
te"><br></div><div class=3D"gmail_quote">Selva</div></div>

--000000000000e16ae005f44c5cbc--


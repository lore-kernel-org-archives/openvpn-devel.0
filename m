MIME-Version: 1.0
References: <20220922125822.313-1-lstipakov@...277...>
In-Reply-To: <20220922125822.313-1-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 22 Sep 2022 10:28:18 -0400
Message-ID: <CAKuzo_gJW_dPeHm7k7HiKSpXzf06bPxLaZ7Wqj2GdKzosnVKOA@...278...>
Content-Type: multipart/alternative; boundary="0000000000002901e805e944e398"
Subject: Re: [Openvpn-devel] [PATCH release/2.5] msvc: add branch name and
 commit hash to version output
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--0000000000002901e805e944e398
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Sep 22, 2022 at 8:59 AM Lev Stipakov <lstipakov@...277...> wrote:

> From: Lev Stipakov <lev@...515...>
>
> Add a simple python script which generates header with
> branch name and commit hash #defines.
>
> While on it, fix filename in msvc-generate.vcxproj
> and add proper copyright header to Makefile.mak.
>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  build/msvc/msvc-generate/Makefile.mak         | 33 +++++++++++++-
>  build/msvc/msvc-generate/git-version.py       | 45 +++++++++++++++++++
>  .../msvc/msvc-generate/msvc-generate.vcxproj  |  2 +-
>  config-msvc.h                                 |  2 +
>  4 files changed, 79 insertions(+), 3 deletions(-)
>  create mode 100644 build/msvc/msvc-generate/git-version.py
>
> diff --git a/build/msvc/msvc-generate/Makefile.mak
> b/build/msvc/msvc-generate/Makefile.mak
> index 1cb43102..ae8b0842 100644
> --- a/build/msvc/msvc-generate/Makefile.mak
> +++ b/build/msvc/msvc-generate/Makefile.mak
> @@ -1,4 +1,27 @@
> -# Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
> +#
> +#  OpenVPN -- An application to securely tunnel IP networks
> +#             over a single UDP port, with support for SSL/TLS-based
> +#             session authentication and key exchange,
> +#             packet encryption, packet authentication, and
> +#             packet compression.
> +#
> +#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
> +#  Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
> +#  Copyright (C) 2022-2022 Lev Stipakov <lev@...2698...>
> +#
> +#  This program is free software; you can redistribute it and/or modify
> +#  it under the terms of the GNU General Public License version 2
> +#  as published by the Free Software Foundation.
> +#
> +#  This program is distributed in the hope that it will be useful,
> +#  but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +#  GNU General Public License for more details.
> +#
> +#  You should have received a copy of the GNU General Public License along
> +#  with this program; if not, write to the Free Software Foundation, Inc.,
> +#  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
>
>  CONFIG=$(SOLUTIONDIR)/version.m4
>
> @@ -14,7 +37,9 @@ OUTPUT_PLUGIN_CONFIG=version.m4
>  INPUT_MAN=$(SOLUTIONDIR)/doc/openvpn.8.rst
>  OUTPUT_MAN=$(SOLUTIONDIR)/doc/openvpn.8.html
>
> -all:   $(OUTPUT_MSVC_VER) $(OUTPUT_PLUGIN) $(OUTPUT_MAN)
> +OUTPUT_MSVC_GIT_CONFIG=$(SOLUTIONDIR)/config-version.h
> +
> +all:   $(OUTPUT_MSVC_VER) $(OUTPUT_PLUGIN) $(OUTPUT_MAN)
> $(OUTPUT_MSVC_GIT_CONFIG)
>
>  $(OUTPUT_MSVC_VER): $(INPUT_MSVC_VER) $(CONFIG)
>         cscript //nologo msvc-generate.js --config="$(CONFIG)"
> --input="$(INPUT_MSVC_VER)" --output="$(OUTPUT_MSVC_VER)"
> @@ -28,8 +53,12 @@ $(OUTPUT_PLUGIN): $(INPUT_PLUGIN)
> $(OUTPUT_PLUGIN_CONFIG)
>  $(OUTPUT_MAN): $(INPUT_MAN)
>      -FOR /F %i IN ('where rst2html.py') DO python %i "$(INPUT_MAN)"
> "$(OUTPUT_MAN)"
>
> +$(OUTPUT_MSVC_GIT_CONFIG):
> +    python git-version.py $(SOLUTIONDIR)
> +
>  clean:
>         -del "$(OUTPUT_MSVC_VER)"
>         -del "$(OUTPUT_PLUGIN)"
>         -del "$(OUTPUT_PLUGIN_CONFIG)"
>         -del "$(OUTPUT_MAN)"
> +       -del "$(OUTPUT_MSVC_GIT_CONFIG)"
> diff --git a/build/msvc/msvc-generate/git-version.py
> b/build/msvc/msvc-generate/git-version.py
> new file mode 100644
> index 00000000..e1bf5bdb
> --- /dev/null
> +++ b/build/msvc/msvc-generate/git-version.py
> @@ -0,0 +1,45 @@
> +#
> +#  OpenVPN -- An application to securely tunnel IP networks
> +#             over a single UDP port, with support for SSL/TLS-based
> +#             session authentication and key exchange,
> +#             packet encryption, packet authentication, and
> +#             packet compression.
> +#
> +#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
>

Is this right in a file that didn't exist in 2002?


> +#  Copyright (C) 2022-2022 Lev Stipakov <lev@...2698...>
> +#
> +#  This program is free software; you can redistribute it and/or modify
> +#  it under the terms of the GNU General Public License version 2
> +#  as published by the Free Software Foundation.
> +#
> +#  This program is distributed in the hope that it will be useful,
> +#  but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +#  GNU General Public License for more details.
> +#
> +#  You should have received a copy of the GNU General Public License along
> +#  with this program; if not, write to the Free Software Foundation, Inc.,
> +#  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +
> +import os
> +import sys
> +
> +def get_branch_commit_id():
> +    commit_id = os.popen("git rev-parse --short=16 HEAD").read()[:-1]
> +    branch = os.popen("git rev-parse --symbolic-full-name
> HEAD").read().split("/")[2][:-1]

+    return branch, commit_id
> +
> +def main():
> +    try:
> +        branch, commit_id = get_branch_commit_id()
> +    except:
> +        branch, commit_id = "<not-a-git-repo>", "<not-a-git-repo>"
> +
>

While "not-a-git-repo" may be a descriptive o/p for a script like this, it
may not make much sense when seen in --version output.
Instead, something like "unknown" may be a better fallback?

As the exception comes from a failed split("/"), it could trigger also when
one is not on a branch (say detached head).

+
> +    name = os.path.join("%s" %  (sys.argv[1] if len(sys.argv) > 1 else
> "."), "config-version.h")
> +    with open(name, "w") as f:
> +        f.write("#define CONFIGURE_GIT_REVISION \"%s/%s\"\n" % (branch,
> commit_id))
> +        f.write("#define CONFIGURE_GIT_FLAGS \"\"\n")
> +
> +if __name__ == "__main__":
> +    main()
> diff --git a/build/msvc/msvc-generate/msvc-generate.vcxproj
> b/build/msvc/msvc-generate/msvc-generate.vcxproj
> index dda8b051..eae94709 100644
> --- a/build/msvc/msvc-generate/msvc-generate.vcxproj
> +++ b/build/msvc/msvc-generate/msvc-generate.vcxproj
> @@ -150,7 +150,7 @@
>    </ItemDefinitionGroup>
>    <ItemGroup>
>      <None Include="Makefile.mak" />
> -    <None Include="msc-generate.js" />
> +    <None Include="msvc-generate.js" />
>    </ItemGroup>
>    <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
>    <ImportGroup Label="ExtensionTargets">
> diff --git a/config-msvc.h b/config-msvc.h
> index e7479c86..47c5ba07 100644
> --- a/config-msvc.h
> +++ b/config-msvc.h
> @@ -177,3 +177,5 @@ typedef uint16_t in_port_t;
>      #define HAVE_INET_NTOP
>      #define HAVE_INET_PTON
>  #endif
> +
> +#define HAVE_CONFIG_VERSION_H 1
> --
> 2.23.0.windows.1
>

Are executables in release builds pulled from corresponding git repo these
days? Otherwise when built from some repo like openvpn-build this would get
wrong branch/commit-ids..

Selva

--0000000000002901e805e944e398
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Thu, Sep 22, 2022 at 8:59 AM Lev Stipakov &lt;<=
a href=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipakov@...277...=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
From: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"_blank">l=
ev@...515...</a>&gt;<br>
<br>
Add a simple python script which generates header with<br>
branch name and commit hash #defines.<br>
<br>
While on it, fix filename in msvc-generate.vcxproj<br>
and add proper copyright header to Makefile.mak.<br>
<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
=C2=A0build/msvc/msvc-generate/Makefile.mak=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 33 +++++++++++++-<br>
=C2=A0build/msvc/msvc-generate/git-version.py=C2=A0 =C2=A0 =C2=A0 =C2=A0| 4=
5 +++++++++++++++++++<br>
=C2=A0.../msvc/msvc-generate/msvc-generate.vcxproj=C2=A0 |=C2=A0 2 +-<br>
=C2=A0config-msvc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +<b=
r>
=C2=A04 files changed, 79 insertions(+), 3 deletions(-)<br>
=C2=A0create mode 100644 build/msvc/msvc-generate/git-version.py<br>
<br>
diff --git a/build/msvc/msvc-generate/Makefile.mak b/build/msvc/msvc-genera=
te/Makefile.mak<br>
index 1cb43102..ae8b0842 100644<br>
--- a/build/msvc/msvc-generate/Makefile.mak<br>
+++ b/build/msvc/msvc-generate/Makefile.mak<br>
@@ -1,4 +1,27 @@<br>
-# Copyright (C) 2008-2012 Alon Bar-Lev &lt;<a href=3D"mailto:alon.barlev@...220...=
..277..." target=3D"_blank">alon.barlev@...277...</a>&gt;<br>
+#<br>
+#=C2=A0 OpenVPN -- An application to securely tunnel IP networks<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0over a single UDP port, w=
ith support for SSL/TLS-based<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0session authentication an=
d key exchange,<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0packet encryption, packet=
 authentication, and<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0packet compression.<br>
+#<br>
+#=C2=A0 Copyright (C) 2002-2022 OpenVPN Inc &lt;<a href=3D"mailto:sales@...1186...=
.515..." target=3D"_blank">sales@...515...</a>&gt;<br>
+#=C2=A0 Copyright (C) 2008-2012 Alon Bar-Lev &lt;<a href=3D"mailto:alon.ba=
rlev@...277..." target=3D"_blank">alon.barlev@...277...</a>&gt;<br>
+#=C2=A0 Copyright (C) 2022-2022 Lev Stipakov &lt;<a href=3D"mailto:lev@...493...=
2698..." target=3D"_blank">lev@...2698...</a>&gt;<br>
+#<br>
+#=C2=A0 This program is free software; you can redistribute it and/or modi=
fy<br>
+#=C2=A0 it under the terms of the GNU General Public License version 2<br>
+#=C2=A0 as published by the Free Software Foundation.<br>
+#<br>
+#=C2=A0 This program is distributed in the hope that it will be useful,<br>
+#=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+#=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
<br>
+#=C2=A0 GNU General Public License for more details.<br>
+#<br>
+#=C2=A0 You should have received a copy of the GNU General Public License =
along<br>
+#=C2=A0 with this program; if not, write to the Free Software Foundation, =
Inc.,<br>
+#=C2=A0 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<br>
+#<br>
<br>
=C2=A0CONFIG=3D$(SOLUTIONDIR)/version.m4<br>
<br>
@@ -14,7 +37,9 @@ OUTPUT_PLUGIN_CONFIG=3Dversion.m4<br>
=C2=A0INPUT_MAN=3D$(SOLUTIONDIR)/doc/openvpn.8.rst<br>
=C2=A0OUTPUT_MAN=3D$(SOLUTIONDIR)/doc/openvpn.8.html<br>
<br>
-all:=C2=A0 =C2=A0$(OUTPUT_MSVC_VER) $(OUTPUT_PLUGIN) $(OUTPUT_MAN)<br>
+OUTPUT_MSVC_GIT_CONFIG=3D$(SOLUTIONDIR)/config-version.h<br>
+<br>
+all:=C2=A0 =C2=A0$(OUTPUT_MSVC_VER) $(OUTPUT_PLUGIN) $(OUTPUT_MAN) $(OUTPU=
T_MSVC_GIT_CONFIG)<br>
<br>
=C2=A0$(OUTPUT_MSVC_VER): $(INPUT_MSVC_VER) $(CONFIG)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cscript //nologo msvc-generate.js --config=3D&q=
uot;$(CONFIG)&quot; --input=3D&quot;$(INPUT_MSVC_VER)&quot; --output=3D&quo=
t;$(OUTPUT_MSVC_VER)&quot;<br>
@@ -28,8 +53,12 @@ $(OUTPUT_PLUGIN): $(INPUT_PLUGIN) $(OUTPUT_PLUGIN_CONFIG=
)<br>
=C2=A0$(OUTPUT_MAN): $(INPUT_MAN)<br>
=C2=A0 =C2=A0 =C2=A0-FOR /F %i IN (&#39;where rst2html.py&#39;) DO python %=
i &quot;$(INPUT_MAN)&quot; &quot;$(OUTPUT_MAN)&quot;<br>
<br>
+$(OUTPUT_MSVC_GIT_CONFIG):<br>
+=C2=A0 =C2=A0 python git-version.py $(SOLUTIONDIR)<br>
+<br>
=C2=A0clean:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 -del &quot;$(OUTPUT_MSVC_VER)&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 -del &quot;$(OUTPUT_PLUGIN)&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 -del &quot;$(OUTPUT_PLUGIN_CONFIG)&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 -del &quot;$(OUTPUT_MAN)&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0-del &quot;$(OUTPUT_MSVC_GIT_CONFIG)&quot;<br>
diff --git a/build/msvc/msvc-generate/git-version.py b/build/msvc/msvc-gene=
rate/git-version.py<br>
new file mode 100644<br>
index 00000000..e1bf5bdb<br>
--- /dev/null<br>
+++ b/build/msvc/msvc-generate/git-version.py<br>
@@ -0,0 +1,45 @@<br>
+#<br>
+#=C2=A0 OpenVPN -- An application to securely tunnel IP networks<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0over a single UDP port, w=
ith support for SSL/TLS-based<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0session authentication an=
d key exchange,<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0packet encryption, packet=
 authentication, and<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0packet compression.<br>
+#<br>
+#=C2=A0 Copyright (C) 2002-2022 OpenVPN Inc &lt;<a href=3D"mailto:sales@...1186...=
.515..." target=3D"_blank">sales@...515...</a>&gt;<br>
</blockquote><div><br></div><div>Is this right in a file that didn&#39;t ex=
ist in 2002?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">+#=C2=A0 Copyright (C) 2022-2022 Lev Stipakov &lt;<a href=3D"mai=
lto:lev@...2698..." target=3D"_blank">lev@...2698...</a>&gt;<br>
+#<br>
+#=C2=A0 This program is free software; you can redistribute it and/or modi=
fy<br>
+#=C2=A0 it under the terms of the GNU General Public License version 2<br>
+#=C2=A0 as published by the Free Software Foundation.<br>
+#<br>
+#=C2=A0 This program is distributed in the hope that it will be useful,<br>
+#=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+#=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
<br>
+#=C2=A0 GNU General Public License for more details.<br>
+#<br>
+#=C2=A0 You should have received a copy of the GNU General Public License =
along<br>
+#=C2=A0 with this program; if not, write to the Free Software Foundation, =
Inc.,<br>
+#=C2=A0 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<br>
+#<br>
+<br>
+import os<br>
+import sys<br>
+<br>
+def get_branch_commit_id():<br>+=C2=A0 =C2=A0 commit_id =3D os.popen(&quot=
;git rev-parse --short=3D16 HEAD&quot;).read()[:-1]<br>+=C2=A0 =C2=A0 branc=
h =3D os.popen(&quot;git rev-parse --symbolic-full-name HEAD&quot;).read().=
split(&quot;/&quot;)[2][:-1]=C2=A0</blockquote><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">+=C2=A0 =C2=A0 return branch, commit_id<br>+<br>+def =
main():<br>+=C2=A0 =C2=A0 try:<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 branch, comm=
it_id =3D get_branch_commit_id()<br>+=C2=A0 =C2=A0 except:<br>+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 branch, commit_id =3D &quot;&lt;not-a-git-repo&gt;&quot;,=
 &quot;&lt;not-a-git-repo&gt;&quot;<br>+<br></blockquote><div><br></div><di=
v>While &quot;not-a-git-repo&quot; may be a descriptive o/p for a script li=
ke this, it may not make much sense when seen in --version output.=C2=A0<br=
></div><div>Instead, something like &quot;unknown&quot; may be a better fal=
lback?</div><div><br></div><div>As the exception comes from a failed split(=
&quot;/&quot;), it could trigger also when one is not on a branch (say deta=
ched head).</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
+<br>
+=C2=A0 =C2=A0 name =3D os.path.join(&quot;%s&quot; %=C2=A0 (sys.argv[1] if=
 len(sys.argv) &gt; 1 else &quot;.&quot;), &quot;config-version.h&quot;)<br>
+=C2=A0 =C2=A0 with open(name, &quot;w&quot;) as f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(&quot;#define CONFIGURE_GIT_REVISION \=
&quot;%s/%s\&quot;\n&quot; % (branch, commit_id))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(&quot;#define CONFIGURE_GIT_FLAGS \&qu=
ot;\&quot;\n&quot;)<br>
+<br>
+if __name__ =3D=3D &quot;__main__&quot;:<br>
+=C2=A0 =C2=A0 main()<br>
diff --git a/build/msvc/msvc-generate/msvc-generate.vcxproj b/build/msvc/ms=
vc-generate/msvc-generate.vcxproj<br>
index dda8b051..eae94709 100644<br>
--- a/build/msvc/msvc-generate/msvc-generate.vcxproj<br>
+++ b/build/msvc/msvc-generate/msvc-generate.vcxproj<br>
@@ -150,7 +150,7 @@<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemGroup&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;None Include=3D&quot;Makefile.mak&quot; /&gt;<br>
-=C2=A0 =C2=A0 &lt;None Include=3D&quot;msc-generate.js&quot; /&gt;<br>
+=C2=A0 =C2=A0 &lt;None Include=3D&quot;msvc-generate.js&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;/ItemGroup&gt;<br>
=C2=A0 =C2=A0&lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.targ=
ets&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;ImportGroup Label=3D&quot;ExtensionTargets&quot;&gt;<br>
diff --git a/config-msvc.h b/config-msvc.h<br>
index e7479c86..47c5ba07 100644<br>
--- a/config-msvc.h<br>
+++ b/config-msvc.h<br>
@@ -177,3 +177,5 @@ typedef uint16_t in_port_t;<br>
=C2=A0 =C2=A0 =C2=A0#define HAVE_INET_NTOP<br>
=C2=A0 =C2=A0 =C2=A0#define HAVE_INET_PTON<br>
=C2=A0#endif<br>
+<br>
+#define HAVE_CONFIG_VERSION_H 1<br>
-- <br>
2.23.0.windows.1<br></blockquote><div><br></div><div>Are executables in rel=
ease builds pulled from corresponding git repo these days? Otherwise when b=
uilt from some repo like openvpn-build this would get wrong branch/commit-i=
ds..</div><div>=C2=A0</div><div>Selva</div></div></div>

--0000000000002901e805e944e398--


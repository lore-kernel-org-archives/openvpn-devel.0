MIME-Version: 1.0
References: <20220922125937.332-1-lstipakov@...277...>
 <20220922143842.379-1-lstipakov@...277...>
In-Reply-To: <20220922143842.379-1-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 22 Sep 2022 13:52:48 -0400
Message-ID: <CAKuzo_gtwm8GT-d=hF+WHB+R6tTgCeb7r93wKQemfqZhKFFtAg@...278...>
Content-Type: multipart/alternative; boundary="000000000000888acc05e947be90"
Subject: Re: [Openvpn-devel] [PATCH] msvc: add branch name and commit hash
 to version output
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

--000000000000888acc05e947be90
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Sep 22, 2022 at 10:39 AM Lev Stipakov <lstipakov@...277...> wrote:

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
>  v2:
>
>   - fix copyright year 2002 -> 2022
>   - change "not-a-git-repo" to "unknown"
>
>
...

--
> 2.23.0.windows.1


I have only tested that the script generates config-version.h matching what
./configure builds.
Based on that, the patch looks good to me.

I'm assuming release openvpn.exe is built from a named branch within
openvpn git-repo. Checking out a tag (detached head) and building will get
unknown/unknown. We could probably improve that by using the commit-id even
when the branch name is not available.

Selva

--000000000000888acc05e947be90
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<br></div><div><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr"><br></div><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Sep 22, 2022 at 10:39 AM Lev Stipakov &lt;<a href=
=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipakov@...277...</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: =
Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"_blank">lev@...493...=
515...</a>&gt;<br>
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
=C2=A0v2:<br>
<br>
=C2=A0 - fix copyright year 2002 -&gt; 2022<br>
=C2=A0 - change &quot;not-a-git-repo&quot; to &quot;unknown&quot;<br><br></=
blockquote><div><br></div><div>...</div><div><br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex"><span style=3D"color:rgb(80,0,80)">--<br></sp=
an><span style=3D"color:rgb(80,0,80)">2.23.0.windows.1</span></blockquote><=
div><span style=3D"color:rgb(80,0,80)"><br></span></div><div>I have only te=
sted that the script generates config-version.h matching what ./configure b=
uilds.</div><div>Based on that, the patch looks good to me.</div><div><br><=
/div><div>I&#39;m assuming release=C2=A0openvpn.exe is built from a named b=
ranch within openvpn git-repo. Checking out a tag (detached head) and build=
ing will get unknown/unknown. We could probably improve that by using the c=
ommit-id even when the branch=C2=A0name is not available.</div><div><br></d=
iv><div>Selva</div></div></div></div>

--000000000000888acc05e947be90--


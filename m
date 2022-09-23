MIME-Version: 1.0
References: <20220923074512.494-1-lstipakov@...277...>
 <20220923085740.525-1-lstipakov@...277...>
In-Reply-To: <20220923085740.525-1-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 23 Sep 2022 11:20:32 -0400
Message-ID: <CAKuzo_hZ=2_M0da=BRdvBHD7nJdEvFwb5j+deL4MHYSC0qOjVQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000d35b7005e959bb99"
Subject: Re: [Openvpn-devel] [PATCH v4 release/2.5] msvc: add branch name
 and commit hash to version output
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

--000000000000d35b7005e959bb99
Content-Type: text/plain; charset="UTF-8"

This may be extreme nitpicking...

+        l = ["detached\n"]
> +    branch = "/" .join(l)[:-1]
>

Use "none" instead of "detached"? The logic being: we are trying to add the
branch name to the version, so "none" if not on a branch, "unknown' if the
branch cannot be determined.

By the way, autotools builds get "[git: HEAD/commit-id]" when not on a
local branch and flags like + and * appended to commit id when there are
uncommitted changes. Not saying we reproduce that on Windows.

Selva

--000000000000d35b7005e959bb99
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>This may be extreme nitpic=
king...=C2=A0</div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 l =3D [&quot;detached\n&quot;]<br>
+=C2=A0 =C2=A0 branch =3D &quot;/&quot; .join(l)[:-1]<br></blockquote><div>=
<br></div><div>Use &quot;none&quot; instead of &quot;detached&quot;? The lo=
gic being: we are trying to add=C2=A0the branch name to the version, so &qu=
ot;none&quot; if not on a branch, &quot;unknown&#39; if the branch cannot b=
e determined.=C2=A0</div><div><br></div><div>By the way, autotools builds g=
et &quot;[git: HEAD/commit-id]&quot; when not on a local branch and=C2=A0fl=
ags=C2=A0like + and * appended to commit id when there are uncommitted chan=
ges. Not saying we reproduce that on Windows.</div><div><br></div><div>Selv=
a</div></div></div>

--000000000000d35b7005e959bb99--


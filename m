MIME-Version: 1.0
References: <20240619134451.222-1-lev@...515...>
In-Reply-To: <20240619134451.222-1-lev@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 19 Jun 2024 09:51:02 -0400
Message-ID: <CAKuzo_iaPkPRdcO1OP_v-uXjp5HFr7=BnaYA9BNQPKEaeGfaLg@...278...>
Content-Type: multipart/alternative; boundary="000000000000242e6c061b3e7e7f"
Subject: Re: [Openvpn-devel] [PATCH] interactive.c: Improve access control
 for gui<->service pipe
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

--000000000000242e6c061b3e7e7f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 9:47=E2=80=AFAM Lev Stipakov <lstipakov@...277...> =
wrote:

> At the moment everyone but anonymous are permitted
> to create a pipe with the same name as interactive service creates,
> which makes it possible for malicious process with SeImpersonatePrivilege
> impersonate as local user.
>
> This hardens the security of the pipe, making it possible only for
> processes running as SYSTEM (such as interactive service) create the
> pipe with the same name.
>
> While on it, replace EXPLICIT_ACCESS structures with SDDL string.
>
> CVE: 2024-4877
>
> Change-Id: I35e783b79a332d247606e05a39e41b4d35d39b5d
> Reported by: Zeze with TeamT5 <zeze7w@...277...>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  v2:
>   - ensure that sd is freed even if pipe creation failed
>   - added Reported-By
>

 Acked-by: Selva Nair <selva.nair@...277...>

--000000000000242e6c061b3e7e7f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 19, 2024 at 9:47=E2=80=AF=
AM Lev Stipakov &lt;<a href=3D"mailto:lstipakov@...277...">lstipakov@...1482...=
...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">At the moment everyone but anonymous are permitted<br>
to create a pipe with the same name as interactive service creates,<br>
which makes it possible for malicious process with SeImpersonatePrivilege<b=
r>
impersonate as local user.<br>
<br>
This hardens the security of the pipe, making it possible only for<br>
processes running as SYSTEM (such as interactive service) create the<br>
pipe with the same name.<br>
<br>
While on it, replace EXPLICIT_ACCESS structures with SDDL string.<br>
<br>
CVE: 2024-4877<br>
<br>
Change-Id: I35e783b79a332d247606e05a39e41b4d35d39b5d<br>
Reported by: Zeze with TeamT5 &lt;<a href=3D"mailto:zeze7w@...277..." targe=
t=3D"_blank">zeze7w@...277...</a>&gt;<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
=C2=A0v2:<br>
=C2=A0 - ensure that sd is freed even if pipe creation failed<br>
=C2=A0 - added Reported-By<br></blockquote><div><br></div><div>=C2=A0Acked-=
by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277...">selva.nair@...1664...=
7...</a>&gt;</div></div></div>

--000000000000242e6c061b3e7e7f--


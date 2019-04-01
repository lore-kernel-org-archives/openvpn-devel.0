MIME-Version: 1.0
References: <20190329193805.GQ31008@...1296...>
 <20190401112140.13212-1-cschenk@...2502...>
 <20190401112140.13212-4-cschenk@...2502...>
In-Reply-To: <20190401112140.13212-4-cschenk@...2502...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 1 Apr 2019 11:59:04 -0400
Message-ID: <CAKuzo_iBrGGWghyvyV5TUtYqd+q7W6aZHproMbBhHzS5i139Kg@...278...>
Content-Type: multipart/alternative; boundary="000000000000843db805857a1af1"
Subject: Re: [Openvpn-devel] [PATCH 4/4] Simplified if statements for better
 readability
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christopher Schenk <cschenk@...2502...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000843db805857a1af1
Content-Type: text/plain; charset="UTF-8"

 Hi,

On Mon, Apr 1, 2019 at 7:22 AM Christopher Schenk <
cschenk@...2502...> wrote:

> ---
>  src/openvpn/tun.c | 58 ++++++++++++-----------------------------------
>  1 file changed, 14 insertions(+), 44 deletions(-)
>

@@ -213,7 +213,7 @@ do_set_mtu_service(const struct tuntap *tt, const short
> family, const int mtu)
>         ack_message_t ack;
>         struct gc_arena gc = gc_new();
>         HANDLE pipe = tt->options.msg_channel;
> -
> +       char *family_name = (family == AF_INET6) ? "IPv6" : "IPv4";


This should be preferably declared as const char *family_name. Also see my
response to commit 2

Some general remarks follow:

Now we have 4 commits, two for the initial netsh implementation,
one replacing that by SetIpInterfaceEntry() and a fixup. We don't want to
keep all that irrelevant history, so these have to be squashed into one
commit
(or two if you wish to separate the interactive service part).
And edit the final commit message header and description to reflect the
final
version. Squashing all into one commit may be easier and that's fine in
this case.

We also prefer to have patches signed off. Adding -s to "git commit" or
doing "git commit -s --amend" will take care of that.

Finally, I'm not sure whether we still require patch authors to follow the
code formatting style or we automatically run uncrustify during merge.
Even if its not mandatory, its a good practice to follow the style in the
rest of
the code to the extent possible: for example, we use 4 spaces for indent
(not 8), no tabs anywhere etc. You can run
"uncrustify -c dev-tools/uncrustify.conf" on tun.c, interactive.c
and openvpn_msg.h to get most of that rectified. Note that uncrustify may
edit unrelated parts of the code -- if it does, do not include
such changes in the patch.

Thanks

Selva

--000000000000843db805857a1af1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">=C2=A0Hi,<br></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 1, 2019 at 7:22 =
AM Christopher Schenk &lt;<a href=3D"mailto:cschenk@...2502..." target=3D"_=
blank">cschenk@...2502...</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">---<br>
=C2=A0src/openvpn/tun.c | 58 ++++++++++++----------------------------------=
-<br>
=C2=A01 file changed, 14 insertions(+), 44 deletions(-)<br></blockquote><di=
v><br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">@@ -213,7 +213,7 @@=
 do_set_mtu_service(const struct tuntap *tt, const short family, const int =
mtu)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ack_message_t ack;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct gc_arena gc =3D gc_new();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 HANDLE pipe =3D tt-&gt;options.msg_channel;<br>
-<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0char *family_name =3D (family =3D=3D AF_INET6) =
? &quot;IPv6&quot; : &quot;IPv4&quot;;</blockquote></div><div><br>This shou=
ld be preferably declared as const char *family_name. Also see my<br>respon=
se to commit 2<br></div><div><br></div><div>Some general remarks follow:<br=
><br></div><div>Now we have 4 commits, two for the initial netsh implementa=
tion,<br>one replacing that by SetIpInterfaceEntry() and a fixup. We don&#3=
9;t want to<br>keep all that irrelevant history, so these have to be squash=
ed into one commit <br>(or two if you wish to separate the interactive serv=
ice part). <br>And edit the final commit message header and description to =
reflect the final<br>version. Squashing all into one commit may be easier a=
nd that&#39;s fine in<br>this case.<br></div><div><br></div><div>We also pr=
efer to have patches signed off. Adding -s to &quot;git commit&quot; or<br>=
doing &quot;git commit -s --amend&quot; will take care of that.<br><br></di=
v><div>Finally, I&#39;m not sure whether we still require patch authors to =
follow the<br>code formatting style or we automatically run uncrustify duri=
ng merge.<br>Even if its not mandatory, its a good practice to follow the s=
tyle in the rest of<br>the code to the extent possible: for example, we use=
 4 spaces for indent<br>(not 8), no tabs anywhere etc. You can run <br>&quo=
t;uncrustify -c dev-tools/uncrustify.conf&quot; on tun.c, interactive.c<br>=
and openvpn_msg.h to get most of that rectified. Note that uncrustify may<b=
r>edit unrelated parts of the code -- if it does, do not include<br>such ch=
anges in the patch.<br></div><div><br></div><div>Thanks<br><br></div><div>S=
elva</div></div></div>

--000000000000843db805857a1af1--


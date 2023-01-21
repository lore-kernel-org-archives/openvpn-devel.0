MIME-Version: 1.0
References: <20230116194809.1980444-1-selva.nair@...277...>
 <Y8wKOa6GK0YSCwko@...1296...>
In-Reply-To: <Y8wKOa6GK0YSCwko@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 21 Jan 2023 14:00:57 -0500
Message-ID: <CAKuzo_jxYo8XeBbyxpaBYi=c+ADZ9848A--cf0EWa0pbd1pZsw@...278...>
Content-Type: multipart/alternative; boundary="00000000000035376f05f2cacace"
Subject: Re: [Openvpn-devel] [PATCH] Fix more "existing route may get
 deleted" cases
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--00000000000035376f05f2cacace
Content-Type: text/plain; charset="UTF-8"

Hi

On Sat, Jan 21, 2023 at 10:52 AM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Mon, Jan 16, 2023 at 02:48:09PM -0500, selva.nair@...277... wrote:
> > From: Selva Nair <selva.nair@...277...>
> >
> > - Set RL_DID_LOCAL only if the corresponding route addition
> >   succeeds. This is needed to preserve when the direct route to
> >   the vpn server preexists.
>
> While I think this is a good thing, the existing implementation does
> not look good - changing add_route() to return RTA_* sounds logical,
> and makes "return something meaningful from add_route3()" very easy,
> but the "check windows route installation success?" code paths relies
> on code like this...
>
>             ret = add_route(r, tt, flags, &rl->rgi, es, ctx) && ret;
>
> this still *works* with an "int" return, because RTA_ERROR is 0, and
> the "not flagged as error" codes are 1 and 2 - but I'm not sure if that
> was intentional or luck, and it makes reading the code harder.
>

Yes, pure luck --- I overlooked it..


>
> So maybe postpone *this* part of the patch to 2.7 to give us a bit
> more time to think about how the return code/logic should look like?
>

agreed.


>
>
> > - Ensure net_route_v4/v6_add/del() functions using iproute2 return
> >   error when route addition fails. Return value follows the same logic
> >   as corresponding functions using netlink though all failure reasons
> >   get the same error code of -1.
>
> This one is very straightforward, easily testable in itself, and could
> go in right away.
>

Will do a v2 with only this part.

Selva

--00000000000035376f05f2cacace
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Sat, Jan 21, 2023 at 10:52 AM Gert Doering &lt;<=
a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Mon, Jan 16, 2023 at 02:48:09PM -0500, <a href=3D"mailto:selva.nair@...1665...=
77..." target=3D"_blank">selva.nair@...277...</a> wrote:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt; <br>
&gt; - Set RL_DID_LOCAL only if the corresponding route addition<br>
&gt;=C2=A0 =C2=A0succeeds. This is needed to preserve when the direct route=
 to<br>
&gt;=C2=A0 =C2=A0the vpn server preexists.<br>
<br>
While I think this is a good thing, the existing implementation does<br>
not look good - changing add_route() to return RTA_* sounds logical,<br>
and makes &quot;return something meaningful from add_route3()&quot; very ea=
sy,<br>
but the &quot;check windows route installation success?&quot; code paths re=
lies<br>
on code like this...<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D add_route(r, tt, flags, &=
amp;rl-&gt;rgi, es, ctx) &amp;&amp; ret;<br>
<br>
this still *works* with an &quot;int&quot; return, because RTA_ERROR is 0, =
and<br>
the &quot;not flagged as error&quot; codes are 1 and 2 - but I&#39;m not su=
re if that<br>
was intentional or luck, and it makes reading the code harder.<br></blockqu=
ote><div><br></div><div>Yes, pure luck --- I overlooked it..</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
So maybe postpone *this* part of the patch to 2.7 to give us a bit<br>
more time to think about how the return code/logic should look like?<br></b=
lockquote><div><br></div><div>agreed.</div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
<br>
<br>
&gt; - Ensure net_route_v4/v6_add/del() functions using iproute2 return<br>
&gt;=C2=A0 =C2=A0error when route addition fails. Return value follows the =
same logic<br>
&gt;=C2=A0 =C2=A0as corresponding functions using netlink though all failur=
e reasons<br>
&gt;=C2=A0 =C2=A0get the same error code of -1.<br>
<br>
This one is very straightforward, easily testable in itself, and could<br>
go in right away.<br></blockquote><div><br></div><div>Will do a v2 with onl=
y this part.</div><div><br></div><div>Selva</div></div></div>

--00000000000035376f05f2cacace--


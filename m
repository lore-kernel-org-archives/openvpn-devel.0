MIME-Version: 1.0
References: <20230105022718.1641751-1-selva.nair@...277...>
 <20230105022718.1641751-2-selva.nair@...277...>
 <CAGyAFMWxzUXCZNuwOr1=ngPH5Eyb0YAWNYT46Gx-FnBc7E3hVw@...278...>
In-Reply-To: <CAGyAFMWxzUXCZNuwOr1=ngPH5Eyb0YAWNYT46Gx-FnBc7E3hVw@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 6 Jan 2023 09:44:45 -0500
Message-ID: <CAKuzo_jw4037MKMWAdYhM-FZojVZuCdc4LDUS4WMOqJKBKOsJg@...278...>
Content-Type: multipart/alternative; boundary="0000000000005bd02b05f19976fd"
Subject: Re: [Openvpn-devel] [PATCH 2/3] Distinguish route addition errors
 from route already exists
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--0000000000005bd02b05f19976fd
Content-Type: text/plain; charset="UTF-8"

On Fri, Jan 6, 2023 at 9:16 AM Lev Stipakov <lstipakov@...277...> wrote:

> Hi,
>
> >          else if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_IPAPI)
> >          {
> >              status = add_route_ipapi(r, tt, ai);
> > -            msg(D_ROUTE, "Route addition via IPAPI %s", status ?
> "succeeded" : "failed");
> > +            msg(D_ROUTE, "Route addition via IPAPI %s", (status == 1) ?
> "succeeded/skipped" : "failed");
> >          }
>
> Under what conditions we might get "skipped"?
>

My mistake -- I had initially left it at "status ?" which would now include
already exists, but then the logs looked odd as it first prints "failed"
with M_WARN in add_route_ipapi, and then "succeeded/skipped" here. On
changing to "status==1",  I missed to remove "skipped".

I'm assuming we want to continue printing a warning when route addition
fails due to "already exists" though we wont pass that as an error to
initialization_completed (next commit).

Time for v2.

Selva

--0000000000005bd02b05f19976fd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 6, 2023 at 9:16 AM Lev St=
ipakov &lt;<a href=3D"mailto:lstipakov@...277...">lstipakov@...277...</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if ((flags &amp; ROUTE_METHOD_M=
ASK) =3D=3D ROUTE_METHOD_IPAPI)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D add_route_i=
papi(r, tt, ai);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_ROUTE, &quot;Route ad=
dition via IPAPI %s&quot;, status ? &quot;succeeded&quot; : &quot;failed&qu=
ot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_ROUTE, &quot;Route ad=
dition via IPAPI %s&quot;, (status =3D=3D 1) ? &quot;succeeded/skipped&quot=
; : &quot;failed&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
Under what conditions we might get &quot;skipped&quot;?<br></blockquote><di=
v><br></div><div>My mistake -- I had initially left it at &quot;status ?&qu=
ot; which would now include already exists, but then the logs looked odd as=
 it first prints=C2=A0&quot;failed&quot; with M_WARN in add_route_ipapi, an=
d then &quot;succeeded/skipped&quot; here. On changing to &quot;status=3D=
=3D1&quot;,=C2=A0 I missed to remove &quot;skipped&quot;.</div><div>=C2=A0<=
br></div><div>I&#39;m assuming we want to continue printing a warning when =
route addition fails due to &quot;already exists&quot; though we wont=C2=A0=
pass that as an error to initialization_completed (next commit).=C2=A0</div=
><div><br></div><div>Time for v2.</div><div><br></div><div>Selva</div></div=
></div>

--0000000000005bd02b05f19976fd--


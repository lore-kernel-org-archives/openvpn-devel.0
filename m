MIME-Version: 1.0
References: <OpenVPN/openvpn-gui/issues/9@...1714...>
 <OpenVPN/openvpn-gui/issues/9/403117394@...1714...>
 <CAKuzo_jDCHm=VLc2wuKYJaf48Duy_4dHnbvHx4StVV6PjDausw@...278...>
 <CAEsd45Q87G=UTjt-PE29a41MFQU90_NJxmmux9=ZS=S7j=9E9A@...278...>
 <CAKuzo_iNcK+B2Tg0a7LS+251JSnfHXd++Gy243+gtWOZx7VC=g@...278...>
 <Y7BmEYJj+935Ow5v@...1296...> <Y7Nf/w7bRBGPd9jV@...1296...>
In-Reply-To: <Y7Nf/w7bRBGPd9jV@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 2 Jan 2023 19:33:58 -0500
Message-ID: <CAKuzo_gEoE+kwF-PM9SjjRNEVt456g73OWj+TA6f4Gjkd40mSg@...278...>
Content-Type: multipart/alternative; boundary="000000000000335c4f05f1513a6f"
Subject: Re: [Openvpn-devel] [OpenVPN/openvpn-gui] UI showing green
 connected status despite not beeing able to create a route (#9)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, "Jonathan K. Bullard" <jkbullard@...277...>

--000000000000335c4f05f1513a6f
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, Jan 2, 2023 at 5:51 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Sat, Dec 31, 2022 at 05:40:49PM +0100, Gert Doering wrote:
> > On Sat, Dec 17, 2022 at 07:09:34PM -0500, Selva Nair wrote:
> > > tldr: Can we get CONNECTED,ERROR instead of CONNECTED,SUCCESS on route
> > > errors?
> >
> > I think this makes sense.  Not sure how complicated it is, and if we
> > can make this before 2.6.0 ("some time in January").
>
> So if I am reading this right, "CONNECTED,<something>" is produced
> by management_set_state() -> log_entry_print(), with the "something"
> being transported via "detail" -> "e->string".
>
> "CONNECTED" is only produced by
> init.c::initialization_sequence_completed(),
> and there already is a case for "CONNECTED,ERROR" though I don't understand
> it...
>
>         if (flags & ISC_ERRORS)
>         {
>             detail = "ERROR";
>         }
>
> (which will also log "Initialization Sequence Completed *With Errors*",
> but the rest of that branch might be a bit misleading, as it will
> tell systemd "STATUS=Failed")
>
>
> initialization_sequence_completed() is called from init.c::do_up()
> (for client/p2p), forward.c, and mtcp.c/mudp.c (Server).
>
> The "--route-delay" case goes via forward.c::check_add_routes_action(),
> which *can* signal ERROR.  init.c::do_up() does not.
>
> Routes are (if no --route-delay) set up by do_init_tun(), which calls
> do_route().  So adding an "&flags" parameter to that call chain which sets
> ISC_ERROR if a route addition fails might be a viable approach.
>

I was also thinking along these lines. I think we can make add_route()
return a status instead of void, and propagate it back to where it's needed
in check_add_route_action(). Many of those functions that return void can
return an int instead. All real worker functions that set a route :
do_route_service, do_route_ipv6_servuce, do_route_ipapi,
openvpn_execve_check, net_route_v4_add, net_route_v6_add etc.
all return true or false or a status, so it's only their callers that need
to pass it on.

This is assuming "false" or error really means a serious error, not
something
trivial like a route already exists. And, there's the rub... I can't see
how to get
around this on all platforms. On Windows when using service or IPAPI we
can check the error code for ERROR_OBJECT_ALREADY_EXISTS, on Linux
using SITNL already ignores EEXIST, so those two cases are  good to go.
But what to do with openvpn_execve?

I'm tempted to take a short-cut and  implement this only for Windows and
Linux
when using SITNL, and leave others to continue reporting CONNECTED,SUCCESS
on route errors.

That would be easy to do as the only change required is: update netsh calls
used
for ipv6 routes on Windows to use IPAPI (that's an easy change worth doing
anyway).

As for those using route-method = exe on Windows, we may occasionally report
CONNECTED,ERROR even for trivial "route already exists" cases. I think that
is
tolerable as no one should be using route-method=exe. The whole route-method
option should have been deprecated long ago. Same with ip-win32 (just retain
the manual option to please the demons).


> ... and then I found ROUTE_BEFORE_TUN, ROUTE_AFTER_TUN... which adds
> yet another call chain, which is totally irrelevant but would need that
> extra argument as well...


> And, --route-delay, I need to understand better what the code is doing
> there...
>

I haven't looked into this either.

Selva

--000000000000335c4f05f1513a6f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Mon, Jan 2, 2023 at 5:51 PM Gert Doering &lt;<a=
 href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Sat, Dec 31, 2022 at 05:40:49PM +0100, Gert Doering wrote:<br>
&gt; On Sat, Dec 17, 2022 at 07:09:34PM -0500, Selva Nair wrote:<br>
&gt; &gt; tldr: Can we get CONNECTED,ERROR instead of CONNECTED,SUCCESS on =
route<br>
&gt; &gt; errors?<br>
&gt; <br>
&gt; I think this makes sense.=C2=A0 Not sure how complicated it is, and if=
 we<br>
&gt; can make this before 2.6.0 (&quot;some time in January&quot;).<br>
<br>
So if I am reading this right, &quot;CONNECTED,&lt;something&gt;&quot; is p=
roduced<br>
by management_set_state() -&gt; log_entry_print(), with the &quot;something=
&quot;<br>
being transported via &quot;detail&quot; -&gt; &quot;e-&gt;string&quot;.<br>
<br>
&quot;CONNECTED&quot; is only produced by init.c::initialization_sequence_c=
ompleted(),<br>
and there already is a case for &quot;CONNECTED,ERROR&quot; though I don&#3=
9;t understand<br>
it...<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (flags &amp; ISC_ERRORS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 detail =3D &quot;ERROR&quot;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
(which will also log &quot;Initialization Sequence Completed *With Errors*&=
quot;,<br>
but the rest of that branch might be a bit misleading, as it will<br>
tell systemd &quot;STATUS=3DFailed&quot;)<br>
<br>
<br>
initialization_sequence_completed() is called from init.c::do_up()<br>
(for client/p2p), forward.c, and mtcp.c/mudp.c (Server).<br>
<br>
The &quot;--route-delay&quot; case goes via forward.c::check_add_routes_act=
ion(),<br>
which *can* signal ERROR.=C2=A0 init.c::do_up() does not.<br>
<br>
Routes are (if no --route-delay) set up by do_init_tun(), which calls<br>
do_route().=C2=A0 So adding an &quot;&amp;flags&quot; parameter to that cal=
l chain which sets<br>
ISC_ERROR if a route addition fails might be a viable approach.<br></blockq=
uote><div><br></div><div>I was also thinking along these lines. I think we =
can make add_route()</div><div>return a status instead of void, and propaga=
te it back to where it&#39;s=C2=A0needed</div><div>in check_add_route_actio=
n(). Many of those functions that return void can</div><div>return an int i=
nstead. All real worker functions that set a route :=C2=A0</div><div>do_rou=
te_service, do_route_ipv6_servuce, do_route_ipapi,=C2=A0</div><div>openvpn_=
execve_check, net_route_v4_add, net_route_v6_add etc.</div><div>all return =
true=C2=A0or false or a status, so it&#39;s only their callers that need to=
 pass it on.</div><div><br></div><div>This is assuming &quot;false&quot; or=
 error really means a serious error, not something</div><div>trivial like a=
 route already exists. And, there&#39;s the rub... I can&#39;t=C2=A0see how=
 to get</div><div>around this on all platforms. On Windows when using servi=
ce or IPAPI we</div><div>can check the error code for ERROR_OBJECT_ALREADY_=
EXISTS, on Linux</div><div>using SITNL already ignores EEXIST, so those=C2=
=A0two cases are=C2=A0 good to go.</div><div>But what to do with openvpn_ex=
ecve?=C2=A0</div><div><br></div><div>I&#39;m tempted to take a short-cut an=
d=C2=A0 implement this only for Windows and Linux</div><div>when using SITN=
L, and leave others to continue reporting CONNECTED,SUCCESS</div><div>on ro=
ute errors.=C2=A0<br></div><div><br></div><div>That would be easy to do as =
the only change required is: update netsh calls used</div><div>for ipv6 rou=
tes on Windows to use IPAPI (that&#39;s an easy change worth doing anyway).=
</div><div><br></div><div>As for those using route-method =3D exe on Window=
s, we may occasionally report</div><div>CONNECTED,ERROR even for trivial &q=
uot;route already exists&quot; cases. I think that is</div><div>tolerable a=
s=C2=A0no one should be using=C2=A0route-method=3Dexe. The whole route-meth=
od</div><div>option should have been deprecated long ago. Same with ip-win3=
2 (just retain</div><div>the manual option to please the demons).</div><div=
><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
... and then I found ROUTE_BEFORE_TUN, ROUTE_AFTER_TUN... which adds<br>
yet another call chain, which is totally irrelevant but would need that<br>
extra argument as well...</blockquote><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
<br>
And, --route-delay, I need to understand better what the code is doing<br>
there...<br></blockquote><div><br></div><div>I haven&#39;t looked into this=
 either.</div><div><br></div><div>Selva</div></div></div>

--000000000000335c4f05f1513a6f--


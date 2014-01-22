From: Thomas Veerman <thomas.veerman@...1862...>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_2CABCE6B-CB85-4172-90CA-3EFDF8D1807A"
Message-Id: <3F074630-6731-43EB-BD03-E6A331FC3109@...1862...>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Date: Wed, 22 Jan 2014 10:28:30 +0100
References: <etPan.52df80ec.2901d82.13bb7@...1863...>
In-Reply-To: <etPan.52df80ec.2901d82.13bb7@...1863...>
Subject: Re: [Openvpn-devel] [PATCH] Update expiry date in management event
	loop
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Apple-Mail=_2CABCE6B-CB85-4172-90CA-3EFDF8D1807A
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The condition under which I encountered this was trying to set up a connect=
ion using "tcp-client" and then querying the management console every 500 m=
illiseconds for the connection state. This would never proceed beyond TCP_C=
ONNECT. If you query less than once per second it works fine.

When connecting with TCP, the code does a non-blocking connect. When you co=
nnect using UDP, you take a different path which does in fact update the ex=
piry timer correctly.

--
Thomas

On Jan 22, 2014, at 9:27 AM, Thomas Veerman <thomas.veerman@...1862...> wro=
te:

> When there are events from the management console with an interval shorter
> than 1 second, the event loop never stops as it keeps resetting event_wai=
t.
> ---
>  src/openvpn/manage.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
> index 22dbe13..42a87c2 100644
> --- a/src/openvpn/manage.c
> +++ b/src/openvpn/manage.c
> @@ -2922,7 +2922,8 @@ management_event_loop_n_seconds (struct management =
*man, int sec)
>  	    man_check_for_signals (&signal_received);
>  	  if (signal_received)
>  	    return;
> -	} while (expire);
> +          update_time();
> +	} while (expire && expire > now);
>=20=20
>        /* revert state */
>        man->persist.standalone_disabled =3D standalone_disabled_save;
> --=20
> 1.7.12.4 (Apple Git-37)
>=20
> -------------------------------------------------------------------------=
-----
> CenturyLink Cloud: The Leader in Enterprise Cloud Services.
> Learn Why More Businesses Are Choosing CenturyLink Cloud For
> Critical Workloads, Development Environments & Everything In Between.
> Get a Quote or Start a Free Trial Today.=20
> http://pubads.g.doubleclick.net/gampad/clk?id=3D119420431&iu=3D/4140/ostg=
.clktrk_______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--Apple-Mail=_2CABCE6B-CB85-4172-90CA-3EFDF8D1807A
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html charset=
=3Dus-ascii"><base href=3D"x-msg://24/"></head><body style=3D"word-wrap: br=
eak-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space; =
">The condition under which I encountered this was trying to set up a conne=
ction using "tcp-client" and then querying the management console every 500=
 milliseconds for the connection state. This would never proceed beyond TCP=
_CONNECT. If you query less than once per second it works fine.<div><br></d=
iv><div>When connecting with TCP, the code does a non-blocking connect. Whe=
n you connect using UDP, you take a different path which does in fact updat=
e the expiry timer correctly.</div><div><br></div><div>--</div><div>Thomas<=
/div><div><br></div><div><div>On Jan 22, 2014, at 9:27 AM, Thomas Veerman &=
lt;<a href=3D"mailto:thomas.veerman@...1862...">thomas.veerman@...1862...</=
a>&gt; wrote:</div><br class=3D"Apple-interchange-newline"><blockquote type=
=3D"cite"><div style=3D"font-family: Helvetica, Arial; font-size: 13px; fon=
t-style: normal; font-variant: normal; font-weight: normal; letter-spacing:=
 normal; line-height: normal; orphans: 2; text-align: -webkit-auto; text-in=
dent: 0px; text-transform: none; white-space: normal; widows: 2; word-spaci=
ng: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; wo=
rd-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-wh=
ite-space; "><div id=3D"bloop_customfont" style=3D"font-family: Helvetica, =
Arial; font-size: 13px; margin: 0px; "><div id=3D"bloop_customfont" style=
=3D"margin: 0px; ">When there are events from the management console with a=
n interval shorter</div><div id=3D"bloop_customfont" style=3D"margin: 0px; =
">than 1 second, the event loop never stops as it keeps resetting event_wai=
t.</div><div id=3D"bloop_customfont" style=3D"margin: 0px; ">---</div><div =
id=3D"bloop_customfont" style=3D"margin: 0px; ">&nbsp;src/openvpn/manage.c =
| 3 ++-</div><div id=3D"bloop_customfont" style=3D"margin: 0px; ">&nbsp;1 f=
ile changed, 2 insertions(+), 1 deletion(-)</div><div id=3D"bloop_customfon=
t" style=3D"margin: 0px; "><br></div><div id=3D"bloop_customfont" style=3D"=
margin: 0px; ">diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c</di=
v><div id=3D"bloop_customfont" style=3D"margin: 0px; ">index 22dbe13..42a87=
c2 100644</div><div id=3D"bloop_customfont" style=3D"margin: 0px; ">--- a/s=
rc/openvpn/manage.c</div><div id=3D"bloop_customfont" style=3D"margin: 0px;=
 ">+++ b/src/openvpn/manage.c</div><div id=3D"bloop_customfont" style=3D"ma=
rgin: 0px; ">@@ -2922,7 +2922,8 @@ management_event_loop_n_seconds (struct =
management *man, int sec)</div><div id=3D"bloop_customfont" style=3D"margin=
: 0px; ">&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space: pre; ">=
	</span><span class=3D"Apple-converted-space">&nbsp;</span>&nbsp; &nbsp;man=
_check_for_signals (&amp;signal_received);</div><div id=3D"bloop_customfont=
" style=3D"margin: 0px; ">&nbsp;<span class=3D"Apple-tab-span" style=3D"whi=
te-space: pre; ">	</span><span class=3D"Apple-converted-space">&nbsp;</span=
>&nbsp;if (signal_received)</div><div id=3D"bloop_customfont" style=3D"marg=
in: 0px; ">&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space: pre; =
">	</span><span class=3D"Apple-converted-space">&nbsp;</span>&nbsp; &nbsp;r=
eturn;</div><div id=3D"bloop_customfont" style=3D"margin: 0px; ">-<span cla=
ss=3D"Apple-tab-span" style=3D"white-space: pre; ">	</span>} while (expire)=
;</div><div id=3D"bloop_customfont" style=3D"margin: 0px; ">+ &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp;update_time();</div><div id=3D"bloop_customfont" style=
=3D"margin: 0px; ">+<span class=3D"Apple-tab-span" style=3D"white-space: pr=
e; ">	</span>} while (expire &amp;&amp; expire &gt; now);</div><div id=3D"b=
loop_customfont" style=3D"margin: 0px; ">&nbsp;</div><div id=3D"bloop_custo=
mfont" style=3D"margin: 0px; ">&nbsp; &nbsp; &nbsp; &nbsp;/* revert state *=
/</div><div id=3D"bloop_customfont" style=3D"margin: 0px; ">&nbsp; &nbsp; &=
nbsp; &nbsp;man-&gt;persist.standalone_disabled =3D standalone_disabled_sav=
e;</div><div id=3D"bloop_customfont" style=3D"margin: 0px; ">--&nbsp;</div>=
<div id=3D"bloop_customfont" style=3D"margin: 0px; ">1.7.12.4 (Apple Git-37=
)</div><div id=3D"bloop_customfont" style=3D"margin: 0px; "><br></div></div=
>--------------------------------------------------------------------------=
----<br>CenturyLink Cloud: The Leader in Enterprise Cloud Services.<br>Lear=
n Why More Businesses Are Choosing CenturyLink Cloud For<br>Critical Worklo=
ads, Development Environments &amp; Everything In Between.<br>Get a Quote o=
r Start a Free Trial Today.<span class=3D"Apple-converted-space">&nbsp;</sp=
an><br><a href=3D"http://pubads.g.doubleclick.net/gampad/clk?id=3D119420431=
&amp;iu=3D/4140/ostg.clktrk_______________________________________________"=
>http://pubads.g.doubleclick.net/gampad/clk?id=3D119420431&amp;iu=3D/4140/o=
stg.clktrk_______________________________________________</a><br>Openvpn-de=
vel mailing list<br><a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">=
Openvpn-devel@lists.sourceforge.net</a><br><a href=3D"https://lists.sourcef=
orge.net/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/=
listinfo/openvpn-devel</a></div></blockquote></div><br></body></html>=

--Apple-Mail=_2CABCE6B-CB85-4172-90CA-3EFDF8D1807A--


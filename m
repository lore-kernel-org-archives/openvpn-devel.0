MIME-Version: 1.0
In-Reply-To: <5654A314.3080607@...2070...>
References: <564BA6DB.4070703@...2070...>
	<564DE8B3.9030803@...2070...>
	<20151124083944.GY24952@...1296...>
	<5654A314.3080607@...2070...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 24 Nov 2015 19:43:31 -0500
Message-ID: <CAKuzo_gUf99ADy=X3G5gEHoMxtGbNK54t5zgXDz3Uhh8kko2tA@...278...>
Content-Type: multipart/alternative; boundary=001a1130cd4689bb12052552c0f6
Subject: Re: [Openvpn-devel] [PATCH v4-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <iam@...2070...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a1130cd4689bb12052552c0f6
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue, Nov 24, 2015 at 12:49 PM, ValdikSS <iam@...2070...> wrote:

> I can't figure out why Thunderbird corrupts my patches.
>

Its not a thunderbird-specific malady, almost every mail client messes up
with line breaks, adds extra spaces etc. As Gert suggested please use git
send-email. That makes it easy for everyone..


> Please use the attached version.
> I still need help with 2.3 build system. If somebody willing to help me,
> please use the attached version.
>

The patch for 2.3 doesn't apply. Hope its not just me.. In fact both
patches apply to the master (after some coaxing and with different offsets,
of course). That shows something is wrong, as some contexts have to be
different in 2.3 and master. For example:

Checking patch src/openvpn/init.c...
error: while searching for:
  "up",
  c->c2.es);

      /* possibly add routes */
      if ((route_order() == ROUTE_AFTER_TUN) &&
(!c->options.route_delay_defined))
do_route (&c->options, c->c1.route_list, c->c1.route_ipv6_list,

error: patch failed: src/openvpn/init.c:1468

The problem is route_order() == ROUTE_AFTER_TUN is not in 2.3, its in
master.

Similarly in options.c

error: while searching for:
      VERIFY_PERMISSION (OPT_P_ROUTE_EXTRAS);
    }
#endif
#if PASSTOS_CAPABILITY
  else if (streq (p[0], "passtos") && !p[1])     <--- this line doesn't
match the one in 2.3
    {

Could you please check whether the patch is really against 2.3?

Also please see why the code has to be different for 2.3 and master -- why
not just use ifdef _WINNT_WIN32 ?

Selva

P.S.
There are tons of whitespace errors as well, but that could be worked
around..

--001a1130cd4689bb12052552c0f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Tue, Nov 24, 2015 at 12:49 PM, Valdi=
kSS <span dir=3D"ltr">&lt;<a href=3D"mailto:iam@...2070..." target=3D"_blan=
k">iam@...2070...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color=
:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div style=3D"o=
verflow:hidden">I can&#39;t figure out why Thunderbird corrupts my patches.=
<br></div></blockquote><div><br></div><div>Its not a thunderbird-specific m=
alady, almost every mail client messes up with line breaks, adds extra spac=
es etc. As Gert suggested please use git send-email. That makes it easy for=
 everyone..</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(20=
4,204,204);border-left-style:solid;padding-left:1ex"><div style=3D"overflow=
:hidden">
Please use the attached version.<br>
I still need help with 2.3 build system. If somebody willing to help me, pl=
ease use the attached version.</div></blockquote></div><div class=3D"gmail_=
extra"><br></div>The patch for 2.3 doesn&#39;t apply. Hope its not just me.=
. In fact both patches apply to the master (after some coaxing and with dif=
ferent offsets, of course). That shows something is wrong, as some contexts=
 have to be different in 2.3 and master. For example:</div><div class=3D"gm=
ail_extra"><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">=
Checking patch src/openvpn/init.c...</div><div class=3D"gmail_extra">error:=
 while searching for:</div><div class=3D"gmail_extra"><span style=3D"white-=
space:pre-wrap">		</span> =C2=A0 &quot;up&quot;,</div><div class=3D"gmail_e=
xtra"><span style=3D"white-space:pre-wrap">		</span> =C2=A0 c-&gt;<a href=
=3D"http://c2.es" target=3D"_blank">c2.es</a>);</div><div class=3D"gmail_ex=
tra"><br></div><div class=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0 /* possibly =
add routes */</div><div class=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0 if ((rou=
te_order() =3D=3D ROUTE_AFTER_TUN) &amp;&amp; (!c-&gt;options.route_delay_d=
efined))</div><div class=3D"gmail_extra"><span style=3D"white-space:pre-wra=
p">	</span>do_route (&amp;c-&gt;options, c-&gt;c1.route_list, c-&gt;c1.rout=
e_ipv6_list,</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_=
extra">error: patch failed: src/openvpn/init.c:1468</div></div><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra">The problem is route_=
order() =3D=3D ROUTE_AFTER_TUN is not in 2.3, its in master.</div><div clas=
s=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Similarly in options=
.c</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><di=
v class=3D"gmail_extra">error: while searching for:</div><div class=3D"gmai=
l_extra">=C2=A0 =C2=A0 =C2=A0 VERIFY_PERMISSION (OPT_P_ROUTE_EXTRAS);</div>=
<div class=3D"gmail_extra">=C2=A0 =C2=A0 }</div><div class=3D"gmail_extra">=
<div class=3D"gmail_extra">#endif</div><div class=3D"gmail_extra">#if PASST=
OS_CAPABILITY</div><div class=3D"gmail_extra">=C2=A0 else if (streq (p[0], =
&quot;passtos&quot;) &amp;&amp; !p[1]) =C2=A0 =C2=A0 &lt;--- this line does=
n&#39;t match the one in 2.3</div><div class=3D"gmail_extra">=C2=A0 =C2=A0 =
{</div><div class=3D"gmail_extra"><br></div></div><div class=3D"gmail_extra=
">Could you please check whether the patch is really against 2.3?</div><div=
 class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Also please see=
 why the code has to be different for 2.3 and master -- why not just use if=
def _WINNT_WIN32 ?</div><div class=3D"gmail_extra"><br></div><div class=3D"=
gmail_extra">Selva</div><div class=3D"gmail_extra"><br></div><div class=3D"=
gmail_extra">P.S.</div><div class=3D"gmail_extra">There are tons of whitesp=
ace errors as well, but that could be worked around..</div></div></div>

--001a1130cd4689bb12052552c0f6--


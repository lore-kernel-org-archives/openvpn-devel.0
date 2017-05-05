MIME-Version: 1.0
In-Reply-To: <81644640-b057-f177-e7ba-eb3957370109@...2080...>
References: <1494008642-7239-1-git-send-email-selva.nair@...277...>
	<20170505182851.GJ97029@...1296...>
	<81644640-b057-f177-e7ba-eb3957370109@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 5 May 2017 15:45:17 -0400
Message-ID: <CAKuzo_gK6DG6-QP7Xh_e2xc21cOXKx51d3pihcoftGRTDU3w7g@...278...>
Content-Type: multipart/alternative; boundary=001a113a408438b9e0054ecc227e
Subject: Re: [Openvpn-devel] [PATCH 1/2] In auth-pam plugin clear the
 password after use
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113a408438b9e0054ecc227e
Content-Type: text/plain; charset=UTF-8

On Fri, May 5, 2017 at 3:01 PM, David Sommerseth <
openvpn@...2080...> wrote:

> On 05/05/17 20:28, Gert Doering wrote:
> > Hi,
> >
> > On Fri, May 05, 2017 at 02:24:01PM -0400, selva.nair@...277... wrote:
> >> From: Selva Nair <selva.nair@...277...>
> >>
> >> This adds a minimal secure_memzero()
> >>
> >> Signed-off-by: Selva Nair <selva.nair@...277...>
> >
> > Feature-ACK, Code-NAK, but just because David is planning to export
> > secure_memzero() to plugins from OpenVPN proper - mentioned just today
> > on IRC
> >
> > 17:09 <@dazo> syzzer: just thinking aloud (remembered our discussion on
> wiping
> >               passwords securely in plug-ins) ... what do you think about
> >               exposing secure_memzero() to plug-ins, similar to what we
> do with
> >               plugin_{log,vlog}()?
> > 17:09 <@dazo> to avoid each plug-in needing to re-implement this
> > 17:09 <@syzzer> yeah, sounds useful
> > 17:10 <@dazo> I'll send a patch doing that too (should be quick to solve)
> >
> >
> > So I'd postpone this until David's patch plus instructions for plugin
> > authors show up.
> >
> > Good timing :-)
>
> Indeed :)
>

Good to know.. This happened to be a dependency for the second patch I sent
(parsing static challenge in auth-pam).


>
> So the patch exporting secure_memzero() is on the way to the mailing
> list now.
>
> To use this, you need to switch the openvpn_plugin_open_v1() to
> openvpn_plugin_open_v3().  The API on this function is quite different,
> but you shouldn't need to tweak too much.  All the pointers are
> available in the new struct pointers the _v3 function uses.
>
> Then you basically can declare a global variable like this:
>
>   plugin_secure_memzero_t ovpn_secure_memzero = NULL;


OK, I'll change this to use v3.

For the static-challenge patch I call openvpn_base64_decode() by compiling
base64.c into the plugin. Instead, can we also get base64_encode/decode
available as callbacks?

Selva

--001a113a408438b9e0054ecc227e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, May 5, 2017 at 3:01 PM, David Sommerseth <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2156...<wbr>=
.net</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span>On 05/05=
/17 20:28, Gert Doering wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; On Fri, May 05, 2017 at 02:24:01PM -0400, <a href=3D"mailto:selva.nair=
@...277..." target=3D"_blank">selva.nair@...277...</a> wrote:<br>
&gt;&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." targe=
t=3D"_blank">selva.nair@...277...</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; This adds a minimal secure_memzero()<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...1354...=
.." target=3D"_blank">selva.nair@...277...</a>&gt;<br>
&gt;<br>
&gt; Feature-ACK, Code-NAK, but just because David is planning to export<br>
&gt; secure_memzero() to plugins from OpenVPN proper - mentioned j<span cla=
ss=3D"m_2127228192032712408m_8260886105234327929m_-5334791780577863503aBn">=
<span class=3D"m_2127228192032712408m_8260886105234327929m_-533479178057786=
3503aQJ">ust t</span></span>oday<br>
&gt; on IRC<br>
&gt;<br>
&gt; 17:09 &lt;@dazo&gt; syzzer: just thinking aloud (remembered our discus=
sion on wiping<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0passwords secure=
ly in plug-ins) ... what do you think about<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exposing secure_=
memzero() to pl<span class=3D"m_2127228192032712408m_8260886105234327929m_-=
5334791780577863503aBn"><span class=3D"m_2127228192032712408m_8260886105234=
327929m_-5334791780577863503aQJ">ug-in</span></span>s, similar to what we d=
o with<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0plugin_{log,v<sp=
an class=3D"m_2127228192032712408m_8260886105234327929m_-533479178057786350=
3aBn"><span class=3D"m_2127228192032712408m_8260886105234327929m_-533479178=
0577863503aQJ">log}(</span></span>)?<br>
&gt; 17:09 &lt;@dazo&gt; to avoid eac<span class=3D"m_2127228192032712408m_=
8260886105234327929m_-5334791780577863503aBn"><span class=3D"m_212722819203=
2712408m_8260886105234327929m_-5334791780577863503aQJ">h plu</span></span>g=
-in needing to re-implement this<br>
&gt; 17:09 &lt;@syzzer&gt; yeah, sounds useful<br>
&gt; 17:10 &lt;@dazo&gt; I&#39;ll send a patch doing that too (should be qu=
ick to solve)<br>
&gt;<br>
&gt;<br>
&gt; So I&#39;d postpone this until David&#39;s patch plus instructions for=
 plugin<br>
&gt; authors show up.<br>
&gt;<br>
&gt; Good timing :-)<br>
<br>
</span>Indeed :)<br></blockquote><div><br></div><div>Good to know.. This ha=
ppened to be a dependency for the second patch I sent (parsing static chall=
enge in auth-pam). <br>=C2=A0<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
So the patch exporting secure_memzero() is on the way to the mailing<br>
list now.<br>
<br>
To use this, you need to switch the openvpn_plugin_open_v1() to<br>
openvpn_plugin_open_v3().=C2=A0 The API on this function is quite different=
,<br>
but you shouldn&#39;t need to tweak too much.=C2=A0 All the pointers are<br>
available in the new struct pointers the _v3 function uses.<br>
<br>
Then you basically can declare a global variable like this:<br>
<br>
=C2=A0 plugin_secure_memzero_t ovpn_secure_memzero =3D NULL;</blockquote></=
div><br></div><div class=3D"gmail_extra">OK, I&#39;ll change this to use v3=
. <br><br>For the static-challenge patch I call openvpn_base64_decode() by =
compiling base64.c into the plugin. Instead, can we also get base64_encode/=
decode available as callbacks?<br><br></div><div class=3D"gmail_extra">Selv=
a<br></div></div>

--001a113a408438b9e0054ecc227e--


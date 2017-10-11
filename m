MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10857E3A4B@...2294...>
References: <20171010231130.6832-1-simon@...2293...>
 <67ed8854-4290-468e-9773-2bdde5cd8909@...2080...>
 <99D61A626FDA8A4B90A270669121BE10857E33EE@...2294...>
 <CAKuzo_i2gtJ9YS09mhmf4Y1T0SDiJ=0HHpyW72XFowbOfNJ3CA@...278...>
 <99D61A626FDA8A4B90A270669121BE10857E3A4B@...2294...>
From: Selva <selva.nair@...277...>
Date: Wed, 11 Oct 2017 10:32:24 -0400
Message-ID: <CAKuzo_hhqgT23+rcdpdbOH74zYg6QvdcV4_ymo18VbuL+WkvFQ@...278...>
Content-Type: multipart/alternative; boundary="001a1138e72603de87055b464c84"
Subject: Re: [Openvpn-devel] [PATCH 01/13] snwprintf() => _snwprintf()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1138e72603de87055b464c84
Content-Type: text/plain; charset="UTF-8"

Hi

On Wed, Oct 11, 2017 at 10:03 AM, Simon Rozman <simon@...2293...> wrote:

> Hi,
>
>
>
> I agree migration towards ISO-C's snwprintf() is better.
>

Just to be sure, ISO-C is 'swprintf' not 'snwprintf'. In spite of 'n'
misisng from that name, it takes the buffer size argument and nul
terminates even if output is truncated.

--001a1138e72603de87055b464c84
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<br><div class=3D"gmail_extra"><br><div class=3D"gmail_q=
uote">On Wed, Oct 11, 2017 at 10:03 AM, Simon Rozman <span dir=3D"ltr">&lt;=
<a href=3D"mailto:simon@...2293..." target=3D"_blank">simon@...2293...</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div lang=3D"SL" link=
=3D"blue" vlink=3D"purple"><div class=3D"m_-8897449481704970227WordSection1=
"><p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-size:11.0pt;fon=
t-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">Hi,<u></=
u><u></u></span></p><p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"fo=
nt-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color=
:#1f497d"><u></u>=C2=A0<u></u></span></p><p class=3D"MsoNormal"><span lang=
=3D"EN-GB" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;=
sans-serif&quot;;color:#1f497d">I agree migration towards ISO-C&#39;s snwpr=
intf() is better.</span></p></div></div></blockquote><div><br></div><div>Ju=
st to be sure, ISO-C is &#39;swprintf&#39; not &#39;snwprintf&#39;. In spit=
e of &#39;n&#39; misisng from that name, it takes the buffer size argument =
and nul terminates even if output is truncated.<br></div></div></div></div>

--001a1138e72603de87055b464c84--


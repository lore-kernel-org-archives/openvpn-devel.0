MIME-Version: 1.0
References: <1539014950-21921-1-git-send-email-lstipakov@...277...>
 <a3899483-efab-51c7-e1de-cb497896f193@...1856...>
 <CAKuzo_hj-Sw5J5HeT1-eOqzjSwK3yvsNxA+cYKJGkPAuT2LHSA@...278...>
In-Reply-To: <CAKuzo_hj-Sw5J5HeT1-eOqzjSwK3yvsNxA+cYKJGkPAuT2LHSA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 9 Oct 2018 17:29:31 -0400
Message-ID: <CAKuzo_jsZhmfEWJd=VhWuJG6cQNwb_y8i6w-2oV+=otTkjD8XQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000001495e40577d27093"
Subject: Re: [Openvpn-devel] [PATCH] options.c: fix broken unary minus usage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000001495e40577d27093
Content-Type: text/plain; charset="UTF-8"

Hi

On Tue, Oct 9, 2018 at 5:14 PM Selva Nair <selva.nair@...277...> wrote:

>
>
> In fact the issue here is not the unary minus, but the unsigned to signed
> conversion. So when there is no scope for overflow all is good. If there is
> overflow, unsigned->signed conversion is ill-defined -- cast doesn't fix
> it. In fact the cast is meaningless here (see more on that below):
>
> Although C99 std does not seem to be explicit about unary minus of
> unsigned, the practice in C even before that was to subtract the number
> from the largest possible value and add 1: as in K&R A7.4.5 (p. 204 in my
> copy):
>
> "If the operand is unsigned, the result is computed by subtracting the
> value from the largest value of the promoted type"
>
> So unary minus of unsigned itself is well-defined. Actually even the unary
> minus of unsigned is computed using the above rule for signed:
>
> "If the operand is signed, the result is computed by promoted operand to
> its unsigned type, applying -, and converting back to the signed type".!!
>
>

> So what the cast achieves is a an additional iteration of conversions
> which gains nothing.
>

Ignore most of it -- I'm having really bad day and writing mostly nonsense.

Selva

--0000000000001495e40577d27093
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<br><div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
>On Tue, Oct 9, 2018 at 5:14 PM Selva Nair &lt;<a href=3D"mailto:selva.nair=
@...277...">selva.nair@...277...</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div dir=3D"ltr"><br><div><div class=3D"gmail_quote"><div><br=
></div><div>In fact the issue here is not the unary minus, but the unsigned=
 to signed conversion. So when there is no scope for overflow all is good. =
If there is overflow, unsigned-&gt;signed conversion is ill-defined -- cast=
 doesn&#39;t fix it. In fact the cast is meaningless here (see more on that=
 below):<br><br>Although C99 std does not seem to be explicit about unary m=
inus of unsigned, the practice in C even before that was to subtract the nu=
mber from the largest possible value and add 1: as in K&amp;R A7.4.5 (p. 20=
4 in my copy):<br><br></div><div>&quot;If the operand is unsigned, the resu=
lt is computed by subtracting the value from the largest value of the promo=
ted type&quot;<br><br></div><div>So unary minus of unsigned itself is well-=
defined. Actually even the unary minus of unsigned is computed using the ab=
ove rule for signed:<br><br>&quot;If the operand is signed, the result is c=
omputed by promoted operand to its unsigned type, applying -, and convertin=
g back to the signed type&quot;.!!<br>=C2=A0</div></div></div></div></block=
quote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div><div class=3D"gm=
ail_quote"><div><br></div><div>So what the cast achieves is a an additional=
 iteration of conversions which gains nothing.<br></div></div></div></div><=
/blockquote><div><br></div><div>Ignore most of it -- I&#39;m having really =
bad day and writing mostly nonsense.<br><br></div><div>Selva <br></div></di=
v></div></div>

--0000000000001495e40577d27093--


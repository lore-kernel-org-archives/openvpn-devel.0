MIME-Version: 1.0
References: <1539014950-21921-1-git-send-email-lstipakov@...277...>
 <a3899483-efab-51c7-e1de-cb497896f193@...1856...>
 <CAKuzo_hj-Sw5J5HeT1-eOqzjSwK3yvsNxA+cYKJGkPAuT2LHSA@...278...>
In-Reply-To: <CAKuzo_hj-Sw5J5HeT1-eOqzjSwK3yvsNxA+cYKJGkPAuT2LHSA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 9 Oct 2018 17:19:10 -0400
Message-ID: <CAKuzo_gsn15yFxHBQORbe0dnk1WtN_1hzO6YRj0ufc=5o6qi5g@...278...>
Content-Type: multipart/alternative; boundary="000000000000ffe5720577d24ae8"
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

--000000000000ffe5720577d24ae8
Content-Type: text/plain; charset="UTF-8"

Hi,

More noise: a typo alert below:

On Tue, Oct 9, 2018 at 5:14 PM Selva Nair <selva.nair@...277...> wrote:

> Hi
>
> On Tue, Oct 9, 2018 at 4:39 PM Steffan Karger <steffan@...1856...> wrote:
>
>> Hi,
>>
>> On 08-10-18 18:09, Lev Stipakov wrote:
>> > From: Lev Stipakov <lev@...515...>
>> >
>> > In Visual Studio when unary minus is applied to unsigned,
>> > result is still unsigned. This means that when we use result
>> > as function formal parameter, we pass incorrect value.
>>
>> Good catch. I had to look it up, but I think this is actually undefined
>> behaviour. 6.5 point 5 of C99 says:
>>
>> "If an exceptional condition occurs during the evaluation of an
>> expression (that is, if the result is not mathematically defined or not
>> in the range of representable values for its type), the behavior is
>> undefined."
>>
>> Remarkably, even with -Wall -Wextra -pedantic, GCC 7.3 does not throw
>> any warnings. But some tests show that GCC does what one might expect
>> when reading this code: cast to a signed value.
>>
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

Typo alert: signed and unsigned inverted in the last sentence, in case
anyone really read all that..


> "If the operand is signed, the result is computed by promoted operand to
> its unsigned type, applying -, and converting back to the signed type".!!
>
> So what the cast achieves is a an additional iteration of conversions
> which gains nothing.
>
>
>> I'm just not sure whether we should add casts, or stop using the 'hack'
>> of supplying a negative value to frame_add_to_extra_frame. Maybe we
>> should add a frame_remove_from_extra_frame function instead. What do you
>> think?
>>
>
> If the logic could be changed that should be preferred.
>
> Selva
>

--000000000000ffe5720577d24ae8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi,<br></div><br></div>More noise: a typo alert =
below:<br><br><div><div><div><div class=3D"gmail_quote"><div dir=3D"ltr">On=
 Tue, Oct 9, 2018 at 5:14 PM Selva Nair &lt;<a href=3D"mailto:selva.nair@...1186...=
.277...">selva.nair@...277...</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex"><div dir=3D"ltr">Hi<br><div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr">On Tue, Oct 9, 2018 at 4:39 PM Steffan Karger &lt;<a href=3D"mai=
lto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
On 08-10-18 18:09, Lev Stipakov wrote:<br>
&gt; From: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"_bla=
nk">lev@...515...</a>&gt;<br>
&gt; <br>
&gt; In Visual Studio when unary minus is applied to unsigned,<br>
&gt; result is still unsigned. This means that when we use result<br>
&gt; as function formal parameter, we pass incorrect value.<br><br>
Good catch. I had to look it up, but I think this is actually undefined<br>
behaviour. 6.5 point 5 of C99 says:<br>
<br>
&quot;If an exceptional condition occurs during the evaluation of an<br>
expression (that is, if the result is not mathematically defined or not<br>
in the range of representable values for its type), the behavior is<br>
undefined.&quot;<br>
<br>
Remarkably, even with -Wall -Wextra -pedantic, GCC 7.3 does not throw<br>
any warnings. But some tests show that GCC does what one might expect<br>
when reading this code: cast to a signed value.<br></blockquote><div><br></=
div><div>In fact the issue here is not the unary minus, but the unsigned to=
 signed conversion. So when there is no scope for overflow all is good. If =
there is overflow, unsigned-&gt;signed conversion is ill-defined -- cast do=
esn&#39;t fix it. In fact the cast is meaningless here (see more on that be=
low):<br><br>Although C99 std does not seem to be explicit about unary minu=
s of unsigned, the practice in C even before that was to subtract the numbe=
r from the largest possible value and add 1: as in K&amp;R A7.4.5 (p. 204 i=
n my copy):<br><br></div><div>&quot;If the operand is unsigned, the result =
is computed by subtracting the value from the largest value of the promoted=
 type&quot;<br><br></div><div>So unary minus of unsigned itself is well-def=
ined. Actually even the unary minus of unsigned is computed using the above=
 rule for signed:<br></div></div></div></div></blockquote><div><br>Typo ale=
rt: signed and unsigned inverted in the last sentence, in case anyone reall=
y read all that..<br><br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"l=
tr"><div><div class=3D"gmail_quote"><div><br>&quot;If the operand is signed=
, the result is computed by promoted operand to its unsigned type, applying=
 -, and converting back to the signed type&quot;.!!<br><br></div><div>So wh=
at the cast achieves is a an additional iteration of conversions which gain=
s nothing.<br></div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
I&#39;m just not sure whether we should add casts, or stop using the &#39;h=
ack&#39;<br>
of supplying a negative value to frame_add_to_extra_frame. Maybe we<br>
should add a frame_remove_from_extra_frame function instead. What do you<br>
think?<br></blockquote><div><br>If the logic could be changed that should b=
e preferred.<br><br></div><div>Selva<br></div></div></div></div>
</blockquote></div></div></div></div></div>

--000000000000ffe5720577d24ae8--


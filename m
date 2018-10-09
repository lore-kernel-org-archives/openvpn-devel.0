MIME-Version: 1.0
References: <1539014950-21921-1-git-send-email-lstipakov@...277...>
 <a3899483-efab-51c7-e1de-cb497896f193@...1856...>
In-Reply-To: <a3899483-efab-51c7-e1de-cb497896f193@...1856...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 9 Oct 2018 17:14:10 -0400
Message-ID: <CAKuzo_hj-Sw5J5HeT1-eOqzjSwK3yvsNxA+cYKJGkPAuT2LHSA@...278...>
Content-Type: multipart/alternative; boundary="00000000000038df5e0577d23908"
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

--00000000000038df5e0577d23908
Content-Type: text/plain; charset="UTF-8"

Hi

On Tue, Oct 9, 2018 at 4:39 PM Steffan Karger <steffan@...1856...> wrote:

> Hi,
>
> On 08-10-18 18:09, Lev Stipakov wrote:
> > From: Lev Stipakov <lev@...515...>
> >
> > In Visual Studio when unary minus is applied to unsigned,
> > result is still unsigned. This means that when we use result
> > as function formal parameter, we pass incorrect value.
> >
> > Fix by adding explicit cast to signed type.
> >
> > Since GCC doesn't complain (and users too :), it probably
> > casts to signed automatically.
> >
> > Signed-off-by: Lev Stipakov <lev@...515...>
> > ---
> >  src/openvpn/options.c | 2 +-
> >  src/openvpn/ssl.c     | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> > index e42029c..1927a32 100644
> > --- a/src/openvpn/options.c
> > +++ b/src/openvpn/options.c
> > @@ -3509,7 +3509,7 @@ calc_options_string_link_mtu(const struct options
> *o, const struct frame *frame)
> >          struct key_type fake_kt;
> >          init_key_type(&fake_kt, o->ciphername, o->authname, o->keysize,
> true,
> >                        false);
> > -        frame_add_to_extra_frame(&fake_frame, -(crypto_max_overhead()));
> > +        frame_add_to_extra_frame(&fake_frame,
> -(int)(crypto_max_overhead()));
> >          crypto_adjust_frame_parameters(&fake_frame, &fake_kt, o->replay,
> >
>  cipher_kt_mode_ofb_cfb(fake_kt.cipher));
> >          frame_finalize(&fake_frame, o->ce.link_mtu_defined,
> o->ce.link_mtu,
> > diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> > index 315303b..18b1fbd 100644
> > --- a/src/openvpn/ssl.c
> > +++ b/src/openvpn/ssl.c
> > @@ -1987,7 +1987,7 @@ tls_session_update_crypto_params(struct
> tls_session *session,
> >      }
> >
> >      /* Update frame parameters: undo worst-case overhead, add actual
> overhead */
> > -    frame_add_to_extra_frame(frame, -(crypto_max_overhead()));
> > +    frame_add_to_extra_frame(frame, -(int)(crypto_max_overhead()));
> >      crypto_adjust_frame_parameters(frame, &session->opt->key_type,
> >                                     options->replay,
> packet_id_long_form);
> >      frame_finalize(frame, options->ce.link_mtu_defined,
> options->ce.link_mtu,
> >
>
> Good catch. I had to look it up, but I think this is actually undefined
> behaviour. 6.5 point 5 of C99 says:
>
> "If an exceptional condition occurs during the evaluation of an
> expression (that is, if the result is not mathematically defined or not
> in the range of representable values for its type), the behavior is
> undefined."
>
> Remarkably, even with -Wall -Wextra -pedantic, GCC 7.3 does not throw
> any warnings. But some tests show that GCC does what one might expect
> when reading this code: cast to a signed value.
>

In fact the issue here is not the unary minus, but the unsigned to signed
conversion. So when there is no scope for overflow all is good. If there is
overflow, unsigned->signed conversion is ill-defined -- cast doesn't fix
it. In fact the cast is meaningless here (see more on that below):

Although C99 std does not seem to be explicit about unary minus of
unsigned, the practice in C even before that was to subtract the number
from the largest possible value and add 1: as in K&R A7.4.5 (p. 204 in my
copy):

"If the operand is unsigned, the result is computed by subtracting the
value from the largest value of the promoted type"

So unary minus of unsigned itself is well-defined. Actually even the unary
minus of unsigned is computed using the above rule for signed:

"If the operand is signed, the result is computed by promoted operand to
its unsigned type, applying -, and converting back to the signed type".!!

So what the cast achieves is a an additional iteration of conversions which
gains nothing.


> I'm just not sure whether we should add casts, or stop using the 'hack'
> of supplying a negative value to frame_add_to_extra_frame. Maybe we
> should add a frame_remove_from_extra_frame function instead. What do you
> think?
>

If the logic could be changed that should be preferred.

Selva

--00000000000038df5e0577d23908
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<br><div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
>On Tue, Oct 9, 2018 at 4:39 PM Steffan Karger &lt;<a href=3D"mailto:steffa=
n@...1856...">steffan@...1856...</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Hi,<br>
<br>
On 08-10-18 18:09, Lev Stipakov wrote:<br>
&gt; From: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"_bla=
nk">lev@...515...</a>&gt;<br>
&gt; <br>
&gt; In Visual Studio when unary minus is applied to unsigned,<br>
&gt; result is still unsigned. This means that when we use result<br>
&gt; as function formal parameter, we pass incorrect value.<br>
&gt; <br>
&gt; Fix by adding explicit cast to signed type.<br>
&gt; <br>
&gt; Since GCC doesn&#39;t complain (and users too :), it probably<br>
&gt; casts to signed automatically.<br>
&gt; <br>
&gt; Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." targe=
t=3D"_blank">lev@...515...</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 src/openvpn/options.c | 2 +-<br>
&gt;=C2=A0 src/openvpn/ssl.c=C2=A0 =C2=A0 =C2=A0| 2 +-<br>
&gt;=C2=A0 2 files changed, 2 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/src/openvpn/options.c b/src/openvpn/options.c<br>
&gt; index e42029c..1927a32 100644<br>
&gt; --- a/src/openvpn/options.c<br>
&gt; +++ b/src/openvpn/options.c<br>
&gt; @@ -3509,7 +3509,7 @@ calc_options_string_link_mtu(const struct option=
s *o, const struct frame *frame)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct key_type fake_kt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 init_key_type(&amp;fake_kt, o-&gt;ci=
phername, o-&gt;authname, o-&gt;keysize, true,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 false);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 frame_add_to_extra_frame(&amp;fake_frame,=
 -(crypto_max_overhead()));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 frame_add_to_extra_frame(&amp;fake_frame,=
 -(int)(crypto_max_overhead()));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 crypto_adjust_frame_parameters(&amp;=
fake_frame, &amp;fake_kt, o-&gt;replay,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0cipher_kt_mode_ofb_cfb(fake_kt.cipher));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 frame_finalize(&amp;fake_frame, o-&g=
t;ce.link_mtu_defined, o-&gt;ce.link_mtu,<br>
&gt; diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c<br>
&gt; index 315303b..18b1fbd 100644<br>
&gt; --- a/src/openvpn/ssl.c<br>
&gt; +++ b/src/openvpn/ssl.c<br>
&gt; @@ -1987,7 +1987,7 @@ tls_session_update_crypto_params(struct tls_sess=
ion *session,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Update frame parameters: undo worst-case overhe=
ad, add actual overhead */<br>
&gt; -=C2=A0 =C2=A0 frame_add_to_extra_frame(frame, -(crypto_max_overhead()=
));<br>
&gt; +=C2=A0 =C2=A0 frame_add_to_extra_frame(frame, -(int)(crypto_max_overh=
ead()));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 crypto_adjust_frame_parameters(frame, &amp;session=
-&gt;opt-&gt;key_type,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0options-&gt;r=
eplay, packet_id_long_form);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 frame_finalize(frame, options-&gt;ce.link_mtu_defi=
ned, options-&gt;ce.link_mtu,<br>
&gt; <br>
<br>
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
 rule for signed:<br><br>&quot;If the operand is signed, the result is comp=
uted by promoted operand to its unsigned type, applying -, and converting b=
ack to the signed type&quot;.!!<br><br></div><div>So what the cast achieves=
 is a an additional iteration of conversions which gains nothing.<br></div>=
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">
<br>
I&#39;m just not sure whether we should add casts, or stop using the &#39;h=
ack&#39;<br>
of supplying a negative value to frame_add_to_extra_frame. Maybe we<br>
should add a frame_remove_from_extra_frame function instead. What do you<br>
think?<br></blockquote><div><br>If the logic could be changed that should b=
e preferred.<br><br></div><div>Selva<br></div><br></div></div></div>

--00000000000038df5e0577d23908--


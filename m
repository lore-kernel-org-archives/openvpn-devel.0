MIME-Version: 1.0
References: <CAM8w-qEE6vHj=yUOpTFbM7DqPKzUV0NupvEG4rUefY=kNB2DxQ@...278...>
 <aTlMDx6K__4yQenl@...1296...>
In-Reply-To: <aTlMDx6K__4yQenl@...1296...>
From: Marco Baffo <marco@...2726...>
Date: Wed, 10 Dec 2025 12:08:32 +0100
Message-ID: <CAL7H48R92xUi__0qA7wU37HC_PnGwgu8LStwTt7a3Ai4CM-3sw@...278...>
Content-Type: multipart/alternative; boundary="0000000000002413f60645970d6b"
Subject: Re: [Openvpn-devel] [Bugfix v2]: PUSH_UPDATE: fix option reset
 logic in continuation messages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Moritz Fain <moritz-openvpn@...2969...>, openvpn-devel@lists.sourceforge.net

--0000000000002413f60645970d6b
Content-Type: text/plain; charset="UTF-8"

They are 2 different variables (just very similar names), we can move
onwards :-)

On Wed, 10 Dec 2025 at 11:32, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> so, I wanted to merge this into 2.7_rc4 ("it has an ACK, it has unit
> tests")
> but there is one hunk I do not understand...
>
> On Mon, Dec 01, 2025 at 03:04:18PM +0100, Moritz Fain wrote:
> > diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> > index 7852d360..898d1585 100644
> > --- a/src/openvpn/push.c
> > +++ b/src/openvpn/push.c
> > @@ -540,11 +540,15 @@ incoming_push_message(struct context *c, const
> > struct buffer *buffer)
> >              }
> >              else
> >              {
> > -                if (!option_types_found)
> > +                /* Clear push_update_options_found for next
> > PUSH_UPDATE sequence */
> > +                c->options.push_update_options_found = 0;
> > +
> > +                /* Use accumulated option_types_found for the entire
> > PUSH_UPDATE sequence */
> > +                if (!c->options.push_option_types_found)
> >                  {
>
> so... "we set push_update_options_found = 0, and then we check if
> it might be non-0"?
>
> This looks wrong :-)
>
>
> (Also, that hunk displays a problem of the sending mail client - it
> wraps all long lines, so I had to manually unwrap ~30 lines, which is
> stupid work that should be left to machines... so if at all possible,
> please send patches with "git send-email" - this is magic, and succeeds
> almost always in making patches arrive intact)
>
> gert
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never
> doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh
> Mistress
>
> Gert Doering - Munich, Germany
> gert@...1296...
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--0000000000002413f60645970d6b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">They are 2 different variables (just very similar names), =
we can move onwards :-)</div><br><div class=3D"gmail_quote gmail_quote_cont=
ainer"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 10 Dec 2025 at 11:32, =
Gert Doering &lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
so, I wanted to merge this into 2.7_rc4 (&quot;it has an ACK, it has unit t=
ests&quot;)<br>
but there is one hunk I do not understand...<br>
<br>
On Mon, Dec 01, 2025 at 03:04:18PM +0100, Moritz Fain wrote:<br>
&gt; diff --git a/src/openvpn/push.c b/src/openvpn/push.c<br>
&gt; index 7852d360..898d1585 100644<br>
&gt; --- a/src/openvpn/push.c<br>
&gt; +++ b/src/openvpn/push.c<br>
&gt; @@ -540,11 +540,15 @@ incoming_push_message(struct context *c, const<b=
r>
&gt; struct buffer *buffer)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!option_t=
ypes_found)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Clear push=
_update_options_found for next<br>
&gt; PUSH_UPDATE sequence */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;options=
.push_update_options_found =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Use accumu=
lated option_types_found for the entire<br>
&gt; PUSH_UPDATE sequence */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!c-&gt;op=
tions.push_option_types_found)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
<br>
so... &quot;we set push_update_options_found =3D 0, and then we check if<br>
it might be non-0&quot;?<br>
<br>
This looks wrong :-)<br>
<br>
<br>
(Also, that hunk displays a problem of the sending mail client - it <br>
wraps all long lines, so I had to manually unwrap ~30 lines, which is<br>
stupid work that should be left to machines... so if at all possible,<br>
please send patches with &quot;git send-email&quot; - this is magic, and su=
cceeds<br>
almost always in making patches arrive intact)<br>
<br>
gert<br>
-- <br>
&quot;If was one thing all people took for granted, was conviction that if =
you <br>
=C2=A0feed honest figures into a computer, honest figures come out. Never d=
oubted <br>
=C2=A0it myself till I met a computer with a sense of humor.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Robert A. Heinlein, The Moon is a Harsh Mist=
ress<br>
<br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296..." target=3D"_blank">gert@...1296...</a><br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div>

--0000000000002413f60645970d6b--


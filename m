MIME-Version: 1.0
In-Reply-To: <20170930172859.GY70062@...1296...>
References: <1b275182-8551-6100-e3e9-80c966c2b200@...277...>
 <c2fbb372-cbfe-5231-66fa-33403a1566df@...277...>
 <20170930172859.GY70062@...1296...>
From: Selva <selva.nair@...277...>
Date: Sat, 30 Sep 2017 23:25:37 -0400
Message-ID: <CAKuzo_h_HMpRVVoSXft3DPDoDrjhnkWepLiThLbDC43HJtt-Sg@...278...>
Content-Type: multipart/alternative; boundary="001a1149dc8601597d055a73d120"
Subject: Re: [Openvpn-devel] Too much output at --verb 0 (bug?)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: fragmentux <fragmentux@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1149dc8601597d055a73d120
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sat, Sep 30, 2017 at 1:28 PM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Thu, Sep 28, 2017 at 01:18:20PM +0100, fragmentux wrote:
> >
>
> Could you please fix your mail client settings so that it writes a proper
> name here?
>
> > On 27/09/17 15:57, fragmentux wrote:
> > > not sure if this really counts as a bug but ..
> > >
> > > according to the manual --verb 0 = "No output except fatal errors"
> > >
> > > This, however, is the output at --verb 0 (2.4.4)
> > >
> > > == Start client:
> > > Option 'explicit-exit-notify' in [PUSH-OPTIONS]:3 is ignored by
> previous
> > > <connection> blocks
> > > Option 'explicit-exit-notify' in [PUSH-OPTIONS]:9 is ignored by
> previous
> > > <connection> blocks
>
> These two have been taken care of just now ("why is your server pushing
> it twice?"), but anyway.
>

Yes, muted when pushed. But such messages will still print at verb 0 if
present outside connection blocks in the config file.


>
> > > do_ifconfig, tt->did_ifconfig_ipv6_setup=0
>
> This one comes as a bit of surprise - it's logged with M_DEBUG, and I
> assumed that this would be something like "verb 3 or 4, or even higher".
>
> Selva, Steffan, or someone else who understands our message levels -
> what's M_DEBUG for, and what *should* I have used here?
>

Hmm.. The log levels code is out of this world and I've only a vague idea..
I for sure don't know the "officially sanctioned" way of using it and have
more questions than answers.

M_DEBUG, M_WARN, M_FATAL etc by themselves do not define any printing level
-- in other words these will print at all verb levels unless combined with
something that sets the print level. M_INFO is the only M_x flag that is
different -- it  has a "verb level" of 1 or more encoded in it.

I suppose the original design idea was that we are only supposed to use
M_INFO or one of the LOGLEV's defined in errlevel.h -- the ones starting
with D_xxx. If so I  don't see one appropriate for printing ifconfig
errors/info/debug. You ma have to create one?

One could generate a log level on the fly using, say,  LOGLEV(4,0,M_DEBUG)
meaning print at verb 4+, don't mute, tag as debug. But there is not a
single instance of such use anywhere in the code, so I suppose that would
be considered a hack?


>
> > > WARNING: this configuration may cache passwords in memory -- use the
> > > auth-nocache option to prevent this
> > >
> > > == Reconnect client:
> > > WARNING: 'link-mtu' is used inconsistently, local='link-mtu 1550',
> > > remote='link-mtu 1602'
> > > WARNING: 'cipher' is used inconsistently, local='cipher AES-256-GCM',
> > > remote='cipher AES-256-CBC'
> > > WARNING: 'auth' is used inconsistently, local='auth [null-digest]',
> > > remote='auth SHA512'
> [..]
> > > None of these are Fatal errors ..
>
> Indeed, WARNINGs could also be re-evaluated.  Either we document that
> "verb 0" will print errors *and* warnings, or we change the printout
> to not print warnings.
>

Aha. so we're not supposed to print warnings or non-fatal errors at verb 0
-- had no idea.

I would wager that documentation is wrong as we have loads of messages
printed with just M_WARN or M_NONFATAL. All of those will print at verb 0.
Unless are we not supposed print anything with pure M_x flags alone --
M_INFO being the only exception? Is every M_WARN to be used as
M_WARN|M_INFO so that it will print only at verb 1+? That would be a kludge.

Then there is a M_VERB0 = 0 which is commented as "messages displayed even
at verb0 -- (fatal errors only)" but its used just once in the code -- that
too used by itself which does nothing but just print the message at all
verb levels.  And make log consumers (like the GUI) wrongly assume that its
a benign info message.

As all M_INFO messages will print at verb 1, we do not have much room to
define verb levels for WARN, ERROR, FATAL, do we.. This is unlike any
logging system I've seen and could be totally misreading the designer's
intent.


>
> Personally, I wouldn't ever run any software with "--verb 0".  I want
> to be able to check the log and see "oh, it reconnected tonight at
> 4:30, so something must have been funny with the network or the server".
>

++1.

Selva

--001a1149dc8601597d055a73d120
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Sat, Sep 30, 2017 at 1:28 PM, Gert Doering <span dir=3D"ltr">&lt;=
<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
On Thu, Sep 28, 2017 at 01:18:20PM +0100, fragmentux wrote:<br>
&gt;<br>
<br>
Could you please fix your mail client settings so that it writes a proper<b=
r>
name here?<br>
<br>
&gt; On 27/09/17 15:57, fragmentux wrote:<br>
&gt; &gt; not sure if this really counts as a bug but ..<br>
&gt; &gt;<br>
&gt; &gt; according to the manual --verb 0 =3D &quot;No output except fatal=
 errors&quot;<br>
&gt; &gt;<br>
&gt; &gt; This, however, is the output at --verb 0 (2.4.4)<br>
&gt; &gt;<br>
&gt; &gt; =3D=3D Start client:<br>
&gt; &gt; Option &#39;explicit-exit-notify&#39; in [PUSH-OPTIONS]:3 is igno=
red by previous<br>
&gt; &gt; &lt;connection&gt; blocks<br>
&gt; &gt; Option &#39;explicit-exit-notify&#39; in [PUSH-OPTIONS]:9 is igno=
red by previous<br>
&gt; &gt; &lt;connection&gt; blocks<br>
<br>
These two have been taken care of just now (&quot;why is your server pushin=
g<br>
it twice?&quot;), but anyway.<br></blockquote><div><br></div><div>Yes, mute=
d when pushed. But such messages will still print at verb 0 if present outs=
ide connection blocks in the config file.</div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">
<br>
&gt; &gt; do_ifconfig, tt-&gt;did_ifconfig_ipv6_setup=3D0<br>
<br>
This one comes as a bit of surprise - it&#39;s logged with M_DEBUG, and I<b=
r>
assumed that this would be something like &quot;verb 3 or 4, or even higher=
&quot;.<br>
<br>
Selva, Steffan, or someone else who understands our message levels -<br>
what&#39;s M_DEBUG for, and what *should* I have used here?<br></blockquote=
><div><br></div><div>Hmm.. The log levels code is out of this world and I&#=
39;ve only a vague idea.. I for sure don&#39;t know the &quot;officially sa=
nctioned&quot; way of using it and have more questions than answers.</div><=
div><br></div><div>M_DEBUG, M_WARN, M_FATAL etc by themselves do not define=
 any printing level -- in other words these will print at all verb levels u=
nless combined with something that sets the print level. M_INFO is the only=
 M_x flag that is different -- it =C2=A0has a &quot;verb level&quot; of 1 o=
r more encoded in it.</div><div><br></div><div>I suppose the original desig=
n idea was that we are only supposed to use M_INFO or one of the LOGLEV&#39=
;s defined in errlevel.h -- the ones starting with D_xxx. If so I =C2=A0don=
&#39;t see one appropriate for printing ifconfig errors/info/debug. You ma =
have to create one?</div><div><br></div><div>One could generate a log level=
 on the fly using, say, =C2=A0LOGLEV(4,0,M_DEBUG) meaning print at verb 4+,=
 don&#39;t mute, tag as debug. But there is not a single instance of such u=
se anywhere in the code, so I suppose that would be considered a hack?</div=
><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; &gt; WARNING: this configuration may cache passwords in memory -- use =
the<br>
&gt; &gt; auth-nocache option to prevent this<br>
&gt; &gt;<br>
&gt; &gt; =3D=3D Reconnect client:<br>
&gt; &gt; WARNING: &#39;link-mtu&#39; is used inconsistently, local=3D&#39;=
link-mtu 1550&#39;,<br>
&gt; &gt; remote=3D&#39;link-mtu 1602&#39;<br>
&gt; &gt; WARNING: &#39;cipher&#39; is used inconsistently, local=3D&#39;ci=
pher AES-256-GCM&#39;,<br>
&gt; &gt; remote=3D&#39;cipher AES-256-CBC&#39;<br>
&gt; &gt; WARNING: &#39;auth&#39; is used inconsistently, local=3D&#39;auth=
 [null-digest]&#39;,<br>
&gt; &gt; remote=3D&#39;auth SHA512&#39;<br>
[..]<br>
&gt; &gt; None of these are Fatal errors ..<br>
<br>
Indeed, WARNINGs could also be re-evaluated.=C2=A0 Either we document that<=
br>
&quot;verb 0&quot; will print errors *and* warnings, or we change the print=
out<br>
to not print warnings.<br></blockquote><div><br></div><div>Aha. so we&#39;r=
e not supposed to print warnings or non-fatal errors at verb 0 -- had no id=
ea.</div><div><br></div><div>I would wager that documentation is wrong as w=
e have loads of messages printed with just M_WARN or M_NONFATAL. All of tho=
se will print at verb 0. Unless are we not supposed print anything with pur=
e M_x flags alone -- M_INFO being the only exception? Is every M_WARN to be=
 used as M_WARN|M_INFO so that it will print only at verb 1+? That would be=
 a kludge.</div><div><br></div><div>Then there is a M_VERB0 =3D 0 which is =
commented as &quot;messages displayed even at verb0 -- (fatal errors only)&=
quot; but its used just once in the code -- that too used by itself which d=
oes nothing but just print the message at all verb levels.=C2=A0 And make l=
og consumers (like the GUI) wrongly assume that its a benign info message.<=
/div><div><br></div><div>As all M_INFO messages will print at verb 1, we do=
 not have much room to define verb levels for WARN, ERROR, FATAL, do we.. T=
his is unlike any logging system I&#39;ve seen and could be totally misread=
ing the designer&#39;s intent.</div><div><br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">
<br>
<br>
Personally, I wouldn&#39;t ever run any software with &quot;--verb 0&quot;.=
=C2=A0 I want<br>
to be able to check the log and see &quot;oh, it reconnected tonight at<br>
4:30, so something must have been funny with the network or the server&quot=
;.<br></blockquote><div><br></div><div>++1.</div><div><br></div><div>Selva<=
/div></div></div></div>

--001a1149dc8601597d055a73d120--


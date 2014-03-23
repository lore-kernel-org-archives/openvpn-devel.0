MIME-Version: 1.0
In-Reply-To: <20140322183508.GZ16637@...1296...>
References: <1395017376-24554-1-git-send-email-james@...515...>
	<20140317202910.GM16637@...1296...> <532775DD.4050106@...515...>
	<1CED409804E2164C8104F9E623B08B90155646D4C1@...1436...>
	<53281720.2050504@...1147...> <5328463F.7090704@...1114...>
	<53284DA8.1010709@...1147...>
	<1CED409804E2164C8104F9E623B08B9016F95AD5DC@...1436...>
	<20140322183508.GZ16637@...1296...>
From: Steffan Karger <steffan@...1856...>
Date: Sun, 23 Mar 2014 10:22:57 +0100
Message-ID: <CAA1AbxJMVBtOgeswADw_Q1XuKyK6h_jWmVg-gUqPPtM2XCk1kA@...278...>
Content-Type: multipart/alternative; boundary=089e0163464e5362f704f542ab2b
Subject: Re: [Openvpn-devel] [PATCH] Set SSL_OP_NO_TICKET flag in SSL
 context for OpenSSL builds, to disable TLS stateless session resumption.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--089e0163464e5362f704f542ab2b
Content-Type: text/plain; charset=ISO-8859-1

Hi,

On Sat, Mar 22, 2014 at 7:35 PM, Gert Doering <gert@...1296...> wrote:

> On Tue, Mar 18, 2014 at 05:40:41PM +0100, Steffan Karger wrote:
> > > So it seems I spoke too soon... sorry for the noise, although I must
> > > say that I'm still in favour of checking for the existence of an IFDEF
> > > instead of relying on a particular version...
> >
> > Point taken, just checking the OpenSSL version does not suffice.
> > Still, I'd like to prevent more #ifdef's in the code. We could
> > check the #ifdef in configure.ac, and refuse to build when it's
> > not present. Any objections against requiring SSL_OP_NO_TICKET to
> > be present for OpenVPN 2.4+? We have to drop support for 'ancient
> > stuff' at some point.
>
> If I understood this all right, this feature improves OpenVPN security
> against yet-unknown attacks using a feature of OpenSSL that we don't
> use anyway.  Right?
>

Right.

So in that case, I'm fine with your proposal - do something on configure.ac
> that will check for SSL_OP_NO_TICKET and complain (with a useful error
> message :) ) if it's not there.
>
> For 2.3, I'd propose to add code to ssl_openssl.h like this:
>
> /* SSL_OP_NO_TICKET tells OpenSSL to disable "stateless session
> resumption",
>  * as this is something we do not want nor need, but could potentially be
>  * used for a future attack.  For compatibility reasons, in the 2.3.x
>  * series, we keep building if the OpenSSL version is too old to support
>  * this.  2.4 requires it and will fail configure if not present.
>  */
> #ifndef SSL_OP_NO_TICKET
> # define SSL_OP_NO_TICKET 0
> #endif
>
>
> ACK?  Is the message correct?
>

ACK. Message looks correct and clear to me (but please remove the double
space before 2.4).

-Steffan

--089e0163464e5362f704f542ab2b
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div><div class=3D"gmail_extra"><br><div class=3D"g=
mail_quote">On Sat, Mar 22, 2014 at 7:35 PM, Gert Doering <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</=
a>&gt;</span> wrote:<br>


<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">On Tue, Mar 18, 2014 at 05:40:41PM +0100, St=
effan Karger wrote:<br><div>
&gt; &gt; So it seems I spoke too soon... sorry for the noise, although I m=
ust<br>
&gt; &gt; say that I&#39;m still in favour of checking for the existence of=
 an IFDEF<br>
&gt; &gt; instead of relying on a particular version...<br>
&gt;<br>
&gt; Point taken, just checking the OpenSSL version does not suffice.<br>
&gt; Still, I&#39;d like to prevent more #ifdef&#39;s in the code. We could=
<br>
&gt; check the #ifdef in <a href=3D"http://configure.ac" target=3D"_blank">=
configure.ac</a>, and refuse to build when it&#39;s<br>
&gt; not present. Any objections against requiring SSL_OP_NO_TICKET to<br>
&gt; be present for OpenVPN 2.4+? We have to drop support for &#39;ancient<=
br>
&gt; stuff&#39; at some point.<br>
<br>
</div>If I understood this all right, this feature improves OpenVPN securit=
y<br>
against yet-unknown attacks using a feature of OpenSSL that we don&#39;t<br>
use anyway. =A0Right?<br></blockquote><div><br></div><div>Right. <br><br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">
So in that case, I&#39;m fine with your proposal - do something on <a href=
=3D"http://configure.ac" target=3D"_blank">configure.ac</a><br>
that will check for SSL_OP_NO_TICKET and complain (with a useful error<br>
message :) ) if it&#39;s not there.<br>
<br>
For 2.3, I&#39;d propose to add code to ssl_openssl.h like this:<br>
<br>
/* SSL_OP_NO_TICKET tells OpenSSL to disable &quot;stateless session resump=
tion&quot;,<br>
=A0* as this is something we do not want nor need, but could potentially be=
<br>
=A0* used for a future attack. =A0For compatibility reasons, in the 2.3.x<b=
r>
=A0* series, we keep building if the OpenSSL version is too old to support<=
br>
=A0* this. =A02.4 requires it and will fail configure if not present.<br>
=A0*/<br>
#ifndef SSL_OP_NO_TICKET<br>
# define SSL_OP_NO_TICKET 0<br>
#endif<br>
<br>
<br>
ACK? =A0Is the message correct?<br></blockquote><div><br></div><div>ACK. Me=
ssage looks correct and clear to me (but please remove the double space bef=
ore 2.4).<br></div><br></div><div class=3D"gmail_quote">-Steffan<br></div>

</div></div></div>

--089e0163464e5362f704f542ab2b--


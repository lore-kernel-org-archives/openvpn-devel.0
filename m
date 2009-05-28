MIME-Version: 1.0
Sender: fyellin@...277...
In-Reply-To: <20090528055401.GB24851@...1066...>
References: <f9615cc80905271048v646f546fod19ecec32c2a172a@...278...>
	<20090528055401.GB24851@...1066...>
Date: Wed, 27 May 2009 23:17:39 -0700
Message-ID: <f9615cc80905272317pa53b833vbe66477de31537b9@...278...>
From: Frank Yellin <fy@...1222...>
Content-Type: multipart/alternative; boundary=001636283644b5d60d046af2ea12
Subject: Re: [Openvpn-devel] Unable to use -OFB or -CFB ciphers in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--001636283644b5d60d046af2ea12
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

[Just to you, not the list.]

I figured that someone had to have noticed this problem before.  But when I
googled "OpenVPN BF-OFB"  or  "OpenVPN BF-CFB", I couldn't find anything.

This bug is particularly strange because just before the bug, there is code
that's supposed to deal with -CFB and -OFB mode.  But then it doesn't do
anything.  It almost feels like this code was never tested.

I didn't have any trouble with my brief tests using BF-CFB over UDP, once I
deleted the offending line.  But I wasn't trying anything difficult.  Mainly
just making sure the connection was there and that it didn't die.



On Wed, May 27, 2009 at 10:54 PM, Victor Wagner <vitus@...1066...> wrote:

> On 2009.05.27 at 10:48:30 -0700, Frank Yellin wrote:
>
> >    I posted the following onto the OpenVPN forum, but it was suggested
> >    that I would be better off mailing directly to this list.
> >    =========================
> >    I seem to have found a bug in 2.1_rc16 that is also apparent in
> earlier
> >    versions. Although OpenVPN claims to support -CFB and -OFB cipher
> >    modes, using them seems to cause OpenVPN to crash consistently.
> >
> >    For example, when I run the simple TLS example on the 2.1
> documentation
> >    page, it works fine.  But if I add "--cipher bf-cfb" to both the
> client
> >    and server command lines, one or the other will crash. The error
> >    message is always "Assertion failed at crypto.c:162". The crasher is
> >    always the first one to try and send an encrypted message.
>
> I've reported this problem more than a year ago, but nothing changed.
> I really don't understand why openvpn prefers CBC modes. There is
> nothing wrong with CFB and OFB neither from securith nor from
> performance point of view.
>
> But it is not only problem with non-CBC ciphers. If you try to use
> preshared keys, you'll find out that they are explicitely disabled
> unless --test-crypto option is given, even if your compile with
> -DALLOW_NON_CBC_CIPHERS.
>
> Also, I've encountered some problems with UDP transport and stream
> ciphers which I haven't find time to debug yet.
>
>
>
>
>
> ------------------------------------------------------------------------------
> Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
> is a gathering of tech-side developers & brand creativity professionals.
> Meet
> the minds behind Google Creative Lab, Visual Complexity, Processing, &
> iPhoneDevCamp as they present alongside digital heavyweights like Barbarian
> Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--001636283644b5d60d046af2ea12
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

[Just to you, not the list.]<br><br>I figured that someone had to have noti=
ced this problem before.=A0 But when I googled &quot;OpenVPN BF-OFB&quot;=
=A0 or=A0 &quot;OpenVPN BF-CFB&quot;, I couldn&#39;t find anything.<br><br>=
This bug is particularly strange because just before the bug, there is code=
 that&#39;s supposed to deal with -CFB and -OFB mode.=A0 But then it doesn&=
#39;t do anything.=A0 It almost feels like this code was never tested.<br>
<br>I didn&#39;t have any trouble with my brief tests using BF-CFB over UDP=
, once I deleted the offending line.=A0 But I wasn&#39;t trying anything di=
fficult.=A0 Mainly just making sure the connection was there and that it di=
dn&#39;t die.<br>
<br><br><br><div class=3D"gmail_quote">On Wed, May 27, 2009 at 10:54 PM, Vi=
ctor Wagner <span dir=3D"ltr">&lt;<a href=3D"mailto:vitus@...1066...">vitus=
@...1066...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; =
padding-left: 1ex;">
<div class=3D"im">On 2009.05.27 at 10:48:30 -0700, Frank Yellin wrote:<br>
<br>
&gt; =A0 =A0I posted the following onto the OpenVPN forum, but it was sugge=
sted<br>
&gt; =A0 =A0that I would be better off mailing directly to this list.<br>
&gt; =A0 =A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<br>
&gt; =A0 =A0I seem to have found a bug in 2.1_rc16 that is also apparent in=
 earlier<br>
&gt; =A0 =A0versions. Although OpenVPN claims to support -CFB and -OFB ciph=
er<br>
&gt; =A0 =A0modes, using them seems to cause OpenVPN to crash consistently.=
<br>
&gt;<br>
&gt; =A0 =A0For example, when I run the simple TLS example on the 2.1 docum=
entation<br>
&gt; =A0 =A0page, it works fine. =A0But if I add &quot;--cipher bf-cfb&quot=
; to both the client<br>
&gt; =A0 =A0and server command lines, one or the other will crash. The erro=
r<br>
&gt; =A0 =A0message is always &quot;Assertion failed at crypto.c:162&quot;.=
 The crasher is<br>
&gt; =A0 =A0always the first one to try and send an encrypted message.<br>
<br>
</div>I&#39;ve reported this problem more than a year ago, but nothing chan=
ged.<br>
I really don&#39;t understand why openvpn prefers CBC modes. There is<br>
nothing wrong with CFB and OFB neither from securith nor from<br>
performance point of view.<br>
<br>
But it is not only problem with non-CBC ciphers. If you try to use<br>
preshared keys, you&#39;ll find out that they are explicitely disabled<br>
unless --test-crypto option is given, even if your compile with<br>
-DALLOW_NON_CBC_CIPHERS.<br>
<br>
Also, I&#39;ve encountered some problems with UDP transport and stream<br>
ciphers which I haven&#39;t find time to debug yet.<br>
<br>
<br>
<br>
<br>
---------------------------------------------------------------------------=
---<br>
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT<br>
is a gathering of tech-side developers &amp; brand creativity professionals=
. Meet<br>
the minds behind Google Creative Lab, Visual Complexity, Processing, &amp;<=
br>
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian=
<br>
Group, R/GA, &amp; Big Spaceship. <a href=3D"http://p.sf.net/sfu/creativity=
cat-com" target=3D"_blank">http://p.sf.net/sfu/creativitycat-com</a><br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" targ=
et=3D"_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a=
><br>
</blockquote></div><br>

--001636283644b5d60d046af2ea12--


MIME-Version: 1.0
References: <6c0e8ca1-9518-1bc0-65cb-f742311ef08f@...1227...>
 <f52172ec20da430975373e7192380874bc600062.camel@...2316...>
 <43485320-4957-8ac1-7bab-4e769000d156@...1227...>
 <234ef71a00e43f74bda0836d66c63a3d8c54a74c.camel@...2316...>
 <af0497ca-b862-6a5c-f5ff-eb0d34a84692@...1227...>
 <0456a9e2e317af58f1aa6947c768ac7853c06485.camel@...2316...>
 <334bc5ad-1d55-208b-bbaf-2233c4708d9f@...1227...>
 <f24287289b084285b67fc1a7fb26714fec3f0bbc.camel@...2316...>
 <79a79fe0-978b-020d-83f2-026299e7337e@...1227...>
In-Reply-To: <79a79fe0-978b-020d-83f2-026299e7337e@...1227...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 15 Jan 2023 22:07:21 +0600
Message-ID: <CAFHpkQH-XCkzoY70AMQvZSeC9LVfrabnu6nSKmthq_-cxUw=Dg@...278...>
Content-Type: multipart/alternative; boundary="0000000000000ac86305f24faa9a"
Subject: Re: [Openvpn-devel] Amend OpenVPN license to allow continued mbed
 TLS support (allow mbed TLS 3.x linking)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: James Bottomley <James.Bottomley@...2317...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--0000000000000ac86305f24faa9a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

just curious, is linking against LibreSSL allowed ? os x Tunnelblick is
shipped with both LibreSSL and OpenSSL builds, but neither of them is
"system" lib as far as I know.

=D0=B2=D1=81, 15 =D1=8F=D0=BD=D0=B2. 2023 =D0=B3. =D0=B2 21:35, Arne Schwab=
e <arne@...1227...>:

> Am 15.01.23 um 16:22 schrieb James Bottomley:
> > On Sun, 2023-01-15 at 15:22 +0100, Arne Schwabe wrote:
> >>
> >>> If that's the source of this issue, then I think there's a
> >>> misunderstanding about the problem the OpenSSL exception is
> >>> addressing. The problem was that the OpenSSL licence required
> >>> additional conditions be imposed on the binary as a whole, even
> >>> though openssl itself was a system library.
> >>>
> >>> https://spdx.org/licenses/OpenSSL.html
> >>>
> >>> Specifically the advertising and redistribution clauses.  The
> >>> OpenSSL exception is to make GPLv2 compatible with the OpenSSL
> >>> licence's additional restrictions, not the other way around.  There
> >>> is still a considerable body of opinion that thinks the system
> >>> exception covers this case as well, but just in case, people added
> >>> the OpenSSL compatibility exception to GPLv2.
> >>>
> >>> The goal of changing OpenSSL to Apache-2 was to remove those
> >>> additional restrictions and make the library behave like a normal
> >>> linked library from a licensing point of view.  The Apache-2
> >>> licence imposes no additional restrictions on the binary as a
> >>> whole, which is why no exception is necessary.  Specifically the
> >>> patent retaliation and indemnity clauses which some people think
> >>> cause the cut and paste incompatibility don't apply to the binary
> >>> as a whole, only to the Apache2 pieces.
> >>
> >>
> >> Yes. That is my understanding as well. But I think where we have been
> >> told
> >
> > Who told you?  Because I'd like to tackle this misinformation at source
> > before it spreads further than openvpn.
> >
> >>   and see the problem different is that the GPL2 covers the whole
> >> binary and also the Apache2 licensed parts.
> >
> > It does under section 2 for any component that can't be classified as a
> > system library, yes.  But the system library exception is the way you
> > avoid this for linking with most libraries.
>
> So we have the same interpretation and just disagree if mbed TLS and
> OpenSSL can be seen as system library on non-Linux/non-BSD systems.
>
> >>   And then the restrictions become a problem.
> >
> > Only if the library you're linking with isn't a system library, which I
> > think we can all agree in not the case on every Linux distribution
> > because they all ship both openssl and mbedtls as part of the
> > distribution.
> >
> >>   So you are right in the sense that the Apache2 is just
> >> a normal library to link for most purposes, the GPL licenses are
> >> special in the way that they want to cover the whole source
> >> code/binary. Sometimes this feature of the GPL is called viral by
> >> opponents of the license.
> >
> > Not for system libraries ... that's what the system library exception
> > is all about.
>
> Yes but neither mbed TLS nor OpenSSL is a system library on Windows or
> macOS. And even mbed TLS is sketchy as many distributions do not have in
> their base system. So just assume, at least for the sake of argument
> that they are not. In that case I think we need this exception. So I am
> asking if you are willing to allow this exception to the license even
> though you think it is unnecessary to make the people that think that it
> is needed happy?
>
> Arne
>
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--0000000000000ac86305f24faa9a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">just curious, is linking against LibreSSL allowed ? os x T=
unnelblick is shipped with both LibreSSL and OpenSSL builds, but neither of=
 them is &quot;system&quot; lib as far as=C2=A0I know.</div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D0=B2=D1=81, 15 =D1=
=8F=D0=BD=D0=B2. 2023 =D0=B3. =D0=B2 21:35, Arne Schwabe &lt;<a href=3D"mai=
lto:arne@...1227...">arne@...1227...</a>&gt;:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">Am 15.01.23 um 16:22 schrieb James Bottomley:=
<br>
&gt; On Sun, 2023-01-15 at 15:22 +0100, Arne Schwabe wrote:<br>
&gt;&gt;<br>
&gt;&gt;&gt; If that&#39;s the source of this issue, then I think there&#39=
;s a<br>
&gt;&gt;&gt; misunderstanding about the problem the OpenSSL exception is<br>
&gt;&gt;&gt; addressing. The problem was that the OpenSSL licence required<=
br>
&gt;&gt;&gt; additional conditions be imposed on the binary as a whole, eve=
n<br>
&gt;&gt;&gt; though openssl itself was a system library.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; <a href=3D"https://spdx.org/licenses/OpenSSL.html" rel=3D"nore=
ferrer" target=3D"_blank">https://spdx.org/licenses/OpenSSL.html</a><br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Specifically the advertising and redistribution clauses.=C2=A0=
 The<br>
&gt;&gt;&gt; OpenSSL exception is to make GPLv2 compatible with the OpenSSL=
<br>
&gt;&gt;&gt; licence&#39;s additional restrictions, not the other way aroun=
d.=C2=A0 There<br>
&gt;&gt;&gt; is still a considerable body of opinion that thinks the system=
<br>
&gt;&gt;&gt; exception covers this case as well, but just in case, people a=
dded<br>
&gt;&gt;&gt; the OpenSSL compatibility exception to GPLv2.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The goal of changing OpenSSL to Apache-2 was to remove those<b=
r>
&gt;&gt;&gt; additional restrictions and make the library behave like a nor=
mal<br>
&gt;&gt;&gt; linked library from a licensing point of view.=C2=A0 The Apach=
e-2<br>
&gt;&gt;&gt; licence imposes no additional restrictions on the binary as a<=
br>
&gt;&gt;&gt; whole, which is why no exception is necessary.=C2=A0 Specifica=
lly the<br>
&gt;&gt;&gt; patent retaliation and indemnity clauses which some people thi=
nk<br>
&gt;&gt;&gt; cause the cut and paste incompatibility don&#39;t apply to the=
 binary<br>
&gt;&gt;&gt; as a whole, only to the Apache2 pieces.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Yes. That is my understanding as well. But I think where we have b=
een<br>
&gt;&gt; told<br>
&gt; <br>
&gt; Who told you?=C2=A0 Because I&#39;d like to tackle this misinformation=
 at source<br>
&gt; before it spreads further than openvpn.<br>
&gt; <br>
&gt;&gt;=C2=A0 =C2=A0and see the problem different is that the GPL2 covers =
the whole<br>
&gt;&gt; binary and also the Apache2 licensed parts.<br>
&gt; <br>
&gt; It does under section 2 for any component that can&#39;t be classified=
 as a<br>
&gt; system library, yes.=C2=A0 But the system library exception is the way=
 you<br>
&gt; avoid this for linking with most libraries.<br>
<br>
So we have the same interpretation and just disagree if mbed TLS and <br>
OpenSSL can be seen as system library on non-Linux/non-BSD systems.<br>
<br>
&gt;&gt;=C2=A0 =C2=A0And then the restrictions become a problem.<br>
&gt; <br>
&gt; Only if the library you&#39;re linking with isn&#39;t a system library=
, which I<br>
&gt; think we can all agree in not the case on every Linux distribution<br>
&gt; because they all ship both openssl and mbedtls as part of the<br>
&gt; distribution.<br>
&gt; <br>
&gt;&gt;=C2=A0 =C2=A0So you are right in the sense that the Apache2 is just=
<br>
&gt;&gt; a normal library to link for most purposes, the GPL licenses are<b=
r>
&gt;&gt; special in the way that they want to cover the whole source<br>
&gt;&gt; code/binary. Sometimes this feature of the GPL is called viral by<=
br>
&gt;&gt; opponents of the license.<br>
&gt; <br>
&gt; Not for system libraries ... that&#39;s what the system library except=
ion<br>
&gt; is all about.<br>
<br>
Yes but neither mbed TLS nor OpenSSL is a system library on Windows or <br>
macOS. And even mbed TLS is sketchy as many distributions do not have in <b=
r>
their base system. So just assume, at least for the sake of argument <br>
that they are not. In that case I think we need this exception. So I am <br>
asking if you are willing to allow this exception to the license even <br>
though you think it is unnecessary to make the people that think that it <b=
r>
is needed happy?<br>
<br>
Arne<br>
<br>
<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div>

--0000000000000ac86305f24faa9a--


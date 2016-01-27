MIME-Version: 1.0
In-Reply-To: <20160127134656.GZ24952@...1296...>
References: <2215306.x9ci9DhAZ9@...2001...>
	<1453835508-26119-1-git-send-email-gert@...1296...>
	<20160126191913.GV24952@...1296...>
	<56A7D1F6.8030805@...515...>
	<20160126212431.GW24952@...1296...>
	<CAKuzo_jKX6+KAw3cfPR-VTGe1A_bMh=R93i+4p=eC4BbCqWtAg@...278...>
	<56A87C5A.3050104@...515...>
	<20160127082046.GY24952@...1296...>
	<CAPTYJtuHGBZ2UvQKsX3wKyxpACj0Xh-Xbn1u6qzE0XdP3Waqsw@...278...>
	<20160127134656.GZ24952@...1296...>
Date: Wed, 27 Jan 2016 22:07:43 +0800
Message-ID: <CAPTYJttJ0Z+c0zGcm4g1hRwp1w02SL2W-nFqHgUHyudYf0SuYg@...278...>
From: Daniel Sim <daniel.ssq89@...277...>
Content-Type: multipart/alternative; boundary=089e0153686e60a4bc052a5153f4
Subject: Re: [Openvpn-devel] [PATCH v3] interactive service v3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--089e0153686e60a4bc052a5153f4
Content-Type: text/plain; charset=UTF-8

(forgot to CC the mailing list earlier)

>
> In case we stay with openvpnserv2, I think some followup questions
> need to be asked...
>
>  - do we want to migrate "interactive service" functionality into
>    openvpnserv2 as well?  More code, but not overly complex stuff
>    (if the network/route API in C# isn't totally different from C) -
>    and all the arguments from above apply to the interactive service
>    as well, of course
>

Interesting question that warrants more discussion. Other implementations
(NSSM, Openvpnwinserv) implement this by creating multiple services.
Personally I prefer a single service managing multiple instances (in the
style of IIS, Windows file sharing, etc.). Firstly, backward compatibility.
Secondly, services should only be interactive when something exceptional
happens.

But to implement anything of that sort, the question is how we could
implement interprocess communication? Do we watch registry values? Open
some port? Security issues?


>
>  - should "the service(s)" live inside the main openvpn repo, in the
>    GUI repo, in their own repo, ...?
>

Definitely main repo. But I'm not in a position to decide.

>
>  - what code change rules apply?  I tend to opt for "openvpn main repo"
>    rules, that is, no change goes in without review & ACK - a bad or
>    malicious commit to the service could compromise the system security
>    about as badly as a bad commit inside openvpn.  I am aware that this
>    is a totally annoying process, especially if the code author has to
>    wait for months for an ACK to a trivial change - but hopefully a
>    somewhat larger active developer base can improve on this.
>
>

--089e0153686e60a4bc052a5153f4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">(forgot to CC the mailing list earlier)<br><div class=3D"g=
mail_extra"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span=
 class=3D""><br>
</span>In case we stay with openvpnserv2, I think some followup questions<b=
r>
need to be asked...<br>
<br>
=C2=A0- do we want to migrate &quot;interactive service&quot; functionality=
 into<br>
=C2=A0 =C2=A0openvpnserv2 as well?=C2=A0 More code, but not overly complex =
stuff<br>
=C2=A0 =C2=A0(if the network/route API in C# isn&#39;t totally different fr=
om C) -<br>
=C2=A0 =C2=A0and all the arguments from above apply to the interactive serv=
ice<br>
=C2=A0 =C2=A0as well, of course<br></blockquote><div><br></div><div>Interes=
ting question that warrants more discussion. Other implementations (NSSM, O=
penvpnwinserv) implement this by creating multiple services. Personally I p=
refer a single service managing multiple instances (in the style of IIS, Wi=
ndows file sharing, etc.). Firstly, backward compatibility. Secondly, servi=
ces should only be interactive when something exceptional happens.</div><di=
v><br></div><div>But to implement anything of that sort, the question is ho=
w we could implement interprocess communication? Do we watch registry value=
s? Open some port? Security issues?</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<br>
=C2=A0- should &quot;the service(s)&quot; live inside the main openvpn repo=
, in the<br>
=C2=A0 =C2=A0GUI repo, in their own repo, ...?<br></blockquote><div><br></d=
iv><div>Definitely main repo. But I&#39;m not in a position to decide.</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">
<br>
=C2=A0- what code change rules apply?=C2=A0 I tend to opt for &quot;openvpn=
 main repo&quot;<br>
=C2=A0 =C2=A0rules, that is, no change goes in without review &amp; ACK - a=
 bad or<br>
=C2=A0 =C2=A0malicious commit to the service could compromise the system se=
curity<br>
=C2=A0 =C2=A0about as badly as a bad commit inside openvpn.=C2=A0 I am awar=
e that this<br>
=C2=A0 =C2=A0is a totally annoying process, especially if the code author h=
as to<br>
=C2=A0 =C2=A0wait for months for an ACK to a trivial change - but hopefully=
 a<br>
=C2=A0 =C2=A0somewhat larger active developer base can improve on this.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br></div></div></blockquote><div>=
=C2=A0</div></div></div></div>

--089e0153686e60a4bc052a5153f4--


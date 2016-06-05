MIME-Version: 1.0
In-Reply-To: <CAA1AbxLTqKF-Bqz1zg4kC3=-SUP3FMQqxXLuy=-CnAspiFQiyw@...278...>
References: <CAFHpkQHNu9qOVeQjco9ywL1iFUZqCjU5-LFt8PsYra1usyjkVA@...278...>
	<938A4CDB-D912-421E-8059-4B40E0CD0791@...2127...>
	<CAA1AbxLTqKF-Bqz1zg4kC3=-SUP3FMQqxXLuy=-CnAspiFQiyw@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 5 Jun 2016 12:38:04 +0500
Message-ID: <CAFHpkQERQvsLsU23C+rZ3Kpxc8+VTv5j1i-n=BkzSOroPKTvtA@...278...>
Content-Type: multipart/alternative; boundary=047d7bb04ae85371c505348309ef
Subject: Re: [Openvpn-devel] travis-ci (smoke testing)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7bb04ae85371c505348309ef
Content-Type: text/plain; charset=UTF-8

it is because of SNI

2016-06-05 12:25 GMT+05:00 Steffan Karger <steffan@...1856...>:

> On Sun, Jun 5, 2016 at 2:16 AM, Jens Neuhalfen
> <openvpn-devel@...2127...> wrote:
> >> (unfortunately, ssl cert at mbed tls website was expired and Xcode7.3
> does
> >> not compile openvpn with openssl)
> >
> > Very strange, the cert is valid till 2017.
>
> There seems to be some load balancing / CDN going om at mbed.org.  My
> browser also gets a cert that's valid till 2017, but openssl s_client
> -connect tls.mbed.org:443 gives me a cert that's valid till Oct 2016.
> I guess the XCode 6.4 travis setup uses some permutation of the ssl
> connection manages to trigger receiving an expired certificate.  I'll
> notify the mbed people.
>
> -Steffan
>

--047d7bb04ae85371c505348309ef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">it is because of SNI<br></div><div class=3D"gmail_extra"><=
br><div class=3D"gmail_quote">2016-06-05 12:25 GMT+05:00 Steffan Karger <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:steffan@...1856..." target=3D"_blank">=
steffan@...1856...</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span =
class=3D"">On Sun, Jun 5, 2016 at 2:16 AM, Jens Neuhalfen<br>
&lt;<a href=3D"mailto:openvpn-devel@...2127...">openvpn-devel@...2127...</a=
>&gt; wrote:<br>
&gt;&gt; (unfortunately, ssl cert at mbed tls website was expired and Xcode=
7.3 does<br>
&gt;&gt; not compile openvpn with openssl)<br>
&gt;<br>
&gt; Very strange, the cert is valid till 2017.<br>
<br>
</span>There seems to be some load balancing / CDN going om at <a href=3D"h=
ttp://mbed.org" rel=3D"noreferrer" target=3D"_blank">mbed.org</a>.=C2=A0 My=
<br>
browser also gets a cert that&#39;s valid till 2017, but openssl s_client<b=
r>
-connect <a href=3D"http://tls.mbed.org:443" rel=3D"noreferrer" target=3D"_=
blank">tls.mbed.org:443</a> gives me a cert that&#39;s valid till Oct 2016.=
<br>
I guess the XCode 6.4 travis setup uses some permutation of the ssl<br>
connection manages to trigger receiving an expired certificate.=C2=A0 I&#39=
;ll<br>
notify the mbed people.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
-Steffan<br>
</font></span></blockquote></div><br></div>

--047d7bb04ae85371c505348309ef--


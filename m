MIME-Version: 1.0
In-Reply-To: <8e0f7ca4-a790-2143-ccfa-8e6ab6114955@...277...>
References: <10719981480674741@...2206...>
	<8e0f7ca4-a790-2143-ccfa-8e6ab6114955@...277...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 2 Dec 2016 19:20:06 +0500
Message-ID: <CAFHpkQEoamLFfEHrEiJkqZTr7X11SX6LY9JrWG0q-cuSR_NjhQ@...278...>
Content-Type: multipart/alternative; boundary=089e0102e3da8b37cb0542ada2b4
Subject: Re: [Openvpn-devel] Enable FIPS encryption
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--089e0102e3da8b37cb0542ada2b4
Content-Type: text/plain; charset=UTF-8

2016-12-02 17:55 GMT+05:00 debbie10t <debbie10t@...277...>:

> Hi,
>
> On 02/12/16 10:32, boxartst@...1411... wrote:
> > Hi!
> >
> > I would like to know if it's possible to enable fips  enabled encryption
> on my vpn server?
> > Here is a link to fips user guide https://www.openssl.org/docs/
> fips/UserGuide-2.0.pdf .
> > It looks like I'd have to change source code and compile it myself to
> make it FIPS compliant.
> > Any help or advice would be very much appreciated.
> >
>
> Without very much effort it is possible to build openvpn with openssl
> FIPS support on CentOS7:
>
> OpenVPN 2.4_beta2 [git:master/1c587a1112220618+]
> x86_64-unknown-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL]
> [MH/PKTINFO] [AEAD] built on Dec  1 2016
> library versions: OpenSSL 1.0.1e-fips 11 Feb 2013, LZO 2.06
>
> OpenSSL 1.0.1e-fips appears to be the default openssl developer library
> in CentOS7.
>
> I do not know enough about FIPS certification to advise if *only* this
> change is sufficient to cover you for real world certification.
>

since we build openssl ourselves in travis-ci, should we add "openssl fips"
to travis-ci build matrix ?

I guess "just build" is not proper testing.
and, as already said here, at least MD5 will become unavailable in fips mode


>
> Regards
>
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--089e0102e3da8b37cb0542ada2b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-12-02 17:55 GMT+05:00 debbie10t <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:debbie10t@...277..." target=3D"_blank">debbie10t@...277...</a>&gt;</s=
pan>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On 02/12/16 10:32, <a href=3D"mailto:boxartst@...1411...">boxartst@...2207...=
..</a> wrote:<br>
&gt; Hi!<br>
&gt;<br>
&gt; I would like to know if it&#39;s possible to enable fips=C2=A0 enabled=
 encryption on my vpn server?<br>
&gt; Here is a link to fips user guide <a href=3D"https://www.openssl.org/d=
ocs/fips/UserGuide-2.0.pdf" rel=3D"noreferrer" target=3D"_blank">https://ww=
w.openssl.org/docs/<wbr>fips/UserGuide-2.0.pdf</a> .<br>
&gt; It looks like I&#39;d have to change source code and compile it myself=
 to make it FIPS compliant.<br>
&gt; Any help or advice would be very much appreciated.<br>
&gt;<br>
<br>
</span>Without very much effort it is possible to build openvpn with openss=
l<br>
FIPS support on CentOS7:<br>
<br>
OpenVPN 2.4_beta2 [git:master/1c587a1112220618+]<br>
x86_64-unknown-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL]<br>
[MH/PKTINFO] [AEAD] built on Dec=C2=A0 1 2016<br>
library versions: OpenSSL 1.0.1e-fips 11 Feb 2013, LZO 2.06<br>
<br>
OpenSSL 1.0.1e-fips appears to be the default openssl developer library<br>
in CentOS7.<br>
<br>
I do not know enough about FIPS certification to advise if *only* this<br>
change is sufficient to cover you for real world certification.<br></blockq=
uote><div><br></div><div>since we build openssl ourselves in travis-ci, sho=
uld we add &quot;openssl fips&quot; to travis-ci build matrix ?<br><br></di=
v><div>I guess &quot;just build&quot; is not proper testing.<br></div><div>=
and, as already said here, at least MD5 will become unavailable in fips mod=
e<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Regards<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, SlashDot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</blockquote></div><br></div></div>

--089e0102e3da8b37cb0542ada2b4--


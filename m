MIME-Version: 1.0
In-Reply-To: <20150730114818.GE382@...1296...>
References: <CALKXstsZLjqxCrzo3E-qGiyhJo3yi9bW1Jf2bKGYphkB+4b0Qg@...278...>
	<CALKXsttsrkPxgrT1A+gpRh5WoxTxw6djkBQJh7BjKTSk5itDig@...278...>
	<20150730114818.GE382@...1296...>
Date: Thu, 30 Jul 2015 22:34:03 +0530
Message-ID: <CALKXstt-DBKbwiaheOWCTmFgeTYMok13TnrHnZMyzaUP26H4PA@...278...>
From: Rahul Arora <rahul1991.arora@...277...>
Content-Type: multipart/alternative; boundary=001a113495b2b8294d051c1ab0c4
Subject: Re: [Openvpn-devel] Openvpn is not working with hardware encryption
 enabled CPU.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--001a113495b2b8294d051c1ab0c4
Content-Type: text/plain; charset=UTF-8

Hi

Thanks for the reply.

I am already using "--engine cryptodev" in the configuration file.

I am using "aes-128-cbc"  cipher algorithm and it is supported in my
hardware as i am running "openssl speed test" using these ciphers only and
in case of "openssl speed test" throughput is increasing but with openvpn
it is not so.




On Thu, Jul 30, 2015 at 5:18 PM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Thu, Jul 30, 2015 at 12:55:00PM +0530, Rahul Arora wrote:
> > *Openvpn --version*
> > OpenVPN 2.1.3 arm-fsl-linux-gnueabi [SSL] [LZO2] [EPOLL] built on Jul 29
> > 2015
>
> This is, uh, ancient.  2.3.7 is the current stable release.
>
> (It might or might not related, but we're certainly not going back to 2.2
> or even 2.1 releases to debug anything.  OpenVPN *should* use the crypto
> accelerator just fine, if OpenSSL can use it - if you need to use an
> OpenSSL engine, tell OpenVPN with "--engine yourengine".  It might not
> make an overwhelming difference in speed if you use the wrong crypto
> algorithms - like, your hardware accelerates 3DES and you use
> --cipher blowfish...)
>
> gert
>
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //
> www.muc.de/~gert/
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025
> gert@...1297...
>

--001a113495b2b8294d051c1ab0c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi<br><br></div>Thanks for the reply.<br><b=
r></div>I am already using &quot;--engine cryptodev&quot; in the configurat=
ion file.<br><br></div><div>I am using &quot;aes-128-cbc&quot;=C2=A0 cipher=
 algorithm and it is supported in my hardware as i am running &quot;openssl=
 speed test&quot; using these ciphers only and in case of &quot;openssl spe=
ed test&quot; throughput is increasing but with openvpn it is not so.<br></=
div><div><br><br>=C2=A0<br></div></div><div class=3D"gmail_extra"><br><div =
class=3D"gmail_quote">On Thu, Jul 30, 2015 at 5:18 PM, Gert Doering <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1186...=
.1296...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
On Thu, Jul 30, 2015 at 12:55:00PM +0530, Rahul Arora wrote:<br>
&gt; *Openvpn --version*<br>
<span class=3D"">&gt; OpenVPN 2.1.3 arm-fsl-linux-gnueabi [SSL] [LZO2] [EPO=
LL] built on Jul 29<br>
&gt; 2015<br>
<br>
</span>This is, uh, ancient.=C2=A0 2.3.7 is the current stable release.<br>
<br>
(It might or might not related, but we&#39;re certainly not going back to 2=
.2<br>
or even 2.1 releases to debug anything.=C2=A0 OpenVPN *should* use the cryp=
to<br>
accelerator just fine, if OpenSSL can use it - if you need to use an<br>
OpenSSL engine, tell OpenVPN with &quot;--engine yourengine&quot;.=C2=A0 It=
 might not<br>
make an overwhelming difference in speed if you use the wrong crypto<br>
algorithms - like, your hardware accelerates 3DES and you use<br>
--cipher blowfish...)<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
gert<br>
<br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//<a href=3D"=
http://www.muc.de/~gert/" rel=3D"noreferrer" target=3D"_blank">www.muc.de/~=
gert/</a><br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296...">gert@...1296...</a><br>
fax: +49-89-35655025=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:gert@...1297...">gert@...1826...=
7...</a><br>
</font></span></blockquote></div><br></div>

--001a113495b2b8294d051c1ab0c4--


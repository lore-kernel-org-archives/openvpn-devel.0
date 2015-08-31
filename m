MIME-Version: 1.0
In-Reply-To: <CABgPX1maNQDV9XzTi8E8NCYSPPvAXgX2=-mza7j=1tQTUgEcXw@...278...>
References: <CABgPX1maNQDV9XzTi8E8NCYSPPvAXgX2=-mza7j=1tQTUgEcXw@...278...>
Date: Mon, 31 Aug 2015 13:45:33 +0300
Message-ID: <CADxRZqzSMJ366XGkjrKOq4oezb1K9T=zCryTNLj1ctS6uRajww@...278...>
From: Anatoly Pugachev <matorola@...277...>
Content-Type: multipart/alternative; boundary=089e0160bd2608c217051e992241
Subject: Re: [Openvpn-devel] Disable TLS for mode server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--089e0160bd2608c217051e992241
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

can you try with GRE tunneling ?

as simple as http://lartc.org/howto/lartc.tunnel.gre.html

On Mon, Aug 31, 2015 at 12:46 PM, Valentin Sawadski <valentin@...2062...>
wrote:

> Hello,
>
> I'm looking for a way to remove any encryption or MAC from OpenVPN in
> "--mode server".
>
> Since I'm new to the OpenVPN code base my starting point right now
> will be patching "options.c" to allow "--mode server" without TLS.
> Will this already be enough to make it work or is TLS tightly
> integrated into the workings of the mode?
>
> Thanks for any pointers!
>
> Best Regards,
> Valentin
>
> P.S. I know it is an odd request to remove the security of TLS but we
> want to run a few experiments where the TLS overhead would bias our
> results.
>
> --
> Valentin Sawadski
> Founder & Embedded Software
>
> Tel.: +49 - (0) 89 - 716 77 86 - 15
> Fax: +49 - (0) 89 - 716 77 86 - 99
> Mobil: +49 - (0) 162 - 460 163 4
>
> facebook.com/tado | twitter.com/tado | youtube.com/tado
> www.tado.com | tado=C2=B0 GmbH | Lindwurmstr. 76 | 80337 Munich | Germany
> Managing Directors: Christian Deilmann | Johannes Schwarz | Leopold v.
> Bismarck
> Registered with the Commercial Register Munich as HRB 194769 B |
> VAT-No: DE 280012558
>
>
> -------------------------------------------------------------------------=
-----
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--089e0160bd2608c217051e992241
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif">can you try with GRE tunneling ?<br><br></div><div class=3D"gma=
il_default" style=3D"font-family:verdana,sans-serif">as simple as <a href=
=3D"http://lartc.org/howto/lartc.tunnel.gre.html">http://lartc.org/howto/la=
rtc.tunnel.gre.html</a><br></div></div><div class=3D"gmail_extra"><br><div =
class=3D"gmail_quote">On Mon, Aug 31, 2015 at 12:46 PM, Valentin Sawadski <=
span dir=3D"ltr">&lt;<a href=3D"mailto:valentin@...2062..." target=3D"_blan=
k">valentin@...2062...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">Hello,<br>
<br>
I&#39;m looking for a way to remove any encryption or MAC from OpenVPN in<b=
r>
&quot;--mode server&quot;.<br>
<br>
Since I&#39;m new to the OpenVPN code base my starting point right now<br>
will be patching &quot;options.c&quot; to allow &quot;--mode server&quot; w=
ithout TLS.<br>
Will this already be enough to make it work or is TLS tightly<br>
integrated into the workings of the mode?<br>
<br>
Thanks for any pointers!<br>
<br>
Best Regards,<br>
Valentin<br>
<br>
P.S. I know it is an odd request to remove the security of TLS but we<br>
want to run a few experiments where the TLS overhead would bias our<br>
results.<br>
<br>
--<br>
Valentin Sawadski<br>
Founder &amp; Embedded Software<br>
<br>
Tel.: +49 - (0) 89 - 716 77 86 - 15<br>
Fax: +49 - (0) 89 - 716 77 86 - 99<br>
Mobil: +49 - (0) 162 - 460 163 4<br>
<br>
<a href=3D"http://facebook.com/tado" rel=3D"noreferrer" target=3D"_blank">f=
acebook.com/tado</a> | <a href=3D"http://twitter.com/tado" rel=3D"noreferre=
r" target=3D"_blank">twitter.com/tado</a> | <a href=3D"http://youtube.com/t=
ado" rel=3D"noreferrer" target=3D"_blank">youtube.com/tado</a><br>
<a href=3D"http://www.tado.com" rel=3D"noreferrer" target=3D"_blank">www.ta=
do.com</a> | tado=C2=B0 GmbH | Lindwurmstr. 76 | 80337 Munich | Germany<br>
Managing Directors: Christian Deilmann | Johannes Schwarz | Leopold v. Bism=
arck<br>
Registered with the Commercial Register Munich as HRB 194769 B |<br>
VAT-No: DE 280012558<br>
<br>
---------------------------------------------------------------------------=
---<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div><br></div>

--089e0160bd2608c217051e992241--


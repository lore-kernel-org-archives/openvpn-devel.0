In-Reply-To: <CAN_jwOsZ52oxbv9tRxMbSN3Edbr6adUeWOn0V7D-iaOQsZhU=w@...278...>
References: <OF05315ED1.21B1F5C0-ONC1257C2B.0035DBF4-C1257C2B.00362669@...1846...>	<20131122101521.GZ161@...1296...>
	<CAN_jwOsZ52oxbv9tRxMbSN3Edbr6adUeWOn0V7D-iaOQsZhU=w@...278...>
MIME-Version: 1.0
From: arno.odermatt@...1845...
Message-ID: <OF3A5C5E15.B8A20868-ONC1257C38.002E17F6-C1257C38.004782F3@...1846...>
Date: Thu, 5 Dec 2013 14:01:05 +0100
Content-Type: multipart/alternative;
	boundary="=_alternative 00478251C1257C38_="
Subject: Re: [Openvpn-devel] Does openvpn 2.3.2 has memory leak? (addendum3
	and 4)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Brad Zhang <hebei5000@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multipart message in MIME format.
--=_alternative 00478251C1257C38_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear Brad,

thank you. Yes, it is acceptable.
From our point of view, it still seems, memory not to be released=20
properly, when a disconnection script has been run.
In our environment with O-VPN 2.3.2, when we start to disconnect large=20
amounts of client sessions, using the disconnect script, memory seems not=20
to become freed, and therefore can not be re-used by other sessions. This=20
is a problem, since the app might  run out of memory again.

freundlich gr=FCsst,
kind regards,

_________________________
_________________________
_________________________
_________________________
_________________________
________________=20

Arno Odermatt=20
Phone +41414454053=20
arno.odermatt@...1845...=20

Schindler Elevator Ltd. | Corporate Research & Development | CRD/CO-BAT=20
Zugerstr. 13 | CH-6030 Ebikon, Switzerland=20
http://www.schindler.com=20
_________________________
_________________________
_________________________
_________________________
_________________________
________________=20

Please consider your environment.=20

Schindler supports sustainable urban development with
safe, reliable and ecologically sound mobility solutions.





From:   Brad Zhang <hebei5000@...277...>
To:     Gert Doering <gert@...1296...>,=20
arno.odermatt@...1845...,=20
Cc:     openvpn-devel@lists.sourceforge.net
Date:   05.12.2013 09:11
Subject:        Re: [Openvpn-devel] Does openvpn 2.3.2 has memory leak?=20
(addendum3 and 4)



Hi Arno,

It is acceptable for me that memory can be used again in new connection.=20


Hi Gert,

It is very helpful, thank you so much for your help. Thanks to all of you=20
for developing  so excellent and powerful  open source project (also=20
complicated for me:) ). Look forward to openvpn 2.3.3.=20

Thanks,
Brad Zhang


On Fri, Nov 22, 2013 at 6:15 PM, Gert Doering <gert@...1296...> wrote:
Hi,

On Fri, Nov 22, 2013 at 10:51:27AM +0100, arno.odermatt@...1845...=20
wrote:
> Dear Gert, Brad all,
>
> as I also had reported to have recognized, that memory was not freed,=20
even
>
> though the openvpn disconnect-script was disconnecting all of the 3400
> Openvpn-sessions (pls see mail below).
> Would you think, this is also improved by the change from malloc to
> calloc, so we could update to 2.3.3 to improve the memory-leak=20
situation?

Using malloc() or calloc() will neither affect the total memory used,
nor any fragmentation issues or mem leaks.  It's just about guaranteeing
that allocated memory is zeroed-out.

gert
--
USENET is *not* the non-clickable part of WWW!
                                                           //
www.muc.de/~gert/
Gert Doering - Munich, Germany=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20
gert@...1296...
fax: +49-89-35655025=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20
gert@...1297...


******************************************************
Notice: The information contained in this message is intended only for use =
of the individual(s) named above and may contain confidential, proprietary =
or legally privileged information. No confidentiality or privilege is waive=
d or lost by any mistransmission. If you are not the intended recipient of =
this message you are hereby notified that you must not use, disseminate , c=
opy it in any form or take any action in reliance of it. If you have receiv=
ed this message in error please delete it and any copies of it and notify t=
he sender immediately.
*******************************************************=

--=_alternative 00478251C1257C38_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<font size=3D2 face=3D"sans-serif">Dear Brad,</font>
<br>
<br><font size=3D2 face=3D"sans-serif">thank you. Yes, it is acceptable.</f=
ont>
<br><font size=3D2 face=3D"sans-serif">From our point of view, it still see=
ms,
memory not to be released properly, when a disconnection script has been
run.</font>
<br><font size=3D2 face=3D"sans-serif">In our environment with O-VPN 2.3.2,
when we start to disconnect large amounts of client sessions, using the
disconnect script, memory seems not to become freed, and therefore can
not be re-used by other sessions. This is a problem, since the app might
&nbsp;run out of memory again.</font>
<br><font size=3D2 face=3D"sans-serif"><br>
freundlich gr=FCsst,<br>
kind regards,<br>
</font><font size=3D1 face=3D"Arial"><br>
_________________________
_________________________
_________________________
_________________________
_________________________
________________
</font><font size=3D2 face=3D"sans-serif"><br>
Arno Odermatt <br>
Phone +41414454053 <br>
arno.odermatt@...1845... <br>
<br>
Schindler Elevator Ltd. | Corporate Research &amp; Development | CRD/CO-BAT
<br>
Zugerstr. 13 | CH-6030 Ebikon, Switzerland <br>
</font><a href=3Dhttp://www.schindler.com/><font size=3D2 face=3D"sans-seri=
f">http://www.schindler.com</font></a><font size=3D2 face=3D"sans-serif">
</font><font size=3D1 face=3D"Arial"><br>
_________________________
_________________________
_________________________
_________________________
_________________________
________________
</font><font size=3D1 color=3D#008000 face=3D"Arial"><br>
Please consider your environment. <br>
</font><font size=3D1 color=3D#5f5f5f face=3D"Arial"><br>
Schindler supports sustainable urban development with<br>
safe, reliable and ecologically sound mobility solutions.<br>
</font><font size=3D1 color=3D#008000 face=3D"Arial"><br>
</font>
<br>
<br>
<br>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">From: &nbsp; &nbsp; =
&nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">Brad Zhang &lt;hebei5000@...1186...=
.277...&gt;</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">To: &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">Gert Doering &lt;gert@...1711...=
96...&gt;,
arno.odermatt@...1845..., </font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Cc: &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">openvpn-devel@...1535...=
orge.net</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Date: &nbsp; &nbsp; =
&nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">05.12.2013 09:11</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Subject: &nbsp; &nbs=
p;
&nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">Re: [Openvpn-devel]
Does openvpn 2.3.2 has memory leak? (addendum3 and 4)</font>
<br>
<hr noshade>
<br>
<br>
<br><font size=3D3>Hi Arno,</font>
<br>
<br><font size=3D3>It is acceptable for me that memory can be used again
in new connection.&nbsp;</font>
<br>
<br>
<br><font size=3D3>Hi Gert,</font>
<br>
<br><font size=3D3>It is very helpful, thank you so much for your help. Tha=
nks
to all of you for developing &nbsp;so excellent and powerful &nbsp;open
source project (also complicated for me:) ). Look forward to openvpn 2.3.3.=
&nbsp;</font>
<br>
<br><font size=3D3>Thanks,</font>
<br><font size=3D3>Brad Zhang</font>
<br><font size=3D3><br>
</font>
<br><font size=3D3>On Fri, Nov 22, 2013 at 6:15 PM, Gert Doering &lt;</font=
><a href=3Dmailto:gert@...1296... target=3D_blank><font size=3D3 color=3Dbl=
ue><u>gert@...1296...</u></font></a><font size=3D3>&gt;
wrote:</font>
<br><font size=3D3>Hi,</font>
<br><font size=3D3><br>
On Fri, Nov 22, 2013 at 10:51:27AM +0100, </font><a href=3Dmailto:arno.oder=
matt@...1845...><font size=3D3 color=3Dblue><u>arno.odermatt@...1845...</u>=
</font></a><font size=3D3>
wrote:<br>
&gt; Dear Gert, Brad all,<br>
&gt;<br>
&gt; as I also had reported to have recognized, that memory was not freed,
even<br>
&gt;<br>
&gt; though the openvpn disconnect-script was disconnecting all of the
3400<br>
&gt; Openvpn-sessions (pls see mail below).<br>
&gt; Would you think, this is also improved by the change from malloc to<br>
&gt; calloc, so we could update to 2.3.3 to improve the memory-leak situati=
on?<br>
</font>
<br><font size=3D3>Using malloc() or calloc() will neither affect the total
memory used,<br>
nor any fragmentation issues or mem leaks. &nbsp;It's just about guaranteei=
ng<br>
that allocated memory is zeroed-out.</font>
<br><font size=3D3><br>
gert<br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;//</font><a href=3Dh=
ttp://www.muc.de/~gert/ target=3D_blank><font size=3D3 color=3Dblue><u>www.=
muc.de/~gert/</u></font></a><font size=3D3><br>
Gert Doering - Munich, Germany &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </font><a href=3Dma=
ilto:gert@...1296...><font size=3D3 color=3Dblue><u>gert@...1296...</u></fo=
nt></a><font size=3D3><br>
fax: </font><a href=3D"tel:%2B49-89-35655025"><font size=3D3 color=3Dblue><=
u>+49-89-35655025</u></font></a><font size=3D3>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;</font><a href=3D"mailto:gert@...1297..."><font size=3D3 color=3Dblue=
><u>gert@...1297...</u></font></a>
<br>
<br><br clear=3D"both">
******************************************************<BR>
Notice: The information contained in this message is intended only for use =
of the individual(s) named above and may contain confidential, proprietary =
or legally privileged information. No confidentiality or privilege is waive=
d or lost by any mistransmission. If you are not the intended recipient of =
this message you are hereby notified that you must not use, disseminate , c=
opy it in any form or take any action in reliance of it. If you have receiv=
ed this message in error please delete it and any copies of it and notify t=
he sender immediately.<BR>
*******************************************************<BR>

--=_alternative 00478251C1257C38_=--


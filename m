Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Wed, 7 Apr 2010 00:59:08 -0700
Message-ID: <201004070959.09215.hhund@...194...>
In-Reply-To: <OF16C98C16.EEA12E96-ONC12576FD.006F673E-C12576FD.00713519@...1343...>
References: <OF16C98C16.EEA12E96-ONC12576FD.006F673E-C12576FD.00713519@...1343...>
From: "Heiko Hund" <hhund@...194...>
Subject: Re: [Openvpn-devel] DNS problems with openvpn 2.1 on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Diso-8859-=
1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.5.7654.12">
<TITLE>Re: [Openvpn-devel] DNS problems with openvpn 2.1 on Windows</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi,</FONT>
</P>

<P><FONT SIZE=3D2>On Tuesday 06 April 2010 22:36:31 Johan Ymerson wrote:</F=
ONT>

<BR><FONT SIZE=3D2>&gt; I have tested on 3 PC's with Windows XP, all 3 show=
 the same problem, at</FONT>

<BR><FONT SIZE=3D2>&gt; almost 100% of my connection attempts. OpenVPN 2.0.=
9 does not have this</FONT>

<BR><FONT SIZE=3D2>&gt; issue (ie. reverting back to 2.0.9 on the same mach=
ines with the same</FONT>

<BR><FONT SIZE=3D2>&gt; config never show the problem).</FONT>
</P>

<P><FONT SIZE=3D2>We also tried 2.0.9 but were able to reproduce the bug wi=
th it as well, so it </FONT>

<BR><FONT SIZE=3D2>has nothing to do with the openvpn driver version involv=
ed. I came to the </FONT>

<BR><FONT SIZE=3D2>conclusion that it's rather some kind of race condition =
in the Windows XP DNS </FONT>

<BR><FONT SIZE=3D2>resolver. At least I haven't seen this problem on Vista =
or 7 personally.</FONT>

<BR><FONT SIZE=3D2>&nbsp;</FONT>

<BR><FONT SIZE=3D2>&gt; Is this problem known, and is someone working on it=
?</FONT>

<BR><FONT SIZE=3D2>&gt; I can of course help debugging this, but I don't ha=
ve the development</FONT>

<BR><FONT SIZE=3D2>&gt; environment needed to compile the Windows binaries.=
</FONT>
</P>

<P><FONT SIZE=3D2>Not much to debug anyway. The DNS servers get passed corr=
ectly via DHCP and </FONT>

<BR><FONT SIZE=3D2>Windows actually takes notice of them as they show up in=
 `ipconfig /all`. </FONT>

<BR><FONT SIZE=3D2>Problem is that XP resolver somehow forgets to repriorit=
ize the DNS servers </FONT>

<BR><FONT SIZE=3D2>list after an DHCP update sometimes and sticks with the =
old preferred name </FONT>

<BR><FONT SIZE=3D2>server until the scheduled reprioritization. At least th=
at's my personal </FONT>

<BR><FONT SIZE=3D2>conclusion. And it would explain why a /renew fixes it.<=
/FONT>
</P>

<P><FONT SIZE=3D2>We've contacted Microsoft tech support about this issue. =
If anything like a </FONT>

<BR><FONT SIZE=3D2>fix comes out of that I'll post an update here. If not w=
e'll have to consider </FONT>

<BR><FONT SIZE=3D2>a workaround of some kind, but let's wait with that disc=
ussion until we're </FONT>

<BR><FONT SIZE=3D2>sure it's not fixable the right way.</FONT>
</P>

<P><FONT SIZE=3D2>Regards</FONT>

<BR><FONT SIZE=3D2>Heiko</FONT>

<BR><FONT SIZE=3D2>-- </FONT>

<BR><FONT SIZE=3D2>Heiko Hund | Software Engineer | Phone +49-721-25516-237=
 | Fax -200</FONT>

<BR><FONT SIZE=3D2>Astaro AG | An der RaumFabrik 33a | 76227 Karlsruhe | Ge=
rmany</FONT>
</P>

<P><FONT SIZE=3D2>Executive Board: Markus Hennig, Jan Hichert, G=FCnter Jun=
k, Dr. Frank Nellissen</FONT>

<BR><FONT SIZE=3D2>Chairman of the Supervisory Board: Stanley J. Krasnow</F=
ONT>

<BR><FONT SIZE=3D2>Headquarter Location: Karlsruhe</FONT>

<BR><FONT SIZE=3D2>Commercial Register: Mannheim HRB 108997</FONT>
</P>

</BODY>
</HTML>


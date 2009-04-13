From: "dave" <dev@...575...>
Date: Sun, 12 Apr 2009 21:11:30 -0500
Message-ID: <5BB9A8CFC43A4CCCB144358E382FDC83@...576...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0028_01C9BBB3.40691B60"
In-Reply-To: <508591.71590.qm@...1210...>
Subject: Re: [Openvpn-devel] Generating certificate/key pair locally on
	clientmachine
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: 'Oana Comanici' <oana.comanici@...109...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_0028_01C9BBB3.40691B60
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

 
1 I.m not sure this is possible, but maybe it will work with
client-cert-not-required; I have never tried, though 
 
2 I'm not sure what this means, because certificates are public keys,
bound with some attributes (like common name) and the bundle signed by
the CA, and the communicating entity retains and uses the private key.
 
3 most secure, though you still have to get the certificate from the CA
machine to the client, which you said is a problem for you.
 
some folks have all clients use the same pre-generated cert, and rely on
different methods for client authorization, by way of
<outbind://8/#opt_auth_user_pass_verify> auth-user-pass-verify.
 
-dave

-----Original Message-----
From: Oana Comanici [mailto:oana.comanici@...109...] 
Sent: Sunday, April 12, 2009 6:10 PM
To: openvpn-devel@lists.sourceforge.net
Subject: [Openvpn-devel] Generating certificate/key pair locally on
clientmachine


Hello, 

My name is Oana Comanici and I am developing a zero config application
based on OpenVPN. I have encountered an issue regarding the generation
of certificates for clients. Since the application is supposed to
require as little configuration as possible, the actual method for
generating the certificates on the server machine and copying them
afterwards to the client is not appropriate. 

There are three possible solutions that I have found so far, but I don't
know exactly which one is easier to implement and more efficient.

1. The clients could use self-signed SSL certificates for the
communication with the server. At the moment, OpenVPN servers only
accept connections from clients with certificates signed by the server's
CA. However, it would decrease the level of security provided by the
VPN.

2. The communication between client and server would be no longer based
on certificates, but on a public key and a private key. Does the actual
OpenVPN implementation offers any kind of support for this method?

3. The server acts as a CA, signing the Certificate Signing Request sent
by the client. This would probably imply that the server was listening
on a separate port for a .csr file from a file.

These are the solutions that I have thought of so far, but if there is a
more efficient one, please tell me. Also, I would like to know which of
the three ideas would be the best.

Thank you,
    Oana




------=_NextPart_000_0028_01C9BBB3.40691B60
Content-Type: text/html; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
<TITLE>Message</TITLE>

<STYLE type=3Dtext/css>DIV {
	MARGIN: 0px
}
</STYLE>

<META content=3D"MSHTML 6.00.6000.16809" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D094465001-13042009><FONT face=3DArial color=3D#0000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D094465001-13042009><FONT face=3DArial color=3D#0000ff si=
ze=3D2>1 I.m=20
not sure&nbsp;this is&nbsp;possible, but maybe it will work with <FONT=20
color=3D#000000><STRONG><SPAN=20
style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Times New Roman'; mso-fareast-font-=
family: 'Times New Roman'; mso-ansi-language: EN-US; mso-fareast-language: =
EN-US; mso-bidi-language: AR-SA">client-cert-not-required;</SPAN></STRONG><=
/FONT>=20
I have never tried, though&nbsp;</FONT></SPAN></DIV>
<DIV><SPAN class=3D094465001-13042009><FONT face=3DArial color=3D#0000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D094465001-13042009><FONT face=3DArial color=3D#0000ff si=
ze=3D2>2 I'm=20
not sure what this means, because certificates <EM>are</EM> public keys, bo=
und=20
with some attributes (like common name) and the bundle signed by the CA, an=
d the=20
communicating entity retains and uses the private key.</FONT></SPAN></DIV>
<DIV><SPAN class=3D094465001-13042009><FONT face=3DArial color=3D#0000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D094465001-13042009><FONT face=3DArial color=3D#0000ff=20
size=3D2>3&nbsp;most secure, though you still have to get the certificate f=
rom the=20
CA machine to the client, which you said is&nbsp;a problem for=20
you.</FONT></SPAN></DIV>
<DIV><SPAN class=3D094465001-13042009><FONT face=3DArial color=3D#0000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D094465001-13042009><FONT face=3DArial color=3D#0000ff si=
ze=3D2>some=20
folks have all clients use the same pre-generated cert,&nbsp;and rely on=20
different methods for client authorization, by way of <SPAN=20
style=3D"FONT-SIZE: 12pt; FONT-FAMILY: 'Times New Roman'; mso-fareast-font-=
family: 'Times New Roman'; mso-ansi-language: EN-US; mso-fareast-language: =
EN-US; mso-bidi-language: AR-SA"><A=20
title=3D"option:  auth-user-pass-verify"=20
href=3D"outbind://8/#opt_auth_user_pass_verify"><STRONG>auth-user-pass-veri=
fy</STRONG></A></SPAN>.</FONT></SPAN></DIV>
<DIV><SPAN class=3D094465001-13042009><FONT face=3DArial color=3D#0000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D094465001-13042009><FONT face=3DArial color=3D#0000ff=20
size=3D2>-dave</FONT></SPAN></DIV>
<BLOCKQUOTE=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px soli=
d; MARGIN-RIGHT: 0px">
  <DIV></DIV>
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft><FO=
NT=20
  face=3DTahoma size=3D2>-----Original Message-----<BR><B>From:</B> Oana Co=
manici=20
  [mailto:oana.comanici@...109...] <BR><B>Sent:</B> Sunday, April 12, 2009 =
6:10=20
  PM<BR><B>To:</B> openvpn-devel@lists.sourceforge.net<BR><B>Subject:</B>=20
  [Openvpn-devel] Generating certificate/key pair locally on=20
  clientmachine<BR><BR></FONT></DIV>
  <DIV style=3D"FONT-SIZE: 10pt; FONT-FAMILY: verdana,helvetica,sans-serif">
  <DIV=20
  style=3D"FONT-SIZE: 10pt; COLOR: rgb(0,0,0); FONT-FAMILY: verdana,helveti=
ca,sans-serif">
  <DIV>Hello, <BR><BR>My name is Oana Comanici and I am developing a zero c=
onfig=20
  application based on OpenVPN. I have encountered an issue regarding the=20
  generation of certificates for clients. Since the application is supposed=
 to=20
  require as little configuration as possible, the actual method for genera=
ting=20
  the certificates on the server machine and copying them afterwards to the=
=20
  client is not appropriate. <BR><BR>There are three possible solutions tha=
t I=20
  have found so far, but I don't know exactly which one is easier to implem=
ent=20
  and more efficient.<BR><BR>1. The clients could use self-signed SSL=20
  certificates for the communication with the server. At the moment, OpenVP=
N=20
  servers only accept connections from clients with certificates signed by =
the=20
  server's CA. However, it would decrease the level of security provided by=
 the=20
  VPN.<BR><BR>2. The communication between client and server would be no lo=
nger=20
  based on certificates, but on a public key and a private key. Does the ac=
tual=20
  OpenVPN implementation offers any kind of support for this method?<BR><BR=
>3.=20
  The server acts as a CA, signing the Certificate Signing Request sent by =
the=20
  client. This would probably imply that the server was listening on a sepa=
rate=20
  port for a .csr file from a file.<BR><BR>These are the solutions that I h=
ave=20
  thought of so far, but if there is a more efficient one, please tell me. =
Also,=20
  I would like to know which of the three ideas would be the best.<BR><BR>T=
hank=20
  you,<BR>&nbsp;&nbsp;&nbsp;=20
Oana<BR></DIV></DIV></DIV><BR></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_0028_01C9BBB3.40691B60--



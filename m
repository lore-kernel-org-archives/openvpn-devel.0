Message-ID: <20686C579479DC438276A726FE80CDAA01B12C8D@...281...>
From: satinders@...280...
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4A54D.41ECA870"
Subject: [Openvpn-devel] customizable authentication
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Sep 28 04:30:11 2004
To: openvpn-devel@lists.sourceforge.net

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C4A54D.41ECA870
Content-Type: text/plain;
	charset="iso-8859-1"

Hi,
	I need to add a field in the message sent through tunnel. I will use
this field to maintain session validity. This session id will be based on
some user/passwd info. I have seen that a field session_id is there in
ssl.h.  Should I use this for my purpose?
Where should I add code for this? I need to set this field in client and
verify it in server openvpn. In case it does not matches, I will close
session.

Also, is there any way to disable TLS in server mode?

Warm Regards,
Satinder Singh
ext 162
SafeNet InfoTech (P) Ltd 
STP-NSIC, NSIC Bhawan, 
Okhla Industrial Estate, 
New Delhi - 110020 
91-11-26917538 
www.safenet-inc.com 

. . . . . . . . . . . . . . . . . . 
The information contained in this electronic mail transmission may be
privileged and confidential, and therefore, protected from disclosure. If
you have received this communication in error, please notify us immediately
by replying to this message and deleting it from your computer without
copying or disclosing it.



------_=_NextPart_001_01C4A54D.41ECA870
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Diso-8859-=
1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 5.5.2653.12">
<TITLE>customizable authentication</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi,</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 FACE=3D"Arial=
">I need to add a field in the message sent through tunnel. I will use this=
 field to maintain session validity. This session id will be based on some =
user/passwd info. I have seen that a field session_id is there in ssl.h.&nb=
sp; Should I use this for my purpose?</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Where should I add code for this? I need t=
o set this field in client and verify it in server openvpn. In case it does=
 not matches, I will close session.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Also, is there any way to disable TLS in s=
erver mode?</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Warm Regards,</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">Satinder Singh</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">ext 162</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Comic Sans MS">SafeNet InfoTech (P) Ltd<BR>
STP-NSIC, NSIC Bhawan,<BR>
Okhla Industrial Estate,<BR>
New Delhi - 110020<BR>
91-11-26917538<BR>
www.safenet-inc.com</FONT><FONT FACE=3D"Times New Roman"> </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">. . . . . . . . . . . . . . . . . .<BR>
</FONT><FONT SIZE=3D1 FACE=3D"Times New Roman">The information contained in=
 this electronic mail transmission may be privileged and confidential, and =
therefore, protected from disclosure. If you have received this communicati=
on in error, please notify us immediately by replying to this message and d=
eleting it from your computer without copying or disclosing it.</FONT></P>
<BR>

</BODY>
</HTML>=

------_=_NextPart_001_01C4A54D.41ECA870--


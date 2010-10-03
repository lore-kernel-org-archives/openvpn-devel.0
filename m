From: "Carlos Soto" <carlos.soto@...1413...>
Date: Sun, 3 Oct 2010 20:56:06 +0200
Message-ID: <000001cb632c$a2bb8420$e8328c60$@soto@...1413...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0001_01CB633D.66447B30"
Content-Language: es
Subject: [Openvpn-devel] Variable common_name can be blank in client-connect
	script
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_0001_01CB633D.66447B30
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Author: Carlos Soto <carlos.soto at terra.es <mailto:carlos.soto@...1413...> >

 

Variable common_name can be blank in client-connect script

 

If a server is configured with auth-user-pass-optional and
username-as-common-name it is possible that the auth-user-pass-verify script
will validate a connection with no username as it is optional. It that case
the common_name becames blank and client-connect script may fail because it
does not have a value for the common name. I think that the common name
should never be blank so in cases where the username is blank and the
username-as-common-name option is enabled, the common_name should keep its
original value.

 

 

diff --git a/ssl.c b/ssl.c

index a1268ac..381ab07 100644

--- a/ssl.c

+++ b/ssl.c

@@ -3718,7 +3718,7 @@ key_method_2_read (struct buffer *buf, struct
tls_multi *multi, struct tls_sessi

          if (man_def_auth != KMDA_UNDEF)

            ks->auth_deferred = true;

 #endif

-         if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME))

+         if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME) &&
(strlen (up->username)))

            set_common_name (session, up->username);

 #ifdef ENABLE_DEF_AUTH

          msg (D_HANDSHAKE, "TLS: Username/Password authentication %s for
username '%s' %s",

 

 


------=_NextPart_000_0001_01CB633D.66447B30
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
h2
	{mso-style-priority:9;
	mso-style-link:"T\00EDtulo 2 Car";
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:18.0pt;
	font-family:"Times New Roman","serif";
	font-weight:bold;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML con formato previo Car";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EstiloCorreo17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.HTMLconformatoprevioCar
	{mso-style-name:"HTML con formato previo Car";
	mso-style-priority:99;
	mso-style-link:"HTML con formato previo";
	font-family:"Courier New";}
span.Ttulo2Car
	{mso-style-name:"T\00EDtulo 2 Car";
	mso-style-priority:9;
	mso-style-link:"T\00EDtulo 2";
	font-family:"Times New Roman","serif";
	font-weight:bold;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 3.0cm 70.85pt 3.0cm;}
div.WordSection1
	{page:WordSection1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DES link=3Dblue vlink=3Dpurple>

<div class=3DWordSection1>

<p class=3DMsoNormal><span style=3D'font-size:12.0pt'>Author: Carlos Soto &=
lt;<a
href=3D"mailto:carlos.soto@...1413...">carlos.soto at terra.es</a>&gt;<o:p>=
</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></sp=
an></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'>Variable=
 common_name
can be blank in client-connect script<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'><o:p>&nb=
sp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'>If a ser=
ver is
configured with </span><span lang=3DEN-US style=3D'font-size:12.0pt'>auth-u=
ser-pass-optional
and username-as-common-name it is possible that the auth-user-pass-verify
script will validate a connection with no username as it is optional. It th=
at
case the common_name becames blank and client-connect script may fail becau=
se
it does not have a value for the common name. I think that the common name
should never be blank so in cases where the username is blank and the usern=
ame-as-common-name
option is enabled, the common_name should keep its original value.<o:p></o:=
p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'><o:p>&nb=
sp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'><o:p>&nb=
sp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'>diff --g=
it a/ssl.c
b/ssl.c<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'>index
a1268ac..381ab07 100644<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'>--- a/ss=
l.c<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'>+++ b/ss=
l.c<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'>@@ -3718=
,7 +3718,7
@@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct
tls_sessi<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if (man_def_auth !=3D KMDA_UNDEF)<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
ks-&gt;auth_deferred =3D true;<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'>&nbsp;#e=
ndif<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'>-&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if ((session-&gt;opt-&gt;ssl_flags &amp; SSLF_USERNAME_AS_COMMON_NAME))<o:p=
></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if ((session-&gt;opt-&gt;ssl_flags &amp; SSLF_USERNAME_AS_COMMON_NAME)
&amp;&amp; (strlen (up-&gt;username)))<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
set_common_name (session, up-&gt;username);<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'>&nbsp;#i=
fdef
ENABLE_DEF_AUTH<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
msg (D_HANDSHAKE, &quot;TLS: Username/Password authentication %s for userna=
me
'%s' %s&quot;,<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'><o:p>&nb=
sp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'><o:p>&nb=
sp;</o:p></span></p>

</div>

</body>

</html>

------=_NextPart_000_0001_01CB633D.66447B30--



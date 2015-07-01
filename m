From: "Fish Wang" <fish.thss@...277...>
Date: Wed, 1 Jul 2015 12:47:56 -0700
Message-ID: <015601d0b436$d555ad60$80010820$@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0157_01D0B3FC.28F771A0"
Content-Language: zh-cn
Subject: [Openvpn-devel] Compiling issue on Visual Studio 2010
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multipart message in MIME format.

------=_NextPart_000_0157_01D0B3FC.28F771A0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

Hi,

 

Visual Studio 2010 refuses to compile the latest code on branch release/2.3
because __func__ is not supported. Microsoft supports __FUNCTION__ instead
of __func__ in their compiler. VS 2013 complains the same.

 

The following patch resolves this issue.

 

 

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c

index aa93a7b..c4fda84 100644

--- a/src/openvpn/crypto.c

+++ b/src/openvpn/crypto.c

@@ -423,7 +423,7 @@ crypto_adjust_frame_parameters(struct frame *frame,

   frame_add_to_extra_frame (frame, crypto_overhead);

 

   msg(D_MTU_DEBUG, "%s: Adjusting frame parameters for crypto by %zu
bytes",

-      __func__, crypto_overhead);

+      CURRENT_FUNCTION, crypto_overhead);

}

 

/*

diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h

index e489827..66704ba 100644

--- a/src/openvpn/crypto.h

+++ b/src/openvpn/crypto.h

@@ -459,6 +459,15 @@ key_ctx_bi_defined(const struct key_ctx_bi* key)

   return key->encrypt.cipher || key->encrypt.hmac || key->decrypt.cipher ||
key->decrypt.hmac;

}

 

+/*

+ * __func__ is not yet supported on Visual Studio 2013

+ */

+

+#ifdef _MSC_VER

+    #define CURRENT_FUNCTION __FUNCTION__

+#else

+    #define CURRENT_FUNCTION __func__

+#endif

 

#endif /* ENABLE_CRYPTO */

#endif /* CRYPTO_H */

 

Best,

Fish


------=_NextPart_000_0157_01D0B3FC.28F771A0
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Dgb2312"><meta name=3DGenerator content=3D"Microsof=
t Word 15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DZH-CN link=3D"#0563C1=
" vlink=3D"#954F72" style=3D'text-justify-trim:punctuation'><div class=3DWo=
rdSection1><p class=3DMsoNormal><span lang=3DEN-US>Hi,<o:p></o:p></span></p=
><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p cla=
ss=3DMsoNormal><span lang=3DEN-US>Visual Studio 2010 refuses to compile the=
 latest code on branch release/2.3 because __func__ is not supported. Micro=
soft supports __FUNCTION__ instead of __func__ in their compiler. VS 2013 c=
omplains the same.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DE=
N-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>Th=
e following patch resolves this issue.<o:p></o:p></span></p><p class=3DMsoN=
ormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><=
span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span la=
ng=3DEN-US>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c<o:p></o=
:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>index aa93a7b..c4fda8=
4 100644<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>--- a=
/src/openvpn/crypto.c<o:p></o:p></span></p><p class=3DMsoNormal><span lang=
=3DEN-US>+++ b/src/openvpn/crypto.c<o:p></o:p></span></p><p class=3DMsoNorm=
al><span lang=3DEN-US>@@ -423,7 +423,7 @@ crypto_adjust_frame_parameters(st=
ruct frame *frame,<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DE=
N-US>&nbsp;&nbsp; frame_add_to_extra_frame (frame, crypto_overhead);<o:p></=
o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></s=
pan></p><p class=3DMsoNormal><span lang=3DEN-US>&nbsp;&nbsp; msg(D_MTU_DEBU=
G, &quot;%s: Adjusting frame parameters for crypto by %zu bytes&quot;,<o:p>=
</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>-&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; __func__, crypto_overhead);<o:p></o:p></span></p><p class=3DM=
soNormal><span lang=3DEN-US>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CURRENT_FUNCTIO=
N, crypto_overhead);<o:p></o:p></span></p><p class=3DMsoNormal><span lang=
=3DEN-US> }<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US><o=
:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US> /*<o:p><=
/o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>diff --git a/src/op=
envpn/crypto.h b/src/openvpn/crypto.h<o:p></o:p></span></p><p class=3DMsoNo=
rmal><span lang=3DEN-US>index e489827..66704ba 100644<o:p></o:p></span></p>=
<p class=3DMsoNormal><span lang=3DEN-US>--- a/src/openvpn/crypto.h<o:p></o:=
p></span></p><p class=3DMsoNormal><span lang=3DEN-US>+++ b/src/openvpn/cryp=
to.h<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>@@ -459,6=
 +459,15 @@ key_ctx_bi_defined(const struct key_ctx_bi* key)<o:p></o:p></sp=
an></p><p class=3DMsoNormal><span lang=3DEN-US>&nbsp;&nbsp; return key-&gt;=
encrypt.cipher || key-&gt;encrypt.hmac || key-&gt;decrypt.cipher || key-&gt=
;decrypt.hmac;<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US=
> }<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp=
;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>+/*<o:p></o:p></s=
pan></p><p class=3DMsoNormal><span lang=3DEN-US>+ * __func__ is not yet sup=
ported on Visual Studio 2013<o:p></o:p></span></p><p class=3DMsoNormal><spa=
n lang=3DEN-US>+ */<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3D=
EN-US>+<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>+#ifde=
f _MSC_VER<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>+&n=
bsp;&nbsp;&nbsp; #define CURRENT_FUNCTION __FUNCTION__<o:p></o:p></span></p=
><p class=3DMsoNormal><span lang=3DEN-US>+#else<o:p></o:p></span></p><p cla=
ss=3DMsoNormal><span lang=3DEN-US>+&nbsp;&nbsp;&nbsp; #define CURRENT_FUNCT=
ION __func__<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>+=
#endif<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&n=
bsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US> #endif /* ENA=
BLE_CRYPTO */<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>=
 #endif /* CRYPTO_H */<o:p></o:p></span></p><p class=3DMsoNormal><span lang=
=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-U=
S>Best,<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>Fish<o=
:p></o:p></span></p></div></body></html>=

------=_NextPart_000_0157_01D0B3FC.28F771A0--



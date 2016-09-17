MIME-Version: 1.0
In-Reply-To: <CAFHpkQFN16Ah4woE5uGh=Hp4vjBCu2cROAN-wAZVivZHtEDoGg@...278...>
References: <20160917132024.12570-1-gert@...1296...>
	<CAFHpkQFN16Ah4woE5uGh=Hp4vjBCu2cROAN-wAZVivZHtEDoGg@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sat, 17 Sep 2016 18:40:00 +0500
Message-ID: <CAFHpkQHNCis9UVV_P=sTCV2+u2op_yuS8_UApzW2NKRoJHzMiw@...278...>
Content-Type: multipart/alternative; boundary=001a1141a1fe3727e0053cb437be
Subject: Re: [Openvpn-devel] [PATCH] Fix win32 building with C99 mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--001a1141a1fe3727e0053cb437be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Should we add mingw compiler to travis-ci matrix?

17 =D1=81=D0=B5=D0=BD=D1=82. 2016 =D0=B3. 6:34 PM =D0=BF=D0=BE=D0=BB=D1=8C=
=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C "Gert Doering" <gert@...1711...=
96...>
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:

In -std=3Dc99 mode, WIN32 is not defined to be "1" anymore, but just
"#define WIN32" - so the "#if WIN32" breaks, needs to be "#ifdef WIN32"

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 0991d79..2982cd0 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -977,7 +977,7 @@ hostname_randomize(const char *hostname, struct
gc_arena *gc)
 const char *
 gen_path (const char *directory, const char *filename, struct gc_arena *gc)
 {
-#if WIN32
+#ifdef WIN32
   const int CC_PATH_RESERVED =3D CC_LESS_THAN|CC_GREATER_THAN|CC_COLON|
     CC_DOUBLE_QUOTE|CC_SLASH|CC_BACKSLASH|CC_PIPE|CC_QUESTION_
MARK|CC_ASTERISK;
 #else
--
1.9.1


------------------------------------------------------------
------------------
_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--001a1141a1fe3727e0053cb437be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Should we add mingw compiler to travis-ci matrix?</p>
<div class=3D"gmail_extra"><br><div class=3D"gmail_quote">17 =D1=81=D0=B5=
=D0=BD=D1=82. 2016 =D0=B3. 6:34 PM =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=
=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C &quot;Gert Doering&quot; &lt;<a href=3D"m=
ailto:gert@...1296...">gert@...1296...</a>&gt; =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BB:<br type=3D"attribution"><blockquote class=3D"quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">In -std=
=3Dc99 mode, WIN32 is not defined to be &quot;1&quot; anymore, but just<br>
&quot;#define WIN32&quot; - so the &quot;#if WIN32&quot; breaks, needs to b=
e &quot;#ifdef WIN32&quot;<br>
<br>
Signed-off-by: Gert Doering &lt;<a href=3D"mailto:gert@...1296...">gert@...493...=
1296...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/misc.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c<br>
index 0991d79..2982cd0 100644<br>
--- a/src/openvpn/misc.c<br>
+++ b/src/openvpn/misc.c<br>
@@ -977,7 +977,7 @@ hostname_randomize(const char *hostname, struct gc_aren=
a *gc)<br>
=C2=A0const char *<br>
=C2=A0gen_path (const char *directory, const char *filename, struct gc_aren=
a *gc)<br>
=C2=A0{<br>
-#if WIN32<br>
+#ifdef WIN32<br>
=C2=A0 =C2=A0const int CC_PATH_RESERVED =3D CC_LESS_THAN|CC_GREATER_THAN|<w=
br>CC_COLON|<br>
=C2=A0 =C2=A0 =C2=A0CC_DOUBLE_QUOTE|CC_SLASH|CC_<wbr>BACKSLASH|CC_PIPE|CC_Q=
UESTION_<wbr>MARK|CC_ASTERISK;<br>
=C2=A0#else<br>
<font color=3D"#888888">--<br>
1.9.1<br>
<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</font></blockquote></div><br></div>

--001a1141a1fe3727e0053cb437be--


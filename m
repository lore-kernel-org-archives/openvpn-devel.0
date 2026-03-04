From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 4 Mar 2026 11:58:46 +0000
In-Reply-To: <gerrit.1754656456000.I73bc163d48b2d6a954cd231961826f33143fcd12@...2715...>
References: <gerrit.1754656456000.I73bc163d48b2d6a954cd231961826f33143fcd12@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <899335e308c1670e5a36d03a8b276e5baed23d3b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="basfXSEl+2c="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: buffer: Clarify
 usage of char_class
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--basfXSEl+2c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
42?usp=3Demail )

Change subject: buffer: Clarify usage of char_class
......................................................................

buffer: Clarify usage of char_class

Silence compiler warnings due to conversion from
char to unsigned char. In this case we actually
depend on this conversion.

Change-Id: I73bc163d48b2d6a954cd231961826f33143fcd12
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1142
Message-Id: <20260304105007.14485-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
867.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/buffer.c
1 file changed, 11 insertions(+), 2 deletions(-)




diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index dd74b38..12a8ff9 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -559,7 +559,7 @@
         {
             break;
         }
-        if (char_class(*last, CC_CRLF | CC_NULL))
+        if (char_class((unsigned char)*last, CC_CRLF | CC_NULL))
         {
             if (!buf_inc_len(buf, -1))
             {
@@ -876,6 +876,14 @@
  * Classify and mutate strings based on character types.
  */

+/* Note 1: This functions depends on getting an unsigned
+   char. Both the is*() functions and our own checks expect it
+   this way.
+   Note 2: For CC_PRINT we just accept everything >=3D 32, so
+   if we ingest non-ASCII UTF-8 we will classify it as
+   printable since it will be >=3D 128. Other encodings are
+   not officially supported.
+*/
 bool
 char_class(const unsigned char c, const unsigned int flags)
 {
@@ -1019,7 +1027,8 @@
 static inline bool
 char_inc_exc(const char c, const unsigned int inclusive, const unsigned in=
t exclusive)
 {
-    return char_class(c, inclusive) && !char_class(c, exclusive);
+    return char_class((unsigned char)c, inclusive)
+           && !char_class((unsigned char)c, exclusive);
 }

 bool

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1142?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I73bc163d48b2d6a954cd231961826f33143fcd12
Gerrit-Change-Number: 1142
Gerrit-PatchSet: 8
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--basfXSEl+2c=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1142?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">buffer: Clarify usage of char_class<br><br>Silen=
ce compiler warnings due to conversion from<br>char to unsigned char. In th=
is case we actually<br>depend on this conversion.<br><br>Change-Id: I73bc16=
3d48b2d6a954cd231961826f33143fcd12<br>Signed-off-by: Frank Lichtenheld &lt;=
frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>G=
errit URL: https://gerrit.openvpn.net/c/openvpn/+/1142<br>Message-Id: &lt;2=
0260304105007.14485-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.=
com/openvpn-devel@lists.sourceforge.net/msg35867.html<br>Signed-off-by: Ger=
t Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/buffer.c<br>1 fil=
e changed, 11 insertions(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c</span><br><span=
>index dd74b38..12a8ff9 100644</span><br><span>--- a/src/openvpn/buffer.c</=
span><br><span>+++ b/src/openvpn/buffer.c</span><br><span>@@ -559,7 +559,7 =
@@</span><br><span>         {</span><br><span>             break;</span><br=
><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (char_class(*last, CC_CRLF | CC_NULL))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (char_class((unsigned char)*last, CC_C=
RLF | CC_NULL))</span><br><span>         {</span><br><span>             if =
(!buf_inc_len(buf, -1))</span><br><span>             {</span><br><span>@@ -=
876,6 +876,14 @@</span><br><span>  * Classify and mutate strings based on c=
haracter types.</span><br><span>  */</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* Note 1: This functions depends on get=
ting an unsigned</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
char. Both the is*() functions and our own checks expect it</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+   this way.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+   Note 2: For CC_PRINT we just accept ev=
erything &gt;=3D 32, so</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+   if we ingest non-ASCII UTF-8 we will classify it as</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+   printable since it will be &gt;=
=3D 128. Other encodings are</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+   not officially supported.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+*/</span><br><span> bool</span><br><span> char_class(cons=
t unsigned char c, const unsigned int flags)</span><br><span> {</span><br><=
span>@@ -1019,7 +1027,8 @@</span><br><span> static inline bool</span><br><s=
pan> char_inc_exc(const char c, const unsigned int inclusive, const unsigne=
d int exclusive)</span><br><span> {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    return char_class(c, inclusive) &amp;&amp; !char_class(c,=
 exclusive);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn char_class((unsigned char)c, inclusive)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+           &amp;&amp; !char_class((unsigned char)c,=
 exclusive);</span><br><span> }</span><br><span> </span><br><span> bool</sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1142?usp=3Demail">change 1142</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1142?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I73bc163d48b2d6a954cd2319618=
26f33143fcd12 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1142 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--basfXSEl+2c=--


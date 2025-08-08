From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 8 Aug 2025 12:34:18 +0000
References: <gerrit.1754656456000.I73bc163d48b2d6a954cd231961826f33143fcd12@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <3f3f29d6997179a83c0e42b1072f66c07e1445f4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Lp4H+IX3dBM="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Lp4H+IX3dBM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1142?usp=3Demail

to review the following change.


Change subject: buffer: Clarify usage of char_class
......................................................................

buffer: Clarify usage of char_class

Silence compiler warnings due to conversion from
char to unsigned char. In this case we actually
depend on this conversion.

Change-Id: I73bc163d48b2d6a954cd231961826f33143fcd12
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/buffer.c
1 file changed, 11 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/42/1142/1

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 3dd8b31..ca2e3aa 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -560,7 +560,7 @@
         {
             break;
         }
-        if (char_class(*last, CC_CRLF | CC_NULL))
+        if (char_class((unsigned char)*last, CC_CRLF | CC_NULL))
         {
             if (!buf_inc_len(buf, -1))
             {
@@ -872,6 +872,14 @@
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
@@ -1015,7 +1023,8 @@
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
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I73bc163d48b2d6a954cd231961826f33143fcd12
Gerrit-Change-Number: 1142
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--Lp4H+IX3dBM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1142?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">buffer: Clarify usage of char_class<br><br>Silence compiler =
warnings due to conversion from<br>char to unsigned char. In this case we a=
ctually<br>depend on this conversion.<br><br>Change-Id: I73bc163d48b2d6a954=
cd231961826f33143fcd12<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2716...=
1...&gt;<br>---<br>M src/openvpn/buffer.c<br>1 file changed, 11 insertions(=
+), 2 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvp=
n refs/changes/42/1142/1</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/buffer.c b/src/op=
envpn/buffer.c</span><br><span>index 3dd8b31..ca2e3aa 100644</span><br><spa=
n>--- a/src/openvpn/buffer.c</span><br><span>+++ b/src/openvpn/buffer.c</sp=
an><br><span>@@ -560,7 +560,7 @@</span><br><span>         {</span><br><span=
>             break;</span><br><span>         }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        if (char_class(*last, CC_CRLF | CC_NULL))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (char_cl=
ass((unsigned char)*last, CC_CRLF | CC_NULL))</span><br><span>         {</s=
pan><br><span>             if (!buf_inc_len(buf, -1))</span><br><span>     =
        {</span><br><span>@@ -872,6 +872,14 @@</span><br><span>  * Classify=
 and mutate strings based on character types.</span><br><span>  */</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Note 1:=
 This functions depends on getting an unsigned</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+   char. Both the is*() functions and our own ch=
ecks expect it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   th=
is way.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   Note 2: F=
or CC_PRINT we just accept everything &gt;=3D 32, so</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+   if we ingest non-ASCII UTF-8 we will c=
lassify it as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   pri=
ntable since it will be &gt;=3D 128. Other encodings are</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+   not officially supported.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+*/</span><br><span> bool</spa=
n><br><span> char_class(const unsigned char c, const unsigned int flags)</s=
pan><br><span> {</span><br><span>@@ -1015,7 +1023,8 @@</span><br><span> sta=
tic inline bool</span><br><span> char_inc_exc(const char c, const unsigned =
int inclusive, const unsigned int exclusive)</span><br><span> {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    return char_class(c, inclusiv=
e) &amp;&amp; !char_class(c, exclusive);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return char_class((unsigned char)c, inclusive)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; !=
char_class((unsigned char)c, exclusive);</span><br><span> }</span><br><span=
> </span><br><span> bool</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1142?usp=3Demail">change =
1142</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1142?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I73bc163d48b2d6a954cd2319618=
26f33143fcd12 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1142 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--Lp4H+IX3dBM=--


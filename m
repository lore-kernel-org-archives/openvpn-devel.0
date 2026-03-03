From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 3 Mar 2026 14:07:55 +0000
In-Reply-To: <gerrit.1754656456000.I73bc163d48b2d6a954cd231961826f33143fcd12@...2715...>
References: <gerrit.1754656456000.I73bc163d48b2d6a954cd231961826f33143fcd12@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e721f12db9b00ba3481d1076639c29c66bc94b4d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Q1FUgm2T0pM="; charset=UTF-8
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

--Q1FUgm2T0pM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1142?usp=3Demail

to look at the new patch set (#7).


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/42/1142/7

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I73bc163d48b2d6a954cd231961826f33143fcd12
Gerrit-Change-Number: 1142
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--Q1FUgm2T0pM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #7</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1142?usp=3Demail">View C=
hange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">buffer: Clarify usage of char_class<br><br>Silen=
ce compiler warnings due to conversion from<br>char to unsigned char. In th=
is case we actually<br>depend on this conversion.<br><br>Change-Id: I73bc16=
3d48b2d6a954cd231961826f33143fcd12<br>Signed-off-by: Frank Lichtenheld &lt;=
frank@...2641...&gt;<br>---<br>M src/openvpn/buffer.c<br>1 file changed, 11=
 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit.openvpn.net:29418/openvpn refs/changes/42/1142/7</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/buffer.c b/src/openvpn/buffer.c</span><br><span>index dd74b38..=
12a8ff9 100644</span><br><span>--- a/src/openvpn/buffer.c</span><br><span>+=
++ b/src/openvpn/buffer.c</span><br><span>@@ -559,7 +559,7 @@</span><br><sp=
an>         {</span><br><span>             break;</span><br><span>         =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (char_cla=
ss(*last, CC_CRLF | CC_NULL))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (char_class((unsigned char)*last, CC_CRLF | CC_NULL))<=
/span><br><span>         {</span><br><span>             if (!buf_inc_len(bu=
f, -1))</span><br><span>             {</span><br><span>@@ -876,6 +876,14 @@=
</span><br><span>  * Classify and mutate strings based on character types.<=
/span><br><span>  */</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* Note 1: This functions depends on getting an unsigned=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   char. Both the i=
s*() functions and our own checks expect it</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+   this way.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+   Note 2: For CC_PRINT we just accept everything &gt;=3D =
32, so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   if we inge=
st non-ASCII UTF-8 we will classify it as</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+   printable since it will be &gt;=3D 128. Other enco=
dings are</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   not off=
icially supported.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+*=
/</span><br><span> bool</span><br><span> char_class(const unsigned char c, =
const unsigned int flags)</span><br><span> {</span><br><span>@@ -1019,7 +10=
27,8 @@</span><br><span> static inline bool</span><br><span> char_inc_exc(c=
onst char c, const unsigned int inclusive, const unsigned int exclusive)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
eturn char_class(c, inclusive) &amp;&amp; !char_class(c, exclusive);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return char_class((uns=
igned char)c, inclusive)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+           &amp;&amp; !char_class((unsigned char)c, exclusive);</span>=
<br><span> }</span><br><span> </span><br><span> bool</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1142?usp=3Demail">change 1142</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demai=
l">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1142?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I73bc163d48b2d6a954cd2319618=
26f33143fcd12 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1142 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--Q1FUgm2T0pM=--


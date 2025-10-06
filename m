From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 6 Oct 2025 16:07:05 +0000
References: <gerrit.1759766819000.Ia93bd8874e1b578d553720eedc274b974a462483@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <0b33b268d44cc8ef86e4cc5a5d82e4021b8a94ac-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="j9H6viu75nA="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: crypto: Add more
 explicit casts for OpenBSD
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

--j9H6viu75nA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1252?usp=3Demail

to review the following change.


Change subject: crypto: Add more explicit casts for OpenBSD
......................................................................

crypto: Add more explicit casts for OpenBSD

The compiler on OpenBSD is a bit more zealous
about these strlen's even though these are
static values that can be determined at
compile time...

This was missed in the previous commit
("crypto: Make some casts to int explicit")
because we don't use -Werror on OpenBSD, yet.

Change-Id: Ia93bd8874e1b578d553720eedc274b974a462483
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/crypto.c
1 file changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/52/1252/1

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 13635fb..026e874 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1361,8 +1361,8 @@
     int state =3D PARSE_INITIAL;

     /* constants */
-    const int hlen =3D strlen(static_key_head);
-    const int flen =3D strlen(static_key_foot);
+    const int hlen =3D (int)strlen(static_key_head);
+    const int flen =3D (int)strlen(static_key_foot);
     const int onekeylen =3D sizeof(key2->keys[0]);

     CLEAR(*key2);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1252?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia93bd8874e1b578d553720eedc274b974a462483
Gerrit-Change-Number: 1252
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--j9H6viu75nA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1252?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">crypto: Add more explicit casts for OpenBSD=
<br><br>The compiler on OpenBSD is a bit more zealous<br>about these strlen=
&#39;s even though these are<br>static values that can be determined at<br>=
compile time...<br><br>This was missed in the previous commit<br>(&quot;cry=
pto: Make some casts to int explicit&quot;)<br>because we don&#39;t use -We=
rror on OpenBSD, yet.<br><br>Change-Id: Ia93bd8874e1b578d553720eedc274b974a=
462483<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<=
br>M src/openvpn/crypto.c<br>1 file changed, 2 insertions(+), 2 deletions(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvp=
n refs/changes/52/1252/1</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto.c b/src/op=
envpn/crypto.c</span><br><span>index 13635fb..026e874 100644</span><br><spa=
n>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src/openvpn/crypto.c</sp=
an><br><span>@@ -1361,8 +1361,8 @@</span><br><span>     int state =3D PARSE=
_INITIAL;</span><br><span> </span><br><span>     /* constants */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    const int hlen =3D strlen(st=
atic_key_head);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    co=
nst int flen =3D strlen(static_key_foot);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const int hlen =3D (int)strlen(static_key_head);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int flen =
=3D (int)strlen(static_key_foot);</span><br><span>     const int onekeylen =
=3D sizeof(key2-&gt;keys[0]);</span><br><span> </span><br><span>     CLEAR(=
*key2);</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1252?usp=3Demail">change 1252</a>. To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.o=
penvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1252?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia93bd8874e1b578d553720eedc2=
74b974a462483 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1252 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--j9H6viu75nA=--


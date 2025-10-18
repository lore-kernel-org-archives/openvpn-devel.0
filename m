From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 18 Oct 2025 16:51:24 +0000
In-Reply-To: <gerrit.1760698129000.I2d1fbe7ec080beb931253d09c1b5227e9bf4e756@...2715...>
References: <gerrit.1760698129000.I2d1fbe7ec080beb931253d09c1b5227e9bf4e756@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <45a955fb8d010ec4f7290a3a464cafdd2634b189-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Do4dcLGdNHc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_util: Fix
 conversion warning in get_num_elements
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Do4dcLGdNHc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1281?usp=3Demail )


Change subject: ssl_util: Fix conversion warning in get_num_elements
......................................................................

ssl_util: Fix conversion warning in get_num_elements

Just use correct type.

Change-Id: I2d1fbe7ec080beb931253d09c1b5227e9bf4e756
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1281
Message-Id: <20251017204914.7548-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
421.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_util.c
1 file changed, 2 insertions(+), 11 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/81/1281/2

diff --git a/src/openvpn/ssl_util.c b/src/openvpn/ssl_util.c
index 50e8c03..fb7cf3e 100644
--- a/src/openvpn/ssl_util.c
+++ b/src/openvpn/ssl_util.c
@@ -290,21 +290,16 @@
     return NULL;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 int
 get_num_elements(const char *string, char delimiter)
 {
-    int string_len =3D strlen(string);
+    const size_t string_len =3D strlen(string);

     ASSERT(0 !=3D string_len);

     int element_count =3D 1;
     /* Get number of ciphers */
-    for (int i =3D 0; i < string_len; i++)
+    for (size_t i =3D 0; i < string_len; i++)
     {
         if (string[i] =3D=3D delimiter)
         {
@@ -314,7 +309,3 @@

     return element_count;
 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1281?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2d1fbe7ec080beb931253d09c1b5227e9bf4e756
Gerrit-Change-Number: 1281
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Do4dcLGdNHc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1281?usp=3Demail"=
>View Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">ssl_util: Fix conversion warning in get_n=
um_elements<br><br>Just use correct type.<br><br>Change-Id: I2d1fbe7ec080be=
b931253d09c1b5227e9bf4e756<br>Signed-off-by: Frank Lichtenheld &lt;frank@...1186...=
.2641...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1281<br>=
Message-Id: &lt;20251017204914.7548-1-gert@...1296...&gt;<br>URL: https://w=
ww.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33421.html<br>Si=
gned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/s=
sl_util.c<br>1 file changed, 2 insertions(+), 11 deletions(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/=
81/1281/2</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/ssl_util.c b/src/openvpn/ssl_uti=
l.c</span><br><span>index 50e8c03..fb7cf3e 100644</span><br><span>--- a/src=
/openvpn/ssl_util.c</span><br><span>+++ b/src/openvpn/ssl_util.c</span><br>=
<span>@@ -290,21 +290,16 @@</span><br><span>     return NULL;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconv=
ersion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> int</s=
pan><br><span> get_num_elements(const char *string, char delimiter)</span><=
br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int st=
ring_len =3D strlen(string);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const size_t string_len =3D strlen(string);</span><br><span> <=
/span><br><span>     ASSERT(0 !=3D string_len);</span><br><span> </span><br=
><span>     int element_count =3D 1;</span><br><span>     /* Get number of =
ciphers */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (in=
t i =3D 0; i &lt; string_len; i++)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    for (size_t i =3D 0; i &lt; string_len; i++)</span><br><=
span>     {</span><br><span>         if (string[i] =3D=3D delimiter)</span>=
<br><span>         {</span><br><span>@@ -314,7 +309,3 @@</span><br><span> <=
/span><br><span>     return element_count;</span><br><span> }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1281?usp=3Demail">change 1281</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demai=
l">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1281?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2d1fbe7ec080beb931253d09c1b=
5227e9bf4e756 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1281 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--Do4dcLGdNHc=--


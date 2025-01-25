From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 25 Jan 2025 10:18:36 +0000
In-Reply-To: <gerrit.1736865848000.Iaaf80c688ddff79ac9472d7237003713637c140b@...2715...>
References: <gerrit.1736865848000.Iaaf80c688ddff79ac9472d7237003713637c140b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0d29859ec18b79b8487cf6cc27b6bb58f0a912fe-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Wtd2aHhtOAo="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]:
 tls_crypt_v2_write_client_key_file: Fix missing-field-initializers co...
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

--Wtd2aHhtOAo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/86=
7?usp=3Demail )

Change subject: tls_crypt_v2_write_client_key_file: Fix missing-field-initi=
alizers compiler warning
......................................................................

tls_crypt_v2_write_client_key_file: Fix missing-field-initializers compiler=
 warning

GCC wants us to be more explicit here.

Change-Id: Iaaf80c688ddff79ac9472d7237003713637c140b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250125100838.20796-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
588.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/tls_crypt.c
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 76f06bc..0e5dfee 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -692,7 +692,7 @@
     struct buffer client_key_pem =3D { 0 };
     struct buffer dst =3D alloc_buf_gc(TLS_CRYPT_V2_CLIENT_KEY_LEN
                                      + TLS_CRYPT_V2_MAX_WKC_LEN, &gc);
-    struct key2 client_key =3D { 2 };
+    struct key2 client_key =3D { .n =3D 2 };

     if (!rand_bytes((void *)client_key.keys, sizeof(client_key.keys)))
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/867?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iaaf80c688ddff79ac9472d7237003713637c140b
Gerrit-Change-Number: 867
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--Wtd2aHhtOAo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/867?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">tls_crypt_v2_write_client_key_file: Fix missin=
g-field-initializers compiler warning<br><br>GCC wants us to be more explic=
it here.<br><br>Change-Id: Iaaf80c688ddff79ac9472d7237003713637c140b<br>Sig=
ned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Do=
ering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250125100838.20796-1-ger=
t@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1096...=
ourceforge.net/msg30588.html<br>Signed-off-by: Gert Doering &lt;gert@...1826...=
6...&gt;<br>---<br>M src/openvpn/tls_crypt.c<br>1 file changed, 1 insertion=
(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c</span><br=
><span>index 76f06bc..0e5dfee 100644</span><br><span>--- a/src/openvpn/tls_=
crypt.c</span><br><span>+++ b/src/openvpn/tls_crypt.c</span><br><span>@@ -6=
92,7 +692,7 @@</span><br><span>     struct buffer client_key_pem =3D { 0 };=
</span><br><span>     struct buffer dst =3D alloc_buf_gc(TLS_CRYPT_V2_CLIEN=
T_KEY_LEN</span><br><span>                                      + TLS_CRYPT=
_V2_MAX_WKC_LEN, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    struct key2 client_key =3D { 2 };</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct key2 client_key =3D { .n =3D 2 };</span><=
br><span> </span><br><span>     if (!rand_bytes((void *)client_key.keys, si=
zeof(client_key.keys)))</span><br><span>     {</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/867=
?usp=3Demail">change 867</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/867?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iaaf80c688ddff79ac9472d72370=
03713637c140b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 867 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--Wtd2aHhtOAo=--


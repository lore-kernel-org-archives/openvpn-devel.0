From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 2 Apr 2024 09:55:55 +0000
In-Reply-To: <gerrit.1712017317000.I5b14bf90bb07935f0bb84373ec4e62352752c03f@...2715...>
References: <gerrit.1712017317000.I5b14bf90bb07935f0bb84373ec4e62352752c03f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <51d8829d737bfe4c97a0896ae8a0de5be2b982f6-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Vt5OFx8NxWA="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Match ifdef for
 get_sigtype function with if ifdef of caller
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Vt5OFx8NxWA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/551?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Match ifdef for get_sigtype function with if ifdef of caller
......................................................................

Match ifdef for get_sigtype function with if ifdef of caller

These two ifdef needs to be the same otherwise the compiler will
break with a undefined function.

Change-Id: I5b14bf90bb07935f0bb84373ec4e62352752c03f
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240402063646.25490-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
512.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_openssl.c
1 file changed, 2 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/51/551/2

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 6f29c3d..a158617 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2166,7 +2166,8 @@
     EVP_PKEY_free(pkey);
 }

-#if !defined(LIBRESSL_VERSION_NUMBER)  && OPENSSL_VERSION_NUMBER >=3D 0x10=
10000fL
+#if (!defined(LIBRESSL_VERSION_NUMBER) && OPENSSL_VERSION_NUMBER >=3D 0x10=
10000fL) \
+    || (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER >=3D 0=
x3090000fL)
 /**
  * Translate an OpenSSL NID into a more human readable name
  * @param nid

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/551?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5b14bf90bb07935f0bb84373ec4e62352752c03f
Gerrit-Change-Number: 551
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--Vt5OFx8NxWA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
551?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Match ifdef for get_sigtype function with if ifdef o=
f caller<br><br>These two ifdef needs to be the same otherwise the compiler=
 will<br>break with a undefined function.<br><br>Change-Id: I5b14bf90bb0793=
5f0bb84373ec4e62352752c03f<br>Signed-off-by: Arne Schwabe &lt;arne@...2639...=
..&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt=
;20240402063646.25490-1-gert@...1296...&gt;<br>URL: https://www.mail-archiv=
e.com/openvpn-devel@lists.sourceforge.net/msg28512.html<br>Signed-off-by: G=
ert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/ssl_openssl.c<b=
r>1 file changed, 2 insertions(+), 1 deletion(-)<br><br></pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit.openvpn.net:29418/openvpn refs/changes/51/551/2</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span><br><span>index=
 6f29c3d..a158617 100644</span><br><span>--- a/src/openvpn/ssl_openssl.c</s=
pan><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><span>@@ -2166,7 +2=
166,8 @@</span><br><span>     EVP_PKEY_free(pkey);</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !defi=
ned(LIBRESSL_VERSION_NUMBER)  &amp;&amp; OPENSSL_VERSION_NUMBER &gt;=3D 0x1=
010000fL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if (!defin=
ed(LIBRESSL_VERSION_NUMBER) &amp;&amp; OPENSSL_VERSION_NUMBER &gt;=3D 0x101=
0000fL) \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    || (de=
fined(LIBRESSL_VERSION_NUMBER) &amp;&amp; LIBRESSL_VERSION_NUMBER &gt;=3D 0=
x3090000fL)</span><br><span> /**</span><br><span>  * Translate an OpenSSL N=
ID into a more human readable name</span><br><span>  * @param nid</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/551?usp=3Demail">change 551</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/5=
51?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5b14bf90bb07935f0bb84373ec4=
e62352752c03f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 551 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--Vt5OFx8NxWA=--


From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 2 Sep 2025 18:28:53 +0000
In-Reply-To: <gerrit.1753289942000.Ia5e0aad8a97d38f8d309a29ecfe3c578edff9595@...2715...>
References: <gerrit.1753289942000.Ia5e0aad8a97d38f8d309a29ecfe3c578edff9595@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1b03f0f6bab713ad7ec39ac6b1f7d1f4eda18e68-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oqxZq8EGjys="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_openssl: Fix
 type of sslopts argument to SSL_CTX_set_options
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

--oqxZq8EGjys=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#8) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1101?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: ssl_openssl: Fix type of sslopts argument to SSL_CTX_set_op=
tions
......................................................................

ssl_openssl: Fix type of sslopts argument to SSL_CTX_set_options

The argument changed type in OpenSSL 3.0.

Change-Id: Ia5e0aad8a97d38f8d309a29ecfe3c578edff9595
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20250826184148.21534-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
690.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_openssl.c
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/01/1101/8

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 1948d12..aa1ac11 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -308,7 +308,7 @@
     ASSERT(NULL !=3D ctx);

     /* process SSL options */
-    long sslopt =3D SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET;
+    uint64_t sslopt =3D SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET;
 #ifdef SSL_OP_CIPHER_SERVER_PREFERENCE
     sslopt |=3D SSL_OP_CIPHER_SERVER_PREFERENCE;
 #endif

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1101?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia5e0aad8a97d38f8d309a29ecfe3c578edff9595
Gerrit-Change-Number: 1101
Gerrit-PatchSet: 8
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--oqxZq8EGjys=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #8</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1101?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">ssl_openssl: Fix type of sslopts argument to SSL=
_CTX_set_options<br><br>The argument changed type in OpenSSL 3.0.<br><br>Ch=
ange-Id: Ia5e0aad8a97d38f8d309a29ecfe3c578edff9595<br>Signed-off-by: Frank =
Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-ope=
nvpn@...1227...&gt;<br>Message-Id: &lt;20250826184148.21534-1-gert@...1725...=
..&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...282...=
.net/msg32690.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<b=
r>---<br>M src/openvpn/ssl_openssl.c<br>1 file changed, 1 insertion(+), 1 d=
eletion(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/c=
hanges/01/1101/8</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_openssl.c b/src/openv=
pn/ssl_openssl.c</span><br><span>index 1948d12..aa1ac11 100644</span><br><s=
pan>--- a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_o=
penssl.c</span><br><span>@@ -308,7 +308,7 @@</span><br><span>     ASSERT(NU=
LL !=3D ctx);</span><br><span> </span><br><span>     /* process SSL options=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    long sslopt =
=3D SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    uint64_t sslopt =3D SSL_OP_SINGLE_DH_USE | SSL=
_OP_NO_TICKET;</span><br><span> #ifdef SSL_OP_CIPHER_SERVER_PREFERENCE</spa=
n><br><span>     sslopt |=3D SSL_OP_CIPHER_SERVER_PREFERENCE;</span><br><sp=
an> #endif</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1101?usp=3Demail">change 1101</a>. To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1101?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia5e0aad8a97d38f8d309a29ecfe=
3c578edff9595 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1101 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--oqxZq8EGjys=--


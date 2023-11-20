From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 20 Nov 2023 11:28:00 +0000
References: <gerrit.1700479678000.I6bdab3028c9bd679c31d4177a746a3ea505dcbbf@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <3294243313900bdfd258abc4d47910884fa3aab9-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cSlFO7YydM0="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Log SSL alerts more
 prominently
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--cSlFO7YydM0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/448?usp=3Demail

to review the following change.


Change subject: Log SSL alerts more prominently
......................................................................

Log SSL alerts more prominently

When we receive an SSL alert from a server we currently only log a
very cryptic OpenSSL error message:

   OpenSSL: error:0A00042E:SSL routines::tlsv1 alert protocol version:SSL a=
lert number 70

This also enables logging the much more readable SSL error message:

   Received fatal SSL alert: protocol version

which previously needed --verb 8 to be displayed (now verb 3). Also rework =
the
message to be better readable.

Change-Id: I6bdab3028c9bd679c31d4177a746a3ea505dcbbf
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/ssl_openssl.c
1 file changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/48/448/1

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 23e7623..82872bf 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -196,8 +196,8 @@
     }
     else if (where & SSL_CB_ALERT)
     {
-        dmsg(D_HANDSHAKE_VERBOSE, "SSL alert (%s): %s: %s",
-             where & SSL_CB_READ ? "read" : "write",
+        dmsg(D_TLS_DEBUG_LOW, "%s %s SSL alert: %s",
+             where & SSL_CB_READ ? "Received" : "Sent",
              SSL_alert_type_string_long(ret),
              SSL_alert_desc_string_long(ret));
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/448?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6bdab3028c9bd679c31d4177a746a3ea505dcbbf
Gerrit-Change-Number: 448
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--cSlFO7YydM0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/448?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Log SSL alerts more prominently<br><br>When we receive an SSL=
 alert from a server we currently only log a<br>very cryptic OpenSSL error =
message:<br><br>   OpenSSL: error:0A00042E:SSL routines::tlsv1 alert protoc=
ol version:SSL alert number 70<br><br>This also enables logging the much mo=
re readable SSL error message:<br><br>   Received fatal SSL alert: protocol=
 version<br><br>which previously needed --verb 8 to be displayed (now verb =
3). Also rework the<br>message to be better readable.<br><br>Change-Id: I6b=
dab3028c9bd679c31d4177a746a3ea505dcbbf<br>Signed-off-by: Arne Schwabe &lt;a=
rne@...1227...&gt;<br>---<br>M src/openvpn/ssl_openssl.c<br>1 file changed,=
 2 insertions(+), 2 deletions(-)<br><br></pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.ne=
t:29418/openvpn refs/changes/48/448/1</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_=
openssl.c b/src/openvpn/ssl_openssl.c</span><br><span>index 23e7623..82872b=
f 100644</span><br><span>--- a/src/openvpn/ssl_openssl.c</span><br><span>++=
+ b/src/openvpn/ssl_openssl.c</span><br><span>@@ -196,8 +196,8 @@</span><br=
><span>     }</span><br><span>     else if (where &amp; SSL_CB_ALERT)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    dmsg(D_HANDSHAKE_VERBOSE, &quot;SSL alert (%s): %s: %s&quot;,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-             where &amp; SSL_CB=
_READ ? &quot;read&quot; : &quot;write&quot;,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        dmsg(D_TLS_DEBUG_LOW, &quot;%s %s SSL ale=
rt: %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
       where &amp; SSL_CB_READ ? &quot;Received&quot; : &quot;Sent&quot;,</=
span><br><span>              SSL_alert_type_string_long(ret),</span><br><sp=
an>              SSL_alert_desc_string_long(ret));</span><br><span>     }</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/448?usp=3Demail">change 448</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/448?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6bdab3028c9bd679c31d4177a74=
6a3ea505dcbbf </div>
<div style=3D"display:none"> Gerrit-Change-Number: 448 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--cSlFO7YydM0=--


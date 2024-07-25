From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 25 Jul 2024 11:38:13 +0000
In-Reply-To: <gerrit.1721830475000.I975057c20c1457ef88111f8d142ca3fd2039d5ff@...2715...>
References: <gerrit.1721830475000.I975057c20c1457ef88111f8d142ca3fd2039d5ff@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <34d2e8069354bf95436bdf4eb4f93534f57852af-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cldhpIZ9fEA="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: add and send
 IV_PROTO_DNS_OPTION_V2 flag
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--cldhpIZ9fEA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 d12fk. ( http://gerrit.openvpn.net/c/openvpn/+/680?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: add and send IV_PROTO_DNS_OPTION_V2 flag
......................................................................

add and send IV_PROTO_DNS_OPTION_V2 flag

Incompatible changes to the --dns server address and --dns server
exclude-domains options were introduced after the code for handling them
was released. Add and send a new IV_PROTO flag, so servers which act on
the flags set can differentiate between clients which have implemented
--dns and those which just support the new option. This enables them to
decide which variant of options to send to the client.

Change-Id: I975057c20c1457ef88111f8d142ca3fd2039d5ff
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20240725112248.21075-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
970.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl.c
M src/openvpn/ssl.h
2 files changed, 6 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/80/680/2

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e0e9591..14c38cf 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1900,8 +1900,8 @@
         /* support for P_DATA_V2 */
         int iv_proto =3D IV_PROTO_DATA_V2;

-        /* support for the --dns option */
-        iv_proto |=3D IV_PROTO_DNS_OPTION;
+        /* support for the latest --dns option */
+        iv_proto |=3D IV_PROTO_DNS_OPTION_V2;

         /* support for exit notify via control channel */
         iv_proto |=3D IV_PROTO_CC_EXIT_NOTIFY;
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 1a45048..6c2bfc3 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -94,7 +94,7 @@
  * result. */
 #define IV_PROTO_NCP_P2P         (1<<5)

-/** Supports the --dns option introduced in version 2.6 */
+/** Supports the --dns option introduced in version 2.6. Not sent anymore.=
 */
 #define IV_PROTO_DNS_OPTION      (1<<6)

 /** Support for explicit exit notify via control channel
@@ -107,6 +107,9 @@
 /** Support to dynamic tls-crypt (renegotiation with TLS-EKM derived tls-c=
rypt key) */
 #define IV_PROTO_DYN_TLS_CRYPT   (1<<9)

+/** Supports the --dns option after all the incompatible changes */
+#define IV_PROTO_DNS_OPTION_V2   (1<<11)
+
 /* Default field in X509 to be username */
 #define X509_USERNAME_FIELD_DEFAULT "CN"


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/680?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I975057c20c1457ef88111f8d142ca3fd2039d5ff
Gerrit-Change-Number: 680
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--cldhpIZ9fEA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by d12fk.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/680?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">add and send IV_PROTO_DNS_OPTION_V2 flag<br><br>=
Incompatible changes to the --dns server address and --dns server<br>exclud=
e-domains options were introduced after the code for handling them<br>was r=
eleased. Add and send a new IV_PROTO flag, so servers which act on<br>the f=
lags set can differentiate between clients which have implemented<br>--dns =
and those which just support the new option. This enables them to<br>decide=
 which variant of options to send to the client.<br><br>Change-Id: I975057c=
20c1457ef88111f8d142ca3fd2039d5ff<br>Signed-off-by: Heiko Hund &lt;heiko@...1186...=
.2662...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>M=
essage-Id: &lt;20240725112248.21075-1-gert@...1296...&gt;<br>URL: https://w=
ww.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28970.html<br>Si=
gned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/s=
sl.c<br>M src/openvpn/ssl.h<br>2 files changed, 6 insertions(+), 3 deletion=
s(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes=
/80/680/2</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span>=
<br><span>index e0e9591..14c38cf 100644</span><br><span>--- a/src/openvpn/s=
sl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -1900,8 +19=
00,8 @@</span><br><span>         /* support for P_DATA_V2 */</span><br><spa=
n>         int iv_proto =3D IV_PROTO_DATA_V2;</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        /* support for the --dns =
option */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        iv_p=
roto |=3D IV_PROTO_DNS_OPTION;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        /* support for the latest --dns option */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        iv_proto |=3D IV_PROTO_DNS=
_OPTION_V2;</span><br><span> </span><br><span>         /* support for exit =
notify via control channel */</span><br><span>         iv_proto |=3D IV_PRO=
TO_CC_EXIT_NOTIFY;</span><br><span>diff --git a/src/openvpn/ssl.h b/src/ope=
nvpn/ssl.h</span><br><span>index 1a45048..6c2bfc3 100644</span><br><span>--=
- a/src/openvpn/ssl.h</span><br><span>+++ b/src/openvpn/ssl.h</span><br><sp=
an>@@ -94,7 +94,7 @@</span><br><span>  * result. */</span><br><span> #defin=
e IV_PROTO_NCP_P2P         (1&lt;&lt;5)</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-/** Supports the --dns option introduce=
d in version 2.6 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/** Supports the --dns option introduced in version 2.6. Not sent anymore. =
*/</span><br><span> #define IV_PROTO_DNS_OPTION      (1&lt;&lt;6)</span><br=
><span> </span><br><span> /** Support for explicit exit notify via control =
channel</span><br><span>@@ -107,6 +107,9 @@</span><br><span> /** Support to=
 dynamic tls-crypt (renegotiation with TLS-EKM derived tls-crypt key) */</s=
pan><br><span> #define IV_PROTO_DYN_TLS_CRYPT   (1&lt;&lt;9)</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Supports the=
 --dns option after all the incompatible changes */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define IV_PROTO_DNS_OPTION_V2   (1&lt;&l=
t;11)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> /* Default field in X509 to be username */</span><br><span> #define X50=
9_USERNAME_FIELD_DEFAULT &quot;CN&quot;</span><br><span> </span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/680?usp=3Demail">change 680</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/680?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I975057c20c1457ef88111f8d142=
ca3fd2039d5ff </div>
<div style=3D"display:none"> Gerrit-Change-Number: 680 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--cldhpIZ9fEA=--


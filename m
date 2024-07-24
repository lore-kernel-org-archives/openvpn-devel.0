From: "d12fk (Code Review)" <gerrit@...515...>
Date: Wed, 24 Jul 2024 14:14:37 +0000
References: <gerrit.1721830475000.I975057c20c1457ef88111f8d142ca3fd2039d5ff@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1f7a7eb17635cc300a54855f2a1b8aa86256e5d3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OBaUkthJHJA="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--OBaUkthJHJA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/680?usp=3Demail

to review the following change.


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
---
M src/openvpn/ssl.c
M src/openvpn/ssl.h
2 files changed, 6 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/80/680/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--OBaUkthJHJA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/680?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">add and send IV_PROTO_DNS_OPTION_V2 flag<br><br>Incompatible =
changes to the --dns server address and --dns server<br>exclude-domains opt=
ions were introduced after the code for handling them<br>was released. Add =
and send a new IV_PROTO flag, so servers which act on<br>the flags set can =
differentiate between clients which have implemented<br>--dns and those whi=
ch just support the new option. This enables them to<br>decide which varian=
t of options to send to the client.<br><br>Change-Id: I975057c20c1457ef8811=
1f8d142ca3fd2039d5ff<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<=
br>---<br>M src/openvpn/ssl.c<br>M src/openvpn/ssl.h<br>2 files changed, 6 =
insertions(+), 3 deletions(-)<br><br></pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2=
9418/openvpn refs/changes/80/680/1</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl.c b=
/src/openvpn/ssl.c</span><br><span>index e0e9591..14c38cf 100644</span><br>=
<span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span=
><br><span>@@ -1900,8 +1900,8 @@</span><br><span>         /* support for P_=
DATA_V2 */</span><br><span>         int iv_proto =3D IV_PROTO_DATA_V2;</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
/* support for the --dns option */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        iv_proto |=3D IV_PROTO_DNS_OPTION;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        /* support for the latest --dns=
 option */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
v_proto |=3D IV_PROTO_DNS_OPTION_V2;</span><br><span> </span><br><span>    =
     /* support for exit notify via control channel */</span><br><span>    =
     iv_proto |=3D IV_PROTO_CC_EXIT_NOTIFY;</span><br><span>diff --git a/sr=
c/openvpn/ssl.h b/src/openvpn/ssl.h</span><br><span>index 1a45048..6c2bfc3 =
100644</span><br><span>--- a/src/openvpn/ssl.h</span><br><span>+++ b/src/op=
envpn/ssl.h</span><br><span>@@ -94,7 +94,7 @@</span><br><span>  * result. *=
/</span><br><span> #define IV_PROTO_NCP_P2P         (1&lt;&lt;5)</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/** Supports t=
he --dns option introduced in version 2.6 */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/** Supports the --dns option introduced in versio=
n 2.6. Not sent anymore. */</span><br><span> #define IV_PROTO_DNS_OPTION   =
   (1&lt;&lt;6)</span><br><span> </span><br><span> /** Support for explicit=
 exit notify via control channel</span><br><span>@@ -107,6 +107,9 @@</span>=
<br><span> /** Support to dynamic tls-crypt (renegotiation with TLS-EKM der=
ived tls-crypt key) */</span><br><span> #define IV_PROTO_DYN_TLS_CRYPT   (1=
&lt;&lt;9)</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/** Supports the --dns option after all the incompatible changes *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IV_PROTO_D=
NS_OPTION_V2   (1&lt;&lt;11)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> /* Default field in X509 to be username */</span=
><br><span> #define X509_USERNAME_FIELD_DEFAULT &quot;CN&quot;</span><br><s=
pan> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/680?usp=3Demail">change 680</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/680?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I975057c20c1457ef88111f8d142=
ca3fd2039d5ff </div>
<div style=3D"display:none"> Gerrit-Change-Number: 680 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--OBaUkthJHJA=--


From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 27 Aug 2025 09:25:42 +0000
In-Reply-To: <gerrit.1753360288000.I89820c76e2e099f7acb817c71c8aeb83736ac556@...2715...>
References: <gerrit.1753360288000.I89820c76e2e099f7acb817c71c8aeb83736ac556@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d55c08d8aec15f13722b2f3df504bb3590aa3607-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OP+KRx9qCo0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: crypto: Make sure
 crypto flags are treated as unsigned
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

--OP+KRx9qCo0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
03?usp=3Demail )

Change subject: crypto: Make sure crypto flags are treated as unsigned
......................................................................

crypto: Make sure crypto flags are treated as unsigned

crypto_options.flags is already unsigned, make sure the
flags are as well to avoid spurious conversion warnings.

Change-Id: I89820c76e2e099f7acb817c71c8aeb83736ac556
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20250826184935.22110-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
688.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto.h
1 file changed, 9 insertions(+), 9 deletions(-)




diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index cee4145..efd7f60 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -342,39 +342,39 @@
      *   keeping state between successive
      *   OpenVPN process startups. */
=20
-#define CO_PACKET_ID_LONG_FORM         (1 << 0)
+#define CO_PACKET_ID_LONG_FORM         (1u << 0)
     /**< Bit-flag indicating whether to use
      *   OpenVPN's long packet ID format. */
-#define CO_IGNORE_PACKET_ID            (1 << 1)
+#define CO_IGNORE_PACKET_ID            (1u << 1)
     /**< Bit-flag indicating whether to ignore
      *   the packet ID of a received packet.
      *   This flag is used during processing
      *   of the first packet received from a
      *   client. */
-#define CO_MUTE_REPLAY_WARNINGS        (1 << 2)
+#define CO_MUTE_REPLAY_WARNINGS        (1u << 2)
     /**< Bit-flag indicating not to display
      *   replay warnings. */
-#define CO_USE_TLS_KEY_MATERIAL_EXPORT (1 << 3)
+#define CO_USE_TLS_KEY_MATERIAL_EXPORT (1u << 3)
     /**< Bit-flag indicating that data channel key derivation
      * is done using TLS keying material export [RFC5705]
      */
-#define CO_RESEND_WKC                  (1 << 4)
+#define CO_RESEND_WKC                  (1u << 4)
     /**< Bit-flag indicating that the client is expected to
      * resend the wrapped client key with the 2nd packet (packet-id 1)
      * like with the HARD_RESET_CLIENT_V3 packet */
-#define CO_FORCE_TLSCRYPTV2_COOKIE     (1 << 5)
+#define CO_FORCE_TLSCRYPTV2_COOKIE     (1u << 5)
     /**< Bit-flag indicating that we do not allow clients that do
      * not support resending the wrapped client key (WKc) with the
      * third packet of the three-way handshake */
-#define CO_USE_CC_EXIT_NOTIFY          (1 << 6)
+#define CO_USE_CC_EXIT_NOTIFY          (1u << 6)
     /**< Bit-flag indicating that explicit exit notifies should be
      * sent via the control channel instead of using an OCC message
      */
-#define CO_USE_DYNAMIC_TLS_CRYPT       (1 << 7)
+#define CO_USE_DYNAMIC_TLS_CRYPT       (1u << 7)
     /**< Bit-flag indicating that renegotiations are using tls-crypt
      *   with a TLS-EKM derived key.
      */
-#define CO_EPOCH_DATA_KEY_FORMAT       (1 << 8)
+#define CO_EPOCH_DATA_KEY_FORMAT       (1u << 8)
     /**< Bit-flag indicating the epoch the data format. This format
      * has the AEAD tag at the end of the packet and is using a longer
      * 64-bit packet id that is split into a 16 bit epoch and 48 bit

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1103?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I89820c76e2e099f7acb817c71c8aeb83736ac556
Gerrit-Change-Number: 1103
Gerrit-PatchSet: 9
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--OP+KRx9qCo0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1103?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">crypto: Make sure crypto flags are treated as=
 unsigned<br><br>crypto_options.flags is already unsigned, make sure the<br=
>flags are as well to avoid spurious conversion warnings.<br><br>Change-Id:=
 I89820c76e2e099f7acb817c71c8aeb83736ac556<br>Signed-off-by: Frank Lichtenh=
eld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...493...=
1227...&gt;<br>Message-Id: &lt;20250826184935.22110-1-gert@...1296...&gt;<b=
r>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg=
32688.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br=
>M src/openvpn/crypto.h<br>1 file changed, 9 insertions(+), 9 deletions(-)<=
br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h</span><br><span=
>index cee4145..efd7f60 100644</span><br><span>--- a/src/openvpn/crypto.h</=
span><br><span>+++ b/src/openvpn/crypto.h</span><br><span>@@ -342,39 +342,3=
9 @@</span><br><span>      *   keeping state between successive</span><br><=
span>      *   OpenVPN process startups. */</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#define CO_PACKET_ID_LONG_FORM     =
    (1 &lt;&lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define CO_PACKET_ID_LONG_FORM         (1u &lt;&lt; 0)</span><br><span>     =
/**&lt; Bit-flag indicating whether to use</span><br><span>      *   OpenVP=
N&#39;s long packet ID format. */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#define CO_IGNORE_PACKET_ID            (1 &lt;&lt; 1)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define CO_IGNORE_PACKET_ID  =
          (1u &lt;&lt; 1)</span><br><span>     /**&lt; Bit-flag indicating =
whether to ignore</span><br><span>      *   the packet ID of a received pac=
ket.</span><br><span>      *   This flag is used during processing</span><b=
r><span>      *   of the first packet received from a</span><br><span>     =
 *   client. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defin=
e CO_MUTE_REPLAY_WARNINGS        (1 &lt;&lt; 2)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define CO_MUTE_REPLAY_WARNINGS        (1u &lt;=
&lt; 2)</span><br><span>     /**&lt; Bit-flag indicating not to display</sp=
an><br><span>      *   replay warnings. */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define CO_USE_TLS_KEY_MATERIAL_EXPORT (1 &lt;&lt; 3)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CO_USE_TLS_K=
EY_MATERIAL_EXPORT (1u &lt;&lt; 3)</span><br><span>     /**&lt; Bit-flag in=
dicating that data channel key derivation</span><br><span>      * is done u=
sing TLS keying material export [RFC5705]</span><br><span>      */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define CO_RESEND_WKC         =
         (1 &lt;&lt; 4)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define CO_RESEND_WKC                  (1u &lt;&lt; 4)</span><br><span>=
     /**&lt; Bit-flag indicating that the client is expected to</span><br><=
span>      * resend the wrapped client key with the 2nd packet (packet-id 1=
)</span><br><span>      * like with the HARD_RESET_CLIENT_V3 packet */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CO_FORCE_TLSCRYPTV=
2_COOKIE     (1 &lt;&lt; 5)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define CO_FORCE_TLSCRYPTV2_COOKIE     (1u &lt;&lt; 5)</span><br><s=
pan>     /**&lt; Bit-flag indicating that we do not allow clients that do</=
span><br><span>      * not support resending the wrapped client key (WKc) w=
ith the</span><br><span>      * third packet of the three-way handshake */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CO_USE_CC_EXIT=
_NOTIFY          (1 &lt;&lt; 6)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define CO_USE_CC_EXIT_NOTIFY          (1u &lt;&lt; 6)</span><b=
r><span>     /**&lt; Bit-flag indicating that explicit exit notifies should=
 be</span><br><span>      * sent via the control channel instead of using a=
n OCC message</span><br><span>      */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#define CO_USE_DYNAMIC_TLS_CRYPT       (1 &lt;&lt; 7)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CO_USE_DYNAMIC_T=
LS_CRYPT       (1u &lt;&lt; 7)</span><br><span>     /**&lt; Bit-flag indica=
ting that renegotiations are using tls-crypt</span><br><span>      *   with=
 a TLS-EKM derived key.</span><br><span>      */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#define CO_EPOCH_DATA_KEY_FORMAT       (1 &lt;&l=
t; 8)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CO_EPO=
CH_DATA_KEY_FORMAT       (1u &lt;&lt; 8)</span><br><span>     /**&lt; Bit-f=
lag indicating the epoch the data format. This format</span><br><span>     =
 * has the AEAD tag at the end of the packet and is using a longer</span><b=
r><span>      * 64-bit packet id that is split into a 16 bit epoch and 48 b=
it</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1103?usp=3Demail">change 1103</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1103?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I89820c76e2e099f7acb817c71c8=
aeb83736ac556 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1103 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--OP+KRx9qCo0=--


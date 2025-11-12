From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 12 Nov 2025 15:54:29 +0000
In-Reply-To: <gerrit.1761324750000.I71e9d4a61d37483685723c16e98f59755694cadf@...2715...>
References: <gerrit.1761324750000.I71e9d4a61d37483685723c16e98f59755694cadf@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <04e404c20f25da19e28b19424f91f99d54b3094e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dkDisBwVIAY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: change return
 type of calc_control_channel_frame_overhead to size_t
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

--dkDisBwVIAY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1297?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: ssl: change return type of calc_control_channel_frame_overh=
ead to size_t
......................................................................

ssl: change return type of calc_control_channel_frame_overhead to size_t

This avoids dealing with conversion warnings inside
the function. Since we only add values that are
supposed to be positive this should be safe.

Note that we now cast the return value to int at
the caller side. There we actually substract it and
want to catch the case where the result gets negative.
Since all the involved values are quite small compared
to INT_MAX I decided to just cast it without further
checks.

Change-Id: I71e9d4a61d37483685723c16e98f59755694cadf
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1297
Message-Id: <20251111172437.7634-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
326.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl.c
1 file changed, 3 insertions(+), 12 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/97/1297/5

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e21ac78..d7f55dd 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -179,21 +179,16 @@
     frame->tun_mtu =3D max_int(frame->tun_mtu, TLS_CHANNEL_MTU_MIN);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /**
  * calculate the maximum overhead that control channel frames have
  * This includes header, op code and everything apart from the
  * payload itself. This method is a bit pessimistic and might give higher
  * overhead than we actually have */
-static int
+static size_t
 calc_control_channel_frame_overhead(const struct tls_session *session)
 {
     const struct key_state *ks =3D &session->key[KS_PRIMARY];
-    int overhead =3D 0;
+    size_t overhead =3D 0;

     /* opcode */
     overhead +=3D 1;
@@ -226,10 +221,6 @@
     return overhead;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 init_ssl_lib(void)
 {
@@ -2650,7 +2641,7 @@
     int max_pkt_len =3D min_int(TLS_CHANNEL_BUF_SIZE, session->opt->frame.=
tun_mtu);

     /* Subtract overhead */
-    max_pkt_len -=3D calc_control_channel_frame_overhead(session);
+    max_pkt_len -=3D (int)calc_control_channel_frame_overhead(session);

     /* calculate total available length for outgoing tls ciphertext */
     int maxlen =3D max_pkt_len * rel_avail;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1297?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I71e9d4a61d37483685723c16e98f59755694cadf
Gerrit-Change-Number: 1297
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--dkDisBwVIAY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #5</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1297?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">ssl: change return type of calc=
_control_channel_frame_overhead to size_t<br><br>This avoids dealing with c=
onversion warnings inside<br>the function. Since we only add values that ar=
e<br>supposed to be positive this should be safe.<br><br>Note that we now c=
ast the return value to int at<br>the caller side. There we actually substr=
act it and<br>want to catch the case where the result gets negative.<br>Sin=
ce all the involved values are quite small compared<br>to INT_MAX I decided=
 to just cast it without further<br>checks.<br><br>Change-Id: I71e9d4a61d37=
483685723c16e98f59755694cadf<br>Signed-off-by: Frank Lichtenheld &lt;frank@=
...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br=
>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1297<br>Message-Id: &lt=
;20251111172437.7634-1-gert@...1296...&gt;<br>URL: https://www.mail-archive=
.com/openvpn-devel@lists.sourceforge.net/msg34326.html<br>Signed-off-by: Ge=
rt Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/ssl.c<br>1 file =
changed, 3 insertions(+), 12 deletions(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit.openvpn.net:29418/openvpn refs/changes/97/1297/5</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index e21a=
c78..d7f55dd 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span=
>+++ b/src/openvpn/ssl.c</span><br><span>@@ -179,21 +179,16 @@</span><br><s=
pan>     frame-&gt;tun_mtu =3D max_int(frame-&gt;tun_mtu, TLS_CHANNEL_MTU_M=
IN);</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic igno=
red &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> /**</span><br><span>  * calculate the maximum overhead that contr=
ol channel frames have</span><br><span>  * This includes header, op code an=
d everything apart from the</span><br><span>  * payload itself. This method=
 is a bit pessimistic and might give higher</span><br><span>  * overhead th=
an we actually have */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static s=
ize_t</span><br><span> calc_control_channel_frame_overhead(const struct tls=
_session *session)</span><br><span> {</span><br><span>     const struct key=
_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    int overhead =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    size_t overhead =3D 0;</span><br><span> =
</span><br><span>     /* opcode */</span><br><span>     overhead +=3D 1;</s=
pan><br><span>@@ -226,10 +221,6 @@</span><br><span>     return overhead;</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span> init_ssl_l=
ib(void)</span><br><span> {</span><br><span>@@ -2650,7 +2641,7 @@</span><br=
><span>     int max_pkt_len =3D min_int(TLS_CHANNEL_BUF_SIZE, session-&gt;o=
pt-&gt;frame.tun_mtu);</span><br><span> </span><br><span>     /* Subtract o=
verhead */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    max_pkt=
_len -=3D calc_control_channel_frame_overhead(session);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    max_pkt_len -=3D (int)calc_control_=
channel_frame_overhead(session);</span><br><span> </span><br><span>     /* =
calculate total available length for outgoing tls ciphertext */</span><br><=
span>     int maxlen =3D max_pkt_len * rel_avail;</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1297?usp=3Demail">change 1297</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">=
settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/129=
7?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I71e9d4a61d37483685723c16e98=
f59755694cadf </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1297 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--dkDisBwVIAY=--


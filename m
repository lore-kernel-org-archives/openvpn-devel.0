From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 12 Nov 2025 13:38:45 +0000
In-Reply-To: <gerrit.1762517501000.Ic90c5a0e48bda4a02d5e11c4c161f388cc8805af@...2715...>
References: <gerrit.1762517501000.Ic90c5a0e48bda4a02d5e11c4c161f388cc8805af@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ab8c0f04d881e72a74c29995872c85b177112f23-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ybWwmwW4AzI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: Change
 tls_send_payload size argument to size_t
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

--ybWwmwW4AzI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1355?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: ssl: Change tls_send_payload size argument to size_t
......................................................................

ssl: Change tls_send_payload size argument to size_t

There is only one caller of this function and it
wants it to be size_t. So move the size_t to int
conversion one step down in the call chain. Do not
switch key_state_write_plaintext_const, yet, since
that is a backend function and so needs way more
work.

Change-Id: Ic90c5a0e48bda4a02d5e11c4c161f388cc8805af
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1355
Message-Id: <20251111155239.31747-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
320.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/forward.c
M src/openvpn/ssl.c
M src/openvpn/ssl.h
3 files changed, 10 insertions(+), 9 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/55/1355/2

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index c355f66..aa1f858 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -365,11 +365,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 bool
 send_control_channel_string_dowork(struct tls_session *session, const char=
 *str,
                                    msglvl_t msglevel)
@@ -834,6 +829,11 @@
 #endif /* ENABLE_MANAGEMENT */
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static void
 check_coarse_timers(struct context *c)
 {
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 908854a..398c9ae 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -4032,7 +4032,7 @@
  */

 bool
-tls_send_payload(struct key_state *ks, const uint8_t *data, int size)
+tls_send_payload(struct key_state *ks, const uint8_t *data, size_t size)
 {
     bool ret =3D false;

@@ -4042,7 +4042,8 @@

     if (ks->state >=3D S_ACTIVE)
     {
-        if (key_state_write_plaintext_const(&ks->ks_ssl, data, size) =3D=
=3D 1)
+        ASSERT(size <=3D INT_MAX);
+        if (key_state_write_plaintext_const(&ks->ks_ssl, data, (int)size) =
=3D=3D 1)
         {
             ret =3D true;
         }
@@ -4053,7 +4054,7 @@
         {
             ks->paybuf =3D buffer_list_new();
         }
-        buffer_list_push_data(ks->paybuf, data, (size_t)size);
+        buffer_list_push_data(ks->paybuf, data, size);
         ret =3D true;
     }

diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index ffcc7c4..db8a798 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -426,7 +426,7 @@
 /*
  * Send a payload over the TLS control channel
  */
-bool tls_send_payload(struct key_state *ks, const uint8_t *data, int size);
+bool tls_send_payload(struct key_state *ks, const uint8_t *data, size_t si=
ze);

 /*
  * Receive a payload through the TLS control channel

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1355?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic90c5a0e48bda4a02d5e11c4c161f388cc8805af
Gerrit-Change-Number: 1355
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ybWwmwW4AzI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1355?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">ssl: Change tls_send_payload si=
ze argument to size_t<br><br>There is only one caller of this function and =
it<br>wants it to be size_t. So move the size_t to int<br>conversion one st=
ep down in the call chain. Do not<br>switch key_state_write_plaintext_const=
, yet, since<br>that is a backend function and so needs way more<br>work.<b=
r><br>Change-Id: Ic90c5a0e48bda4a02d5e11c4c161f388cc8805af<br>Signed-off-by=
: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;=
arne-openvpn@...1227...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/ope=
nvpn/+/1355<br>Message-Id: &lt;20251111155239.31747-1-gert@...1296...&gt;<b=
r>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg=
34320.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br=
>M src/openvpn/forward.c<br>M src/openvpn/ssl.c<br>M src/openvpn/ssl.h<br>3=
 files changed, 10 insertions(+), 9 deletions(-)<br><br></pre><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/55/1355/2</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><=
span>index c355f66..aa1f858 100644</span><br><span>--- a/src/openvpn/forwar=
d.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -365,11 =
+365,6 @@</span><br><span>     }</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || de=
fined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#prag=
ma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span> bool</span><br><span> send_control_ch=
annel_string_dowork(struct tls_session *session, const char *str,</span><br=
><span>                                    msglvl_t msglevel)</span><br><sp=
an>@@ -834,6 +829,11 @@</span><br><span> #endif /* ENABLE_MANAGEMENT */</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignore=
d &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> static void</span><br><span> check_coarse_timers(struct context=
 *c)</span><br><span> {</span><br><span>diff --git a/src/openvpn/ssl.c b/sr=
c/openvpn/ssl.c</span><br><span>index 908854a..398c9ae 100644</span><br><sp=
an>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><b=
r><span>@@ -4032,7 +4032,7 @@</span><br><span>  */</span><br><span> </span>=
<br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_se=
nd_payload(struct key_state *ks, const uint8_t *data, int size)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+tls_send_payload(struct key_sta=
te *ks, const uint8_t *data, size_t size)</span><br><span> {</span><br><spa=
n>     bool ret =3D false;</span><br><span> </span><br><span>@@ -4042,7 +40=
42,8 @@</span><br><span> </span><br><span>     if (ks-&gt;state &gt;=3D S_A=
CTIVE)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        if (key_state_write_plaintext_const(&amp;ks-&gt;ks_ssl, dat=
a, size) =3D=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       ASSERT(size &lt;=3D INT_MAX);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (key_state_write_plaintext_const(&amp;ks-&gt;ks=
_ssl, data, (int)size) =3D=3D 1)</span><br><span>         {</span><br><span=
>             ret =3D true;</span><br><span>         }</span><br><span>@@ -=
4053,7 +4054,7 @@</span><br><span>         {</span><br><span>             k=
s-&gt;paybuf =3D buffer_list_new();</span><br><span>         }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        buffer_list_push_data(ks-&=
gt;paybuf, data, (size_t)size);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        buffer_list_push_data(ks-&gt;paybuf, data, size);</span=
><br><span>         ret =3D true;</span><br><span>     }</span><br><span> <=
/span><br><span>diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h</span><b=
r><span>index ffcc7c4..db8a798 100644</span><br><span>--- a/src/openvpn/ssl=
.h</span><br><span>+++ b/src/openvpn/ssl.h</span><br><span>@@ -426,7 +426,7=
 @@</span><br><span> /*</span><br><span>  * Send a payload over the TLS con=
trol channel</span><br><span>  */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-bool tls_send_payload(struct key_state *ks, const uint8_t *data=
, int size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool tl=
s_send_payload(struct key_state *ks, const uint8_t *data, size_t size);</sp=
an><br><span> </span><br><span> /*</span><br><span>  * Receive a payload th=
rough the TLS control channel</span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1355?usp=3Demail">ch=
ange 1355</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1355?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic90c5a0e48bda4a02d5e11c4c16=
1f388cc8805af </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1355 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--ybWwmwW4AzI=--


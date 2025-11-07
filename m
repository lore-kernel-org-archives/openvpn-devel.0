From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 7 Nov 2025 12:11:47 +0000
References: <gerrit.1762517501000.Ic90c5a0e48bda4a02d5e11c4c161f388cc8805af@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <f62388f7b538ed62194bb5db67beee10f044a59e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XqY4EPrsXQQ="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--XqY4EPrsXQQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1355?usp=3Demail

to review the following change.


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
---
M src/openvpn/forward.c
M src/openvpn/ssl.c
M src/openvpn/ssl.h
3 files changed, 10 insertions(+), 9 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/55/1355/1

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 5bbac13..cffb310 100644
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
@@ -827,6 +822,11 @@
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic90c5a0e48bda4a02d5e11c4c161f388cc8805af
Gerrit-Change-Number: 1355
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--XqY4EPrsXQQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1355?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">ssl: Change tls_send_payload size argument =
to size_t<br><br>There is only one caller of this function and it<br>wants =
it to be size_t. So move the size_t to int<br>conversion one step down in t=
he call chain. Do not<br>switch key_state_write_plaintext_const, yet, since=
<br>that is a backend function and so needs way more<br>work.<br><br>Change=
-Id: Ic90c5a0e48bda4a02d5e11c4c161f388cc8805af<br>Signed-off-by: Frank Lich=
tenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/forward.c<br>M src=
/openvpn/ssl.c<br>M src/openvpn/ssl.h<br>3 files changed, 10 insertions(+),=
 9 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.ne=
t:29418/openvpn refs/changes/55/1355/1</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/for=
ward.c b/src/openvpn/forward.c</span><br><span>index 5bbac13..cffb310 10064=
4</span><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/ope=
nvpn/forward.c</span><br><span>@@ -365,11 +365,6 @@</span><br><span>     }<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &=
quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> bool</span><br><span> send_control_channel_string_dowork(struct tls_se=
ssion *session, const char *str,</span><br><span>                          =
          msglvl_t msglevel)</span><br><span>@@ -827,6 +822,11 @@</span><br=
><span> #endif /* ENABLE_MANAGEMENT */</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC_=
_) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br=
><span> check_coarse_timers(struct context *c)</span><br><span> {</span><br=
><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>i=
ndex 908854a..398c9ae 100644</span><br><span>--- a/src/openvpn/ssl.c</span>=
<br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -4032,7 +4032,7 @@</sp=
an><br><span>  */</span><br><span> </span><br><span> bool</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-tls_send_payload(struct key_state *ks, =
const uint8_t *data, int size)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+tls_send_payload(struct key_state *ks, const uint8_t *data, size=
_t size)</span><br><span> {</span><br><span>     bool ret =3D false;</span>=
<br><span> </span><br><span>@@ -4042,7 +4042,8 @@</span><br><span> </span><=
br><span>     if (ks-&gt;state &gt;=3D S_ACTIVE)</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (key_state_wri=
te_plaintext_const(&amp;ks-&gt;ks_ssl, data, size) =3D=3D 1)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(size &lt;=3D INT_MA=
X);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (key_=
state_write_plaintext_const(&amp;ks-&gt;ks_ssl, data, (int)size) =3D=3D 1)<=
/span><br><span>         {</span><br><span>             ret =3D true;</span=
><br><span>         }</span><br><span>@@ -4053,7 +4054,7 @@</span><br><span=
>         {</span><br><span>             ks-&gt;paybuf =3D buffer_list_new(=
);</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        buffer_list_push_data(ks-&gt;paybuf, data, (size_t)size);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buffer_list_p=
ush_data(ks-&gt;paybuf, data, size);</span><br><span>         ret =3D true;=
</span><br><span>     }</span><br><span> </span><br><span>diff --git a/src/=
openvpn/ssl.h b/src/openvpn/ssl.h</span><br><span>index ffcc7c4..db8a798 10=
0644</span><br><span>--- a/src/openvpn/ssl.h</span><br><span>+++ b/src/open=
vpn/ssl.h</span><br><span>@@ -426,7 +426,7 @@</span><br><span> /*</span><br=
><span>  * Send a payload over the TLS control channel</span><br><span>  */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool tls_send_payload=
(struct key_state *ks, const uint8_t *data, int size);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+bool tls_send_payload(struct key_state *=
ks, const uint8_t *data, size_t size);</span><br><span> </span><br><span> /=
*</span><br><span>  * Receive a payload through the TLS control channel</sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1355?usp=3Demail">change 1355</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1355?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic90c5a0e48bda4a02d5e11c4c16=
1f388cc8805af </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1355 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--XqY4EPrsXQQ=--


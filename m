From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 27 Mar 2025 16:09:01 +0000
In-Reply-To: <gerrit.1742996678000.I54073f8b63894a62699f6ecdc90a77f9f131205b@...2715...>
References: <gerrit.1742996678000.I54073f8b63894a62699f6ecdc90a77f9f131205b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <12a69438e4e3e61fac12a5bc3ea002e62344bf43-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bNA/XB68D8k="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Do not leave
 half-initialised key wrap struct when dynamic tls-crypt ...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: MaxF <max@...2606...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--bNA/XB68D8k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/92=
1?usp=3Demail )

Change subject: Do not leave half-initialised key wrap struct when dynamic =
tls-crypt fails
......................................................................

Do not leave half-initialised key wrap struct when dynamic tls-crypt fails

In case when key_state_export_keying_material fails we left a
half-initialised tls_wrap_reneg  structure in the tls_session.
Later calls to try to free this structure causes freeing of
invalid memory locations.

To test: make key_state_export_keying_material return false even though
         HAVE_EXPORT_KEYING_MATERIAL is defined and connect to a server
         supporting dynamic tls-crypt (2.6.0+)

Change-Id: I54073f8b63894a62699f6ecdc90a77f9f131205b
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: MaxF <max@...2606...>
Message-Id: <20250327153606.15282-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
267.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/tls_crypt.c
1 file changed, 9 insertions(+), 10 deletions(-)




diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index eb7b03d..9e9807d 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -97,6 +97,15 @@
 bool
 tls_session_generate_dynamic_tls_crypt_key(struct tls_session *session)
 {
+    struct key2 rengokeys;
+    if (!key_state_export_keying_material(session, EXPORT_DYNAMIC_TLS_CRYP=
T_LABEL,
+                                          strlen(EXPORT_DYNAMIC_TLS_CRYPT_=
LABEL),
+                                          rengokeys.keys, sizeof(rengokeys=
.keys)))
+    {
+        return false;
+    }
+    rengokeys.n =3D 2;
+
     session->tls_wrap_reneg.opt =3D session->tls_wrap.opt;
     session->tls_wrap_reneg.mode =3D TLS_WRAP_CRYPT;
     session->tls_wrap_reneg.cleanup_key_ctx =3D true;
@@ -108,16 +117,6 @@
                    session->opt->replay_time,
                    "TLS_WRAP_RENEG", session->key_id);

-
-    struct key2 rengokeys;
-    if (!key_state_export_keying_material(session, EXPORT_DYNAMIC_TLS_CRYP=
T_LABEL,
-                                          strlen(EXPORT_DYNAMIC_TLS_CRYPT_=
LABEL),
-                                          rengokeys.keys, sizeof(rengokeys=
.keys)))
-    {
-        return false;
-    }
-    rengokeys.n =3D 2;
-
     if (session->tls_wrap.mode =3D=3D TLS_WRAP_CRYPT
         || session->tls_wrap.mode =3D=3D TLS_WRAP_AUTH)
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/921?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I54073f8b63894a62699f6ecdc90a77f9f131205b
Gerrit-Change-Number: 921
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--bNA/XB68D8k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/921?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Do not leave half-initialised key wrap struct =
when dynamic tls-crypt fails<br><br>In case when key_state_export_keying_ma=
terial fails we left a<br>half-initialised tls_wrap_reneg  structure in the=
 tls_session.<br>Later calls to try to free this structure causes freeing o=
f<br>invalid memory locations.<br><br>To test: make key_state_export_keying=
_material return false even though<br>         HAVE_EXPORT_KEYING_MATERIAL =
is defined and connect to a server<br>         supporting dynamic tls-crypt=
 (2.6.0+)<br><br>Change-Id: I54073f8b63894a62699f6ecdc90a77f9f131205b<br>Si=
gned-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: MaxF &lt;max=
@...2606...&gt;<br>Message-Id: &lt;20250327153606.15282-1-gert@...1296...&g=
t;<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net=
/msg31267.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>--=
-<br>M src/openvpn/tls_crypt.c<br>1 file changed, 9 insertions(+), 10 delet=
ions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c</span><br=
><span>index eb7b03d..9e9807d 100644</span><br><span>--- a/src/openvpn/tls_=
crypt.c</span><br><span>+++ b/src/openvpn/tls_crypt.c</span><br><span>@@ -9=
7,6 +97,15 @@</span><br><span> bool</span><br><span> tls_session_generate_d=
ynamic_tls_crypt_key(struct tls_session *session)</span><br><span> {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct key2 rengokeys;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!key_state_=
export_keying_material(session, EXPORT_DYNAMIC_TLS_CRYPT_LABEL,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
           strlen(EXPORT_DYNAMIC_TLS_CRYPT_LABEL),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                          re=
ngokeys.keys, sizeof(rengokeys.keys)))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ren=
gokeys.n =3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span>     session-&gt;tls_wrap_reneg.opt =3D session-&gt;tls_wrap.o=
pt;</span><br><span>     session-&gt;tls_wrap_reneg.mode =3D TLS_WRAP_CRYPT=
;</span><br><span>     session-&gt;tls_wrap_reneg.cleanup_key_ctx =3D true;=
</span><br><span>@@ -108,16 +117,6 @@</span><br><span>                    s=
ession-&gt;opt-&gt;replay_time,</span><br><span>                    &quot;T=
LS_WRAP_RENEG&quot;, session-&gt;key_id);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    struct key2 rengokeys;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (!key_state_export_keying_material(session, EX=
PORT_DYNAMIC_TLS_CRYPT_LABEL,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                                          strlen(EXPORT_DYNAMIC_TLS=
_CRYPT_LABEL),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                                   rengokeys.keys, sizeof(rengokeys.keys)))=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    rengokeys.n =3D 2;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span>     if (session-&gt;tls_wrap.mode =
=3D=3D TLS_WRAP_CRYPT</span><br><span>         || session-&gt;tls_wrap.mode=
 =3D=3D TLS_WRAP_AUTH)</span><br><span>     {</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/921?=
usp=3Demail">change 921</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/921?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I54073f8b63894a62699f6ecdc90=
a77f9f131205b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 921 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--bNA/XB68D8k=--


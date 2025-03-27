From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 27 Mar 2025 16:08:59 +0000
In-Reply-To: <gerrit.1742996678000.I54073f8b63894a62699f6ecdc90a77f9f131205b@...2715...>
References: <gerrit.1742996678000.I54073f8b63894a62699f6ecdc90a77f9f131205b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <12a69438e4e3e61fac12a5bc3ea002e62344bf43-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qtrnDGQX4z4="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, MaxF <max@...2606...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qtrnDGQX4z4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/921?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by MaxF


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/921/2

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
Gerrit-MessageType: newpatchset

--qtrnDGQX4z4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
921?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by MaxF</p><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">Do not leave half-initialised key wrap struct when dy=
namic tls-crypt fails<br><br>In case when key_state_export_keying_material =
fails we left a<br>half-initialised tls_wrap_reneg  structure in the tls_se=
ssion.<br>Later calls to try to free this structure causes freeing of<br>in=
valid memory locations.<br><br>To test: make key_state_export_keying_materi=
al return false even though<br>         HAVE_EXPORT_KEYING_MATERIAL is defi=
ned and connect to a server<br>         supporting dynamic tls-crypt (2.6.0=
+)<br><br>Change-Id: I54073f8b63894a62699f6ecdc90a77f9f131205b<br>Signed-of=
f-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: MaxF &lt;max@...2854...=
6...&gt;<br>Message-Id: &lt;20250327153606.15282-1-gert@...1296...&gt;<br>U=
RL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg312=
67.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M =
src/openvpn/tls_crypt.c<br>1 file changed, 9 insertions(+), 10 deletions(-)=
<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/=
921/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.=
c</span><br><span>index eb7b03d..9e9807d 100644</span><br><span>--- a/src/o=
penvpn/tls_crypt.c</span><br><span>+++ b/src/openvpn/tls_crypt.c</span><br>=
<span>@@ -97,6 +97,15 @@</span><br><span> bool</span><br><span> tls_session=
_generate_dynamic_tls_crypt_key(struct tls_session *session)</span><br><spa=
n> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct key2=
 rengokeys;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!key_state_export_keying_material(session, EXPORT_DYNAMIC_TLS_CRYPT_LABEL,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                      strlen(EXPORT_DYNAMIC_TLS_CRYPT_LABEL),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
         rengokeys.keys, sizeof(rengokeys.keys)))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    rengokeys.n =3D 2;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span>     session-&gt;tls_wrap_reneg.opt =3D session-&gt=
;tls_wrap.opt;</span><br><span>     session-&gt;tls_wrap_reneg.mode =3D TLS=
_WRAP_CRYPT;</span><br><span>     session-&gt;tls_wrap_reneg.cleanup_key_ct=
x =3D true;</span><br><span>@@ -108,16 +117,6 @@</span><br><span>          =
          session-&gt;opt-&gt;replay_time,</span><br><span>                =
    &quot;TLS_WRAP_RENEG&quot;, session-&gt;key_id);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    struct key2 rengokeys;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (!key_state_export_keying_material(=
session, EXPORT_DYNAMIC_TLS_CRYPT_LABEL,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                                          strlen(EXPORT_=
DYNAMIC_TLS_CRYPT_LABEL),</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                                          rengokeys.keys, sizeof(rengok=
eys.keys)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        return false;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    rengokeys.n =3D 2;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (session-&gt;tls=
_wrap.mode =3D=3D TLS_WRAP_CRYPT</span><br><span>         || session-&gt;tl=
s_wrap.mode =3D=3D TLS_WRAP_AUTH)</span><br><span>     {</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/921?usp=3Demail">change 921</a>. To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/921?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--qtrnDGQX4z4=--


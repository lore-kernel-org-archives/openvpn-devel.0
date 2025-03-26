From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 26 Mar 2025 13:44:45 +0000
References: <gerrit.1742996678000.I54073f8b63894a62699f6ecdc90a77f9f131205b@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <42df71360792172c308ffbc249bb9cb895881649-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ztFj4xcQ+I8="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ztFj4xcQ+I8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/921?usp=3Demail

to review the following change.


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
---
M src/openvpn/tls_crypt.c
1 file changed, 9 insertions(+), 10 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/921/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--ztFj4xcQ+I8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/921?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Do not leave half-initialised key wrap struct when dynamic tl=
s-crypt fails<br><br>In case when key_state_export_keying_material fails we=
 left a<br>half-initialised tls_wrap_reneg  structure in the tls_session.<b=
r>Later calls to try to free this structure causes freeing of<br>invalid me=
mory locations.<br><br>To test: make key_state_export_keying_material retur=
n false even though<br>         HAVE_EXPORT_KEYING_MATERIAL is defined and =
connect to a server<br>         supporting dynamic tls-crypt (2.6.0+)<br><b=
r>Change-Id: I54073f8b63894a62699f6ecdc90a77f9f131205b<br>Signed-off-by: Ar=
ne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/tls_crypt.c<br>1=
 file changed, 9 insertions(+), 10 deletions(-)<br><br></pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit.openvpn.net:29418/openvpn refs/changes/21/921/1</pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/s=
rc/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c</span><br><span>index eb7b=
03d..9e9807d 100644</span><br><span>--- a/src/openvpn/tls_crypt.c</span><br=
><span>+++ b/src/openvpn/tls_crypt.c</span><br><span>@@ -97,6 +97,15 @@</sp=
an><br><span> bool</span><br><span> tls_session_generate_dynamic_tls_crypt_=
key(struct tls_session *session)</span><br><span> {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct key2 rengokeys;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (!key_state_export_keying_m=
aterial(session, EXPORT_DYNAMIC_TLS_CRYPT_LABEL,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                          strl=
en(EXPORT_DYNAMIC_TLS_CRYPT_LABEL),</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                                          rengokeys.keys, s=
izeof(rengokeys.keys)))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    rengokeys.n =3D 2;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>  =
   session-&gt;tls_wrap_reneg.opt =3D session-&gt;tls_wrap.opt;</span><br><=
span>     session-&gt;tls_wrap_reneg.mode =3D TLS_WRAP_CRYPT;</span><br><sp=
an>     session-&gt;tls_wrap_reneg.cleanup_key_ctx =3D true;</span><br><spa=
n>@@ -108,16 +117,6 @@</span><br><span>                    session-&gt;opt-=
&gt;replay_time,</span><br><span>                    &quot;TLS_WRAP_RENEG&q=
uot;, session-&gt;key_id);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    struct key2 rengokeys;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (!key_state_export_keying_material(session, EXPORT_DYNAMIC_TL=
S_CRYPT_LABEL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                                   strlen(EXPORT_DYNAMIC_TLS_CRYPT_LABEL),<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
                    rengokeys.keys, sizeof(rengokeys.keys)))</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        return false;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    rengokeys.n =3D 2;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span>     if (session-&gt;tls_wrap.mode =3D=3D TLS_WRAP=
_CRYPT</span><br><span>         || session-&gt;tls_wrap.mode =3D=3D TLS_WRA=
P_AUTH)</span><br><span>     {</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/921?usp=3Demail">ch=
ange 921</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/921?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I54073f8b63894a62699f6ecdc90=
a77f9f131205b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 921 </div>
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


--ztFj4xcQ+I8=--


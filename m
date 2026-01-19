From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Mon, 19 Jan 2026 18:40:06 +0000
References: <gerrit.1768848003000.I704c560fa23c03237d0f8adc30908a617265a5a1@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <ce11222cab5157294381debb597a7c88dbde5367-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DLXaMhTxesc="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tls_multi_process:
 promote lame duck key to primary after reneg
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

--DLXaMhTxesc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1478?usp=3Demail

to review the following change.


Change subject: tls_multi_process: promote lame duck key to primary after r=
eneg
......................................................................

tls_multi_process: promote lame duck key to primary after reneg

When a key is negotiated, the transition window logic imposes a delay
before fully adopting the new key. The auth_deferred_expire field
indicates the interval we must wait before considering the key fully
usable (see tls_select_encryption_key). However, in an unfortunate
scenario where the remote peer uses a reneg-sec interval lower than our
handshake window or lower than half of our reneg-sec interval, we end up
initializing every key with an auth_deferred_expire value that never
expires. This leads to selecting the wrong key when invoking
tls_select_encryption_key.

To ensure we always have a fully valid key, whenever a renegotiation
happens, promote the old key even if its auth_deferred_expire has not
yet expired.

Change-Id: I704c560fa23c03237d0f8adc30908a617265a5a1
---
M src/openvpn/ssl.c
1 file changed, 5 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/78/1478/1

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 69d0e4e..6a28b64 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3310,6 +3310,11 @@
                 ks->state =3D S_ERROR_PRE;
             }

+            /* make the lame duck key the primary one while we transition =
to
+             * the new one */
+            struct key_state *ks_lame =3D &session->key[KS_LAME_DUCK];
+            ks_lame->auth_deferred_expire =3D now;
+
             /* Update auth token on the client if needed on renegotiation
              * (key id !=3D0) */
             if (session->key[KS_PRIMARY].key_id !=3D 0)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1478?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I704c560fa23c03237d0f8adc30908a617265a5a1
Gerrit-Change-Number: 1478
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--DLXaMhTxesc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>ralf_lici would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1478?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">tls_multi_process: promote lame duck key to=
 primary after reneg<br><br>When a key is negotiated, the transition window=
 logic imposes a delay<br>before fully adopting the new key. The auth_defer=
red_expire field<br>indicates the interval we must wait before considering =
the key fully<br>usable (see tls_select_encryption_key). However, in an unf=
ortunate<br>scenario where the remote peer uses a reneg-sec interval lower =
than our<br>handshake window or lower than half of our reneg-sec interval, =
we end up<br>initializing every key with an auth_deferred_expire value that=
 never<br>expires. This leads to selecting the wrong key when invoking<br>t=
ls_select_encryption_key.<br><br>To ensure we always have a fully valid key=
, whenever a renegotiation<br>happens, promote the old key even if its auth=
_deferred_expire has not<br>yet expired.<br><br>Change-Id: I704c560fa23c032=
37d0f8adc30908a617265a5a1<br>---<br>M src/openvpn/ssl.c<br>1 file changed, =
5 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit.openvpn.net:29418/openvpn refs/changes/78/1478/1</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index 69d0e4e..6a28b=
64 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src=
/openvpn/ssl.c</span><br><span>@@ -3310,6 +3310,11 @@</span><br><span>     =
            ks-&gt;state =3D S_ERROR_PRE;</span><br><span>             }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        /* make the lame duck key the primary one while we transition to</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+             * the new=
 one */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
struct key_state *ks_lame =3D &amp;session-&gt;key[KS_LAME_DUCK];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            ks_lame-&gt;auth_=
deferred_expire =3D now;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span>             /* Update auth token on the client if ne=
eded on renegotiation</span><br><span>              * (key id !=3D0) */</sp=
an><br><span>             if (session-&gt;key[KS_PRIMARY].key_id !=3D 0)</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1478?usp=3Demail">change 1478</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1478?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I704c560fa23c03237d0f8adc309=
08a617265a5a1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1478 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--DLXaMhTxesc=--


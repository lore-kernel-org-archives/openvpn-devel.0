From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Mon, 16 Feb 2026 08:41:46 +0000
In-Reply-To: <gerrit.1768848003000.I704c560fa23c03237d0f8adc30908a617265a5a1@...2715...>
References: <gerrit.1768848003000.I704c560fa23c03237d0f8adc30908a617265a5a1@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <669aecf67481645b4c62a581012d7736cf13e49a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9OST89SUGzc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tls: reject incoming
 reneg request if primary key is not fully valid
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

--9OST89SUGzc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1478?usp=3Demail

to look at the new patch set (#2).


Change subject: tls: reject incoming reneg request if primary key is not fu=
lly valid
......................................................................

tls: reject incoming reneg request if primary key is not fully valid

An incoming P_CONTROL_SOFT_RESET_V1 can arrive while the primary key is
already in S_GENERATED_KEYS but no longer fully authorized. This can
happen when deferred auth later expires/fails, or when mid-session auth
checks deauthenticate the key without demoting its TLS state.

This patch keeps read_control_auth as the first gate, then rejects the
incoming renegotiation request unless the primary key is KS_AUTH_TRUE
and its auth_deferred_expire gate has passed.

Change-Id: I704c560fa23c03237d0f8adc30908a617265a5a1
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M src/openvpn/ssl.c
1 file changed, 11 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/78/1478/2

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 69d0e4e..ce88478 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3747,6 +3747,17 @@
                 goto error;
             }

+            /*
+             * Do not allow incoming renegotiation unless our primary key =
is
+             * fully authenticated and past the deferred-auth/transition g=
ate.
+             */
+            if (ks->authenticated !=3D KS_AUTH_TRUE || now < ks->auth_defe=
rred_expire)
+            {
+                msg(D_TLS_ERRORS,
+                    "TLS Error: rejecting incoming renegotiation request: =
key not fully authenticated/valid");
+                goto error;
+            }
+
             key_state_soft_reset(session);

             dmsg(D_TLS_DEBUG, "TLS: received P_CONTROL_SOFT_RESET_V1 s=3D%=
d sid=3D%s", i,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1478?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I704c560fa23c03237d0f8adc30908a617265a5a1
Gerrit-Change-Number: 1478
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--9OST89SUGzc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>ralf_lici <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1478?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">tls: reject incoming reneg request if primary key i=
s not fully valid<br><br>An incoming P_CONTROL_SOFT_RESET_V1 can arrive whi=
le the primary key is<br>already in S_GENERATED_KEYS but no longer fully au=
thorized. This can<br>happen when deferred auth later expires/fails, or whe=
n mid-session auth<br>checks deauthenticate the key without demoting its TL=
S state.<br><br>This patch keeps read_control_auth as the first gate, then =
rejects the<br>incoming renegotiation request unless the primary key is KS_=
AUTH_TRUE<br>and its auth_deferred_expire gate has passed.<br><br>Change-Id=
: I704c560fa23c03237d0f8adc30908a617265a5a1<br>Signed-off-by: Ralf Lici &lt=
;ralf@...2726...&gt;<br>---<br>M src/openvpn/ssl.c<br>1 file changed, 11 in=
sertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t.openvpn.net:29418/openvpn refs/changes/78/1478/2</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index 69d0e4e..ce88478 1=
00644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/ope=
nvpn/ssl.c</span><br><span>@@ -3747,6 +3747,17 @@</span><br><span>         =
        goto error;</span><br><span>             }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            /*</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+             * Do not allow inc=
oming renegotiation unless our primary key is</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+             * fully authenticated and past the d=
eferred-auth/transition gate.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+             */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            if (ks-&gt;authenticated !=3D KS_AUTH_TRUE || now &lt; ks=
-&gt;auth_deferred_expire)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                msg(D_TLS_ERRORS,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    &quot;TLS Error: rejecting incoming rene=
gotiation request: key not fully authenticated/valid&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                goto error;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>             ke=
y_state_soft_reset(session);</span><br><span> </span><br><span>            =
 dmsg(D_TLS_DEBUG, &quot;TLS: received P_CONTROL_SOFT_RESET_V1 s=3D%d sid=
=3D%s&quot;, i,</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1478?usp=3Demail">change 1478</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1478?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I704c560fa23c03237d0f8adc309=
08a617265a5a1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1478 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--9OST89SUGzc=--


From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Mon, 19 Jan 2026 18:40:06 +0000
References: <gerrit.1768848003000.I3d506725e69c09a9c77d6a9ba71a00e112e7abb6@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <3164576bda8f3896cdce0e7d8904a79c43aae9a7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3P1LHJn2FX0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: ignore key
 transition window logic
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

--3P1LHJn2FX0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1479?usp=3Demail

to review the following change.


Change subject: dco: ignore key transition window logic
......................................................................

dco: ignore key transition window logic

Userspace enforces a transition window when moving to a new key, which
involves renegotiating the key, installing it as a secondary one, and
waiting for an interval before fully adopting it. Although the DCO part
of this mechanism is set up in userspace, none of the drivers actually
implements it in the kernel.

Therefore we ignore the transition window and treat the newly installed
key as the primary one, allowing userspace to negotiate, install, and
swap it immediately.

Change-Id: I3d506725e69c09a9c77d6a9ba71a00e112e7abb6
---
M src/openvpn/dco.c
M src/openvpn/forward.c
2 files changed, 11 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/79/1479/1

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 26b8645..a974206 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -78,6 +78,15 @@
         multi->dco_keys_installed++;
         ks->dco_status =3D
             (slot =3D=3D OVPN_KEY_SLOT_PRIMARY) ? DCO_INSTALLED_PRIMARY : =
DCO_INSTALLED_SECONDARY;
+
+        /* TODO: currently none of the DCO drivers support a transition
+         * window when moving to a new key, so we need this hack to
+         * trick userspace into thinking that the newly installed key is t=
he
+         * primary one (see dco_update_keys).
+         * This line should be removed once all drivers implement the
+         * transition window logic.
+         */
+        ks->auth_deferred_expire =3D now;
     }

     return ret;
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 5004e35..0827d63 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -221,6 +221,8 @@
      * on ks->auth_deferred_expire that DCO needs to check that the normal
      * TLS state engine does not check. So we call the \c check_dco_key_st=
atus
      * function even if tmp_status does not indicate that something has ch=
anged.
+     *
+     * TODO: this logic is missing on the kernel side.
      */
     check_dco_key_status(c);


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1479?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3d506725e69c09a9c77d6a9ba71a00e112e7abb6
Gerrit-Change-Number: 1479
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--3P1LHJn2FX0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>ralf_lici would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1479?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">dco: ignore key transition window logic<br>=
<br>Userspace enforces a transition window when moving to a new key, which<=
br>involves renegotiating the key, installing it as a secondary one, and<br=
>waiting for an interval before fully adopting it. Although the DCO part<br=
>of this mechanism is set up in userspace, none of the drivers actually<br>=
implements it in the kernel.<br><br>Therefore we ignore the transition wind=
ow and treat the newly installed<br>key as the primary one, allowing usersp=
ace to negotiate, install, and<br>swap it immediately.<br><br>Change-Id: I3=
d506725e69c09a9c77d6a9ba71a00e112e7abb6<br>---<br>M src/openvpn/dco.c<br>M =
src/openvpn/forward.c<br>2 files changed, 11 insertions(+), 0 deletions(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn =
refs/changes/79/1479/1</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco.c b/src/openvpn=
/dco.c</span><br><span>index 26b8645..a974206 100644</span><br><span>--- a/=
src/openvpn/dco.c</span><br><span>+++ b/src/openvpn/dco.c</span><br><span>@=
@ -78,6 +78,15 @@</span><br><span>         multi-&gt;dco_keys_installed++;<=
/span><br><span>         ks-&gt;dco_status =3D</span><br><span>            =
 (slot =3D=3D OVPN_KEY_SLOT_PRIMARY) ? DCO_INSTALLED_PRIMARY : DCO_INSTALLE=
D_SECONDARY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        /* TODO: currently=
 none of the DCO drivers support a transition</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+         * window when moving to a new key, so we=
 need this hack to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
        * trick userspace into thinking that the newly installed key is the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * primary =
one (see dco_update_keys).</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+         * This line should be removed once all drivers implement th=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * transit=
ion window logic.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
       */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ks=
-&gt;auth_deferred_expire =3D now;</span><br><span>     }</span><br><span> =
</span><br><span>     return ret;</span><br><span>diff --git a/src/openvpn/=
forward.c b/src/openvpn/forward.c</span><br><span>index 5004e35..0827d63 10=
0644</span><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/=
openvpn/forward.c</span><br><span>@@ -221,6 +221,8 @@</span><br><span>     =
 * on ks-&gt;auth_deferred_expire that DCO needs to check that the normal</=
span><br><span>      * TLS state engine does not check. So we call the \c c=
heck_dco_key_status</span><br><span>      * function even if tmp_status doe=
s not indicate that something has changed.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * TODO: this logic is missing on the kernel side.</span><br>=
<span>      */</span><br><span>     check_dco_key_status(c);</span><br><spa=
n> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1479?usp=3Demail">change 1479</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1479?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3d506725e69c09a9c77d6a9ba71=
a00e112e7abb6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1479 </div>
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

--3P1LHJn2FX0=--


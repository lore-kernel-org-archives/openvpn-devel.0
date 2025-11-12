From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 12 Nov 2025 11:06:14 +0000
References: <gerrit.1762945572000.I1104044701145fa37cea857e2e0e0fcac7a2bee3@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <44584efc00be7ac148523cc3fb11a1a02cdfe4d0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oEgbh55P8AY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix dco with null
 cipher being enabled without auth none
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--oEgbh55P8AY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/1369?usp=3Demail )


Change subject: Fix dco with null cipher being enabled without auth none
......................................................................

Fix dco with null cipher being enabled without auth none

This is a corner case and only the FreeBSD DCO module support the
none encryption but as long as it supports it, we should only
enable it when the configuration actually allows to enable it.

Change-Id: I1104044701145fa37cea857e2e0e0fcac7a2bee3
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/dco.c
1 file changed, 10 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/69/1369/1

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 7abdad3..a0a990f 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -474,6 +474,16 @@
             gc_free(&gc);
             return false;
         }
+        /* FreeBSD supports none as cipher type but requires auth none to =
be
+         * be also enabled */
+        if (strcmp(token, "none") =3D=3D 0 && strcmp(o->authname, "none") =
!=3D 0)
+        {
+            msg(msglevel,
+                "Note: cipher '%s' in --data-ciphers is only supported "
+                "with --auth=3Dnone by ovpn-dco, disabling data channel "
+                "offload.",
+                token);
+        }
     }
     gc_free(&gc);


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1369?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1104044701145fa37cea857e2e0e0fcac7a2bee3
Gerrit-Change-Number: 1369
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--oEgbh55P8AY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>.</p><p><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1369?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Fix dco with null cipher being enabled without auth none<br><br>This is=
 a corner case and only the FreeBSD DCO module support the<br>none encrypti=
on but as long as it supports it, we should only<br>enable it when the conf=
iguration actually allows to enable it.<br><br>Change-Id: I1104044701145fa3=
7cea857e2e0e0fcac7a2bee3<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...=
&gt;<br>---<br>M src/openvpn/dco.c<br>1 file changed, 10 insertions(+), 0 d=
eletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29=
418/openvpn refs/changes/69/1369/1</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco.c b=
/src/openvpn/dco.c</span><br><span>index 7abdad3..a0a990f 100644</span><br>=
<span>--- a/src/openvpn/dco.c</span><br><span>+++ b/src/openvpn/dco.c</span=
><br><span>@@ -474,6 +474,16 @@</span><br><span>             gc_free(&amp;g=
c);</span><br><span>             return false;</span><br><span>         }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* FreeBSD su=
pports none as cipher type but requires auth none to be</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+         * be also enabled */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (strcmp(token, &qu=
ot;none&quot;) =3D=3D 0 &amp;&amp; strcmp(o-&gt;authname, &quot;none&quot;)=
 !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(msgle=
vel,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 &quot;Note: cipher &#39;%s&#39; in --data-ciphers is only supported &quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                &qu=
ot;with --auth=3Dnone by ovpn-dco, disabling data channel &quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                &quot;offload.=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    token);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span>     }</span><br><span>     gc_free(&amp;gc);</span><br><=
span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1369?usp=3Demail">change 1369</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1369?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1104044701145fa37cea857e2e0=
e0fcac7a2bee3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1369 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--oEgbh55P8AY=--


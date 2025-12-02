From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 2 Dec 2025 15:14:52 +0000
In-Reply-To: <gerrit.1762945572000.I1104044701145fa37cea857e2e0e0fcac7a2bee3@...2715...>
References: <gerrit.1762945572000.I1104044701145fa37cea857e2e0e0fcac7a2bee3@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 gert@...1296...
Message-ID: <47d671bae83aee190972c129d47dc97b07e52dc8-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="j68d1dLnb8w="; charset=UTF-8
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

--j68d1dLnb8w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2.

Hello cron2,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1369?usp=3Demail

to look at the new patch set (#2).


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
1 file changed, 12 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/69/1369/2

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 7abdad3..6a1a5c9 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -474,6 +474,18 @@
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
+            gc_free(&gc);
+            return false;
+        }
     }
     gc_free(&gc);


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1369?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1104044701145fa37cea857e2e0e0fcac7a2bee3
Gerrit-Change-Number: 1369
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>

--j68d1dLnb8w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1369?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">Fix dco with null cipher being enabled without auth=
 none<br><br>This is a corner case and only the FreeBSD DCO module support =
the<br>none encryption but as long as it supports it, we should only<br>ena=
ble it when the configuration actually allows to enable it.<br><br>Change-I=
d: I1104044701145fa37cea857e2e0e0fcac7a2bee3<br>Signed-off-by: Arne Schwabe=
 &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/dco.c<br>1 file changed, 1=
2 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit.openvpn.net:29418/openvpn refs/changes/69/1369/2</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>index 7abdad3..6a1a5=
c9 100644</span><br><span>--- a/src/openvpn/dco.c</span><br><span>+++ b/src=
/openvpn/dco.c</span><br><span>@@ -474,6 +474,18 @@</span><br><span>       =
      gc_free(&amp;gc);</span><br><span>             return false;</span><b=
r><span>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       /* FreeBSD supports none as cipher type but requires auth none to be=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * be also =
enabled */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (strcmp(token, &quot;none&quot;) =3D=3D 0 &amp;&amp; strcmp(o-&gt;authnam=
e, &quot;none&quot;) !=3D 0)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           msg(msglevel,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                &quot;Note: cipher &#39;%s&#39; in --data-ciphers is o=
nly supported &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                &quot;with --auth=3Dnone by ovpn-dco, disabling data chann=
el &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      &quot;offload.&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                token);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            gc_free(&amp;gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            return false;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><br><spa=
n>     gc_free(&amp;gc);</span><br><span> </span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1369?us=
p=3Demail">change 1369</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1369?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1104044701145fa37cea857e2e0=
e0fcac7a2bee3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1369 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>

</body></html>=

--j68d1dLnb8w=--


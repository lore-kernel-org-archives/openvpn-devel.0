From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 6 Nov 2023 17:32:50 +0000
References: <gerrit.1699291967000.Iede3e7c028cbb715e28bc88c7e583f84dadc02c8@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <2846822129298044d81fb82e95cc6c16c8e5a4c8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vbRTvrR9Zw4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Change default of
 "topology" to "subnet"
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

--vbRTvrR9Zw4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/421?usp=3Demail

to review the following change.


Change subject: Change default of "topology" to "subnet"
......................................................................

Change default of "topology" to "subnet"

Change-Id: Iede3e7c028cbb715e28bc88c7e583f84dadc02c8
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M doc/man-sections/vpn-network-options.rst
M src/openvpn/options.c
2 files changed, 10 insertions(+), 11 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/421/1

diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vp=
n-network-options.rst
index 3fa3ccf..251529f 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -495,11 +495,17 @@

   ``mode`` can be one of:

+  :code:`subnet`
+    Use a subnet rather than a point-to-point topology by
+    configuring the tun interface with a local IP address and subnet mask,
+    similar to the topology used in ``--dev tap`` and ethernet bridging
+    mode. This mode allocates a single IP address per connecting client and
+    works on Windows as well. This is the default.
+
   :code:`net30`
     Use a point-to-point topology, by allocating one /30 subnet
     per client. This is designed to allow point-to-point semantics when so=
me
-    or all of the connecting clients might be Windows systems. This is the
-    default.
+    or all of the connecting clients might be Windows systems.

   :code:`p2p`
     Use a point-to-point topology where the remote endpoint of
@@ -508,15 +514,8 @@
     connecting client. Only use when none of the connecting clients are
     Windows systems.

-  :code:`subnet`
-    Use a subnet rather than a point-to-point topology by
-    configuring the tun interface with a local IP address and subnet mask,
-    similar to the topology used in ``--dev tap`` and ethernet bridging
-    mode. This mode allocates a single IP address per connecting client and
-    works on Windows as well.
-
   *Note:* Using ``--topology subnet`` changes the interpretation of the
-  arguments of ``--ifconfig`` to mean "address netmask", no longer "local
+  arguments of ``--ifconfig`` to mean "address netmask", and not "local
   remote".

 --tun-mtu args
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index d238269..764ca7b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -800,7 +800,7 @@
         o->gc_owned =3D true;
     }
     o->mode =3D MODE_POINT_TO_POINT;
-    o->topology =3D TOP_NET30;
+    o->topology =3D TOP_SUBNET;
     o->ce.proto =3D PROTO_UDP;
     o->ce.af =3D AF_UNSPEC;
     o->ce.bind_ipv6_only =3D false;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/421?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iede3e7c028cbb715e28bc88c7e583f84dadc02c8
Gerrit-Change-Number: 421
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--vbRTvrR9Zw4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/421?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Change default of &quot;topology&quot; to &quot;subnet&quot;<=
br><br>Change-Id: Iede3e7c028cbb715e28bc88c7e583f84dadc02c8<br>Signed-off-b=
y: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M doc/man-sections/=
vpn-network-options.rst<br>M src/openvpn/options.c<br>2 files changed, 10 i=
nsertions(+), 11 deletions(-)<br><br></pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2=
9418/openvpn refs/changes/21/421/1</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/vp=
n-network-options.rst b/doc/man-sections/vpn-network-options.rst</span><br>=
<span>index 3fa3ccf..251529f 100644</span><br><span>--- a/doc/man-sections/=
vpn-network-options.rst</span><br><span>+++ b/doc/man-sections/vpn-network-=
options.rst</span><br><span>@@ -495,11 +495,17 @@</span><br><span> </span><=
br><span>   ``mode`` can be one of:</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  :code:`subnet`</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    Use a subnet rather than a point-to-poin=
t topology by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nfiguring the tun interface with a local IP address and subnet mask,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    similar to the topolog=
y used in ``--dev tap`` and ethernet bridging</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    mode. This mode allocates a single IP address=
 per connecting client and</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    works on Windows as well. This is the default.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   :code:`net30`</sp=
an><br><span>     Use a point-to-point topology, by allocating one /30 subn=
et</span><br><span>     per client. This is designed to allow point-to-poin=
t semantics when some</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    or all of the connecting clients might be Windows systems. This is the<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    default.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    or all of the connecting =
clients might be Windows systems.</span><br><span> </span><br><span>   :cod=
e:`p2p`</span><br><span>     Use a point-to-point topology where the remote=
 endpoint of</span><br><span>@@ -508,15 +514,8 @@</span><br><span>     conn=
ecting client. Only use when none of the connecting clients are</span><br><=
span>     Windows systems.</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  :code:`subnet`</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    Use a subnet rather than a point-to-point topology by=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    configuring the t=
un interface with a local IP address and subnet mask,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    similar to the topology used in ``--dev=
 tap`` and ethernet bridging</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    mode. This mode allocates a single IP address per connecting cli=
ent and</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    works on W=
indows as well.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span>   *Note:* Using ``--topology subnet`` changes the interpretatio=
n of the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  arguments o=
f ``--ifconfig`` to mean &quot;address netmask&quot;, no longer &quot;local=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  arguments of ``--=
ifconfig`` to mean &quot;address netmask&quot;, and not &quot;local</span><=
br><span>   remote&quot;.</span><br><span> </span><br><span> --tun-mtu args=
</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c=
</span><br><span>index d238269..764ca7b 100644</span><br><span>--- a/src/op=
envpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span=
>@@ -800,7 +800,7 @@</span><br><span>         o-&gt;gc_owned =3D true;</spa=
n><br><span>     }</span><br><span>     o-&gt;mode =3D MODE_POINT_TO_POINT;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o-&gt;topology =
=3D TOP_NET30;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o=
-&gt;topology =3D TOP_SUBNET;</span><br><span>     o-&gt;ce.proto =3D PROTO=
_UDP;</span><br><span>     o-&gt;ce.af =3D AF_UNSPEC;</span><br><span>     =
o-&gt;ce.bind_ipv6_only =3D false;</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/421?usp=3Demail=
">change 421</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsco=
pe itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/421?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iede3e7c028cbb715e28bc88c7e5=
83f84dadc02c8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 421 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--vbRTvrR9Zw4=--


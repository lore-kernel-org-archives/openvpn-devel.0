From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 3 Apr 2024 17:27:31 +0000
In-Reply-To: <gerrit.1699291967000.Iede3e7c028cbb715e28bc88c7e583f84dadc02c8@...2715...>
References: <gerrit.1699291967000.Iede3e7c028cbb715e28bc88c7e583f84dadc02c8@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <02044454f6fad51f60b481cf061f3ca8f9676c37-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BeykpCqZDAI="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--BeykpCqZDAI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/42=
1?usp=3Demail )

Change subject: Change default of "topology" to "subnet"
......................................................................

Change default of "topology" to "subnet"

Change-Id: Iede3e7c028cbb715e28bc88c7e583f84dadc02c8
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20231201112022.15337-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
627.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M Changes.rst
M doc/man-sections/vpn-network-options.rst
M src/openvpn/options.c
3 files changed, 19 insertions(+), 11 deletions(-)




diff --git a/Changes.rst b/Changes.rst
index 54e5980..b2278ab 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -23,6 +23,15 @@
 ``persist-key`` option has been enabled by default.
     All the keys will be kept in memory across restart.

+Default for ``--topology`` changed to ``subnet``
+    Previous releases used ``net30`` as default. This only affects
+    configs with ``--dev tun`` and only IPv4. Note that this
+    changes the semantics of ``--ifconfig``, so if you have manual
+    settings for that in your config but not set ``--topology``
+    your config might fail to parse with the new version. Just adding
+    ``--topology net30`` to the config should fix the problem.
+    By default ``--topology`` is pushed from server to client.
+
 Overview of changes in 2.6
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vp=
n-network-options.rst
index abe474f..98b4971 100644
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
index 768332d..e2bfe0e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -796,7 +796,7 @@
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
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--BeykpCqZDAI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/421?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Change default of &quot;topology&quot; to &quo=
t;subnet&quot;<br><br>Change-Id: Iede3e7c028cbb715e28bc88c7e583f84dadc02c8<=
br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: A=
rne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Message-Id: &lt;202312011120=
22.15337-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvp=
n-devel@lists.sourceforge.net/msg27627.html<br>Signed-off-by: Gert Doering =
&lt;gert@...1296...&gt;<br>---<br>M Changes.rst<br>M doc/man-sections/vpn-n=
etwork-options.rst<br>M src/openvpn/options.c<br>3 files changed, 19 insert=
ions(+), 11 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/Changes.rst b/Changes.rst</span><br><span>index 54e5980..b2=
278ab 100644</span><br><span>--- a/Changes.rst</span><br><span>+++ b/Change=
s.rst</span><br><span>@@ -23,6 +23,15 @@</span><br><span> ``persist-key`` o=
ption has been enabled by default.</span><br><span>     All the keys will b=
e kept in memory across restart.</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+Default for ``--topology`` changed to ``subn=
et``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Previous re=
leases used ``net30`` as default. This only affects</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    configs with ``--dev tun`` and only I=
Pv4. Note that this</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    changes the semantics of ``--ifconfig``, so if you have manual</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    settings for that in you=
r config but not set ``--topology``</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    your config might fail to parse with the new version. J=
ust adding</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ``--t=
opology net30`` to the config should fix the problem.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    By default ``--topology`` is pushed f=
rom server to client.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> Overview of changes in 2.6</span><br><span> =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span=
><br><span> </span><br><span>diff --git a/doc/man-sections/vpn-network-opti=
ons.rst b/doc/man-sections/vpn-network-options.rst</span><br><span>index ab=
e474f..98b4971 100644</span><br><span>--- a/doc/man-sections/vpn-network-op=
tions.rst</span><br><span>+++ b/doc/man-sections/vpn-network-options.rst</s=
pan><br><span>@@ -495,11 +495,17 @@</span><br><span> </span><br><span>   ``=
mode`` can be one of:</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  :code:`subnet`</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    Use a subnet rather than a point-to-point topology by<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    configuring the =
tun interface with a local IP address and subnet mask,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    similar to the topology used in ``--=
dev tap`` and ethernet bridging</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    mode. This mode allocates a single IP address per connectin=
g client and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wor=
ks on Windows as well. This is the default.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span>   :code:`net30`</span><br><span> =
    Use a point-to-point topology, by allocating one /30 subnet</span><br><=
span>     per client. This is designed to allow point-to-point semantics wh=
en some</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    or all of =
the connecting clients might be Windows systems. This is the</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    default.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    or all of the connecting clients migh=
t be Windows systems.</span><br><span> </span><br><span>   :code:`p2p`</spa=
n><br><span>     Use a point-to-point topology where the remote endpoint of=
</span><br><span>@@ -508,15 +514,8 @@</span><br><span>     connecting clien=
t. Only use when none of the connecting clients are</span><br><span>     Wi=
ndows systems.</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  :code:`subnet`</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    Use a subnet rather than a point-to-point topology by</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    configuring the tun interface=
 with a local IP address and subnet mask,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    similar to the topology used in ``--dev tap`` and e=
thernet bridging</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m=
ode. This mode allocates a single IP address per connecting client and</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    works on Windows as we=
ll.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
  *Note:* Using ``--topology subnet`` changes the interpretation of the</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  arguments of ``--ifconf=
ig`` to mean &quot;address netmask&quot;, no longer &quot;local</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  arguments of ``--ifconfig`` t=
o mean &quot;address netmask&quot;, and not &quot;local</span><br><span>   =
remote&quot;.</span><br><span> </span><br><span> --tun-mtu args</span><br><=
span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><=
span>index 768332d..e2bfe0e 100644</span><br><span>--- a/src/openvpn/option=
s.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -796,7 +=
796,7 @@</span><br><span>         o-&gt;gc_owned =3D true;</span><br><span>=
     }</span><br><span>     o-&gt;mode =3D MODE_POINT_TO_POINT;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    o-&gt;topology =3D TOP_NET30;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;topology =
=3D TOP_SUBNET;</span><br><span>     o-&gt;ce.proto =3D PROTO_UDP;</span><b=
r><span>     o-&gt;ce.af =3D AF_UNSPEC;</span><br><span>     o-&gt;ce.bind_=
ipv6_only =3D false;</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/421?usp=3Demail">change 421</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/421?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iede3e7c028cbb715e28bc88c7e5=
83f84dadc02c8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 421 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--BeykpCqZDAI=--


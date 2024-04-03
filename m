From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 3 Apr 2024 17:27:28 +0000
In-Reply-To: <gerrit.1699291967000.Iede3e7c028cbb715e28bc88c7e583f84dadc02c8@...2715...>
References: <gerrit.1699291967000.Iede3e7c028cbb715e28bc88c7e583f84dadc02c8@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <02044454f6fad51f60b481cf061f3ca8f9676c37-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fUm3wa8u2mI="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--fUm3wa8u2mI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/421?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/421/3

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
Gerrit-MessageType: newpatchset

--fUm3wa8u2mI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #3</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/421?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Change default of &quot;topology&quot; to &quot;=
subnet&quot;<br><br>Change-Id: Iede3e7c028cbb715e28bc88c7e583f84dadc02c8<br=
>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Arn=
e Schwabe &lt;arne-openvpn@...1227...&gt;<br>Message-Id: &lt;20231201112022=
.15337-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-=
devel@lists.sourceforge.net/msg27627.html<br>Signed-off-by: Gert Doering &l=
t;gert@...1296...&gt;<br>---<br>M Changes.rst<br>M doc/man-sections/vpn-net=
work-options.rst<br>M src/openvpn/options.c<br>3 files changed, 19 insertio=
ns(+), 11 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/op=
envpn refs/changes/21/421/3</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/Changes.rst b/Changes.rst<=
/span><br><span>index 54e5980..b2278ab 100644</span><br><span>--- a/Changes=
.rst</span><br><span>+++ b/Changes.rst</span><br><span>@@ -23,6 +23,15 @@</=
span><br><span> ``persist-key`` option has been enabled by default.</span><=
br><span>     All the keys will be kept in memory across restart.</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+Default for=
 ``--topology`` changed to ``subnet``</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    Previous releases used ``net30`` as default. This onl=
y affects</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    config=
s with ``--dev tun`` and only IPv4. Note that this</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    changes the semantics of ``--ifconfig``,=
 so if you have manual</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    settings for that in your config but not set ``--topology``</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    your config might fail t=
o parse with the new version. Just adding</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ``--topology net30`` to the config should fix the=
 problem.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    By def=
ault ``--topology`` is pushed from server to client.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> Overview of changes in =
2.6</span><br><span> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span> </span><br><span>diff --git a/doc=
/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-option=
s.rst</span><br><span>index abe474f..98b4971 100644</span><br><span>--- a/d=
oc/man-sections/vpn-network-options.rst</span><br><span>+++ b/doc/man-secti=
ons/vpn-network-options.rst</span><br><span>@@ -495,11 +495,17 @@</span><br=
><span> </span><br><span>   ``mode`` can be one of:</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  :code:`subnet`</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    Use a subnet rather than=
 a point-to-point topology by</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    configuring the tun interface with a local IP address and sub=
net mask,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    simila=
r to the topology used in ``--dev tap`` and ethernet bridging</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    mode. This mode allocates a s=
ingle IP address per connecting client and</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    works on Windows as well. This is the default.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   :=
code:`net30`</span><br><span>     Use a point-to-point topology, by allocat=
ing one /30 subnet</span><br><span>     per client. This is designed to all=
ow point-to-point semantics when some</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    or all of the connecting clients might be Windows syste=
ms. This is the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    de=
fault.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    or all of=
 the connecting clients might be Windows systems.</span><br><span> </span><=
br><span>   :code:`p2p`</span><br><span>     Use a point-to-point topology =
where the remote endpoint of</span><br><span>@@ -508,15 +514,8 @@</span><br=
><span>     connecting client. Only use when none of the connecting clients=
 are</span><br><span>     Windows systems.</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  :code:`subnet`</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    Use a subnet rather than a point-to-p=
oint topology by</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c=
onfiguring the tun interface with a local IP address and subnet mask,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    similar to the topology=
 used in ``--dev tap`` and ethernet bridging</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    mode. This mode allocates a single IP address pe=
r connecting client and</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    works on Windows as well.</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span>   *Note:* Using ``--topology subnet`` changes t=
he interpretation of the</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-  arguments of ``--ifconfig`` to mean &quot;address netmask&quot;, no lo=
nger &quot;local</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  a=
rguments of ``--ifconfig`` to mean &quot;address netmask&quot;, and not &qu=
ot;local</span><br><span>   remote&quot;.</span><br><span> </span><br><span=
> --tun-mtu args</span><br><span>diff --git a/src/openvpn/options.c b/src/o=
penvpn/options.c</span><br><span>index 768332d..e2bfe0e 100644</span><br><s=
pan>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c=
</span><br><span>@@ -796,7 +796,7 @@</span><br><span>         o-&gt;gc_owne=
d =3D true;</span><br><span>     }</span><br><span>     o-&gt;mode =3D MODE=
_POINT_TO_POINT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o=
-&gt;topology =3D TOP_NET30;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    o-&gt;topology =3D TOP_SUBNET;</span><br><span>     o-&gt;ce.p=
roto =3D PROTO_UDP;</span><br><span>     o-&gt;ce.af =3D AF_UNSPEC;</span><=
br><span>     o-&gt;ce.bind_ipv6_only =3D false;</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/4=
21?usp=3Demail">change 421</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/421?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--fUm3wa8u2mI=--


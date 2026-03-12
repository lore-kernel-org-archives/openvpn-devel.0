From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 12 Mar 2026 13:04:18 +0000
In-Reply-To: <gerrit.1773145887000.Ia699b0dfa407ac377970bb130434298eaaec592b@...2715...>
References: <gerrit.1773145887000.Ia699b0dfa407ac377970bb130434298eaaec592b@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <6961902bebb67aee6ad871c5acab91b622692f3a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jda+/WEdKO4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Increase default
 size of internal hash maps to 4 * --max-clients
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--jda+/WEdKO4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

plaisthos has uploaded a new patch set (#4). ( http://gerrit.openvpn.net/c/=
openvpn/+/1563?usp=3Demail )


Change subject: Increase default size of internal hash maps to 4 * --max-cl=
ients
......................................................................

Increase default size of internal hash maps to 4 * --max-clients

The default of 256 seems quite low as with (at least) 1024 possible
entries we have a guaranteed collisions. Using 4 times the number
of possible entries for real addresses should reduce collisions quite
a bit while also leaving some headroom for the virtual addresses hash
where a client might have more than one address.

A reason to keep the limit so low are the memory requirements. Each
bucket has the size of one linked-list pointer (4 byte or 32 bit and
8 byte for 64 bit). So 256 buckets use 1 or 2 kB while 4096 will use
16 kB or 32 kB.

When the current limit was set 20 years ago this might have been a
meaningful memory saving but today the collision probability is
more important.

Change-Id: Ia699b0dfa407ac377970bb130434298eaaec592b
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M doc/man-sections/advanced-options.rst
M doc/man-sections/server-options.rst
M src/openvpn/options.c
3 files changed, 20 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/63/1563/4

diff --git a/doc/man-sections/advanced-options.rst b/doc/man-sections/advan=
ced-options.rst
index e1115e4..73ca44a 100644
--- a/doc/man-sections/advanced-options.rst
+++ b/doc/man-sections/advanced-options.rst
@@ -36,7 +36,8 @@

      hash-size r v

-  By default, both tables are sized at 256 buckets.
+  By default, both tables are sized at 4 times ``--max-clients`` buckets.
+  With the default of 1024 of ``--max-clients`` this gives 4096 buckets.

 --bcast-buffers n
   Allocate ``n`` buffers for broadcast datagrams (default :code:`256`).
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-=
options.rst
index 03ce651..eb8e273 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -414,7 +414,7 @@
      iroute-ipv6 ipv6addr/bits

 --max-clients n
-  Limit server to a maximum of ``n`` concurrent clients.
+  Limit server to a maximum of ``n`` concurrent clients. Defaults to 1024.

 --max-routes-per-client n
   Allow a maximum of ``n`` internal routes per client (default
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e065e63..b7b80f7 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -849,8 +849,6 @@
 #endif
     o->vlan_accept =3D VLAN_ALL;
     o->vlan_pvid =3D 1;
-    o->real_hash_size =3D 256;
-    o->virtual_hash_size =3D 256;
     o->n_bcast_buf =3D 256;
     o->tcp_queue_limit =3D 64;
     o->max_clients =3D 1024;
@@ -3724,6 +3722,22 @@
     gc_free(&gc);
 }
 #endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */
+/**
+ * Sets the internal hash maps sizes according to the max_clients
+ *
+ */
+static void
+helper_hashmap_sizes(struct options *o)
+{
+    if (!o->real_hash_size)
+    {
+        o->real_hash_size =3D 4 * o->max_clients;
+    }
+    if (!o->virtual_hash_size)
+    {
+        o->virtual_hash_size =3D 4 * o->max_clients;
+    }
+}

 static void
 options_postprocess_mutate(struct options *o, struct env_set *es)
@@ -3738,6 +3752,7 @@
     helper_setdefault_topology(o);
     helper_keepalive(o);
     helper_tcp_nodelay(o);
+    helper_hashmap_sizes(o);

     options_postprocess_setdefault_ncpciphers(o);
     options_set_backwards_compatible_options(o);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1563?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia699b0dfa407ac377970bb130434298eaaec592b
Gerrit-Change-Number: 1563
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--jda+/WEdKO4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #4</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1563?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">Increase default size of internal hash maps to 4 * =
--max-clients<br><br>The default of 256 seems quite low as with (at least) =
1024 possible<br>entries we have a guaranteed collisions. Using 4 times the=
 number<br>of possible entries for real addresses should reduce collisions =
quite<br>a bit while also leaving some headroom for the virtual addresses h=
ash<br>where a client might have more than one address.<br><br>A reason to =
keep the limit so low are the memory requirements. Each<br>bucket has the s=
ize of one linked-list pointer (4 byte or 32 bit and<br>8 byte for 64 bit).=
 So 256 buckets use 1 or 2 kB while 4096 will use<br>16 kB or 32 kB.<br><br=
>When the current limit was set 20 years ago this might have been a<br>mean=
ingful memory saving but today the collision probability is<br>more importa=
nt.<br><br>Change-Id: Ia699b0dfa407ac377970bb130434298eaaec592b<br>Signed-o=
ff-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M doc/man-sections/ad=
vanced-options.rst<br>M doc/man-sections/server-options.rst<br>M src/openvp=
n/options.c<br>3 files changed, 20 insertions(+), 4 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chang=
es/63/1563/4</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/doc/man-sections/advanced-options.rst b/d=
oc/man-sections/advanced-options.rst</span><br><span>index e1115e4..73ca44a=
 100644</span><br><span>--- a/doc/man-sections/advanced-options.rst</span><=
br><span>+++ b/doc/man-sections/advanced-options.rst</span><br><span>@@ -36=
,7 +36,8 @@</span><br><span> </span><br><span>      hash-size r v</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  By default,=
 both tables are sized at 256 buckets.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  By default, both tables are sized at 4 times ``--max-c=
lients`` buckets.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
With the default of 1024 of ``--max-clients`` this gives 4096 buckets.</spa=
n><br><span> </span><br><span> --bcast-buffers n</span><br><span>   Allocat=
e ``n`` buffers for broadcast datagrams (default :code:`256`).</span><br><s=
pan>diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/ser=
ver-options.rst</span><br><span>index 03ce651..eb8e273 100644</span><br><sp=
an>--- a/doc/man-sections/server-options.rst</span><br><span>+++ b/doc/man-=
sections/server-options.rst</span><br><span>@@ -414,7 +414,7 @@</span><br><=
span>      iroute-ipv6 ipv6addr/bits</span><br><span> </span><br><span> --m=
ax-clients n</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Limit s=
erver to a maximum of ``n`` concurrent clients.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  Limit server to a maximum of ``n`` concurrent=
 clients. Defaults to 1024.</span><br><span> </span><br><span> --max-routes=
-per-client n</span><br><span>   Allow a maximum of ``n`` internal routes p=
er client (default</span><br><span>diff --git a/src/openvpn/options.c b/src=
/openvpn/options.c</span><br><span>index e065e63..b7b80f7 100644</span><br>=
<span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options=
.c</span><br><span>@@ -849,8 +849,6 @@</span><br><span> #endif</span><br><s=
pan>     o-&gt;vlan_accept =3D VLAN_ALL;</span><br><span>     o-&gt;vlan_pv=
id =3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o-&gt;re=
al_hash_size =3D 256;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    o-&gt;virtual_hash_size =3D 256;</span><br><span>     o-&gt;n_bcast_buf=
 =3D 256;</span><br><span>     o-&gt;tcp_queue_limit =3D 64;</span><br><spa=
n>     o-&gt;max_clients =3D 1024;</span><br><span>@@ -3724,6 +3722,22 @@</=
span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> #=
endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Sets the internal hash maps sizes according to the=
 max_clients</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+helper_hashmap_sizes(struct options *o)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (!o-&gt;real_hash_size)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        o-&gt;real_hash_size =3D 4 * o-&gt;max_cl=
ients;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!o-&gt;virtual_hash=
_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        o-&gt;virtual_hash_=
size =3D 4 * o-&gt;max_clients;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span> </span><br><span> static void</span><br><span> options_pos=
tprocess_mutate(struct options *o, struct env_set *es)</span><br><span>@@ -=
3738,6 +3752,7 @@</span><br><span>     helper_setdefault_topology(o);</span=
><br><span>     helper_keepalive(o);</span><br><span>     helper_tcp_nodela=
y(o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    helper_has=
hmap_sizes(o);</span><br><span> </span><br><span>     options_postprocess_s=
etdefault_ncpciphers(o);</span><br><span>     options_set_backwards_compati=
ble_options(o);</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1563?usp=3Demail">change 1563</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1563?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia699b0dfa407ac377970bb13043=
4298eaaec592b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1563 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: flichtenheld &lt;frank@...2641...&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--jda+/WEdKO4=--


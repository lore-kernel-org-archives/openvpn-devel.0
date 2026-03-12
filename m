From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 12 Mar 2026 14:59:51 +0000
In-Reply-To: <gerrit.1773145887000.Ia699b0dfa407ac377970bb130434298eaaec592b@...2715...>
References: <gerrit.1773145887000.Ia699b0dfa407ac377970bb130434298eaaec592b@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <5f7b77bea88b6184337720b146fc241fa957739f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QKB/E+p89xk="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--QKB/E+p89xk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1563?usp=3Demail

to look at the new patch set (#5).

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


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
3 files changed, 24 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/63/1563/5

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
index e065e63..63ab88f 100644
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
@@ -3739,6 +3753,11 @@
     helper_keepalive(o);
     helper_tcp_nodelay(o);

+    if (o->mode =3D=3D MODE_SERVER)
+    {
+        helper_hashmap_sizes(o);
+    }
+
     options_postprocess_setdefault_ncpciphers(o);
     options_set_backwards_compatible_options(o);
     options_process_mutate_prf(o);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1563?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia699b0dfa407ac377970bb130434298eaaec592b
Gerrit-Change-Number: 1563
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--QKB/E+p89xk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #5</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1563?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Increase default size of int=
ernal hash maps to 4 * --max-clients<br><br>The default of 256 seems quite =
low as with (at least) 1024 possible<br>entries we have a guaranteed collis=
ions. Using 4 times the number<br>of possible entries for real addresses sh=
ould reduce collisions quite<br>a bit while also leaving some headroom for =
the virtual addresses hash<br>where a client might have more than one addre=
ss.<br><br>A reason to keep the limit so low are the memory requirements. E=
ach<br>bucket has the size of one linked-list pointer (4 byte or 32 bit and=
<br>8 byte for 64 bit). So 256 buckets use 1 or 2 kB while 4096 will use<br=
>16 kB or 32 kB.<br><br>When the current limit was set 20 years ago this mi=
ght have been a<br>meaningful memory saving but today the collision probabi=
lity is<br>more important.<br><br>Change-Id: Ia699b0dfa407ac377970bb1304342=
98eaaec592b<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<b=
r>M doc/man-sections/advanced-options.rst<br>M doc/man-sections/server-opti=
ons.rst<br>M src/openvpn/options.c<br>3 files changed, 24 insertions(+), 4 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2=
9418/openvpn refs/changes/63/1563/5</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/a=
dvanced-options.rst b/doc/man-sections/advanced-options.rst</span><br><span=
>index e1115e4..73ca44a 100644</span><br><span>--- a/doc/man-sections/advan=
ced-options.rst</span><br><span>+++ b/doc/man-sections/advanced-options.rst=
</span><br><span>@@ -36,7 +36,8 @@</span><br><span> </span><br><span>      =
hash-size r v</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-  By default, both tables are sized at 256 buckets.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  By default, both tables are siz=
ed at 4 times ``--max-clients`` buckets.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  With the default of 1024 of ``--max-clients`` this g=
ives 4096 buckets.</span><br><span> </span><br><span> --bcast-buffers n</sp=
an><br><span>   Allocate ``n`` buffers for broadcast datagrams (default :co=
de:`256`).</span><br><span>diff --git a/doc/man-sections/server-options.rst=
 b/doc/man-sections/server-options.rst</span><br><span>index 03ce651..eb8e2=
73 100644</span><br><span>--- a/doc/man-sections/server-options.rst</span><=
br><span>+++ b/doc/man-sections/server-options.rst</span><br><span>@@ -414,=
7 +414,7 @@</span><br><span>      iroute-ipv6 ipv6addr/bits</span><br><span=
> </span><br><span> --max-clients n</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-  Limit server to a maximum of ``n`` concurrent clients.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  Limit server to a maxi=
mum of ``n`` concurrent clients. Defaults to 1024.</span><br><span> </span>=
<br><span> --max-routes-per-client n</span><br><span>   Allow a maximum of =
``n`` internal routes per client (default</span><br><span>diff --git a/src/=
openvpn/options.c b/src/openvpn/options.c</span><br><span>index e065e63..63=
ab88f 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>++=
+ b/src/openvpn/options.c</span><br><span>@@ -849,8 +849,6 @@</span><br><sp=
an> #endif</span><br><span>     o-&gt;vlan_accept =3D VLAN_ALL;</span><br><=
span>     o-&gt;vlan_pvid =3D 1;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    o-&gt;real_hash_size =3D 256;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    o-&gt;virtual_hash_size =3D 256;</span><br><span=
>     o-&gt;n_bcast_buf =3D 256;</span><br><span>     o-&gt;tcp_queue_limit=
 =3D 64;</span><br><span>     o-&gt;max_clients =3D 1024;</span><br><span>@=
@ -3724,6 +3722,22 @@</span><br><span>     gc_free(&amp;gc);</span><br><spa=
n> }</span><br><span> #endif /* if defined(_WIN32) || defined(TARGET_ANDROI=
D) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Sets the internal hash maps=
 sizes according to the max_clients</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+helper_hashmap_sizes(stru=
ct options *o)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!o-&gt;real_has=
h_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        o-&gt;real_hash_si=
ze =3D 4 * o-&gt;max_clients;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (!o-&gt;virtual_hash_size)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    o-&gt;virtual_hash_size =3D 4 * o-&gt;max_clients;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span> </span><br><span> static void</span=
><br><span> options_postprocess_mutate(struct options *o, struct env_set *e=
s)</span><br><span>@@ -3739,6 +3753,11 @@</span><br><span>     helper_keepa=
live(o);</span><br><span>     helper_tcp_nodelay(o);</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;mode =3D=
=3D MODE_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        helper_ha=
shmap_sizes(o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
    options_postprocess_setdefault_ncpciphers(o);</span><br><span>     opti=
ons_set_backwards_compatible_options(o);</span><br><span>     options_proce=
ss_mutate_prf(o);</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1563?usp=3Demail">change 1563</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1563?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia699b0dfa407ac377970bb13043=
4298eaaec592b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1563 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--QKB/E+p89xk=--


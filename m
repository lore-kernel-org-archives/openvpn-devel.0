From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 26 Mar 2026 14:49:38 +0000
In-Reply-To: <gerrit.1773145887000.Ia699b0dfa407ac377970bb130434298eaaec592b@...2715...>
References: <gerrit.1773145887000.Ia699b0dfa407ac377970bb130434298eaaec592b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <0354b60b1eb87065d282117ec7601080b3d12ce7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LvcmQjrbh1c="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--LvcmQjrbh1c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#8) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1563?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by ordex


Change subject: Increase default size of internal hash maps to 4 * --max-cl=
ients
......................................................................

Increase default size of internal hash maps to 4 * --max-clients

The default of 256 seems quite low as with (at least) 1024 possible
entries (the --max-clients default setting) we have a guaranteed
collisions. Using 4 times the number of possible entries for real
addresses should reduce collisions quite a bit while also leaving
some headroom for the virtual addresses hash where a client might
have more than one address.

A reason to keep the limit so low are the memory requirements. Each
bucket has the size of one linked-list pointer (4 byte or 32 bit and
8 byte for 64 bit). So 256 buckets use 1 or 2 kB while 4096 will use
16 kB or 32 kB.

When the current limit was set 20 years ago this might have been a
meaningful memory saving but today the collision probability is
more important.

Change-Id: Ia699b0dfa407ac377970bb130434298eaaec592b
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1563
Message-Id: <20260325124526.124049-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
268.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/advanced-options.rst
M doc/man-sections/server-options.rst
M src/openvpn/options.c
3 files changed, 24 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/63/1563/8

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
index 1db781d..24f2407 100644
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
Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--LvcmQjrbh1c=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #8</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1563?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by ordex</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Increase default size of internal h=
ash maps to 4 * --max-clients<br><br>The default of 256 seems quite low as =
with (at least) 1024 possible<br>entries (the --max-clients default setting=
) we have a guaranteed<br>collisions. Using 4 times the number of possible =
entries for real<br>addresses should reduce collisions quite a bit while al=
so leaving<br>some headroom for the virtual addresses hash where a client m=
ight<br>have more than one address.<br><br>A reason to keep the limit so lo=
w are the memory requirements. Each<br>bucket has the size of one linked-li=
st pointer (4 byte or 32 bit and<br>8 byte for 64 bit). So 256 buckets use =
1 or 2 kB while 4096 will use<br>16 kB or 32 kB.<br><br>When the current li=
mit was set 20 years ago this might have been a<br>meaningful memory saving=
 but today the collision probability is<br>more important.<br><br>Change-Id=
: Ia699b0dfa407ac377970bb130434298eaaec592b<br>Signed-off-by: Arne Schwabe =
&lt;arne@...1227...&gt;<br>Acked-by: Antonio Quartulli &lt;antonio@...2786...=
..&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1563<br>Messag=
e-Id: &lt;20260325124526.124049-1-frank@...2641...&gt;<br>URL: https://www.=
mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36268.html<br>Signe=
d-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M doc/man-sections=
/advanced-options.rst<br>M doc/man-sections/server-options.rst<br>M src/ope=
nvpn/options.c<br>3 files changed, 24 insertions(+), 4 deletions(-)<br><br>=
</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/ch=
anges/63/1563/8</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/doc/man-sections/advanced-options.rst =
b/doc/man-sections/advanced-options.rst</span><br><span>index e1115e4..73ca=
44a 100644</span><br><span>--- a/doc/man-sections/advanced-options.rst</spa=
n><br><span>+++ b/doc/man-sections/advanced-options.rst</span><br><span>@@ =
-36,7 +36,8 @@</span><br><span> </span><br><span>      hash-size r v</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  By defau=
lt, both tables are sized at 256 buckets.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  By default, both tables are sized at 4 times ``--ma=
x-clients`` buckets.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  With the default of 1024 of ``--max-clients`` this gives 4096 buckets.</=
span><br><span> </span><br><span> --bcast-buffers n</span><br><span>   Allo=
cate ``n`` buffers for broadcast datagrams (default :code:`256`).</span><br=
><span>diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/=
server-options.rst</span><br><span>index 03ce651..eb8e273 100644</span><br>=
<span>--- a/doc/man-sections/server-options.rst</span><br><span>+++ b/doc/m=
an-sections/server-options.rst</span><br><span>@@ -414,7 +414,7 @@</span><b=
r><span>      iroute-ipv6 ipv6addr/bits</span><br><span> </span><br><span> =
--max-clients n</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Limi=
t server to a maximum of ``n`` concurrent clients.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  Limit server to a maximum of ``n`` concurr=
ent clients. Defaults to 1024.</span><br><span> </span><br><span> --max-rou=
tes-per-client n</span><br><span>   Allow a maximum of ``n`` internal route=
s per client (default</span><br><span>diff --git a/src/openvpn/options.c b/=
src/openvpn/options.c</span><br><span>index 1db781d..24f2407 100644</span><=
br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/opti=
ons.c</span><br><span>@@ -849,8 +849,6 @@</span><br><span> #endif</span><br=
><span>     o-&gt;vlan_accept =3D VLAN_ALL;</span><br><span>     o-&gt;vlan=
_pvid =3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o-&gt=
;real_hash_size =3D 256;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    o-&gt;virtual_hash_size =3D 256;</span><br><span>     o-&gt;n_bcast_=
buf =3D 256;</span><br><span>     o-&gt;tcp_queue_limit =3D 64;</span><br><=
span>     o-&gt;max_clients =3D 1024;</span><br><span>@@ -3724,6 +3722,22 @=
@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span=
> #endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * Sets the internal hash maps sizes according to =
the max_clients</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+helper_hashmap_sizes(struct options *o)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!o-&gt;real_hash_size)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        o-&gt;real_hash_size =3D 4 * o-&gt;m=
ax_clients;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!o-&gt;virtual=
_hash_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        o-&gt;virtual_=
hash_size =3D 4 * o-&gt;max_clients;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span> </span><br><span> static void</span><br><span> option=
s_postprocess_mutate(struct options *o, struct env_set *es)</span><br><span=
>@@ -3739,6 +3753,11 @@</span><br><span>     helper_keepalive(o);</span><br=
><span>     helper_tcp_nodelay(o);</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;mode =3D=3D MODE_SERVER)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        helper_hashmap_sizes(o);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     options_postpro=
cess_setdefault_ncpciphers(o);</span><br><span>     options_set_backwards_c=
ompatible_options(o);</span><br><span>     options_process_mutate_prf(o);</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1563?usp=3Demail">change 1563</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1563?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia699b0dfa407ac377970bb13043=
4298eaaec592b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1563 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--LvcmQjrbh1c=--


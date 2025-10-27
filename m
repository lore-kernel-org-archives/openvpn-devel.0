From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 27 Oct 2025 13:08:21 +0000
References: <gerrit.1761570487000.Idede28c850def5e3b4a17dcbd0a5771f15cfc668@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <bf540b35fcad968481b6f7dd16f5652c56276b39-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HBrLgmg38Ho="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi: Fix type
 handling for hashes, mostly inotify_watchers
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

--HBrLgmg38Ho=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1312?usp=3Demail

to review the following change.


Change subject: multi: Fix type handling for hashes, mostly inotify_watchers
......................................................................

multi: Fix type handling for hashes, mostly inotify_watchers

Change-Id: Idede28c850def5e3b4a17dcbd0a5771f15cfc668
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/multi.c
1 file changed, 15 insertions(+), 14 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/12/1312/1

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 74cc866..f9f6b16 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -268,7 +268,7 @@
  */
 int_hash_function(const void *key, uint32_t iv)
 {
-    return (unsigned long)key;
+    return (uint32_t)(uintptr_t)key;
 }

 static bool
@@ -306,22 +306,23 @@
      * to determine which client sent an incoming packet
      * which is seen on the TCP/UDP socket.
      */
-    m->hash =3D hash_init(t->options.real_hash_size, get_random(), mroute_=
addr_hash_function,
-                        mroute_addr_compare_function);
+    m->hash =3D hash_init(t->options.real_hash_size, (uint32_t)get_random(=
),
+                        mroute_addr_hash_function, mroute_addr_compare_fun=
ction);

     /*
      * Virtual address hash table.  Used to determine
      * which client to route a packet to.
      */
-    m->vhash =3D hash_init(t->options.virtual_hash_size, get_random(), mro=
ute_addr_hash_function,
-                         mroute_addr_compare_function);
+    m->vhash =3D hash_init(t->options.virtual_hash_size, (uint32_t)get_ran=
dom(),
+                         mroute_addr_hash_function, mroute_addr_compare_fu=
nction);

     /*
      * This hash table is a clone of m->hash but with a
      * bucket size of one so that it can be used
      * for fast iteration through the list.
      */
-    m->iter =3D hash_init(1, get_random(), mroute_addr_hash_function, mrou=
te_addr_compare_function);
+    m->iter =3D hash_init(1, (uint32_t)get_random(), mroute_addr_hash_func=
tion,
+                        mroute_addr_compare_function);

 #ifdef ENABLE_MANAGEMENT
     m->cid_hash =3D hash_init(t->options.real_hash_size, 0, cid_hash_funct=
ion, cid_compare_function);
@@ -332,8 +333,8 @@
      * Mapping between inotify watch descriptors and
      * multi_instances.
      */
-    m->inotify_watchers =3D
-        hash_init(t->options.real_hash_size, get_random(), int_hash_functi=
on, int_compare_function);
+    m->inotify_watchers =3D hash_init(t->options.real_hash_size, (uint32_t=
)get_random(),
+                                    int_hash_function, int_compare_functio=
n);
 #endif

     /*
@@ -623,7 +624,7 @@
 #ifdef ENABLE_ASYNC_PUSH
         if (mi->inotify_watch !=3D -1)
         {
-            hash_remove(m->inotify_watchers, (void *)(unsigned long)mi->in=
otify_watch);
+            hash_remove(m->inotify_watchers, (void *)(uintptr_t)mi->inotif=
y_watch);
             mi->inotify_watch =3D -1;
         }
 #endif
@@ -2825,7 +2826,7 @@
         msg(D_MULTI_DEBUG, "MULTI: modified fd %d, mask %d", pevent->wd, p=
event->mask);

         struct multi_instance *mi =3D
-            hash_lookup(m->inotify_watchers, (void *)(unsigned long)pevent=
->wd);
+            hash_lookup(m->inotify_watchers, (void *)(uintptr_t)pevent->wd=
);

         if (pevent->mask & IN_CLOSE_WRITE)
         {
@@ -2844,7 +2845,7 @@
             /* this event is _always_ fired when watch is removed or file =
is deleted */
             if (mi)
             {
-                hash_remove(m->inotify_watchers, (void *)(unsigned long)pe=
vent->wd);
+                hash_remove(m->inotify_watchers, (void *)(uintptr_t)pevent=
->wd);
                 mi->inotify_watch =3D -1;
             }
         }
@@ -2984,14 +2985,14 @@
                        const char *file)
 {
     /* watch acf file */
-    long watch_descriptor =3D inotify_add_watch(inotify_fd, file, IN_CLOSE=
_WRITE | IN_ONESHOT);
+    int watch_descriptor =3D inotify_add_watch(inotify_fd, file, IN_CLOSE_=
WRITE | IN_ONESHOT);
     if (watch_descriptor >=3D 0)
     {
         if (mi->inotify_watch !=3D -1)
         {
-            hash_remove(m->inotify_watchers, (void *)(unsigned long)mi->in=
otify_watch);
+            hash_remove(m->inotify_watchers, (void *)(uintptr_t)mi->inotif=
y_watch);
         }
-        hash_add(m->inotify_watchers, (const uintptr_t *)watch_descriptor,=
 mi, true);
+        hash_add(m->inotify_watchers, (void *)(uintptr_t)watch_descriptor,=
 mi, true);
         mi->inotify_watch =3D watch_descriptor;
     }
     else

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1312?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idede28c850def5e3b4a17dcbd0a5771f15cfc668
Gerrit-Change-Number: 1312
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--HBrLgmg38Ho=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1312?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">multi: Fix type handling for hashes, mostly=
 inotify_watchers<br><br>Change-Id: Idede28c850def5e3b4a17dcbd0a5771f15cfc6=
68<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M=
 src/openvpn/multi.c<br>1 file changed, 15 insertions(+), 14 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn r=
efs/changes/12/1312/1</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/src/openvpn/multi.c b/src/openvp=
n/multi.c</span><br><span>index 74cc866..f9f6b16 100644</span><br><span>---=
 a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br>=
<span>@@ -268,7 +268,7 @@</span><br><span>  */</span><br><span> int_hash_fu=
nction(const void *key, uint32_t iv)</span><br><span> {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    return (unsigned long)key;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return (uint32_t)(uintptr_=
t)key;</span><br><span> }</span><br><span> </span><br><span> static bool</s=
pan><br><span>@@ -306,22 +306,23 @@</span><br><span>      * to determine wh=
ich client sent an incoming packet</span><br><span>      * which is seen on=
 the TCP/UDP socket.</span><br><span>      */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    m-&gt;hash =3D hash_init(t-&gt;options.real_has=
h_size, get_random(), mroute_addr_hash_function,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                        mroute_addr_compare_func=
tion);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;has=
h =3D hash_init(t-&gt;options.real_hash_size, (uint32_t)get_random(),</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                        m=
route_addr_hash_function, mroute_addr_compare_function);</span><br><span> <=
/span><br><span>     /*</span><br><span>      * Virtual address hash table.=
  Used to determine</span><br><span>      * which client to route a packet =
to.</span><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    m-&gt;vhash =3D hash_init(t-&gt;options.virtual_hash_size, get_r=
andom(), mroute_addr_hash_function,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                         mroute_addr_compare_function);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;vhash =3D hash_=
init(t-&gt;options.virtual_hash_size, (uint32_t)get_random(),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                         mroute_a=
ddr_hash_function, mroute_addr_compare_function);</span><br><span> </span><=
br><span>     /*</span><br><span>      * This hash table is a clone of m-&g=
t;hash but with a</span><br><span>      * bucket size of one so that it can=
 be used</span><br><span>      * for fast iteration through the list.</span=
><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  m-&gt;iter =3D hash_init(1, get_random(), mroute_addr_hash_function, mrou=
te_addr_compare_function);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    m-&gt;iter =3D hash_init(1, (uint32_t)get_random(), mroute_addr_=
hash_function,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                   mroute_addr_compare_function);</span><br><span> </span><=
br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     m-&gt;cid_hash =3D =
hash_init(t-&gt;options.real_hash_size, 0, cid_hash_function, cid_compare_f=
unction);</span><br><span>@@ -332,8 +333,8 @@</span><br><span>      * Mappi=
ng between inotify watch descriptors and</span><br><span>      * multi_inst=
ances.</span><br><span>      */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    m-&gt;inotify_watchers =3D</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        hash_init(t-&gt;options.real_hash_size, get_rand=
om(), int_hash_function, int_compare_function);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    m-&gt;inotify_watchers =3D hash_init(t-&gt;=
options.real_hash_size, (uint32_t)get_random(),</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                    int_hash_fu=
nction, int_compare_function);</span><br><span> #endif</span><br><span> </s=
pan><br><span>     /*</span><br><span>@@ -623,7 +624,7 @@</span><br><span> =
#ifdef ENABLE_ASYNC_PUSH</span><br><span>         if (mi-&gt;inotify_watch =
!=3D -1)</span><br><span>         {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            hash_remove(m-&gt;inotify_watchers, (void *)(unsi=
gned long)mi-&gt;inotify_watch);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            hash_remove(m-&gt;inotify_watchers, (void *)(uintp=
tr_t)mi-&gt;inotify_watch);</span><br><span>             mi-&gt;inotify_wat=
ch =3D -1;</span><br><span>         }</span><br><span> #endif</span><br><sp=
an>@@ -2825,7 +2826,7 @@</span><br><span>         msg(D_MULTI_DEBUG, &quot;=
MULTI: modified fd %d, mask %d&quot;, pevent-&gt;wd, pevent-&gt;mask);</spa=
n><br><span> </span><br><span>         struct multi_instance *mi =3D</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            hash_lookup(m-&g=
t;inotify_watchers, (void *)(unsigned long)pevent-&gt;wd);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            hash_lookup(m-&gt;inotif=
y_watchers, (void *)(uintptr_t)pevent-&gt;wd);</span><br><span> </span><br>=
<span>         if (pevent-&gt;mask &amp; IN_CLOSE_WRITE)</span><br><span>  =
       {</span><br><span>@@ -2844,7 +2845,7 @@</span><br><span>            =
 /* this event is _always_ fired when watch is removed or file is deleted *=
/</span><br><span>             if (mi)</span><br><span>             {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                hash_remove=
(m-&gt;inotify_watchers, (void *)(unsigned long)pevent-&gt;wd);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                hash_remove(m-&=
gt;inotify_watchers, (void *)(uintptr_t)pevent-&gt;wd);</span><br><span>   =
              mi-&gt;inotify_watch =3D -1;</span><br><span>             }</=
span><br><span>         }</span><br><span>@@ -2984,14 +2985,14 @@</span><br=
><span>                        const char *file)</span><br><span> {</span><=
br><span>     /* watch acf file */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    long watch_descriptor =3D inotify_add_watch(inotify_fd, fi=
le, IN_CLOSE_WRITE | IN_ONESHOT);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    int watch_descriptor =3D inotify_add_watch(inotify_fd, fi=
le, IN_CLOSE_WRITE | IN_ONESHOT);</span><br><span>     if (watch_descriptor=
 &gt;=3D 0)</span><br><span>     {</span><br><span>         if (mi-&gt;inot=
ify_watch !=3D -1)</span><br><span>         {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            hash_remove(m-&gt;inotify_watchers, (vo=
id *)(unsigned long)mi-&gt;inotify_watch);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            hash_remove(m-&gt;inotify_watchers, (voi=
d *)(uintptr_t)mi-&gt;inotify_watch);</span><br><span>         }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        hash_add(m-&gt;inotify_w=
atchers, (const uintptr_t *)watch_descriptor, mi, true);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        hash_add(m-&gt;inotify_watcher=
s, (void *)(uintptr_t)watch_descriptor, mi, true);</span><br><span>        =
 mi-&gt;inotify_watch =3D watch_descriptor;</span><br><span>     }</span><b=
r><span>     else</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1312?usp=3Demail">change 1312</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1312?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idede28c850def5e3b4a17dcbd0a=
5771f15cfc668 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1312 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--HBrLgmg38Ho=--


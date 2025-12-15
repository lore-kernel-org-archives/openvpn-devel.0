From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 15 Dec 2025 15:42:01 +0000
In-Reply-To: <gerrit.1761570487000.Idede28c850def5e3b4a17dcbd0a5771f15cfc668@...2715...>
References: <gerrit.1761570487000.Idede28c850def5e3b4a17dcbd0a5771f15cfc668@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <839b104bfba77cfedd186042b845839a479144cf-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="R/Tvjm/ke/Q="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--R/Tvjm/ke/Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#10) to the change originally created b=
y flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1312?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: multi: Fix type handling for hashes, mostly inotify_watchers
......................................................................

multi: Fix type handling for hashes, mostly inotify_watchers

Change-Id: Idede28c850def5e3b4a17dcbd0a5771f15cfc668
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1312
Message-Id: <20251215145528.18047-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
072.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/multi.c
1 file changed, 15 insertions(+), 14 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/12/1312/10

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index d9cb3a9..20d72c1 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -257,7 +257,7 @@
  */
 int_hash_function(const void *key, uint32_t iv)
 {
-    return (unsigned long)key;
+    return (uint32_t)(uintptr_t)key;
 }

 static bool
@@ -295,22 +295,23 @@
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
@@ -321,8 +322,8 @@
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
@@ -609,7 +610,7 @@
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
@@ -2821,7 +2822,7 @@
         msg(D_MULTI_DEBUG, "MULTI: modified fd %d, mask %d", pevent->wd, p=
event->mask);

         struct multi_instance *mi =3D
-            hash_lookup(m->inotify_watchers, (void *)(unsigned long)pevent=
->wd);
+            hash_lookup(m->inotify_watchers, (void *)(uintptr_t)pevent->wd=
);

         if (pevent->mask & IN_CLOSE_WRITE)
         {
@@ -2840,7 +2841,7 @@
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
@@ -2978,14 +2979,14 @@
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idede28c850def5e3b4a17dcbd0a5771f15cfc668
Gerrit-Change-Number: 1312
Gerrit-PatchSet: 10
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--R/Tvjm/ke/Q=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #10</strong> to the change originally created by flichtenhe=
ld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1312?usp=3Demail=
">View Change</a></p><p>The following approvals got outdated and were remov=
ed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">multi: Fix type handling for hashes=
, mostly inotify_watchers<br><br>Change-Id: Idede28c850def5e3b4a17dcbd0a577=
1f15cfc668<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>=
Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerri=
t.openvpn.net/c/openvpn/+/1312<br>Message-Id: &lt;20251215145528.18047-1-ge=
rt@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1199...=
sourceforge.net/msg35072.html<br>Signed-off-by: Gert Doering &lt;gert@...1711...=
96...&gt;<br>---<br>M src/openvpn/multi.c<br>1 file changed, 15 insertions(=
+), 14 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvp=
n.net:29418/openvpn refs/changes/12/1312/10</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/multi.c b/src/openvpn/multi.c</span><br><span>index d9cb3a9..20d72c1 1006=
44</span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/open=
vpn/multi.c</span><br><span>@@ -257,7 +257,7 @@</span><br><span>  */</span>=
<br><span> int_hash_function(const void *key, uint32_t iv)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (unsigne=
d long)key;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn (uint32_t)(uintptr_t)key;</span><br><span> }</span><br><span> </span><br=
><span> static bool</span><br><span>@@ -295,22 +295,23 @@</span><br><span> =
     * to determine which client sent an incoming packet</span><br><span>  =
    * which is seen on the TCP/UDP socket.</span><br><span>      */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;hash =3D hash_init(=
t-&gt;options.real_hash_size, get_random(), mroute_addr_hash_function,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                        mr=
oute_addr_compare_function);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    m-&gt;hash =3D hash_init(t-&gt;options.real_hash_size, (uint32=
_t)get_random(),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                     mroute_addr_hash_function, mroute_addr_compare_functio=
n);</span><br><span> </span><br><span>     /*</span><br><span>      * Virtu=
al address hash table.  Used to determine</span><br><span>      * which cli=
ent to route a packet to.</span><br><span>      */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    m-&gt;vhash =3D hash_init(t-&gt;options.vi=
rtual_hash_size, get_random(), mroute_addr_hash_function,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                         mroute_addr_co=
mpare_function);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 m-&gt;vhash =3D hash_init(t-&gt;options.virtual_hash_size, (uint32_t)get_r=
andom(),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
              mroute_addr_hash_function, mroute_addr_compare_function);</sp=
an><br><span> </span><br><span>     /*</span><br><span>      * This hash ta=
ble is a clone of m-&gt;hash but with a</span><br><span>      * bucket size=
 of one so that it can be used</span><br><span>      * for fast iteration t=
hrough the list.</span><br><span>      */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    m-&gt;iter =3D hash_init(1, get_random(), mroute_ad=
dr_hash_function, mroute_addr_compare_function);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    m-&gt;iter =3D hash_init(1, (uint32_t)get_=
random(), mroute_addr_hash_function,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                        mroute_addr_compare_function);</sp=
an><br><span> </span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>  =
   m-&gt;cid_hash =3D hash_init(t-&gt;options.real_hash_size, 0, cid_hash_f=
unction, cid_compare_function);</span><br><span>@@ -321,8 +322,8 @@</span><=
br><span>      * Mapping between inotify watch descriptors and</span><br><s=
pan>      * multi_instances.</span><br><span>      */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    m-&gt;inotify_watchers =3D</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        hash_init(t-&gt;options.re=
al_hash_size, get_random(), int_hash_function, int_compare_function);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;inotify_watcher=
s =3D hash_init(t-&gt;options.real_hash_size, (uint32_t)get_random(),</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
           int_hash_function, int_compare_function);</span><br><span> #endi=
f</span><br><span> </span><br><span>     /*</span><br><span>@@ -609,7 +610,=
7 @@</span><br><span> #ifdef ENABLE_ASYNC_PUSH</span><br><span>         if =
(mi-&gt;inotify_watch !=3D -1)</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            hash_remove(m-&gt;inotify_w=
atchers, (void *)(unsigned long)mi-&gt;inotify_watch);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            hash_remove(m-&gt;inotify_wa=
tchers, (void *)(uintptr_t)mi-&gt;inotify_watch);</span><br><span>         =
    mi-&gt;inotify_watch =3D -1;</span><br><span>         }</span><br><span=
> #endif</span><br><span>@@ -2821,7 +2822,7 @@</span><br><span>         msg=
(D_MULTI_DEBUG, &quot;MULTI: modified fd %d, mask %d&quot;, pevent-&gt;wd, =
pevent-&gt;mask);</span><br><span> </span><br><span>         struct multi_i=
nstance *mi =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      hash_lookup(m-&gt;inotify_watchers, (void *)(unsigned long)pevent-&gt=
;wd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ha=
sh_lookup(m-&gt;inotify_watchers, (void *)(uintptr_t)pevent-&gt;wd);</span>=
<br><span> </span><br><span>         if (pevent-&gt;mask &amp; IN_CLOSE_WRI=
TE)</span><br><span>         {</span><br><span>@@ -2840,7 +2841,7 @@</span>=
<br><span>             /* this event is _always_ fired when watch is remove=
d or file is deleted */</span><br><span>             if (mi)</span><br><spa=
n>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           hash_remove(m-&gt;inotify_watchers, (void *)(unsigned long)peven=
t-&gt;wd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       hash_remove(m-&gt;inotify_watchers, (void *)(uintptr_t)pevent-&gt;wd=
);</span><br><span>                 mi-&gt;inotify_watch =3D -1;</span><br>=
<span>             }</span><br><span>         }</span><br><span>@@ -2978,14=
 +2979,14 @@</span><br><span>                        const char *file)</spa=
n><br><span> {</span><br><span>     /* watch acf file */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    long watch_descriptor =3D inotify_ad=
d_watch(inotify_fd, file, IN_CLOSE_WRITE | IN_ONESHOT);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    int watch_descriptor =3D inotify_ad=
d_watch(inotify_fd, file, IN_CLOSE_WRITE | IN_ONESHOT);</span><br><span>   =
  if (watch_descriptor &gt;=3D 0)</span><br><span>     {</span><br><span>  =
       if (mi-&gt;inotify_watch !=3D -1)</span><br><span>         {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            hash_remove(m-&gt=
;inotify_watchers, (void *)(unsigned long)mi-&gt;inotify_watch);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            hash_remove(m-&gt;=
inotify_watchers, (void *)(uintptr_t)mi-&gt;inotify_watch);</span><br><span=
>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ha=
sh_add(m-&gt;inotify_watchers, (const uintptr_t *)watch_descriptor, mi, tru=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        hash_add=
(m-&gt;inotify_watchers, (void *)(uintptr_t)watch_descriptor, mi, true);</s=
pan><br><span>         mi-&gt;inotify_watch =3D watch_descriptor;</span><br=
><span>     }</span><br><span>     else</span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1312?usp=
=3Demail">change 1312</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1312?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idede28c850def5e3b4a17dcbd0a=
5771f15cfc668 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1312 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--R/Tvjm/ke/Q=--


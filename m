From: "d12fk (Code Review)" <gerrit@...515...>
Date: Mon, 19 May 2025 09:19:36 +0000
References: <gerrit.1747646372000.I275bf939f43577427e14890e7093d63c5213ae5d@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5617f7beb62fcb16d011a8ecf064a8f67b18cfba-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="J9bBFzOnnWc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dns: fix potential
 NULL pointer dereference
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

--J9bBFzOnnWc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1026?usp=3Demail

to review the following change.


Change subject: dns: fix potential NULL pointer dereference
......................................................................

dns: fix potential NULL pointer dereference

Fix issue reported by Coverity (CID 1646952): Dereferencing a pointer
that might be NULL dvf when calling env_set_write_file.

In addition to the fix, output a log line in case this happens, because
it will influence to communication with the updown runner process, i.e.
setting up / tearing down DNS things will not work as expected.

Change-Id: I275bf939f43577427e14890e7093d63c5213ae5d
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpn/dns.c
1 file changed, 35 insertions(+), 26 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/26/1026/1

diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 9927961..1299a13 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -691,12 +691,13 @@
 static const char *
 write_dns_vars_file(bool up, const struct options *o, const struct tuntap =
*tt, struct gc_arena *gc)
 {
-    struct env_set *es =3D env_set_create(gc);
     const char *dvf =3D platform_create_temp_file(o->tmp_dir, "dvf", gc);
-
-    updown_env_set(up, &o->dns_options, tt, es);
-    env_set_write_file(dvf, es);
-
+    if (dvf)
+    {
+        struct env_set *es =3D env_set_create(gc);
+        updown_env_set(up, &o->dns_options, tt, es);
+        env_set_write_file(dvf, es);
+    }
     return dvf;
 }

@@ -731,34 +732,42 @@
         int rfd =3D updown_runner->fds[0];
         int wfd =3D updown_runner->fds[1];
         const char *dvf =3D write_dns_vars_file(up, o, tt, &gc);
-        size_t dvf_size =3D strlen(dvf) + 1;
-
-        while (1)
+        if (!dvf)
         {
-            ssize_t len =3D write(wfd, dvf, dvf_size);
-            if (len < dvf_size)
-            {
-                if (len =3D=3D -1 && errno =3D=3D EINTR)
-                {
-                    continue;
-                }
-                msg(M_ERR | M_ERRNO, "could not send dns vars filename");
-            }
-            break;
+            msg(M_ERR, "could not create dns vars file");
+            status =3D 1;
         }
-
-        while (1)
+        else
         {
-            ssize_t len =3D read(rfd, &status, sizeof(status));
-            if (len < sizeof(status))
+            size_t dvf_size =3D strlen(dvf) + 1;
+
+            while (1)
             {
-                if (len =3D=3D -1 && errno =3D=3D EINTR)
+                ssize_t len =3D write(wfd, dvf, dvf_size);
+                if (len < dvf_size)
                 {
-                    continue;
+                    if (len =3D=3D -1 && errno =3D=3D EINTR)
+                    {
+                        continue;
+                    }
+                    msg(M_ERR | M_ERRNO, "could not send dns vars filename=
");
                 }
-                msg(M_ERR | M_ERRNO, "could not receive dns updown status"=
);
+                break;
             }
-            break;
+
+            while (1)
+            {
+                ssize_t len =3D read(rfd, &status, sizeof(status));
+                if (len < sizeof(status))
+                {
+                    if (len =3D=3D -1 && errno =3D=3D EINTR)
+                    {
+                        continue;
+                    }
+                    msg(M_ERR | M_ERRNO, "could not receive dns updown sta=
tus");
+                }
+                break;
+            }
         }

         gc_free(&gc);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1026?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I275bf939f43577427e14890e7093d63c5213ae5d
Gerrit-Change-Number: 1026
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--J9bBFzOnnWc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1026?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">dns: fix potential NULL pointer dereference<br><br>Fix issue=
 reported by Coverity (CID 1646952): Dereferencing a pointer<br>that might =
be NULL dvf when calling env_set_write_file.<br><br>In addition to the fix,=
 output a log line in case this happens, because<br>it will influence to co=
mmunication with the updown runner process, i.e.<br>setting up / tearing do=
wn DNS things will not work as expected.<br><br>Change-Id: I275bf939f435774=
27e14890e7093d63c5213ae5d<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...=
&gt;<br>---<br>M src/openvpn/dns.c<br>1 file changed, 35 insertions(+), 26 =
deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs=
/changes/26/1026/1</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/src/openvpn/dns.c b/src/openvpn/dns=
.c</span><br><span>index 9927961..1299a13 100644</span><br><span>--- a/src/=
openvpn/dns.c</span><br><span>+++ b/src/openvpn/dns.c</span><br><span>@@ -6=
91,12 +691,13 @@</span><br><span> static const char *</span><br><span> writ=
e_dns_vars_file(bool up, const struct options *o, const struct tuntap *tt, =
struct gc_arena *gc)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    struct env_set *es =3D env_set_create(gc);</span><br>=
<span>     const char *dvf =3D platform_create_temp_file(o-&gt;tmp_dir, &qu=
ot;dvf&quot;, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    updown_env_set(up, &=
amp;o-&gt;dns_options, tt, es);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    env_set_write_file(dvf, es);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (dvf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct env_=
set *es =3D env_set_create(gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        updown_env_set(up, &amp;o-&gt;dns_options, tt, es);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        env_set_write_f=
ile(dvf, es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span>     return dvf;</span><br><span> }</span><br><span> </span=
><br><span>@@ -731,34 +732,42 @@</span><br><span>         int rfd =3D updow=
n_runner-&gt;fds[0];</span><br><span>         int wfd =3D updown_runner-&gt=
;fds[1];</span><br><span>         const char *dvf =3D write_dns_vars_file(u=
p, o, tt, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      size_t dvf_size =3D strlen(dvf) + 1;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        while (1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (!dvf)</span><br><span>         {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            ssize_t len =3D write(wfd, dvf, dvf_size);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (len &=
lt; dvf_size)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
if (len =3D=3D -1 &amp;&amp; errno =3D=3D EINTR)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    continue;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                msg(M_ERR | M_ERRNO, &quot;coul=
d not send dns vars filename&quot;);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            break;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            msg(M_ERR, &quot;could not create dns vars file&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            status =
=3D 1;</span><br><span>         }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        w=
hile (1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        els=
e</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            ssize_t len =3D read(rfd, &amp;status, sizeof(status));<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (len &l=
t; sizeof(status))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           size_t dvf_size =3D strlen(dvf) + 1;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            while (1)</span><br><span>             {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                if (len =3D=3D -1 &=
amp;&amp; errno =3D=3D EINTR)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                ssize_t len =3D write(wfd, dvf, dvf_size);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                if (len &l=
t; dvf_size)</span><br><span>                 {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                    continue;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    if (len =3D=3D -1 &=
amp;&amp; errno =3D=3D EINTR)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                        continue;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    msg(M_ERR | M_ERRNO, &quot;=
could not send dns vars filename&quot;);</span><br><span>                 }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(M=
_ERR | M_ERRNO, &quot;could not receive dns updown status&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                break;</span>=
<br><span>             }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            break;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            while=
 (1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ssize=
_t len =3D read(rfd, &amp;status, sizeof(status));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                if (len &lt; sizeof(status))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    i=
f (len =3D=3D -1 &amp;&amp; errno =3D=3D EINTR)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                        continue;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    msg(M_ERR=
 | M_ERRNO, &quot;could not receive dns updown status&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                break;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span>  =
       }</span><br><span> </span><br><span>         gc_free(&amp;gc);</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1026?usp=3Demail">change 1026</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1026?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I275bf939f43577427e14890e709=
3d63c5213ae5d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1026 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--J9bBFzOnnWc=--


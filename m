From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 20 May 2025 08:26:06 +0000
In-Reply-To: <gerrit.1747646372000.I275bf939f43577427e14890e7093d63c5213ae5d@...2715...>
References: <gerrit.1747646372000.I275bf939f43577427e14890e7093d63c5213ae5d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1947143f16a8e2e87939a044a5e00223026751f0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RYqJqUziqv4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dns: fix potential
 NULL pointer dereference
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--RYqJqUziqv4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
26?usp=3Demail )

Change subject: dns: fix potential NULL pointer dereference
......................................................................

dns: fix potential NULL pointer dereference

Fix issue reported by Coverity (CID 1646952): Dereferencing a pointer
that might be NULL dvf when calling env_set_write_file.

In addition to the fix, inline the write_dns_vars_file() helper function.
Also output a log line in case this error happens, because when it
happens it will hinder communication with the updown runner process, i.e.
setting up / tearing down DNS things will not work as expected.

Change-Id: I275bf939f43577427e14890e7093d63c5213ae5d
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250520073354.17091-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
720.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dns.c
1 file changed, 15 insertions(+), 17 deletions(-)




diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 221e9a9..283ce67 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -688,18 +688,6 @@
     return true;
 }

-static const char *
-write_dns_vars_file(bool up, const struct options *o, const struct tuntap =
*tt, struct gc_arena *gc)
-{
-    struct env_set *es =3D env_set_create(gc);
-    const char *dvf =3D platform_create_temp_file(o->tmp_dir, "dvf", gc);
-
-    updown_env_set(up, &o->dns_options, tt, es);
-    env_set_write_file(dvf, es);
-
-    return dvf;
-}
-
 static void
 run_up_down_command(bool up, struct options *o, const struct tuntap *tt, s=
truct dns_updown_runner_info *updown_runner)
 {
@@ -708,7 +696,7 @@
         return;
     }

-    int status;
+    int status =3D -1;

     if (!updown_runner->required)
     {
@@ -727,11 +715,19 @@
         }

         struct gc_arena gc =3D gc_new();
-        int rfd =3D updown_runner->fds[0];
-        int wfd =3D updown_runner->fds[1];
-        const char *dvf =3D write_dns_vars_file(up, o, tt, &gc);
-        size_t dvf_size =3D strlen(dvf) + 1;
+        const char *dvf =3D platform_create_temp_file(o->tmp_dir, "dvf", &=
gc);
+        if (!dvf)
+        {
+            msg(M_ERR, "could not create dns vars file");
+            goto out_free;
+        }

+        struct env_set *es =3D env_set_create(&gc);
+        updown_env_set(up, &o->dns_options, tt, es);
+        env_set_write_file(dvf, es);
+
+        int wfd =3D updown_runner->fds[1];
+        size_t dvf_size =3D strlen(dvf) + 1;
         while (1)
         {
             ssize_t len =3D write(wfd, dvf, dvf_size);
@@ -746,6 +742,7 @@
             break;
         }

+        int rfd =3D updown_runner->fds[0];
         while (1)
         {
             ssize_t len =3D read(rfd, &status, sizeof(status));
@@ -760,6 +757,7 @@
             break;
         }

+out_free:
         gc_free(&gc);
     }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1026?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I275bf939f43577427e14890e7093d63c5213ae5d
Gerrit-Change-Number: 1026
Gerrit-PatchSet: 4
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--RYqJqUziqv4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1026?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">dns: fix potential NULL pointer dereference<b=
r><br>Fix issue reported by Coverity (CID 1646952): Dereferencing a pointer=
<br>that might be NULL dvf when calling env_set_write_file.<br><br>In addit=
ion to the fix, inline the write_dns_vars_file() helper function.<br>Also o=
utput a log line in case this error happens, because when it<br>happens it =
will hinder communication with the updown runner process, i.e.<br>setting u=
p / tearing down DNS things will not work as expected.<br><br>Change-Id: I2=
75bf939f43577427e14890e7093d63c5213ae5d<br>Signed-off-by: Heiko Hund &lt;he=
iko@...2662...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Mes=
sage-Id: &lt;20250520073354.17091-1-gert@...1296...&gt;<br>URL: https://www=
.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31720.html<br>Sign=
ed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/dns=
.c<br>1 file changed, 15 insertions(+), 17 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>index=
 221e9a9..283ce67 100644</span><br><span>--- a/src/openvpn/dns.c</span><br>=
<span>+++ b/src/openvpn/dns.c</span><br><span>@@ -688,18 +688,6 @@</span><b=
r><span>     return true;</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-static const char *</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-write_dns_vars_file(bool up, const s=
truct options *o, const struct tuntap *tt, struct gc_arena *gc)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    struct env_set *es =3D env_set_create(gc);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *dvf =3D plat=
form_create_temp_file(o-&gt;tmp_dir, &quot;dvf&quot;, gc);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    updown_env_set(up, &amp;o-&gt;dns_options, tt, es);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    env_set_write_file(dv=
f, es);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    return dvf;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span> static void</span><br><span> run_up_down_co=
mmand(bool up, struct options *o, const struct tuntap *tt, struct dns_updow=
n_runner_info *updown_runner)</span><br><span> {</span><br><span>@@ -708,7 =
+696,7 @@</span><br><span>         return;</span><br><span>     }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int statu=
s;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int status =
=3D -1;</span><br><span> </span><br><span>     if (!updown_runner-&gt;requi=
red)</span><br><span>     {</span><br><span>@@ -727,11 +715,19 @@</span><br=
><span>         }</span><br><span> </span><br><span>         struct gc_aren=
a gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     int rfd =3D updown_runner-&gt;fds[0];</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        int wfd =3D updown_runner-&gt;fds[1];</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        const char *dvf =3D wr=
ite_dns_vars_file(up, o, tt, &amp;gc);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        size_t dvf_size =3D strlen(dvf) + 1;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        const char *dvf =3D platf=
orm_create_temp_file(o-&gt;tmp_dir, &quot;dvf&quot;, &amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (!dvf)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            msg(M_ERR, &quot;could not creat=
e dns vars file&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            goto out_free;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        struct env_set *es =3D env_set_create(&amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        updown_env_s=
et(up, &amp;o-&gt;dns_options, tt, es);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        env_set_write_file(dvf, es);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        int wfd =3D updown_runner-&gt;fds[1];</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        size_t dvf_size =3D str=
len(dvf) + 1;</span><br><span>         while (1)</span><br><span>         {=
</span><br><span>             ssize_t len =3D write(wfd, dvf, dvf_size);</s=
pan><br><span>@@ -746,6 +742,7 @@</span><br><span>             break;</span=
><br><span>         }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        int rfd =3D updown_runner-&gt;fds[0];</span><br=
><span>         while (1)</span><br><span>         {</span><br><span>      =
       ssize_t len =3D read(rfd, &amp;status, sizeof(status));</span><br><s=
pan>@@ -760,6 +757,7 @@</span><br><span>             break;</span><br><span=
>         }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+out_free:</span><br><span>         gc_free(&amp;gc);</span><br><s=
pan>     }</span><br><span> </span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1026?usp=3Demail">cha=
nge 1026</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1026?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I275bf939f43577427e14890e709=
3d63c5213ae5d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1026 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--RYqJqUziqv4=--


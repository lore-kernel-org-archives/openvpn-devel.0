From: "d12fk (Code Review)" <gerrit@...515...>
Date: Tue, 20 May 2025 07:14:35 +0000
In-Reply-To: <gerrit.1747646372000.I275bf939f43577427e14890e7093d63c5213ae5d@...2715...>
References: <gerrit.1747646372000.I275bf939f43577427e14890e7093d63c5213ae5d@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <aa5db4fe5ea2785455e72e50345081fa3b21d9e6-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6vWaQXSfJxE="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6vWaQXSfJxE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1026?usp=3Demail

to look at the new patch set (#3).


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
---
M src/openvpn/dns.c
1 file changed, 15 insertions(+), 17 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/26/1026/3

diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 9927961..3c703cc 100644
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
@@ -709,7 +697,7 @@
         return;
     }

-    int status;
+    int status =3D -1;

     if (!updown_runner->required)
     {
@@ -728,11 +716,19 @@
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
@@ -747,6 +743,7 @@
             break;
         }

+        int rfd =3D updown_runner->fds[0];
         while (1)
         {
             ssize_t len =3D read(rfd, &status, sizeof(status));
@@ -761,6 +758,7 @@
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
Gerrit-PatchSet: 3
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--6vWaQXSfJxE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk <strong>uploaded patch set #3</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1026?usp=3Demail">View Change</=
a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">dns: fix potential NULL pointer dereference<br><br>Fix issue reported by=
 Coverity (CID 1646952): Dereferencing a pointer<br>that might be NULL dvf =
when calling env_set_write_file.<br><br>In addition to the fix, inline the =
write_dns_vars_file() helper function.<br>Also output a log line in case th=
is error happens, because when it<br>happens it will hinder communication w=
ith the updown runner process, i.e.<br>setting up / tearing down DNS things=
 will not work as expected.<br><br>Change-Id: I275bf939f43577427e14890e7093=
d63c5213ae5d<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>---<b=
r>M src/openvpn/dns.c<br>1 file changed, 15 insertions(+), 17 deletions(-)<=
br><br></pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/26/1=
026/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br>=
<span>index 9927961..3c703cc 100644</span><br><span>--- a/src/openvpn/dns.c=
</span><br><span>+++ b/src/openvpn/dns.c</span><br><span>@@ -688,18 +688,6 =
@@</span><br><span>     return true;</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-static const char *</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-write_dns_vars_file(bool =
up, const struct options *o, const struct tuntap *tt, struct gc_arena *gc)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    struct env_set *es =3D env_set_create(=
gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *d=
vf =3D platform_create_temp_file(o-&gt;tmp_dir, &quot;dvf&quot;, gc);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    updown_env_set(up, &amp;o-&gt;dns_options, t=
t, es);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    env_set_wr=
ite_file(dvf, es);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    return dvf;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span> static void</span><br><span> run=
_up_down_command(bool up, struct options *o, const struct tuntap *tt, struc=
t dns_updown_runner_info *updown_runner)</span><br><span> {</span><br><span=
>@@ -709,7 +697,7 @@</span><br><span>         return;</span><br><span>     =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  int status;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in=
t status =3D -1;</span><br><span> </span><br><span>     if (!updown_runner-=
&gt;required)</span><br><span>     {</span><br><span>@@ -728,11 +716,19 @@<=
/span><br><span>         }</span><br><span> </span><br><span>         struc=
t gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        int rfd =3D updown_runner-&gt;fds[0];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        int wfd =3D updown_runner-&gt;fds[1=
];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const char =
*dvf =3D write_dns_vars_file(up, o, tt, &amp;gc);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        size_t dvf_size =3D strlen(dvf) + 1;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        const char *dv=
f =3D platform_create_temp_file(o-&gt;tmp_dir, &quot;dvf&quot;, &amp;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!dvf)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            msg(M_ERR, &quot;coul=
d not create dns vars file&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            goto out_free;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        struct env_set *es =3D env_set_create=
(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        u=
pdown_env_set(up, &amp;o-&gt;dns_options, tt, es);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        env_set_write_file(dvf, es);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        int wfd =3D updown_runner-&gt;fds[1];<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t dvf_s=
ize =3D strlen(dvf) + 1;</span><br><span>         while (1)</span><br><span=
>         {</span><br><span>             ssize_t len =3D write(wfd, dvf, dv=
f_size);</span><br><span>@@ -747,6 +743,7 @@</span><br><span>             b=
reak;</span><br><span>         }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        int rfd =3D updown_runner-&gt;fds[0]=
;</span><br><span>         while (1)</span><br><span>         {</span><br><=
span>             ssize_t len =3D read(rfd, &amp;status, sizeof(status));</=
span><br><span>@@ -761,6 +758,7 @@</span><br><span>             break;</spa=
n><br><span>         }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+out_free:</span><br><span>         gc_free(&amp;gc);</=
span><br><span>     }</span><br><span> </span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1026?usp=
=3Demail">change 1026</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1026?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I275bf939f43577427e14890e709=
3d63c5213ae5d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1026 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--6vWaQXSfJxE=--


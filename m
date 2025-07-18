From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Fri, 18 Jul 2025 21:02:19 +0000
In-Reply-To: <gerrit.1752849659000.I43cd3d564d8c6ad4e41de5a38130d90cb6778395@...2715...>
References: <gerrit.1752849659000.I43cd3d564d8c6ad4e41de5a38130d90cb6778395@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <18ae3da5ec4662dbda94e0d322675fd9dac0fba7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Q55Jxwy+jXg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: add flag to print
 addresses in a consistent format during float
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

--Q55Jxwy+jXg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1092?usp=3Demail

to look at the new patch set (#2).


Change subject: add flag to print addresses in a consistent format during f=
loat
......................................................................

add flag to print addresses in a consistent format during float

Introduce the MAPF_SHOW_FAMILY flag to prepend the address family to the
address when printing an mroute_addr object, similar to
print_sockaddr_ex(). This ensures that when logging a float operation,
both the old and new addresses are printed in the same format:
$proto:[$family]$address:$port.

Note: when using this flag with an IPv4-mapped IPv6 address, the output
will appear as: [AF_INET6]a.b.c.d

Change-Id: I43cd3d564d8c6ad4e41de5a38130d90cb6778395
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M src/openvpn/mroute.c
M src/openvpn/mroute.h
M src/openvpn/multi.c
3 files changed, 11 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/92/1092/2

diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index a617b33..e3b1e9b 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -415,6 +415,10 @@
                 {
                     buf_printf(&out, "%s:", proto2ascii(maddr.proto, AF_IN=
ET, false));
                 }
+                if (flags & MAPF_SHOW_FAMILY)
+                {
+                    buf_printf(&out, "[AF_INET]");
+                }
                 buf_printf(&out, "%s", print_in_addr_t(ntohl(maddr.v4.addr=
),
                                                        (flags & MAPF_IA_EM=
PTY_IF_UNDEF) ? IA_EMPTY_IF_UNDEF : 0, gc));
                 if (maddr.type & MR_WITH_NETBITS)
@@ -442,6 +446,10 @@
                 {
                     buf_printf(&out, "%s:", proto2ascii(maddr.proto, AF_IN=
ET6, false));
                 }
+                if (flags & MAPF_SHOW_FAMILY)
+                {
+                    buf_printf(&out, "[AF_INET6]");
+                }
                 if (IN6_IS_ADDR_V4MAPPED( &maddr.v6.addr ) )
                 {
                     buf_printf(&out, "%s", print_in_addr_t(maddr.v4mappedv=
6.addr,
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index c359fd2..4f9fc03 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -150,6 +150,7 @@
 #define MAPF_SUBNET            (1<<0)
 #define MAPF_IA_EMPTY_IF_UNDEF (1<<1)
 #define MAPF_SHOW_ARP          (1<<2)
+#define MAPF_SHOW_FAMILY       (1<<3)
 const char *mroute_addr_print_ex(const struct mroute_addr *ma,
                                  const unsigned int flags,
                                  struct gc_arena *gc);
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 4696686..69ec2da 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3274,8 +3274,8 @@
     msg(D_MULTI_MEDIUM, "peer %" PRIu32 " (%s) floated from %s to %s",
         mi->context.c2.tls_multi->peer_id,
         tls_common_name(mi->context.c2.tls_multi, false),
-        mroute_addr_print(&mi->real, &gc),
-        print_link_socket_actual(&m->top.c2.from, &gc));
+        mroute_addr_print_ex(&mi->real, MAPF_SHOW_FAMILY, &gc),
+        mroute_addr_print_ex(&real, MAPF_SHOW_FAMILY, &gc));

     /* remove old address from hash table before changing address */
     ASSERT(hash_remove(m->hash, &mi->real));

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1092?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I43cd3d564d8c6ad4e41de5a38130d90cb6778395
Gerrit-Change-Number: 1092
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--Q55Jxwy+jXg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p>ralf_lici <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1092?usp=3Demail">View Chan=
ge</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">add flag to print addresses in a consistent format during float<br><=
br>Introduce the MAPF_SHOW_FAMILY flag to prepend the address family to the=
<br>address when printing an mroute_addr object, similar to<br>print_sockad=
dr_ex(). This ensures that when logging a float operation,<br>both the old =
and new addresses are printed in the same format:<br>$proto:[$family]$addre=
ss:$port.<br><br>Note: when using this flag with an IPv4-mapped IPv6 addres=
s, the output<br>will appear as: [AF_INET6]a.b.c.d<br><br>Change-Id: I43cd3=
d564d8c6ad4e41de5a38130d90cb6778395<br>Signed-off-by: Ralf Lici &lt;ralf@...1186...=
.2726...&gt;<br>---<br>M src/openvpn/mroute.c<br>M src/openvpn/mroute.h<br>=
M src/openvpn/multi.c<br>3 files changed, 11 insertions(+), 2 deletions(-)<=
br><br></pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/92/1=
092/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c</spa=
n><br><span>index a617b33..e3b1e9b 100644</span><br><span>--- a/src/openvpn=
/mroute.c</span><br><span>+++ b/src/openvpn/mroute.c</span><br><span>@@ -41=
5,6 +415,10 @@</span><br><span>                 {</span><br><span>         =
            buf_printf(&amp;out, &quot;%s:&quot;, proto2ascii(maddr.proto, =
AF_INET, false));</span><br><span>                 }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                if (flags &amp; MAPF_SHOW=
_FAMILY)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       buf_printf(&amp;out, &quot;[AF_INET]&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span>       =
          buf_printf(&amp;out, &quot;%s&quot;, print_in_addr_t(ntohl(maddr.=
v4.addr),</span><br><span>                                                 =
       (flags &amp; MAPF_IA_EMPTY_IF_UNDEF) ? IA_EMPTY_IF_UNDEF : 0, gc));<=
/span><br><span>                 if (maddr.type &amp; MR_WITH_NETBITS)</spa=
n><br><span>@@ -442,6 +446,10 @@</span><br><span>                 {</span><=
br><span>                     buf_printf(&amp;out, &quot;%s:&quot;, proto2a=
scii(maddr.proto, AF_INET6, false));</span><br><span>                 }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                if (fla=
gs &amp; MAPF_SHOW_FAMILY)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    buf_printf(&amp;out, &quot;[AF_INET6]&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</span>=
<br><span>                 if (IN6_IS_ADDR_V4MAPPED( &amp;maddr.v6.addr ) )=
</span><br><span>                 {</span><br><span>                     bu=
f_printf(&amp;out, &quot;%s&quot;, print_in_addr_t(maddr.v4mappedv6.addr,</=
span><br><span>diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h</sp=
an><br><span>index c359fd2..4f9fc03 100644</span><br><span>--- a/src/openvp=
n/mroute.h</span><br><span>+++ b/src/openvpn/mroute.h</span><br><span>@@ -1=
50,6 +150,7 @@</span><br><span> #define MAPF_SUBNET            (1&lt;&lt;0)=
</span><br><span> #define MAPF_IA_EMPTY_IF_UNDEF (1&lt;&lt;1)</span><br><sp=
an> #define MAPF_SHOW_ARP          (1&lt;&lt;2)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define MAPF_SHOW_FAMILY       (1&lt;&lt;3)</sp=
an><br><span> const char *mroute_addr_print_ex(const struct mroute_addr *ma=
,</span><br><span>                                  const unsigned int flag=
s,</span><br><span>                                  struct gc_arena *gc);<=
/span><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</spa=
n><br><span>index 4696686..69ec2da 100644</span><br><span>--- a/src/openvpn=
/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -3274=
,8 +3274,8 @@</span><br><span>     msg(D_MULTI_MEDIUM, &quot;peer %&quot; P=
RIu32 &quot; (%s) floated from %s to %s&quot;,</span><br><span>         mi-=
&gt;context.c2.tls_multi-&gt;peer_id,</span><br><span>         tls_common_n=
ame(mi-&gt;context.c2.tls_multi, false),</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        mroute_addr_print(&amp;mi-&gt;real, &amp;gc),</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        print_link_socke=
t_actual(&amp;m-&gt;top.c2.from, &amp;gc));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        mroute_addr_print_ex(&amp;mi-&gt;real, MAPF=
_SHOW_FAMILY, &amp;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        mroute_addr_print_ex(&amp;real, MAPF_SHOW_FAMILY, &amp;gc));</s=
pan><br><span> </span><br><span>     /* remove old address from hash table =
before changing address */</span><br><span>     ASSERT(hash_remove(m-&gt;ha=
sh, &amp;mi-&gt;real));</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1092?usp=3Demail">change 1=
092</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1092?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I43cd3d564d8c6ad4e41de5a3813=
0d90cb6778395 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1092 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--Q55Jxwy+jXg=--


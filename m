From: "d12fk (Code Review)" <gerrit@...515...>
Date: Wed, 25 Jun 2025 08:58:26 +0000
References: <gerrit.1750841904000.I55940b78e35f0e3d74aa6cba14378afed97a444e@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <05f645e2482343ab64bf275acc14ee4c4a996a13-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kzTn88GaxmQ="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: run forced
 --dns-updown without --script-security
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

--kzTn88GaxmQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1065?usp=3Demail

to review the following change.


Change subject: run forced --dns-updown without --script-security
......................................................................

run forced --dns-updown without --script-security

Due to a shortcut in the `--dns-updown force' implementation, running the
default dns-updown script required `--script-security 2'. This makes the
forced default script run without --script-security set.

Change-Id: I55940b78e35f0e3d74aa6cba14378afed97a444e
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpn/dns.c
M src/openvpn/dns.h
M src/openvpn/options.c
3 files changed, 39 insertions(+), 12 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/1065/1

diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 939ae09..ea3d91b 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -264,7 +264,7 @@
     clone.servers =3D clone_dns_servers(o->servers, gc);
     clone.servers_prepull =3D clone_dns_servers(o->servers_prepull, gc);
     clone.updown =3D o->updown;
-    clone.user_set_updown =3D o->user_set_updown;
+    clone.updown_flags =3D o->updown_flags;

     return clone;
 }
@@ -580,7 +580,7 @@
     argv_printf(&argv, "%s", o->updown);
     argv_msg(M_INFO, &argv);
     int res;
-    if (o->user_set_updown)
+    if (dns_updown_user_set(o))
     {
         res =3D openvpn_run_script(&argv, es, S_EXITCODE, "dns updown");
     }
@@ -692,7 +692,7 @@
 run_up_down_command(bool up, struct options *o, const struct tuntap *tt, s=
truct dns_updown_runner_info *updown_runner)
 {
     struct dns_options *dns =3D &o->dns_options;
-    if (!dns->updown || (o->up_script && !dns->user_set_updown))
+    if (!dns->updown || (o->up_script && !dns_updown_user_set(dns) && !dns=
_updown_forced(dns)))
     {
         return;
     }
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index 688daa7..bbc38fd 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -42,13 +42,18 @@
     DNS_TRANSPORT_TLS
 };

+enum dns_updown_flags {
+    DNS_UPDOWN_NO_FLAGS,
+    DNS_UPDOWN_USER_SET,
+    DNS_UPDOWN_FORCED
+};
+
 struct dns_domain {
     struct dns_domain *next;
     const char *name;
 };

-struct dns_server_addr
-{
+struct dns_server_addr {
     union {
         struct in_addr a4;
         struct in6_addr a6;
@@ -103,7 +108,7 @@
     struct dns_server *servers;
     struct gc_arena gc;
     const char *updown;
-    bool user_set_updown;
+    enum dns_updown_flags updown_flags;
 };

 /**
@@ -195,4 +200,26 @@
  */
 void show_dns_options(const struct dns_options *o);

+/**
+ * Returns whether dns-updown is user defined
+ *
+ * @param   o           Pointer to the DNS options struct
+ */
+static inline bool
+dns_updown_user_set(struct dns_options *o)
+{
+    return o->updown_flags =3D=3D DNS_UPDOWN_USER_SET;
+}
+
+/**
+ * Returns whether dns-updown is forced to run
+ *
+ * @param   o           Pointer to the DNS options struct
+ */
+static inline bool
+dns_updown_forced(struct dns_options *o)
+{
+    return o->updown_flags =3D=3D DNS_UPDOWN_FORCED;
+}
+
 #endif /* ifndef DNS_H */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7e26069..af097f8 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3593,7 +3593,7 @@
     struct gc_arena gc =3D gc_new();
     struct dns_options *dns =3D &o->dns_options;

-    if (dns->servers || dns->user_set_updown)
+    if (dns->servers || dns_updown_user_set(dns) || dns_updown_forced(dns))
     {
         /* Clean up env from --dhcp-option DNS config */
         struct buffer name =3D alloc_buf_gc(OPTION_PARM_SIZE, &gc);
@@ -3667,7 +3667,7 @@
             }
         }
     }
-    else if (o->up_script && !dns->user_set_updown)
+    else if (o->up_script && !dns_updown_user_set(dns) && !dns_updown_forc=
ed(dns))
     {
         /* Set foreign option env vars from --dns config */
         const char *p[] =3D { "dhcp-option", NULL, NULL };
@@ -8182,15 +8182,15 @@
         if (streq(p[1], "disable"))
         {
             dns->updown =3D NULL;
-            dns->user_set_updown =3D false;
+            dns->updown_flags =3D DNS_UPDOWN_NO_FLAGS;
         }
         else if (streq(p[1], "force"))
         {
             /* force dns-updown run, even if a --up script is defined */
-            if (dns->user_set_updown =3D=3D false)
+            if (!dns_updown_user_set(dns))
             {
                 dns->updown =3D DEFAULT_DNS_UPDOWN;
-                dns->user_set_updown =3D true;
+                dns->updown_flags =3D DNS_UPDOWN_FORCED;
             }
         }
         else
@@ -8201,7 +8201,7 @@
                 dns->updown =3D NULL;
             }
             set_user_script(options, &dns->updown, p[1], p[0], false);
-            dns->user_set_updown =3D true;
+            dns->updown_flags =3D DNS_UPDOWN_USER_SET;
         }
     }
     else if (streq(p[0], "dns") && p[1])

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1065?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I55940b78e35f0e3d74aa6cba14378afed97a444e
Gerrit-Change-Number: 1065
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--kzTn88GaxmQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1065?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">run forced --dns-updown without --script-security<br><br>Due=
 to a shortcut in the `--dns-updown force&#39; implementation, running the<=
br>default dns-updown script required `--script-security 2&#39;. This makes=
 the<br>forced default script run without --script-security set.<br><br>Cha=
nge-Id: I55940b78e35f0e3d74aa6cba14378afed97a444e<br>Signed-off-by: Heiko H=
und &lt;heiko@...2662...&gt;<br>---<br>M src/openvpn/dns.c<br>M src/openvpn=
/dns.h<br>M src/openvpn/options.c<br>3 files changed, 39 insertions(+), 12 =
deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs=
/changes/65/1065/1</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/src/openvpn/dns.c b/src/openvpn/dns=
.c</span><br><span>index 939ae09..ea3d91b 100644</span><br><span>--- a/src/=
openvpn/dns.c</span><br><span>+++ b/src/openvpn/dns.c</span><br><span>@@ -2=
64,7 +264,7 @@</span><br><span>     clone.servers =3D clone_dns_servers(o-&=
gt;servers, gc);</span><br><span>     clone.servers_prepull =3D clone_dns_s=
ervers(o-&gt;servers_prepull, gc);</span><br><span>     clone.updown =3D o-=
&gt;updown;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    clone.=
user_set_updown =3D o-&gt;user_set_updown;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    clone.updown_flags =3D o-&gt;updown_flags;</span=
><br><span> </span><br><span>     return clone;</span><br><span> }</span><b=
r><span>@@ -580,7 +580,7 @@</span><br><span>     argv_printf(&amp;argv, &qu=
ot;%s&quot;, o-&gt;updown);</span><br><span>     argv_msg(M_INFO, &amp;argv=
);</span><br><span>     int res;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (o-&gt;user_set_updown)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (dns_updown_user_set(o))</span><br><span>     =
{</span><br><span>         res =3D openvpn_run_script(&amp;argv, es, S_EXIT=
CODE, &quot;dns updown&quot;);</span><br><span>     }</span><br><span>@@ -6=
92,7 +692,7 @@</span><br><span> run_up_down_command(bool up, struct options=
 *o, const struct tuntap *tt, struct dns_updown_runner_info *updown_runner)=
</span><br><span> {</span><br><span>     struct dns_options *dns =3D &amp;o=
-&gt;dns_options;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (!dns-&gt;updown || (o-&gt;up_script &amp;&amp; !dns-&gt;user_set_updown=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!dns-&gt;=
updown || (o-&gt;up_script &amp;&amp; !dns_updown_user_set(dns) &amp;&amp; =
!dns_updown_forced(dns)))</span><br><span>     {</span><br><span>         r=
eturn;</span><br><span>     }</span><br><span>diff --git a/src/openvpn/dns.=
h b/src/openvpn/dns.h</span><br><span>index 688daa7..bbc38fd 100644</span><=
br><span>--- a/src/openvpn/dns.h</span><br><span>+++ b/src/openvpn/dns.h</s=
pan><br><span>@@ -42,13 +42,18 @@</span><br><span>     DNS_TRANSPORT_TLS</s=
pan><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+enum dns_updown_flags {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    DNS_UPDOWN_NO_FLAGS,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    DNS_UPDOWN_USER_SET,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    DNS_UPDOWN_FORCED</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> struct dns_domain {</span><br><span>    =
 struct dns_domain *next;</span><br><span>     const char *name;</span><br>=
<span> };</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-struct dns_server_addr</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct dns_=
server_addr {</span><br><span>     union {</span><br><span>         struct =
in_addr a4;</span><br><span>         struct in6_addr a6;</span><br><span>@@=
 -103,7 +108,7 @@</span><br><span>     struct dns_server *servers;</span><b=
r><span>     struct gc_arena gc;</span><br><span>     const char *updown;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool user_set_updow=
n;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    enum dns_updo=
wn_flags updown_flags;</span><br><span> };</span><br><span> </span><br><spa=
n> /**</span><br><span>@@ -195,4 +200,26 @@</span><br><span>  */</span><br>=
<span> void show_dns_options(const struct dns_options *o);</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Returns whether dns-updown is u=
ser defined</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param   o           P=
ointer to the DNS options struct</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic inline bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dns_=
updown_user_set(struct dns_options *o)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return o-&gt;updown_flags =3D=3D DNS_UPDOWN_USER_SET;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Returns whe=
ther dns-updown is forced to run</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param   o           Pointer to the DNS options struct</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static inline bool</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+dns_updown_forced(struct dns_options *o)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return o-&gt;updown_flags =3D=3D DNS_UPDOWN_FORCED;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* ifndef DN=
S_H */</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/opt=
ions.c</span><br><span>index 7e26069..af097f8 100644</span><br><span>--- a/=
src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br=
><span>@@ -3593,7 +3593,7 @@</span><br><span>     struct gc_arena gc =3D gc=
_new();</span><br><span>     struct dns_options *dns =3D &amp;o-&gt;dns_opt=
ions;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (dns-&gt;servers || dns-&gt;user_set_updown)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (dns-&gt;servers || dns_updown_use=
r_set(dns) || dns_updown_forced(dns))</span><br><span>     {</span><br><spa=
n>         /* Clean up env from --dhcp-option DNS config */</span><br><span=
>         struct buffer name =3D alloc_buf_gc(OPTION_PARM_SIZE, &amp;gc);</=
span><br><span>@@ -3667,7 +3667,7 @@</span><br><span>             }</span><=
br><span>         }</span><br><span>     }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    else if (o-&gt;up_script &amp;&amp; !dns-&gt;user_=
set_updown)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else=
 if (o-&gt;up_script &amp;&amp; !dns_updown_user_set(dns) &amp;&amp; !dns_u=
pdown_forced(dns))</span><br><span>     {</span><br><span>         /* Set f=
oreign option env vars from --dns config */</span><br><span>         const =
char *p[] =3D { &quot;dhcp-option&quot;, NULL, NULL };</span><br><span>@@ -=
8182,15 +8182,15 @@</span><br><span>         if (streq(p[1], &quot;disable&=
quot;))</span><br><span>         {</span><br><span>             dns-&gt;upd=
own =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    dns-&gt;user_set_updown =3D false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            dns-&gt;updown_flags =3D DNS_UPDOWN_NO_FLAGS=
;</span><br><span>         }</span><br><span>         else if (streq(p[1], =
&quot;force&quot;))</span><br><span>         {</span><br><span>            =
 /* force dns-updown run, even if a --up script is defined */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            if (dns-&gt;user_set_up=
down =3D=3D false)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           if (!dns_updown_user_set(dns))</span><br><span>             {</s=
pan><br><span>                 dns-&gt;updown =3D DEFAULT_DNS_UPDOWN;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                dns-&gt;use=
r_set_updown =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                dns-&gt;updown_flags =3D DNS_UPDOWN_FORCED;</span><br><s=
pan>             }</span><br><span>         }</span><br><span>         else=
</span><br><span>@@ -8201,7 +8201,7 @@</span><br><span>                 dns=
-&gt;updown =3D NULL;</span><br><span>             }</span><br><span>      =
       set_user_script(options, &amp;dns-&gt;updown, p[1], p[0], false);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            dns-&gt;user=
_set_updown =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            dns-&gt;updown_flags =3D DNS_UPDOWN_USER_SET;</span><br><span=
>         }</span><br><span>     }</span><br><span>     else if (streq(p[0]=
, &quot;dns&quot;) &amp;&amp; p[1])</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1065?usp=3Dema=
il">change 1065</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1065?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I55940b78e35f0e3d74aa6cba143=
78afed97a444e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1065 </div>
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


--kzTn88GaxmQ=--


From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 17 May 2025 09:51:22 +0000
In-Reply-To: <gerrit.1733989644000.I3fb01ab76cf3df0874ba92e08f371d17607a8369@...2715...>
References: <gerrit.1733989644000.I3fb01ab76cf3df0874ba92e08f371d17607a8369@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <98e56d502d4505a2a7efcf93c9fe4a95c4d9568b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8O1PWKvDoIc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dns: don't publish
 env vars to non-dns scripts
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, stipa <lstipakov@...277...>

--8O1PWKvDoIc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#29) to the change originally created b=
y d12fk. ( http://gerrit.openvpn.net/c/openvpn/+/840?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: dns: don't publish env vars to non-dns scripts
......................................................................

dns: don't publish env vars to non-dns scripts

With --dns-updown in place we no longer need --dns option related vars in
the environment for other script hooks. Code for doing that is removed and
the function to set --dns stuff made static, for internal use only.

Change-Id: I3fb01ab76cf3df0874ba92e08f371d17607a8369
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250517092637.2103-1-gert@...1296...>
URL: https://www.mail-archive.com/search?l=3Dmid&q=3D20250517092637.2103-1-=
gert@...1296...
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dns.c
M src/openvpn/dns.h
M src/openvpn/options.c
3 files changed, 87 insertions(+), 101 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/40/840/29

diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 19de321..221e9a9 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -350,93 +350,6 @@
     }
 }

-static void
-setenv_dns_option(struct env_set *es,
-                  const char *format, int i, int j,
-                  const char *value)
-{
-    char name[64];
-    bool name_ok =3D false;
-
-    if (j < 0)
-    {
-        name_ok =3D snprintf(name, sizeof(name), format, i);
-    }
-    else
-    {
-        name_ok =3D snprintf(name, sizeof(name), format, i, j);
-    }
-
-    if (!name_ok)
-    {
-        msg(M_WARN, "WARNING: dns option setenv name buffer overflow");
-    }
-
-    setenv_str(es, name, value);
-}
-
-void
-setenv_dns_options(const struct dns_options *o, struct env_set *es)
-{
-    struct gc_arena gc =3D gc_new();
-    const struct dns_server *s;
-    const struct dns_domain *d;
-    int i, j;
-
-    for (i =3D 1, d =3D o->search_domains; d !=3D NULL; i++, d =3D d->next)
-    {
-        setenv_dns_option(es, "dns_search_domain_%d", i, -1, d->name);
-    }
-
-    for (i =3D 1, s =3D o->servers; s !=3D NULL; i++, s =3D s->next)
-    {
-        for (j =3D 0; j < s->addr_count; ++j)
-        {
-            if (s->addr[j].family =3D=3D AF_INET)
-            {
-                setenv_dns_option(es, "dns_server_%d_address_%d", i, j + 1,
-                                  print_in_addr_t(s->addr[j].in.a4.s_addr,=
 IA_NET_ORDER, &gc));
-            }
-            else
-            {
-                setenv_dns_option(es, "dns_server_%d_address_%d", i, j + 1,
-                                  print_in6_addr(s->addr[j].in.a6, 0, &gc)=
);
-            }
-            if (s->addr[j].port)
-            {
-                setenv_dns_option(es, "dns_server_%d_port_%d", i, j + 1,
-                                  print_in_port_t(s->addr[j].port, &gc));
-            }
-        }
-
-        if (s->domains)
-        {
-            for (j =3D 1, d =3D s->domains; d !=3D NULL; j++, d =3D d->nex=
t)
-            {
-                setenv_dns_option(es, "dns_server_%d_resolve_domain_%d", i=
, j, d->name);
-            }
-        }
-
-        if (s->dnssec)
-        {
-            setenv_dns_option(es, "dns_server_%d_dnssec", i, -1,
-                              dnssec_value(s->dnssec));
-        }
-
-        if (s->transport)
-        {
-            setenv_dns_option(es, "dns_server_%d_transport", i, -1,
-                              transport_value(s->transport));
-        }
-        if (s->sni)
-        {
-            setenv_dns_option(es, "dns_server_%d_sni", i, -1, s->sni);
-        }
-    }
-
-    gc_free(&gc);
-}
-
 #ifdef _WIN32

 static void
@@ -554,6 +467,93 @@
 #else /* ifdef _WIN32 */

 static void
+setenv_dns_option(struct env_set *es,
+                  const char *format, int i, int j,
+                  const char *value)
+{
+    char name[64];
+    bool name_ok =3D false;
+
+    if (j < 0)
+    {
+        name_ok =3D snprintf(name, sizeof(name), format, i);
+    }
+    else
+    {
+        name_ok =3D snprintf(name, sizeof(name), format, i, j);
+    }
+
+    if (!name_ok)
+    {
+        msg(M_WARN, "WARNING: dns option setenv name buffer overflow");
+    }
+
+    setenv_str(es, name, value);
+}
+
+static void
+setenv_dns_options(const struct dns_options *o, struct env_set *es)
+{
+    struct gc_arena gc =3D gc_new();
+    const struct dns_server *s;
+    const struct dns_domain *d;
+    int i, j;
+
+    for (i =3D 1, d =3D o->search_domains; d !=3D NULL; i++, d =3D d->next)
+    {
+        setenv_dns_option(es, "dns_search_domain_%d", i, -1, d->name);
+    }
+
+    for (i =3D 1, s =3D o->servers; s !=3D NULL; i++, s =3D s->next)
+    {
+        for (j =3D 0; j < s->addr_count; ++j)
+        {
+            if (s->addr[j].family =3D=3D AF_INET)
+            {
+                setenv_dns_option(es, "dns_server_%d_address_%d", i, j + 1,
+                                  print_in_addr_t(s->addr[j].in.a4.s_addr,=
 IA_NET_ORDER, &gc));
+            }
+            else
+            {
+                setenv_dns_option(es, "dns_server_%d_address_%d", i, j + 1,
+                                  print_in6_addr(s->addr[j].in.a6, 0, &gc)=
);
+            }
+            if (s->addr[j].port)
+            {
+                setenv_dns_option(es, "dns_server_%d_port_%d", i, j + 1,
+                                  print_in_port_t(s->addr[j].port, &gc));
+            }
+        }
+
+        if (s->domains)
+        {
+            for (j =3D 1, d =3D s->domains; d !=3D NULL; j++, d =3D d->nex=
t)
+            {
+                setenv_dns_option(es, "dns_server_%d_resolve_domain_%d", i=
, j, d->name);
+            }
+        }
+
+        if (s->dnssec)
+        {
+            setenv_dns_option(es, "dns_server_%d_dnssec", i, -1,
+                              dnssec_value(s->dnssec));
+        }
+
+        if (s->transport)
+        {
+            setenv_dns_option(es, "dns_server_%d_transport", i, -1,
+                              transport_value(s->transport));
+        }
+        if (s->sni)
+        {
+            setenv_dns_option(es, "dns_server_%d_sni", i, -1, s->sni);
+        }
+    }
+
+    gc_free(&gc);
+}
+
+static void
 updown_env_set(bool up, const struct dns_options *o, const struct tuntap *=
tt, struct env_set *es)
 {
     setenv_str(es, "dev", tt->actual_name);
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index 4cc1e73..c56d603 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -168,14 +168,6 @@
                      struct dns_updown_runner_info *duri);

 /**
- * Puts the DNS options into an environment set.
- *
- * @param   o           Pointer to the DNS options to set
- * @param   es          Pointer to the env_set to set the options into
- */
-void setenv_dns_options(const struct dns_options *o, struct env_set *es);
-
-/**
  * Prints configured DNS options.
  *
  * @param   o           Pointer to the DNS options to print
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3c1632f..810bb56 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1059,11 +1059,6 @@
             setenv_local_entry(es, o->ce.local_list->array[i], i+1);
         }
     }
-
-    if (!o->pull)
-    {
-        setenv_dns_options(&o->dns_options, es);
-    }
 }

 #ifndef _WIN32
@@ -4182,7 +4177,6 @@
     if (success)
     {
         dns_options_postprocess_pull(&o->dns_options);
-        setenv_dns_options(&o->dns_options, es);
 #if defined(_WIN32) || defined(TARGET_ANDROID)
         tuntap_options_copy_dns(o);
 #else

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/840?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3fb01ab76cf3df0874ba92e08f371d17607a8369
Gerrit-Change-Number: 840
Gerrit-PatchSet: 29
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--8O1PWKvDoIc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #29</strong> to the change originally c=
reated by d12fk.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/840=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">dns: don&#39;t publish env vars to non-dns scripts<b=
r><br>With --dns-updown in place we no longer need --dns option related var=
s in<br>the environment for other script hooks. Code for doing that is remo=
ved and<br>the function to set --dns stuff made static, for internal use on=
ly.<br><br>Change-Id: I3fb01ab76cf3df0874ba92e08f371d17607a8369<br>Signed-o=
ff-by: Heiko Hund &lt;heiko@...2662...&gt;<br>Acked-by: Gert Doering &lt;ge=
rt@...1296...&gt;<br>Message-Id: &lt;20250517092637.2103-1-gert@...1296...&=
gt;<br>URL: https://www.mail-archive.com/search?l=3Dmid&amp;q=3D20250517092=
637.2103-1-gert@...1296...<br>Signed-off-by: Gert Doering &lt;gert@...1725...=
..&gt;<br>---<br>M src/openvpn/dns.c<br>M src/openvpn/dns.h<br>M src/openvp=
n/options.c<br>3 files changed, 87 insertions(+), 101 deletions(-)<br><br><=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/40/840/29</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>in=
dex 19de321..221e9a9 100644</span><br><span>--- a/src/openvpn/dns.c</span><=
br><span>+++ b/src/openvpn/dns.c</span><br><span>@@ -350,93 +350,6 @@</span=
><br><span>     }</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-setenv_dns_option(struct env_set *es,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                  const char *format=
, int i, int j,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
            const char *value)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char na=
me[64];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool name_=
ok =3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (j &lt; 0)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        name_ok =3D snprintf(name, sizeof(name), =
format, i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        name_ok =3D snprintf(name, sizeof(name), format=
, i, j);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (!name_ok)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        msg(M_WARN, &quot;WARNING: dns option setenv name buffer overf=
low&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    setenv_str(es, name, value);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-vo=
id</span><br><span style=3D"color: hsl(0, 100%, 40%);">-setenv_dns_options(=
const struct dns_options *o, struct env_set *es)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    const struct dns_server *s;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const struct dns_domain *d;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    int i, j;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    for (i =3D 1, d =3D o-&gt;search_domains; d !=3D NULL; i++=
, d =3D d-&gt;next)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        setenv_dns=
_option(es, &quot;dns_search_domain_%d&quot;, i, -1, d-&gt;name);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    for (i =3D 1, s =3D o-&gt;servers; s !=3D NULL; i++, s =3D s-&gt=
;next)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        for (j =3D 0; j &lt; s-=
&gt;addr_count; ++j)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            i=
f (s-&gt;addr[j].family =3D=3D AF_INET)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                setenv_dns_option(es, &quot;dns_server_%d_address=
_%d&quot;, i, j + 1,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                                 print_in_addr_t(s-&gt;addr[j].in.a4.s_addr=
, IA_NET_ORDER, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
setenv_dns_option(es, &quot;dns_server_%d_address_%d&quot;, i, j + 1,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
       print_in6_addr(s-&gt;addr[j].in.a6, 0, &amp;gc));</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            if (s-&gt;addr[j].port)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                setenv_dns_option(es, &quo=
t;dns_server_%d_port_%d&quot;, i, j + 1,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                                  print_in_port_t(s-&gt;=
addr[j].port, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (s-&gt;domains)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            for (j =3D 1, d =3D s-&gt;domai=
ns; d !=3D NULL; j++, d =3D d-&gt;next)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                setenv_dns_option(es, &quot;dns_server_%d_resolve=
_domain_%d&quot;, i, j, d-&gt;name);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (s-&gt;dnssec)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            setenv_dns_option(es, =
&quot;dns_server_%d_dnssec&quot;, i, -1,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                              dnssec_value(s-&gt;dnssec)=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (s-&gt;transport)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            setenv_dns_option(es, &quot;dns_server_%d_t=
ransport&quot;, i, -1,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                              transport_value(s-&gt;transport));</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (s-&gt;sni)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            setenv_dns_option(es, &quot;dns_server_%d_=
sni&quot;, i, -1, s-&gt;sni);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span> #ifdef _WIN32</span><br><span> </span><br><=
span> static void</span><br><span>@@ -554,6 +467,93 @@</span><br><span> #el=
se /* ifdef _WIN32 */</span><br><span> </span><br><span> static void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+setenv_dns_option(struct e=
nv_set *es,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
          const char *format, int i, int j,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                  const char *value)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    char name[64];</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    bool name_ok =3D false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (j &lt; 0)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   name_ok =3D snprintf(name, sizeof(name), format, i);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     name_ok =3D snprintf(name, sizeof(name), format, i, j);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (!name_ok)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
msg(M_WARN, &quot;WARNING: dns option setenv name buffer overflow&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    setenv_str(es, name, value);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+setenv_dns_=
options(const struct dns_options *o, struct env_set *es)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const struct dns_server *s;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct dns_domain=
 *d;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int i, j;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    for (i =3D 1, d =3D o-&gt;search_dom=
ains; d !=3D NULL; i++, d =3D d-&gt;next)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        setenv_dns_option(es, &quot;dns_search_domain_%d&quot;, i, =
-1, d-&gt;name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    for (i =3D 1, s =3D o-&gt;server=
s; s !=3D NULL; i++, s =3D s-&gt;next)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        for (j =3D 0; j &lt; s-&gt;addr_count; ++j)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            if (s-&gt;addr[j].family =3D=3D AF_I=
NET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                seten=
v_dns_option(es, &quot;dns_server_%d_address_%d&quot;, i, j + 1,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
    print_in_addr_t(s-&gt;addr[j].in.a4.s_addr, IA_NET_ORDER, &amp;gc));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                setenv_dns_option(es,=
 &quot;dns_server_%d_address_%d&quot;, i, j + 1,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                  print_in6_ad=
dr(s-&gt;addr[j].in.a6, 0, &amp;gc));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            if (s-&gt;addr[j].port)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                setenv_dns_option(es, &quot;dns_serve=
r_%d_port_%d&quot;, i, j + 1,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                  print_in_port_t(s-&gt;addr[j].p=
ort, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (s-&gt;domains)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            for (j =3D 1, d =3D s-&gt;dom=
ains; d !=3D NULL; j++, d =3D d-&gt;next)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                setenv_dns_option(es, &quot;dns_server_%d_r=
esolve_domain_%d&quot;, i, j, d-&gt;name);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
s-&gt;dnssec)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            sete=
nv_dns_option(es, &quot;dns_server_%d_dnssec&quot;, i, -1,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                              dnssec=
_value(s-&gt;dnssec));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (s-&gt;transpor=
t)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            setenv_dns_opti=
on(es, &quot;dns_server_%d_transport&quot;, i, -1,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                              transport_valu=
e(s-&gt;transport));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (s-&gt;sni)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            sete=
nv_dns_option(es, &quot;dns_server_%d_sni&quot;, i, -1, s-&gt;sni);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span> u=
pdown_env_set(bool up, const struct dns_options *o, const struct tuntap *tt=
, struct env_set *es)</span><br><span> {</span><br><span>     setenv_str(es=
, &quot;dev&quot;, tt-&gt;actual_name);</span><br><span>diff --git a/src/op=
envpn/dns.h b/src/openvpn/dns.h</span><br><span>index 4cc1e73..c56d603 1006=
44</span><br><span>--- a/src/openvpn/dns.h</span><br><span>+++ b/src/openvp=
n/dns.h</span><br><span>@@ -168,14 +168,6 @@</span><br><span>              =
        struct dns_updown_runner_info *duri);</span><br><span> </span><br><=
span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Puts the =
DNS options into an environment set.</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @=
param   o           Pointer to the DNS options to set</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @param   es          Pointer to the env_=
set to set the options into</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void setenv_=
dns_options(const struct dns_options *o, struct env_set *es);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-/**</span><br><span>  * Prints configured DNS options.</=
span><br><span>  *</span><br><span>  * @param   o           Pointer to the =
DNS options to print</span><br><span>diff --git a/src/openvpn/options.c b/s=
rc/openvpn/options.c</span><br><span>index 3c1632f..810bb56 100644</span><b=
r><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/optio=
ns.c</span><br><span>@@ -1059,11 +1059,6 @@</span><br><span>             se=
tenv_local_entry(es, o-&gt;ce.local_list-&gt;array[i], i+1);</span><br><spa=
n>         }</span><br><span>     }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(!o-&gt;pull)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        setenv_dns_optio=
ns(&amp;o-&gt;dns_options, es);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span> }</span><br><span> </span><br><span> #ifnd=
ef _WIN32</span><br><span>@@ -4182,7 +4177,6 @@</span><br><span>     if (su=
ccess)</span><br><span>     {</span><br><span>         dns_options_postproc=
ess_pull(&amp;o-&gt;dns_options);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        setenv_dns_options(&amp;o-&gt;dns_options, es);</span><=
br><span> #if defined(_WIN32) || defined(TARGET_ANDROID)</span><br><span>  =
       tuntap_options_copy_dns(o);</span><br><span> #else</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/840?usp=3Demail">change 840</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/840?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3fb01ab76cf3df0874ba92e08f3=
71d17607a8369 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 840 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 29 </div>
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
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--8O1PWKvDoIc=--


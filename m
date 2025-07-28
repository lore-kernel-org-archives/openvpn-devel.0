From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 28 Jul 2025 14:14:40 +0000
In-Reply-To: <gerrit.1753438913000.I7efc77f63734501dfa8a8f5bed17b1a1b4e9e201@...2715...>
References: <gerrit.1753438913000.I7efc77f63734501dfa8a8f5bed17b1a1b4e9e201@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <708480a93af92c62502989fc673b1ef544234113-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="v4y4gqTjvgY="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: options: Simplify
 function setenv_foreign_option
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

--v4y4gqTjvgY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1112?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: options: Simplify function setenv_foreign_option
......................................................................

options: Simplify function setenv_foreign_option

This was relatively complex for the actual usage.
Looked at the code because of -Wconversion warnings
related to the len argument. So this should also be
gone.

Change-Id: I7efc77f63734501dfa8a8f5bed17b1a1b4e9e201
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250728125647.26992-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
396.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
1 file changed, 33 insertions(+), 45 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/12/1112/4

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0662b49..d44c102 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1067,41 +1067,32 @@

 #ifndef _WIN32
 static void
-setenv_foreign_option(struct options *o, const char *argv[], int len, stru=
ct env_set *es)
+setenv_foreign_option(struct options *o, const char *option, const char *v=
alue, struct env_set *es)
 {
-    if (len > 0)
-    {
-        struct gc_arena gc =3D gc_new();
-        struct buffer name =3D alloc_buf_gc(OPTION_PARM_SIZE, &gc);
-        struct buffer value =3D alloc_buf_gc(OPTION_PARM_SIZE, &gc);
-        int i;
-        bool first =3D true;
-        bool good =3D true;
+    struct gc_arena gc =3D gc_new();
+    struct buffer env_name =3D alloc_buf_gc(OPTION_PARM_SIZE, &gc);
+    struct buffer env_value =3D alloc_buf_gc(OPTION_PARM_SIZE, &gc);
+    bool good =3D true;

-        good &=3D buf_printf(&name, "foreign_option_%d", o->foreign_option=
_index + 1);
-        ++o->foreign_option_index;
-        for (i =3D 0; i < len; ++i)
-        {
-            if (argv[i])
-            {
-                if (!first)
-                {
-                    good &=3D buf_printf(&value, " ");
-                }
-                good &=3D buf_printf(&value, "%s", argv[i]);
-                first =3D false;
-            }
-        }
-        if (good)
-        {
-            setenv_str(es, BSTR(&name), BSTR(&value));
-        }
-        else
-        {
-            msg(M_WARN, "foreign_option: name/value overflow");
-        }
-        gc_free(&gc);
+    good &=3D buf_printf(&env_name, "foreign_option_%d", o->foreign_option=
_index + 1);
+    if (value)
+    {
+        good &=3D buf_printf(&env_value, "dhcp-option %s %s", option, valu=
e);
     }
+    else
+    {
+        good &=3D buf_printf(&env_value, "dhcp-option %s", option);
+    }
+    if (good)
+    {
+        setenv_str(es, BSTR(&env_name), BSTR(&env_value));
+        ++o->foreign_option_index;
+    }
+    else
+    {
+        msg(M_WARN, "foreign_option: name/value overflow");
+    }
+    gc_free(&gc);
 }
 #endif /* ifndef _WIN32 */

@@ -3678,15 +3669,10 @@
     else if (o->up_script && !dns_updown_user_set(dns) && !dns_updown_forc=
ed(dns))
     {
         /* Set foreign option env vars from --dns config */
-        const char *p[] =3D { "dhcp-option", NULL, NULL };
-        size_t p_len =3D sizeof(p) / sizeof(p[0]);
-
-        p[1] =3D "DOMAIN";
         const struct dns_domain *d =3D dns->search_domains;
         while (d)
         {
-            p[2] =3D d->name;
-            setenv_foreign_option(o, (const char **)p, p_len, es);
+            setenv_foreign_option(o, "DOMAIN", d->name, es);
             d =3D d->next;
         }

@@ -3713,17 +3699,19 @@
             {
                 for (int i =3D 0; i < s->addr_count; ++i)
                 {
+                    const char *option;
+                    const char *value;
                     if (s->addr[i].family =3D=3D AF_INET)
                     {
-                        p[1] =3D "DNS";
-                        p[2] =3D print_in_addr_t(s->addr[i].in.a4.s_addr, =
IA_NET_ORDER, &gc);
+                        option =3D "DNS";
+                        value =3D print_in_addr_t(s->addr[i].in.a4.s_addr,=
 IA_NET_ORDER, &gc);
                     }
                     else
                     {
-                        p[1] =3D "DNS6";
-                        p[2] =3D print_in6_addr(s->addr[i].in.a6, 0, &gc);
+                        option =3D "DNS6";
+                        value =3D print_in6_addr(s->addr[i].in.a6, 0, &gc);
                     }
-                    setenv_foreign_option(o, (const char **)p, p_len, es);
+                    setenv_foreign_option(o, option, value, es);
                 }
                 break;
             }
@@ -8388,7 +8376,7 @@
             goto err;
         }
 #else /* if defined(_WIN32) || defined(TARGET_ANDROID) */
-        setenv_foreign_option(options, (const char **)p, 3, es);
+        setenv_foreign_option(options, p[1], p[2], es);
 #endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */
     }
 #ifdef _WIN32
@@ -8530,7 +8518,7 @@
     else if (streq(p[0], "dhcp-option") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
-        setenv_foreign_option(options, (const char **)p, 3, es);
+        setenv_foreign_option(options, p[1], p[2], es);
     }
     else if (streq(p[0], "route-method") && p[1] && !p[2])
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1112?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7efc77f63734501dfa8a8f5bed17b1a1b4e9e201
Gerrit-Change-Number: 1112
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--v4y4gqTjvgY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1112?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">options: Simplify function setenv_foreign_option<br>=
<br>This was relatively complex for the actual usage.<br>Looked at the code=
 because of -Wconversion warnings<br>related to the len argument. So this s=
hould also be<br>gone.<br><br>Change-Id: I7efc77f63734501dfa8a8f5bed17b1a1b=
4e9e201<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Ack=
ed-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;202507281256=
47.26992-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn=
-devel@lists.sourceforge.net/msg32396.html<br>Signed-off-by: Gert Doering &=
lt;gert@...1296...&gt;<br>---<br>M src/openvpn/options.c<br>1 file changed,=
 33 insertions(+), 45 deletions(-)<br><br></pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.=
net:29418/openvpn refs/changes/12/1112/4</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/o=
ptions.c b/src/openvpn/options.c</span><br><span>index 0662b49..d44c102 100=
644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/o=
penvpn/options.c</span><br><span>@@ -1067,41 +1067,32 @@</span><br><span> <=
/span><br><span> #ifndef _WIN32</span><br><span> static void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-setenv_foreign_option(struct options=
 *o, const char *argv[], int len, struct env_set *es)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+setenv_foreign_option(struct options *o, =
const char *option, const char *value, struct env_set *es)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (len &gt; 0)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        struct gc_arena gc =3D gc_new=
();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct buf=
fer name =3D alloc_buf_gc(OPTION_PARM_SIZE, &amp;gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        struct buffer value =3D alloc_buf_g=
c(OPTION_PARM_SIZE, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        bool first =3D true;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        bool good =3D true;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer env_name =3D alloc_buf_=
gc(OPTION_PARM_SIZE, &amp;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct buffer env_value =3D alloc_buf_gc(OPTION_PARM_SIZE, &=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool go=
od =3D true;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        good &amp;=3D buf_printf(&amp;name, &quot;foreign_option_%=
d&quot;, o-&gt;foreign_option_index + 1);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        ++o-&gt;foreign_option_index;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; len; ++i)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            if (argv[i])</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                if (!first)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                    good &amp;=3D buf=
_printf(&amp;value, &quot; &quot;);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                good &amp;=3D buf_printf(&amp;value, &quot;%s&quo=
t;, argv[i]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        first =3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (good)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            setenv_str(es, BSTR(&=
amp;name), BSTR(&amp;value));</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &=
quot;foreign_option: name/value overflow&quot;);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        gc_free(&amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    good &amp;=3D buf_printf(&amp;env_name, &quot;fore=
ign_option_%d&quot;, o-&gt;foreign_option_index + 1);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (value)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        good &amp;=3D buf_printf(&amp;env_value, &quot;dhcp-=
option %s %s&quot;, option, value);</span><br><span>     }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        good &amp;=3D buf_printf(&amp;env_value, &quot;dhcp-o=
ption %s&quot;, option);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (g=
ood)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        setenv_str(es, BSTR(&=
amp;env_name), BSTR(&amp;env_value));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        ++o-&gt;foreign_option_index;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     msg(M_WARN, &quot;foreign_option: name/value overflow&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span> }<=
/span><br><span> #endif /* ifndef _WIN32 */</span><br><span> </span><br><sp=
an>@@ -3678,15 +3669,10 @@</span><br><span>     else if (o-&gt;up_script &a=
mp;&amp; !dns_updown_user_set(dns) &amp;&amp; !dns_updown_forced(dns))</spa=
n><br><span>     {</span><br><span>         /* Set foreign option env vars =
from --dns config */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       const char *p[] =3D { &quot;dhcp-option&quot;, NULL, NULL };</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        size_t p_len =3D size=
of(p) / sizeof(p[0]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        p[1] =3D &quo=
t;DOMAIN&quot;;</span><br><span>         const struct dns_domain *d =3D dns=
-&gt;search_domains;</span><br><span>         while (d)</span><br><span>   =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            p[=
2] =3D d-&gt;name;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         setenv_foreign_option(o, (const char **)p, p_len, es);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            setenv_foreign_opti=
on(o, &quot;DOMAIN&quot;, d-&gt;name, es);</span><br><span>             d =
=3D d-&gt;next;</span><br><span>         }</span><br><span> </span><br><spa=
n>@@ -3713,17 +3699,19 @@</span><br><span>             {</span><br><span>  =
               for (int i =3D 0; i &lt; s-&gt;addr_count; ++i)</span><br><s=
pan>                 {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    const char *option;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    const char *value;</span><br><sp=
an>                     if (s-&gt;addr[i].family =3D=3D AF_INET)</span><br>=
<span>                     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                        p[1] =3D &quot;DNS&quot;;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                        p[2] =3D print_i=
n_addr_t(s-&gt;addr[i].in.a4.s_addr, IA_NET_ORDER, &amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                        option =3D=
 &quot;DNS&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                      value =3D print_in_addr_t(s-&gt;addr[i].in.a4.s_addr,=
 IA_NET_ORDER, &amp;gc);</span><br><span>                     }</span><br><=
span>                     else</span><br><span>                     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                        p[1=
] =3D &quot;DNS6&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                        p[2] =3D print_in6_addr(s-&gt;addr[i].in.a6, 0, &=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
             option =3D &quot;DNS6&quot;;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                        value =3D print_in6_addr(s-&g=
t;addr[i].in.a6, 0, &amp;gc);</span><br><span>                     }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                    setenv_f=
oreign_option(o, (const char **)p, p_len, es);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                    setenv_foreign_option(o, opt=
ion, value, es);</span><br><span>                 }</span><br><span>       =
          break;</span><br><span>             }</span><br><span>@@ -8388,7 =
+8376,7 @@</span><br><span>             goto err;</span><br><span>         =
}</span><br><span> #else /* if defined(_WIN32) || defined(TARGET_ANDROID) *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        setenv_forei=
gn_option(options, (const char **)p, 3, es);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        setenv_foreign_option(options, p[1], p[2],=
 es);</span><br><span> #endif /* if defined(_WIN32) || defined(TARGET_ANDRO=
ID) */</span><br><span>     }</span><br><span> #ifdef _WIN32</span><br><spa=
n>@@ -8530,7 +8518,7 @@</span><br><span>     else if (streq(p[0], &quot;dhc=
p-option&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>     {</s=
pan><br><span>         VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        setenv_foreign_option(options, (=
const char **)p, 3, es);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        setenv_foreign_option(options, p[1], p[2], es);</span><br><spa=
n>     }</span><br><span>     else if (streq(p[0], &quot;route-method&quot;=
) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1112?usp=3Demail">change 1112</a>. To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">set=
tings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1112?u=
sp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7efc77f63734501dfa8a8f5bed1=
7b1a1b4e9e201 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1112 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--v4y4gqTjvgY=--


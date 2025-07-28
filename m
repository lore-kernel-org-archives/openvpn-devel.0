From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 28 Jul 2025 12:28:56 +0000
In-Reply-To: <gerrit.1753438913000.I7efc77f63734501dfa8a8f5bed17b1a1b4e9e201@...2715...>
References: <gerrit.1753438913000.I7efc77f63734501dfa8a8f5bed17b1a1b4e9e201@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <28d649784aefbfd0d9e44ca5164bc172f6313832-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vFa7UJxuCAE="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--vFa7UJxuCAE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1112?usp=3Demail

to look at the new patch set (#2).


Change subject: options: Simplify function setenv_foreign_option
......................................................................

options: Simplify function setenv_foreign_option

This was relatively complex for the actual usage.
Looked at the code because of -Wconversion warnings
related to the len argument. So this should also be
gone.

Change-Id: I7efc77f63734501dfa8a8f5bed17b1a1b4e9e201
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/options.c
1 file changed, 33 insertions(+), 45 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/12/1112/2

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 70b5799..8757581 100644
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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--vFa7UJxuCAE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1112?usp=3Demail">View C=
hange</a></p><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">options: Simplify function setenv_foreign_option<br><br>This was =
relatively complex for the actual usage.<br>Looked at the code because of -=
Wconversion warnings<br>related to the len argument. So this should also be=
<br>gone.<br><br>Change-Id: I7efc77f63734501dfa8a8f5bed17b1a1b4e9e201<br>Si=
gned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/ope=
nvpn/options.c<br>1 file changed, 33 insertions(+), 45 deletions(-)<br><br>=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/12/1112/2</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br=
><span>index 70b5799..8757581 100644</span><br><span>--- a/src/openvpn/opti=
ons.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -1067,=
41 +1067,32 @@</span><br><span> </span><br><span> #ifndef _WIN32</span><br>=
<span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-set=
env_foreign_option(struct options *o, const char *argv[], int len, struct e=
nv_set *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+setenv_f=
oreign_option(struct options *o, const char *option, const char *value, str=
uct env_set *es)</span><br><span> {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (len &gt; 0)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        struct buffer name =3D alloc_buf_gc(OPTION_PARM_SIZE=
, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        st=
ruct buffer value =3D alloc_buf_gc(OPTION_PARM_SIZE, &amp;gc);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        int i;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        bool first =3D true;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        bool good =3D true;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D=
 gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t buffer env_name =3D alloc_buf_gc(OPTION_PARM_SIZE, &amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct buffer env_value =3D =
alloc_buf_gc(OPTION_PARM_SIZE, &amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    bool good =3D true;</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        good &amp;=3D buf_printf(&=
amp;name, &quot;foreign_option_%d&quot;, o-&gt;foreign_option_index + 1);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ++o-&gt;foreign=
_option_index;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 for (i =3D 0; i &lt; len; ++i)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          if (argv[i])</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         if (!first)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               good &amp;=3D buf_printf(&amp;value, &quot; &quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                good &amp;=3D buf=
_printf(&amp;value, &quot;%s&quot;, argv[i]);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                first =3D false;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        if (good)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           setenv_str(es, BSTR(&amp;name), BSTR(&amp;value));</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            msg(M_WARN, &quot;foreign_option: name/value overflow&qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        gc_free(&amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    good &amp;=3D buf_=
printf(&amp;env_name, &quot;foreign_option_%d&quot;, o-&gt;foreign_option_i=
ndex + 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (v=
alue)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        good &amp;=3D buf_pr=
intf(&amp;env_value, &quot;dhcp-option %s %s&quot;, option, value);</span><=
br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        good &amp;=3D buf_pri=
ntf(&amp;env_value, &quot;dhcp-option %s&quot;, option);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (good)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        setenv_str(es, BSTR(&amp;env_name), BSTR(&amp;env_value));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        ++o-&gt;foreign_o=
ption_index;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;foreign_option: name=
/value overflow&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_fre=
e(&amp;gc);</span><br><span> }</span><br><span> #endif /* ifndef _WIN32 */<=
/span><br><span> </span><br><span>@@ -3678,15 +3669,10 @@</span><br><span> =
    else if (o-&gt;up_script &amp;&amp; !dns_updown_user_set(dns) &amp;&amp=
; !dns_updown_forced(dns))</span><br><span>     {</span><br><span>         =
/* Set foreign option env vars from --dns config */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        const char *p[] =3D { &quot;dhcp-op=
tion&quot;, NULL, NULL };</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        size_t p_len =3D sizeof(p) / sizeof(p[0]);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        p[1] =3D &quot;DOMAIN&quot;;</span><br><span>         c=
onst struct dns_domain *d =3D dns-&gt;search_domains;</span><br><span>     =
    while (d)</span><br><span>         {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            p[2] =3D d-&gt;name;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            setenv_foreign_option(o, (const=
 char **)p, p_len, es);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            setenv_foreign_option(o, &quot;DOMAIN&quot;, d-&gt;name, es=
);</span><br><span>             d =3D d-&gt;next;</span><br><span>         =
}</span><br><span> </span><br><span>@@ -3713,17 +3699,19 @@</span><br><span=
>             {</span><br><span>                 for (int i =3D 0; i &lt; s=
-&gt;addr_count; ++i)</span><br><span>                 {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    const char *option=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
  const char *value;</span><br><span>                     if (s-&gt;addr[i]=
.family =3D=3D AF_INET)</span><br><span>                     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                        p[1] =3D &=
quot;DNS&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                  p[2] =3D print_in_addr_t(s-&gt;addr[i].in.a4.s_addr, IA_N=
ET_ORDER, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                        option =3D &quot;DNS&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        value =3D print_i=
n_addr_t(s-&gt;addr[i].in.a4.s_addr, IA_NET_ORDER, &amp;gc);</span><br><spa=
n>                     }</span><br><span>                     else</span><b=
r><span>                     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                        p[1] =3D &quot;DNS6&quot;;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                        p[2] =3D prin=
t_in6_addr(s-&gt;addr[i].in.a6, 0, &amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                        option =3D &quot;DNS6&quot=
;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
       value =3D print_in6_addr(s-&gt;addr[i].in.a6, 0, &amp;gc);</span><br=
><span>                     }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    setenv_foreign_option(o, (const char **)p, p_le=
n, es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        setenv_foreign_option(o, option, value, es);</span><br><span>      =
           }</span><br><span>                 break;</span><br><span>      =
       }</span><br><span>@@ -8388,7 +8376,7 @@</span><br><span>            =
 goto err;</span><br><span>         }</span><br><span> #else /* if defined(=
_WIN32) || defined(TARGET_ANDROID) */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        setenv_foreign_option(options, (const char **)p, 3,=
 es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        setenv=
_foreign_option(options, p[1], p[2], es);</span><br><span> #endif /* if def=
ined(_WIN32) || defined(TARGET_ANDROID) */</span><br><span>     }</span><br=
><span> #ifdef _WIN32</span><br><span>@@ -8530,7 +8518,7 @@</span><br><span=
>     else if (streq(p[0], &quot;dhcp-option&quot;) &amp;&amp; p[1] &amp;&a=
mp; !p[3])</span><br><span>     {</span><br><span>         VERIFY_PERMISSIO=
N(OPT_P_DHCPDNS);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    setenv_foreign_option(options, (const char **)p, 3, es);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        setenv_foreign_option(opti=
ons, p[1], p[2], es);</span><br><span>     }</span><br><span>     else if (=
streq(p[0], &quot;route-method&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</sp=
an><br><span>     {</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1112?usp=3Demail">change 1112<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1112?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7efc77f63734501dfa8a8f5bed1=
7b1a1b4e9e201 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1112 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--vFa7UJxuCAE=--


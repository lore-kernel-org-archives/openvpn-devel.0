From: "d12fk (Code Review)" <gerrit@...515...>
Date: Thu, 6 Mar 2025 22:15:24 +0000
References: <gerrit.1741299308000.I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a9ec6c9aea920039877bb6f4c6589dff110ed677-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RQZPZJMC0Gk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dns: clean up
 --dhcp-options when --dns is active
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

--RQZPZJMC0Gk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/904?usp=3Demail

to review the following change.


Change subject: dns: clean up --dhcp-options when --dns is active
......................................................................

dns: clean up --dhcp-options when --dns is active

Since --dns setting overrule DNS related --dhcp-options,
remove the latter when we got some via --dns.

Change-Id: I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpn/options.c
1 file changed, 47 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/04/904/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index d7f6b16..c42d933 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4160,6 +4160,53 @@
     if (success)
     {
         dns_options_postprocess_pull(&o->dns_options);
+
+#if defined(_WIN32) || defined(TARGET_ANDROID)
+        /* If there's --dns servers, remove dns related --dhcp-options */
+        if (o->dns_options.servers)
+        {
+            o->tuntap_options.dns_len =3D 0;
+            o->tuntap_options.dns6_len =3D 0;
+            o->tuntap_options.domain =3D NULL;
+            o->tuntap_options.domain_search_list_len =3D 0;
+        }
+#else  /* if defined(_WIN32) || defined(TARGET_ANDROID) */
+        /* Clean up env from overridden DNS config */
+        struct gc_arena gc =3D gc_new();
+        struct buffer name =3D alloc_buf_gc(OPTION_PARM_SIZE, &gc);
+        struct buffer value =3D alloc_buf_gc(OPTION_PARM_SIZE, &gc);
+
+        const int fo_count =3D o->foreign_option_index;
+        o->foreign_option_index =3D 0;
+
+        for (int i =3D 1; i <=3D fo_count; ++i)
+        {
+            buf_clear(&name);
+            buf_printf(&name, "foreign_option_%d", i);
+            const char *env_str =3D env_set_get(es, BSTR(&name));
+            const char *item_val =3D strchr(env_str, '=3D') + 1;
+            buf_clear(&value);
+            buf_printf(&value, "%s", item_val);
+
+            /* Remove foreign option item from env set */
+            env_set_del(es, BSTR(&name));
+
+            item_val =3D BSTR(&value);
+            if (strncmp(item_val, "dhcp-option ", 12) !=3D 0
+                || (strncmp(item_val + 12, "ADAPTER-DOMAIN-SUFFIX ", 22) !=
=3D 0
+                    && strncmp(item_val + 12, "DOMAIN-SEARCH ", 14) !=3D 0
+                    && strncmp(item_val + 12, "DOMAIN ", 7) !=3D 0
+                    && strncmp(item_val + 12, "DNS6 ", 5) !=3D 0
+                    && strncmp(item_val + 12, "DNS ", 4) !=3D 0))
+            {
+                /* Re-set the item with potentially updated name */
+                buf_clear(&name);
+                buf_printf(&name, "foreign_option_%d", ++o->foreign_option=
_index);
+                setenv_str(es, BSTR(&name), BSTR(&value));
+            }
+        }
+        gc_free(&gc);
+#endif /* defined(_WIN32) || defined(TARGET_ANDROID) */
     }
     return success;
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/904?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a
Gerrit-Change-Number: 904
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--RQZPZJMC0Gk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/904?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">dns: clean up --dhcp-options when --dns is active<br><br>Sinc=
e --dns setting overrule DNS related --dhcp-options,<br>remove the latter w=
hen we got some via --dns.<br><br>Change-Id: I635c4018fb43b5976a39b6a90cb2e=
9cb2570cd6a<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>---<br=
>M src/openvpn/options.c<br>1 file changed, 47 insertions(+), 0 deletions(-=
)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/04=
/904/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</=
span><br><span>index d7f6b16..c42d933 100644</span><br><span>--- a/src/open=
vpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@=
@ -4160,6 +4160,53 @@</span><br><span>     if (success)</span><br><span>   =
  {</span><br><span>         dns_options_postprocess_pull(&amp;o-&gt;dns_op=
tions);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32) || defined(=
TARGET_ANDROID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* If there&#39;s --dns servers, remove dns related --dhcp-options */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (o-&gt;dns=
_options.servers)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
o-&gt;tuntap_options.dns_len =3D 0;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            o-&gt;tuntap_options.dns6_len =3D 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            o-&gt;tuntap_optio=
ns.domain =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            o-&gt;tuntap_options.domain_search_list_len =3D 0;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#else  /* if defined(_WIN32) || defined(T=
ARGET_ANDROID) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      /* Clean up env from overridden DNS config */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_new();<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct buffe=
r name =3D alloc_buf_gc(OPTION_PARM_SIZE, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct buffer value =3D alloc_buf=
_gc(OPTION_PARM_SIZE, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 const int fo_count =3D o-&gt;foreign_option_index;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        o-&gt;foreign_option_index =3D 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 1; i &lt;=3D fo=
_count; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_c=
lear(&amp;name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         buf_printf(&amp;name, &quot;foreign_option_%d&quot;, i);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            const char *env_s=
tr =3D env_set_get(es, BSTR(&amp;name));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            const char *item_val =3D strchr(env_str, &=
#39;=3D&#39;) + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           buf_clear(&amp;value);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            buf_printf(&amp;value, &quot;%s&quot;, item_val);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            /* Remove foreign option i=
tem from env set */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            env_set_del(es, BSTR(&amp;name));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            item_val =3D BSTR(&amp;value);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (strncmp(item_val, &quot;dhcp-=
option &quot;, 12) !=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                || (strncmp(item_val + 12, &quot;ADAPTER-DOMAIN-SUFFI=
X &quot;, 22) !=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    &amp;&amp; strncmp(item_val + 12, &quot;DOMAIN-SEARCH =
&quot;, 14) !=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   &amp;&amp; strncmp(item_val + 12, &quot;DOMAIN &quot;, 7=
) !=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         &amp;&amp; strncmp(item_val + 12, &quot;DNS6 &quot;, 5) !=3D 0</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    &am=
p;&amp; strncmp(item_val + 12, &quot;DNS &quot;, 4) !=3D 0))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                /* Re-set the item with =
potentially updated name */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                buf_clear(&amp;name);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                buf_printf(&amp;name, &quot;forei=
gn_option_%d&quot;, ++o-&gt;foreign_option_index);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                setenv_str(es, BSTR(&amp;nam=
e), BSTR(&amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_fr=
ee(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif =
/* defined(_WIN32) || defined(TARGET_ANDROID) */</span><br><span>     }</sp=
an><br><span>     return success;</span><br><span> }</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/904?usp=3Demail">change 904</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/904?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I635c4018fb43b5976a39b6a90cb=
2e9cb2570cd6a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 904 </div>
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


--RQZPZJMC0Gk=--


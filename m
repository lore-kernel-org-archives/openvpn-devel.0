From: "mrbff (Code Review)" <gerrit@...515...>
Date: Mon, 6 Oct 2025 09:10:53 +0000
In-Reply-To: <gerrit.1758706218000.Ib3458a9ed2eb38e00184c4a92659b83b97fe476c@...2715...>
References: <gerrit.1758706218000.Ib3458a9ed2eb38e00184c4a92659b83b97fe476c@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <30be7c355465afac670b79cb78aa8479dba51391-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="12zKmqO47T0="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: redirect-gateway:
 only redirect traffic through TUN if address famili...
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

--12zKmqO47T0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1210?usp=3Demail

to look at the new patch set (#3).


Change subject: redirect-gateway: only redirect traffic through TUN if addr=
ess families match
......................................................................

redirect-gateway: only redirect traffic through TUN if address families mat=
ch

Fixes an ifconfig push-reply bug where, if the remote is switched and the n=
ew
TUN has a different address family, the previous ifconfig options remain
assigned to the new TUN.

Adds a check in do_init_route_ipv6_list() to add default routes toward the =
TUN
only if the TUN has IPv6 addresses.

It also resets the ifconfig and ifconfig-ipv6 options on every PUSH_REPLY a=
nd
whenever a valid ifconfig or ifconfig-ipv6 option is found in a PUSH_UPDATE
message to avoid stale data conflicts. This may be necessary when the new
address has a different address family than the old one.

Change-Id: Ib3458a9ed2eb38e00184c4a92659b83b97fe476c
---
M src/openvpn/init.c
M src/openvpn/options.c
2 files changed, 62 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/10/1210/3

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index f8a0fee..aaa0573 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1523,7 +1523,7 @@

     /* redirect (IPv6) gateway to VPN?  if yes, add a few more specifics
      */
-    if (options->routes_ipv6->flags & RG_REROUTE_GW)
+    if (options->routes_ipv6->flags & RG_REROUTE_GW && options->ifconfig_i=
pv6_local)
     {
         char *opt_list[] =3D { "::/3", "2000::/4", "3000::/4", "fc00::/7",=
 NULL };
         int i;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f35738d..fc18931 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5459,6 +5459,17 @@
     }
 }

+/* Reset all ifconfig and ifconfig-ipv6 related options to their default/N=
ULL state */
+#define RESET_IFCONFIG_OPTIONS(opt)            \
+    do                                         \
+    {                                          \
+        (opt)->ifconfig_local =3D NULL;          \
+        (opt)->ifconfig_remote_netmask =3D NULL; \
+        (opt)->ifconfig_ipv6_local =3D NULL;     \
+        (opt)->ifconfig_ipv6_netbits =3D 0;      \
+        (opt)->ifconfig_ipv6_remote =3D NULL;    \
+    } while (0)
+
 bool
 apply_push_options(struct context *c, struct options *options, struct buff=
er *buf,
                    unsigned int permission_mask, unsigned int *option_type=
s_found,
@@ -5470,6 +5481,14 @@
     const msglvl_t msglevel =3D D_PUSH_ERRORS | M_OPTERR;
     unsigned int update_options_found =3D 0;

+    /* When receiving a PUSH_REPLY, reset the ifconfig options to prevent
+     * stale data conflicts. This could be necessary when the new address =
has a
+     * different address family than the previous one. */
+    if (!is_update)
+    {
+        RESET_IFCONFIG_OPTIONS(options);
+    }
+
     while (buf_parse(buf, ',', line, sizeof(line)))
     {
         char *p[MAX_PARMS + 1];
@@ -6014,7 +6033,48 @@
     const bool pull_mode =3D BOOL_CAST(permission_mask & OPT_P_PULL_MODE);
     ASSERT(MAX_PARMS >=3D 7);

-    if (streq(p[0], "route") && p[1] && !p[5])
+    if (streq(p[0], "ifconfig") && p[1] && p[2] && !p[3])
+    {
+        VERIFY_PERMISSION(OPT_P_UP);
+        if (ip_or_dns_addr_safe(p[1], options->allow_pull_fqdn)
+            && ip_or_dns_addr_safe(p[2], options->allow_pull_fqdn)) /* FQD=
N -- may be DNS name */
+        {
+            /* When receiving a PUSH_UPDATE containing a valid ifconfig op=
tion,
+             * we should reset the ifconfig and ifconfig-ipv6 options to p=
revent
+             * stale data conflicts. This could be necessary when the new =
address has a
+             * different address family than the previous one. Same is tru=
e when a valid
+             * ifconfig-ipv6 option is received. */
+            RESET_IFCONFIG_OPTIONS(options);
+        }
+        else
+        {
+            msg(msglevel, "ifconfig parms '%s' and '%s' must be valid addr=
esses", p[1], p[2]);
+            goto err;
+        }
+    }
+    else if (streq(p[0], "ifconfig-ipv6") && p[1] && p[2] && !p[3])
+    {
+        unsigned int netbits;
+
+        VERIFY_PERMISSION(OPT_P_UP);
+        if (get_ipv6_addr(p[1], NULL, &netbits, msglevel) && ipv6_addr_saf=
e(p[2]))
+        {
+            if (netbits < 64 || netbits > 124)
+            {
+                msg(msglevel, "ifconfig-ipv6: /netbits must be between 64 =
and 124, not '/%d'",
+                    netbits);
+                goto err;
+            }
+
+            RESET_IFCONFIG_OPTIONS(options);
+        }
+        else
+        {
+            msg(msglevel, "ifconfig-ipv6 parms '%s' and '%s' must be valid=
 addresses", p[1], p[2]);
+            goto err;
+        }
+    }
+    else if (streq(p[0], "route") && p[1] && !p[5])
     {
         if (!(*update_options_found & OPT_P_U_ROUTE))
         {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1210?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib3458a9ed2eb38e00184c4a92659b83b97fe476c
Gerrit-Change-Number: 1210
Gerrit-PatchSet: 3
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--12zKmqO47T0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos. </p>
<p>mrbff <strong>uploaded patch set #3</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1210?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">redirect-gateway: only redirect traffic through TUN if =
address families match<br><br>Fixes an ifconfig push-reply bug where, if th=
e remote is switched and the new<br>TUN has a different address family, the=
 previous ifconfig options remain<br>assigned to the new TUN.<br><br>Adds a=
 check in do_init_route_ipv6_list() to add default routes toward the TUN<br=
>only if the TUN has IPv6 addresses.<br><br>It also resets the ifconfig and=
 ifconfig-ipv6 options on every PUSH_REPLY and<br>whenever a valid ifconfig=
 or ifconfig-ipv6 option is found in a PUSH_UPDATE<br>message to avoid stal=
e data conflicts. This may be necessary when the new<br>address has a diffe=
rent address family than the old one.<br><br>Change-Id: Ib3458a9ed2eb38e001=
84c4a92659b83b97fe476c<br>---<br>M src/openvpn/init.c<br>M src/openvpn/opti=
ons.c<br>2 files changed, 62 insertions(+), 2 deletions(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/10/=
1210/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><=
br><span>index f8a0fee..aaa0573 100644</span><br><span>--- a/src/openvpn/in=
it.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -1523,7 +1=
523,7 @@</span><br><span> </span><br><span>     /* redirect (IPv6) gateway =
to VPN?  if yes, add a few more specifics</span><br><span>      */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;routes_ipv=
6-&gt;flags &amp; RG_REROUTE_GW)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (options-&gt;routes_ipv6-&gt;flags &amp; RG_REROUTE_GW =
&amp;&amp; options-&gt;ifconfig_ipv6_local)</span><br><span>     {</span><b=
r><span>         char *opt_list[] =3D { &quot;::/3&quot;, &quot;2000::/4&qu=
ot;, &quot;3000::/4&quot;, &quot;fc00::/7&quot;, NULL };</span><br><span>  =
       int i;</span><br><span>diff --git a/src/openvpn/options.c b/src/open=
vpn/options.c</span><br><span>index f35738d..fc18931 100644</span><br><span=
>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</s=
pan><br><span>@@ -5459,6 +5459,17 @@</span><br><span>     }</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* Reset all ifconfig and ifconfig-ipv6 related options to their default/=
NULL state */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e RESET_IFCONFIG_OPTIONS(opt)            \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    do                                         \</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {                  =
                        \</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        (opt)-&gt;ifconfig_local =3D NULL;          \</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        (opt)-&gt;ifconfig_remote_n=
etmask =3D NULL; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       (opt)-&gt;ifconfig_ipv6_local =3D NULL;     \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        (opt)-&gt;ifconfig_ipv6_netbits =
=3D 0;      \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  (opt)-&gt;ifconfig_ipv6_remote =3D NULL;    \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    } while (0)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span> apply_push_=
options(struct context *c, struct options *options, struct buffer *buf,</sp=
an><br><span>                    unsigned int permission_mask, unsigned int=
 *option_types_found,</span><br><span>@@ -5470,6 +5481,14 @@</span><br><spa=
n>     const msglvl_t msglevel =3D D_PUSH_ERRORS | M_OPTERR;</span><br><spa=
n>     unsigned int update_options_found =3D 0;</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* When receiving a PUSH_=
REPLY, reset the ifconfig options to prevent</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * stale data conflicts. This could be necessa=
ry when the new address has a</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * different address family than the previous one. */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!is_update)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        RESET_IFCONFIG_OPTIONS(options);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     while (buf_p=
arse(buf, &#39;,&#39;, line, sizeof(line)))</span><br><span>     {</span><b=
r><span>         char *p[MAX_PARMS + 1];</span><br><span>@@ -6014,7 +6033,4=
8 @@</span><br><span>     const bool pull_mode =3D BOOL_CAST(permission_mas=
k &amp; OPT_P_PULL_MODE);</span><br><span>     ASSERT(MAX_PARMS &gt;=3D 7);=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (streq(p[0], &quot;route&quot;) &amp;&amp; p[1] &amp;&amp; !p[5])</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (streq(p[0], &quot=
;ifconfig&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_UP);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ip_or_dns_ad=
dr_safe(p[1], options-&gt;allow_pull_fqdn)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            &amp;&amp; ip_or_dns_addr_safe(p[2], opt=
ions-&gt;allow_pull_fqdn)) /* FQDN -- may be DNS name */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            /* When receiving a PUSH_UPDATE cont=
aining a valid ifconfig option,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+             * we should reset the ifconfig and ifconfig-ipv6 o=
ptions to prevent</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
           * stale data conflicts. This could be necessary when the new add=
ress has a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
    * different address family than the previous one. Same is true when a v=
alid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * =
ifconfig-ipv6 option is received. */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            RESET_IFCONFIG_OPTIONS(options);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            msg(msglevel, &quot;ifconfig parms &#39;%s&#39=
; and &#39;%s&#39; must be valid addresses&quot;, p[1], p[2]);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    else if (streq(p[0], &quot;ifconfig-ipv6&quot;) &a=
mp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        unsigned int netbits;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        VERIFY_PERMISSION(OPT_P_UP);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (get_ipv6_addr(p[1], NULL, &amp;netbits, m=
sglevel) &amp;&amp; ipv6_addr_safe(p[2]))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            if (netbits &lt; 64 || netbits &gt; 124)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                msg(msglevel, &quot;=
ifconfig-ipv6: /netbits must be between 64 and 124, not &#39;/%d&#39;&quot;=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
  netbits);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            RESET_IFCONFIG_=
OPTIONS(options);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &qu=
ot;ifconfig-ipv6 parms &#39;%s&#39; and &#39;%s&#39; must be valid addresse=
s&quot;, p[1], p[2]);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p=
[0], &quot;route&quot;) &amp;&amp; p[1] &amp;&amp; !p[5])</span><br><span> =
    {</span><br><span>         if (!(*update_options_found &amp; OPT_P_U_RO=
UTE))</span><br><span>         {</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1210?usp=3Demail"=
>change 1210</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1210?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib3458a9ed2eb38e00184c4a9265=
9b83b97fe476c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1210 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
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

</body></html>=

--12zKmqO47T0=--


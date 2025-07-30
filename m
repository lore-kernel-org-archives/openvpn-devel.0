From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 30 Jul 2025 18:15:36 +0000
In-Reply-To: <gerrit.1752843465000.I0d75efcceb826d06e74abd003d5377468ff9fe3b@...2715...>
References: <gerrit.1752843465000.I0d75efcceb826d06e74abd003d5377468ff9fe3b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <b4fae009061410f31a8398d03bd702ecd448e1f9-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UnBMue3VZsg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix broken DHCP
 options
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--UnBMue3VZsg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/1090?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Fix broken DHCP options
......................................................................

Fix broken DHCP options

Commit

  2dfc4f ("dns: deal with --dhcp-options when --dns is active")

broke support for --dhcp-options. It removed the setting of the
DHCP_OPTIONS_DHCP_OPTIONAL flag for some DHCP options. This flag is
required for those options to be applied correctly, as it is used
when building the DHCP options string that is passed to the TAP driver.

This commit fixes the issue by restoring the setting of this flag.

GitHub: fixes OpenVPN/openvpn#791

Change-Id: I0d75efcceb826d06e74abd003d5377468ff9fe3b
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250730180527.25339-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
427.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
1 file changed, 13 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/90/1090/2

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b7328d7..53be6f5 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8712,9 +8712,12 @@
 #endif
         VERIFY_PERMISSION(OPT_P_DHCPDNS);

+        bool dhcp_optional =3D false;
+
         if ((streq(p[1], "DOMAIN") || streq(p[1], "ADAPTER_DOMAIN_SUFFIX")=
) && p[2] && !p[3])
         {
             dhcp->domain =3D p[2];
+            dhcp_optional =3D true;
         }
         else if (streq(p[1], "DOMAIN-SEARCH") && p[2] && !p[3])
         {
@@ -8727,6 +8730,7 @@
                 msg(msglevel, "--dhcp-option %s: maximum of %d search entr=
ies can be specified",
                     p[1], N_SEARCH_LIST_LEN);
             }
+            dhcp_optional =3D true;
         }
         else if ((streq(p[1], "DNS") || streq(p[1], "DNS6")) && p[2] && !p=
[3]
                  && (!strstr(p[2], ":") || ipv6_addr_safe(p[2])))
@@ -8738,6 +8742,7 @@
             else
             {
                 dhcp_option_address_parse("DNS", p[2], dhcp->dns, &dhcp->d=
ns_len, msglevel);
+                dhcp_optional =3D true;
             }
         }
 #if defined(_WIN32) || defined(TARGET_ANDROID)
@@ -8761,6 +8766,7 @@
         else if (streq(p[1], "WINS") && p[2] && !p[3])
         {
             dhcp_option_address_parse("WINS", p[2], o->wins, &o->wins_len,=
 msglevel);
+            o->dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;
         }
         else if (streq(p[1], "NTP") && p[2] && !p[3])
         {
@@ -8792,6 +8798,13 @@
 #else /* if defined(_WIN32) || defined(TARGET_ANDROID) */
         setenv_foreign_option(options, p[1], p[2], es);
 #endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */
+
+        if (dhcp_optional)
+        {
+#if defined(_WIN32) || defined(TARGET_ANDROID)
+            o->dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;
+#endif
+        }
     }
 #ifdef _WIN32
     else if (streq(p[0], "show-adapters") && !p[1])

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1090?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0d75efcceb826d06e74abd003d5377468ff9fe3b
Gerrit-Change-Number: 1090
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--UnBMue3VZsg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1090=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Fix broken DHCP options<br><br>Commit<br><br>  2dfc4=
f (&quot;dns: deal with --dhcp-options when --dns is active&quot;)<br><br>b=
roke support for --dhcp-options. It removed the setting of the<br>DHCP_OPTI=
ONS_DHCP_OPTIONAL flag for some DHCP options. This flag is<br>required for =
those options to be applied correctly, as it is used<br>when building the D=
HCP options string that is passed to the TAP driver.<br><br>This commit fix=
es the issue by restoring the setting of this flag.<br><br>GitHub: fixes Op=
enVPN/openvpn#791<br><br>Change-Id: I0d75efcceb826d06e74abd003d5377468ff9fe=
3b<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>Acked-by: Gert D=
oering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250730180527.25339-1-ge=
rt@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1199...=
sourceforge.net/msg32427.html<br>Signed-off-by: Gert Doering &lt;gert@...1711...=
96...&gt;<br>---<br>M src/openvpn/options.c<br>1 file changed, 13 insertion=
s(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/open=
vpn refs/changes/90/1090/2</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/options.c b/src=
/openvpn/options.c</span><br><span>index b7328d7..53be6f5 100644</span><br>=
<span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options=
.c</span><br><span>@@ -8712,9 +8712,12 @@</span><br><span> #endif</span><br=
><span>         VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        bool dhcp_optional =
=3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span>         if ((streq(p[1], &quot;DOMAIN&quot;) || streq(p[1], &quot;=
ADAPTER_DOMAIN_SUFFIX&quot;)) &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><=
span>         {</span><br><span>             dhcp-&gt;domain =3D p[2];</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            dhcp_optiona=
l =3D true;</span><br><span>         }</span><br><span>         else if (st=
req(p[1], &quot;DOMAIN-SEARCH&quot;) &amp;&amp; p[2] &amp;&amp; !p[3])</spa=
n><br><span>         {</span><br><span>@@ -8727,6 +8730,7 @@</span><br><spa=
n>                 msg(msglevel, &quot;--dhcp-option %s: maximum of %d sear=
ch entries can be specified&quot;,</span><br><span>                     p[1=
], N_SEARCH_LIST_LEN);</span><br><span>             }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            dhcp_optional =3D true;</span=
><br><span>         }</span><br><span>         else if ((streq(p[1], &quot;=
DNS&quot;) || streq(p[1], &quot;DNS6&quot;)) &amp;&amp; p[2] &amp;&amp; !p[=
3]</span><br><span>                  &amp;&amp; (!strstr(p[2], &quot;:&quot=
;) || ipv6_addr_safe(p[2])))</span><br><span>@@ -8738,6 +8742,7 @@</span><b=
r><span>             else</span><br><span>             {</span><br><span>  =
               dhcp_option_address_parse(&quot;DNS&quot;, p[2], dhcp-&gt;dn=
s, &amp;dhcp-&gt;dns_len, msglevel);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                dhcp_optional =3D true;</span><br><span>  =
           }</span><br><span>         }</span><br><span> #if defined(_WIN32=
) || defined(TARGET_ANDROID)</span><br><span>@@ -8761,6 +8766,7 @@</span><b=
r><span>         else if (streq(p[1], &quot;WINS&quot;) &amp;&amp; p[2] &am=
p;&amp; !p[3])</span><br><span>         {</span><br><span>             dhcp=
_option_address_parse(&quot;WINS&quot;, p[2], o-&gt;wins, &amp;o-&gt;wins_l=
en, msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       o-&gt;dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;</span><br><span>=
         }</span><br><span>         else if (streq(p[1], &quot;NTP&quot;) &=
amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span>         {</span><br><span=
>@@ -8792,6 +8798,13 @@</span><br><span> #else /* if defined(_WIN32) || def=
ined(TARGET_ANDROID) */</span><br><span>         setenv_foreign_option(opti=
ons, p[1], p[2], es);</span><br><span> #endif /* if defined(_WIN32) || defi=
ned(TARGET_ANDROID) */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (dhcp=
_optional)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32)=
 || defined(TARGET_ANDROID)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            o-&gt;dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</sp=
an><br><span> #ifdef _WIN32</span><br><span>     else if (streq(p[0], &quot=
;show-adapters&quot;) &amp;&amp; !p[1])</span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1090?usp=
=3Demail">change 1090</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1090?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0d75efcceb826d06e74abd003d5=
377468ff9fe3b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1090 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--UnBMue3VZsg=--


From: "stipa (Code Review)" <gerrit@...515...>
Date: Fri, 18 Jul 2025 12:57:47 +0000
References: <gerrit.1752843465000.I0d75efcceb826d06e74abd003d5377468ff9fe3b@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3225cb5d56552d1291bd3d8136b04afcfbef7a27-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VRpP16Ft0l8="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--VRpP16Ft0l8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1090?usp=3Demail

to review the following change.


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

GitHub: #791

Change-Id: I0d75efcceb826d06e74abd003d5377468ff9fe3b
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/options.c
1 file changed, 13 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/90/1090/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0662b49..4ba9243 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8310,9 +8310,12 @@
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
@@ -8325,6 +8328,7 @@
                 msg(msglevel, "--dhcp-option %s: maximum of %d search entr=
ies can be specified",
                     p[1], N_SEARCH_LIST_LEN);
             }
+            dhcp_optional =3D true;
         }
         else if ((streq(p[1], "DNS") || streq(p[1], "DNS6")) && p[2] && !p=
[3]
                  && (!strstr(p[2], ":") || ipv6_addr_safe(p[2])))
@@ -8336,6 +8340,7 @@
             else
             {
                 dhcp_option_address_parse("DNS", p[2], dhcp->dns, &dhcp->d=
ns_len, msglevel);
+                dhcp_optional =3D true;
             }
         }
 #if defined(_WIN32) || defined(TARGET_ANDROID)
@@ -8359,6 +8364,7 @@
         else if (streq(p[1], "WINS") && p[2] && !p[3])
         {
             dhcp_option_address_parse("WINS", p[2], o->wins, &o->wins_len,=
 msglevel);
+            o->dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;
         }
         else if (streq(p[1], "NTP") && p[2] && !p[3])
         {
@@ -8390,6 +8396,13 @@
 #else /* if defined(_WIN32) || defined(TARGET_ANDROID) */
         setenv_foreign_option(options, (const char **)p, 3, es);
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
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--VRpP16Ft0l8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1090?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Fix broken DHCP options<br><br>Commit<br><br>  2dfc4f (&quot=
;dns: deal with --dhcp-options when --dns is active&quot;)<br><br>broke sup=
port for --dhcp-options. It removed the setting of the<br>DHCP_OPTIONS_DHCP=
_OPTIONAL flag for some DHCP options. This flag is<br>required for those op=
tions to be applied correctly, as it is used<br>when building the DHCP opti=
ons string that is passed to the TAP driver.<br><br>This commit fixes the i=
ssue by restoring the setting of this flag.<br><br>GitHub: #791<br><br>Chan=
ge-Id: I0d75efcceb826d06e74abd003d5377468ff9fe3b<br>Signed-off-by: Lev Stip=
akov &lt;lev@...515...&gt;<br>---<br>M src/openvpn/options.c<br>1 file chan=
ged, 13 insertions(+), 0 deletions(-)<br><br></pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openv=
pn.net:29418/openvpn refs/changes/90/1090/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/options.c b/src/openvpn/options.c</span><br><span>index 0662b49..4ba9243 =
100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/sr=
c/openvpn/options.c</span><br><span>@@ -8310,9 +8310,12 @@</span><br><span>=
 #endif</span><br><span>         VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bo=
ol dhcp_optional =3D false;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span>         if ((streq(p[1], &quot;DOMAIN&quot;) || s=
treq(p[1], &quot;ADAPTER_DOMAIN_SUFFIX&quot;)) &amp;&amp; p[2] &amp;&amp; !=
p[3])</span><br><span>         {</span><br><span>             dhcp-&gt;doma=
in =3D p[2];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     dhcp_optional =3D true;</span><br><span>         }</span><br><span>   =
      else if (streq(p[1], &quot;DOMAIN-SEARCH&quot;) &amp;&amp; p[2] &amp;=
&amp; !p[3])</span><br><span>         {</span><br><span>@@ -8325,6 +8328,7 =
@@</span><br><span>                 msg(msglevel, &quot;--dhcp-option %s: m=
aximum of %d search entries can be specified&quot;,</span><br><span>       =
              p[1], N_SEARCH_LIST_LEN);</span><br><span>             }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            dhcp_optiona=
l =3D true;</span><br><span>         }</span><br><span>         else if ((s=
treq(p[1], &quot;DNS&quot;) || streq(p[1], &quot;DNS6&quot;)) &amp;&amp; p[=
2] &amp;&amp; !p[3]</span><br><span>                  &amp;&amp; (!strstr(p=
[2], &quot;:&quot;) || ipv6_addr_safe(p[2])))</span><br><span>@@ -8336,6 +8=
340,7 @@</span><br><span>             else</span><br><span>             {</=
span><br><span>                 dhcp_option_address_parse(&quot;DNS&quot;, =
p[2], dhcp-&gt;dns, &amp;dhcp-&gt;dns_len, msglevel);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                dhcp_optional =3D true;</=
span><br><span>             }</span><br><span>         }</span><br><span> #=
if defined(_WIN32) || defined(TARGET_ANDROID)</span><br><span>@@ -8359,6 +8=
364,7 @@</span><br><span>         else if (streq(p[1], &quot;WINS&quot;) &a=
mp;&amp; p[2] &amp;&amp; !p[3])</span><br><span>         {</span><br><span>=
             dhcp_option_address_parse(&quot;WINS&quot;, p[2], o-&gt;wins, =
&amp;o-&gt;wins_len, msglevel);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            o-&gt;dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;=
</span><br><span>         }</span><br><span>         else if (streq(p[1], &=
quot;NTP&quot;) &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span>         =
{</span><br><span>@@ -8390,6 +8396,13 @@</span><br><span> #else /* if defin=
ed(_WIN32) || defined(TARGET_ANDROID) */</span><br><span>         setenv_fo=
reign_option(options, (const char **)p, 3, es);</span><br><span> #endif /* =
if defined(_WIN32) || defined(TARGET_ANDROID) */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (dhcp_optional)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if defined(_WIN32) || defined(TARGET_ANDROID)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            o-&gt;dhcp_options |=3D DHCP_=
OPTIONS_DHCP_OPTIONAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span>     }</span><br><span> #ifdef _WIN32</span><br><span>     =
else if (streq(p[0], &quot;show-adapters&quot;) &amp;&amp; !p[1])</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1090?usp=3Demail">change 1090</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1090?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0d75efcceb826d06e74abd003d5=
377468ff9fe3b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1090 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
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


--VRpP16Ft0l8=--


From: "d12fk (Code Review)" <gerrit@...515...>
Date: Thu, 3 Jul 2025 19:41:36 +0000
References: <gerrit.1751571694000.I7e9a0c668e0950257632452cfd9eeb236f0120f2@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f1722ef3eab9e65d9e8d0eac46f0ba54cb65e154-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kFr4GWJZkCE="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dns: do not run
 updown scripts with lwipovpn
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

--kFr4GWJZkCE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1077?usp=3Demail

to review the following change.


Change subject: dns: do not run updown scripts with lwipovpn
......................................................................

dns: do not run updown scripts with lwipovpn

Running the script doesn't make sense with the AFUNIX dev node, so we
simply clear any scripts that have been set before.

Change-Id: I7e9a0c668e0950257632452cfd9eeb236f0120f2
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpn/options.c
1 file changed, 8 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/77/1077/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index af097f8..0662b49 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -61,6 +61,7 @@
 #include "xkey_common.h"
 #include "dco.h"
 #include "options_util.h"
+#include "tun_afunix.h"

 #include <ctype.h>

@@ -3593,6 +3594,13 @@
     struct gc_arena gc =3D gc_new();
     struct dns_options *dns =3D &o->dns_options;

+    if (is_tun_afunix(o->dev_node))
+    {
+        /* Disable running  dns-updown script with lwipovpn */
+        dns->updown_flags =3D DNS_UPDOWN_NO_FLAGS;
+        dns->updown =3D NULL;
+    }
+
     if (dns->servers || dns_updown_user_set(dns) || dns_updown_forced(dns))
     {
         /* Clean up env from --dhcp-option DNS config */

--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1077?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7e9a0c668e0950257632452cfd9eeb236f0120f2
Gerrit-Change-Number: 1077
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--kFr4GWJZkCE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1077?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">dns: do not run updown scripts with lwipovpn<br><br>Running =
the script doesn&#39;t make sense with the AFUNIX dev node, so we<br>simply=
 clear any scripts that have been set before.<br><br>Change-Id: I7e9a0c668e=
0950257632452cfd9eeb236f0120f2<br>Signed-off-by: Heiko Hund &lt;heiko@...2375...=
62...&gt;<br>---<br>M src/openvpn/options.c<br>1 file changed, 8 insertions=
(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openv=
pn refs/changes/77/1077/1</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/options.c b/src/=
openvpn/options.c</span><br><span>index af097f8..0662b49 100644</span><br><=
span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.=
c</span><br><span>@@ -61,6 +61,7 @@</span><br><span> #include &quot;xkey_co=
mmon.h&quot;</span><br><span> #include &quot;dco.h&quot;</span><br><span> #=
include &quot;options_util.h&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;tun_afunix.h&quot;</span><br><span> </span><b=
r><span> #include &lt;ctype.h&gt;</span><br><span> </span><br><span>@@ -359=
3,6 +3594,13 @@</span><br><span>     struct gc_arena gc =3D gc_new();</span=
><br><span>     struct dns_options *dns =3D &amp;o-&gt;dns_options;</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (i=
s_tun_afunix(o-&gt;dev_node))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* Disable running  dns-updown script with lwipovpn */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        dns-&gt;updown_flags =3D DNS=
_UPDOWN_NO_FLAGS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      dns-&gt;updown =3D NULL;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span>     if (dns-&gt;servers || dns_updown_user_set(dns) || dns_u=
pdown_forced(dns))</span><br><span>     {</span><br><span>         /* Clean=
 up env from --dhcp-option DNS config */</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1077?usp=
=3Demail">change 1077</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1077?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7e9a0c668e0950257632452cfd9=
eeb236f0120f2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1077 </div>
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


--kFr4GWJZkCE=--


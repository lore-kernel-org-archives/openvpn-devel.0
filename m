From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 22 Aug 2025 16:25:18 +0000
References: <gerrit.1755879913000.Ic9ac18f730e6035126ccf1cf19799548e5fd9316@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <3496710a52e7f8d913ff7dcd1b82a1cc2f8f9a79-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RAmZZTaxNIE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: Move < 0
 check for keepalive settings earlier
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

--RAmZZTaxNIE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1155?usp=3Demail

to review the following change.


Change subject: options: Move < 0 check for keepalive settings earlier
......................................................................

options: Move < 0 check for keepalive settings earlier

Use the atoi_constrained function.

Change-Id: Ic9ac18f730e6035126ccf1cf19799548e5fd9316
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/helper.c
M src/openvpn/options.c
2 files changed, 3 insertions(+), 7 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/55/1155/1

diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index b2ecb1e..b262e8d 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -552,14 +552,10 @@
         /*
          * Sanity checks.
          */
-        if (o->keepalive_ping <=3D 0 || o->keepalive_timeout <=3D 0)
-        {
-            msg(M_USAGE, "--keepalive parameters must be > 0");
-        }
         if (o->keepalive_ping * 2 > o->keepalive_timeout)
         {
             msg(M_USAGE,
-                "the second parameter to --keepalive (restart timeout=3D%d=
) must be at least twice the value of the first parameter (ping interval=3D=
%d).  A ratio of 1:5 or 1:6 would be even better.  Recommended setting is -=
-keepalive 10 60.",
+                "The second parameter to --keepalive (restart timeout=3D%d=
) must be at least twice the value of the first parameter (ping interval=3D=
%d).  A ratio of 1:5 or 1:6 would be even better.  Recommended setting is -=
-keepalive 10 60.",
                 o->keepalive_timeout, o->keepalive_ping);
         }
         if (o->ping_send_timeout || o->ping_rec_timeout)
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 87c0895..97bf957 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7362,8 +7362,8 @@
     else if (streq(p[0], "keepalive") && p[1] && p[2] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->keepalive_ping =3D atoi_warn(p[1], msglevel);
-        options->keepalive_timeout =3D atoi_warn(p[2], msglevel);
+        atoi_constrained(p[1], &options->keepalive_ping, "keepalive ping",=
 0, 0, msglevel);
+        atoi_constrained(p[2], &options->keepalive_timeout, "keepalive tim=
eout", 0, 0, msglevel);
     }
     else if (streq(p[0], "ping") && p[1] && !p[2])
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1155?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic9ac18f730e6035126ccf1cf19799548e5fd9316
Gerrit-Change-Number: 1155
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--RAmZZTaxNIE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1155?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">options: Move &lt; 0 check for keepalive settings earlier<br=
><br>Use the atoi_constrained function.<br><br>Change-Id: Ic9ac18f730e60351=
26ccf1cf19799548e5fd9316<br>Signed-off-by: Frank Lichtenheld &lt;frank@...1665...=
641...&gt;<br>---<br>M src/openvpn/helper.c<br>M src/openvpn/options.c<br>2=
 files changed, 3 insertions(+), 7 deletions(-)<br><br></pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit.openvpn.net:29418/openvpn refs/changes/55/1155/1</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/helper.c b/src/openvpn/helper.c</span><br><span>index b2ecb1e..=
b262e8d 100644</span><br><span>--- a/src/openvpn/helper.c</span><br><span>+=
++ b/src/openvpn/helper.c</span><br><span>@@ -552,14 +552,10 @@</span><br><=
span>         /*</span><br><span>          * Sanity checks.</span><br><span=
>          */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
if (o-&gt;keepalive_ping &lt;=3D 0 || o-&gt;keepalive_timeout &lt;=3D 0)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            msg(M_USAGE, &quot;--kee=
palive parameters must be &gt; 0&quot;);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        }</span><br><span>         if (o-&gt;keepalive_p=
ing * 2 &gt; o-&gt;keepalive_timeout)</span><br><span>         {</span><br>=
<span>             msg(M_USAGE,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                &quot;the second parameter to --keepalive (restar=
t timeout=3D%d) must be at least twice the value of the first parameter (pi=
ng interval=3D%d).  A ratio of 1:5 or 1:6 would be even better.  Recommende=
d setting is --keepalive 10 60.&quot;,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                &quot;The second parameter to --keepaliv=
e (restart timeout=3D%d) must be at least twice the value of the first para=
meter (ping interval=3D%d).  A ratio of 1:5 or 1:6 would be even better.  R=
ecommended setting is --keepalive 10 60.&quot;,</span><br><span>           =
      o-&gt;keepalive_timeout, o-&gt;keepalive_ping);</span><br><span>     =
    }</span><br><span>         if (o-&gt;ping_send_timeout || o-&gt;ping_re=
c_timeout)</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn=
/options.c</span><br><span>index 87c0895..97bf957 100644</span><br><span>--=
- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span=
><br><span>@@ -7362,8 +7362,8 @@</span><br><span>     else if (streq(p[0], =
&quot;keepalive&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</s=
pan><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENER=
AL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&=
gt;keepalive_ping =3D atoi_warn(p[1], msglevel);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        options-&gt;keepalive_timeout =3D atoi_w=
arn(p[2], msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        atoi_constrained(p[1], &amp;options-&gt;keepalive_ping, &quot;keep=
alive ping&quot;, 0, 0, msglevel);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        atoi_constrained(p[2], &amp;options-&gt;keepalive_ti=
meout, &quot;keepalive timeout&quot;, 0, 0, msglevel);</span><br><span>    =
 }</span><br><span>     else if (streq(p[0], &quot;ping&quot;) &amp;&amp; p=
[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1155?=
usp=3Demail">change 1155</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1155?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic9ac18f730e6035126ccf1cf197=
99548e5fd9316 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1155 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--RAmZZTaxNIE=--


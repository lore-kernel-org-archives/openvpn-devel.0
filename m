From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 18 Jul 2025 19:21:43 +0000
In-Reply-To: <gerrit.1752849659000.I217cfb319b85fd75a88f7d4d50c374d28771df28@...2715...>
References: <gerrit.1752849659000.I217cfb319b85fd75a88f7d4d50c374d28771df28@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., frank@...2641...
Message-ID: <3c2e7891c94a0b382621d4591753647a0ae12ac6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6NZPGjzQBhg="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: improve float
 collision logging
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf_lici <ralf@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6NZPGjzQBhg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
91?usp=3Demail )

Change subject: improve float collision logging
......................................................................

improve float collision logging

Extend the log message printed when an instance floats to an address
already taken by another instance with the same certificate. The updated
message now includes the instance being closed, the reason it's being
closed, and the new instance taking over that address.

Change-Id: I217cfb319b85fd75a88f7d4d50c374d28771df28
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250718191702.9451-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
226.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/multi.c
1 file changed, 5 insertions(+), 1 deletion(-)




diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index ead3dd0..4696686 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3263,7 +3263,11 @@
                 mroute_addr_print(&mi->real, &gc));
             goto done;
         }
-        msg(D_MULTI_MEDIUM, "closing instance %s", multi_instance_string(e=
x_mi, false, &gc));
+
+        msg(D_MULTI_LOW, "closing instance %s due to float collision with =
%s "
+            "using the same certificate",
+            multi_instance_string(ex_mi, false, &gc),
+            multi_instance_string(mi, false, &gc));
         multi_close_instance(m, ex_mi, false);
     }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1091?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I217cfb319b85fd75a88f7d4d50c374d28771df28
Gerrit-Change-Number: 1091
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--6NZPGjzQBhg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1091?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">improve float collision logging<br><br>Extend=
 the log message printed when an instance floats to an address<br>already t=
aken by another instance with the same certificate. The updated<br>message =
now includes the instance being closed, the reason it&#39;s being<br>closed=
, and the new instance taking over that address.<br><br>Change-Id: I217cfb3=
19b85fd75a88f7d4d50c374d28771df28<br>Signed-off-by: Ralf Lici &lt;ralf@...1665...=
726...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id:=
 &lt;20250718191702.9451-1-gert@...1296...&gt;<br>URL: https://www.mail-arc=
hive.com/openvpn-devel@lists.sourceforge.net/msg32226.html<br>Signed-off-by=
: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/multi.c<br>1=
 file changed, 5 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>i=
ndex ead3dd0..4696686 100644</span><br><span>--- a/src/openvpn/multi.c</spa=
n><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -3263,7 +3263,11 @=
@</span><br><span>                 mroute_addr_print(&amp;mi-&gt;real, &amp=
;gc));</span><br><span>             goto done;</span><br><span>         }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_MULTI_MED=
IUM, &quot;closing instance %s&quot;, multi_instance_string(ex_mi, false, &=
amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_LOW, &quo=
t;closing instance %s due to float collision with %s &quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            &quot;using the same ce=
rtificate&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         multi_instance_string(ex_mi, false, &amp;gc),</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            multi_instance_string(mi, fa=
lse, &amp;gc));</span><br><span>         multi_close_instance(m, ex_mi, fal=
se);</span><br><span>     }</span><br><span> </span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1091=
?usp=3Demail">change 1091</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1091?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I217cfb319b85fd75a88f7d4d50c=
374d28771df28 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1091 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--6NZPGjzQBhg=--


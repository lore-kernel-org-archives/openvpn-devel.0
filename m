From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Fri, 18 Jul 2025 14:41:02 +0000
References: <gerrit.1752849659000.I217cfb319b85fd75a88f7d4d50c374d28771df28@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6adced6192e0b879944d33220b732ec6a20ef684-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rondNW8chLs="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--rondNW8chLs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1091?usp=3Demail

to review the following change.


Change subject: improve float collision logging
......................................................................

improve float collision logging

Extend the log message printed when an instance floats to an address
already taken by another instance with the same certificate. The updated
message now includes the instance being closed, the reason it's being
closed, and the new instance taking over that address.

Change-Id: I217cfb319b85fd75a88f7d4d50c374d28771df28
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M src/openvpn/multi.c
1 file changed, 5 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/91/1091/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--rondNW8chLs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ralf_lici would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1091?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">improve float collision logging<br><br>Extend the log messag=
e printed when an instance floats to an address<br>already taken by another=
 instance with the same certificate. The updated<br>message now includes th=
e instance being closed, the reason it&#39;s being<br>closed, and the new i=
nstance taking over that address.<br><br>Change-Id: I217cfb319b85fd75a88f7d=
4d50c374d28771df28<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br>-=
--<br>M src/openvpn/multi.c<br>1 file changed, 5 insertions(+), 1 deletion(=
-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/9=
1/1091/1</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</sp=
an><br><span>index ead3dd0..4696686 100644</span><br><span>--- a/src/openvp=
n/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -326=
3,7 +3263,11 @@</span><br><span>                 mroute_addr_print(&amp;mi-=
&gt;real, &amp;gc));</span><br><span>             goto done;</span><br><spa=
n>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m=
sg(D_MULTI_MEDIUM, &quot;closing instance %s&quot;, multi_instance_string(e=
x_mi, false, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_M=
ULTI_LOW, &quot;closing instance %s due to float collision with %s &quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;usi=
ng the same certificate&quot;,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            multi_instance_string(ex_mi, false, &amp;gc),</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            multi_instance=
_string(mi, false, &amp;gc));</span><br><span>         multi_close_instance=
(m, ex_mi, false);</span><br><span>     }</span><br><span> </span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1091?usp=3Demail">change 1091</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">se=
ttings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1091?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I217cfb319b85fd75a88f7d4d50c=
374d28771df28 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1091 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
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


--rondNW8chLs=--


From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Fri, 28 Mar 2025 15:26:29 +0000
References: <gerrit.1743175587000.I9b6359076a61ae2bbb8e5cea00e33969cb5f92cf@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e88922794197334e59ead195e266856a28ac82b9-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mqzXtyhCFjg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix FreeBSD-DCO and
 Multisocket interaction
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

--mqzXtyhCFjg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/925?usp=3Demail

to review the following change.


Change subject: Fix FreeBSD-DCO and Multisocket interaction
......................................................................

Fix FreeBSD-DCO and Multisocket interaction

FreeBSD-DCO does not support TCP as transport
protocol so in order to be able to use DCO in a
multi-socket environment we need to check
the local_list entries and disable DCO
if any of the listening socket is TCP.

While at it, removed some dead code left
from Multisocket polishing.

Github: #710

Change-Id: I9b6359076a61ae2bbb8e5cea00e33969cb5f92cf
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/dco.c
M src/openvpn/options.c
M src/openvpn/options.h
3 files changed, 9 insertions(+), 22 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/25/925/1

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index d00958d..7ad9cb3 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -260,10 +260,16 @@
     }

 #if defined(TARGET_FREEBSD)
-    if (!proto_is_udp(ce->proto))
+    if (ce->local_list)
     {
-        msg(msglevel, "NOTE: TCP transport disables data channel offload o=
n FreeBSD.");
-        return false;
+        for (int i =3D 0; i < ce->local_list->len; i++)
+        {
+            if (!proto_is_dgram(ce->local_list->array[i]->proto))
+            {
+                msg(msglevel, "NOTE: TCP transport disables data channel o=
ffload on FreeBSD.");
+                return false;
+            }
+        }
     }
 #endif

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 99dd60a..6605a42 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -9577,20 +9577,3 @@

     return false;
 }
-
-bool
-has_tcp_in_local_list(const struct options *options)
-{
-    if (options->ce.local_list)
-    {
-        for (int i =3D 0; i < options->ce.local_list->len; i++)
-        {
-            if (!proto_is_dgram(options->ce.local_list->array[i]->proto))
-            {
-                return true;
-            }
-        }
-    }
-
-    return false;
-}
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index fa617c8..8d1ef6c 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -921,8 +921,6 @@

 bool has_udp_in_local_list(const struct options *options);

-bool has_tcp_in_local_list(const struct options *options);
-
 /**
  * Returns whether the current configuration has dco enabled.
  */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/925?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9b6359076a61ae2bbb8e5cea00e33969cb5f92cf
Gerrit-Change-Number: 925
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--mqzXtyhCFjg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/925?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Fix FreeBSD-DCO and Multisocket interaction<br><br>FreeBSD-DC=
O does not support TCP as transport<br>protocol so in order to be able to u=
se DCO in a<br>multi-socket environment we need to check<br>the local_list =
entries and disable DCO<br>if any of the listening socket is TCP.<br><br>Wh=
ile at it, removed some dead code left<br>from Multisocket polishing.<br><b=
r>Github: #710<br><br>Change-Id: I9b6359076a61ae2bbb8e5cea00e33969cb5f92cf<=
br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...2726...&gt;<br>---<=
br>M src/openvpn/dco.c<br>M src/openvpn/options.c<br>M src/openvpn/options.=
h<br>3 files changed, 9 insertions(+), 22 deletions(-)<br><br></pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit.openvpn.net:29418/openvpn refs/changes/25/925/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>index d00958d..=
7ad9cb3 100644</span><br><span>--- a/src/openvpn/dco.c</span><br><span>+++ =
b/src/openvpn/dco.c</span><br><span>@@ -260,10 +260,16 @@</span><br><span> =
    }</span><br><span> </span><br><span> #if defined(TARGET_FREEBSD)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!proto_is_udp(ce-&gt=
;proto))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ce-=
&gt;local_list)</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        msg(msglevel, &quot;NOTE: TCP transport disables d=
ata channel offload on FreeBSD.&quot;);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        return false;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        for (int i =3D 0; i &lt; ce-&gt;local_list-&gt;=
len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!pro=
to_is_dgram(ce-&gt;local_list-&gt;array[i]-&gt;proto))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                msg(msglevel, &quot;NOTE: TCP =
transport disables data channel offload on FreeBSD.&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                return false;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     =
}</span><br><span> #endif</span><br><span> </span><br><span>diff --git a/sr=
c/openvpn/options.c b/src/openvpn/options.c</span><br><span>index 99dd60a..=
6605a42 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>=
+++ b/src/openvpn/options.c</span><br><span>@@ -9577,20 +9577,3 @@</span><b=
r><span> </span><br><span>     return false;</span><br><span> }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-has_tcp_in_local_list(const struct options *options)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (options-&gt;ce.local_list)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        for (int i =3D 0; i &lt; options-&gt;ce.local_list-&gt;=
len; i++)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!proto_i=
s_dgram(options-&gt;ce.local_list-&gt;array[i]-&gt;proto))</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                return true;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return false;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span>diff --=
git a/src/openvpn/options.h b/src/openvpn/options.h</span><br><span>index f=
a617c8..8d1ef6c 100644</span><br><span>--- a/src/openvpn/options.h</span><b=
r><span>+++ b/src/openvpn/options.h</span><br><span>@@ -921,8 +921,6 @@</sp=
an><br><span> </span><br><span> bool has_udp_in_local_list(const struct opt=
ions *options);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-bool has_tcp_in_local_list(const struct options *options);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</spa=
n><br><span>  * Returns whether the current configuration has dco enabled.<=
/span><br><span>  */</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/925?usp=3Demail">change 925</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/925?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9b6359076a61ae2bbb8e5cea00e=
33969cb5f92cf </div>
<div style=3D"display:none"> Gerrit-Change-Number: 925 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
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


--mqzXtyhCFjg=--


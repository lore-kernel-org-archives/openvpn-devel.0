From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 2 Apr 2025 18:32:17 +0000
In-Reply-To: <gerrit.1743175587000.I9b6359076a61ae2bbb8e5cea00e33969cb5f92cf@...2715...>
References: <gerrit.1743175587000.I9b6359076a61ae2bbb8e5cea00e33969cb5f92cf@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <73403bafe5829c8c182485c0cf67002cd5b4ddbe-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="e9sZzutzje4="; charset=UTF-8
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
To: its_Giaan <gianmarco@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--e9sZzutzje4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 its_Giaan. ( http://gerrit.openvpn.net/c/openvpn/+/925?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Fix FreeBSD-DCO and Multisocket interaction
......................................................................

Fix FreeBSD-DCO and Multisocket interaction

FreeBSD-DCO does not support TCP as transport protocol so in order to
be able to use DCO in a multi-socket environment we need to check the
local_list entries and disable DCO if any of the listening socket
is TCP.

While at it, removed some dead code left from Multisocket polishing.

Github: closes OpenVPN/openvpn#710

Change-Id: I9b6359076a61ae2bbb8e5cea00e33969cb5f92cf
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250402132148.18810-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
324.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco.c
M src/openvpn/options.c
M src/openvpn/options.h
3 files changed, 9 insertions(+), 22 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/25/925/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--e9sZzutzje4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by its_Giaan.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
925?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Fix FreeBSD-DCO and Multisocket interaction<br><br>F=
reeBSD-DCO does not support TCP as transport protocol so in order to<br>be =
able to use DCO in a multi-socket environment we need to check the<br>local=
_list entries and disable DCO if any of the listening socket<br>is TCP.<br>=
<br>While at it, removed some dead code left from Multisocket polishing.<br=
><br>Github: closes OpenVPN/openvpn#710<br><br>Change-Id: I9b6359076a61ae2b=
bb8e5cea00e33969cb5f92cf<br>Signed-off-by: Gianmarco De Gregori &lt;gianmar=
co@...2726...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Mess=
age-Id: &lt;20250402132148.18810-1-gert@...1296...&gt;<br>URL: https://www.=
mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31324.html<br>Signe=
d-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/dco.=
c<br>M src/openvpn/options.c<br>M src/openvpn/options.h<br>3 files changed,=
 9 insertions(+), 22 deletions(-)<br><br></pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.n=
et:29418/openvpn refs/changes/25/925/2</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco=
.c b/src/openvpn/dco.c</span><br><span>index d00958d..7ad9cb3 100644</span>=
<br><span>--- a/src/openvpn/dco.c</span><br><span>+++ b/src/openvpn/dco.c</=
span><br><span>@@ -260,10 +260,16 @@</span><br><span>     }</span><br><span=
> </span><br><span> #if defined(TARGET_FREEBSD)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (!proto_is_udp(ce-&gt;proto))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (ce-&gt;local_list)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    msg(msglevel, &quot;NOTE: TCP transport disables data channel offload o=
n FreeBSD.&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       for (int i =3D 0; i &lt; ce-&gt;local_list-&gt;len; i++)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (!proto_is_dgram(ce-&gt;lo=
cal_list-&gt;array[i]-&gt;proto))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                msg(msglevel, &quot;NOTE: TCP transport disables da=
ta channel offload on FreeBSD.&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                return false;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><br><span> #e=
ndif</span><br><span> </span><br><span>diff --git a/src/openvpn/options.c b=
/src/openvpn/options.c</span><br><span>index 99dd60a..6605a42 100644</span>=
<br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/opt=
ions.c</span><br><span>@@ -9577,20 +9577,3 @@</span><br><span> </span><br><=
span>     return false;</span><br><span> }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-has_tcp_in_local_=
list(const struct options *options)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (options-&gt;ce.local_list)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        f=
or (int i =3D 0; i &lt; options-&gt;ce.local_list-&gt;len; i++)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (!proto_is_dgram(options-&gt=
;ce.local_list-&gt;array[i]-&gt;proto))</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                return true;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    return false;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span>diff --git a/src/openvpn/=
options.h b/src/openvpn/options.h</span><br><span>index fa617c8..8d1ef6c 10=
0644</span><br><span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/=
openvpn/options.h</span><br><span>@@ -921,8 +921,6 @@</span><br><span> </sp=
an><br><span> bool has_udp_in_local_list(const struct options *options);</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool h=
as_tcp_in_local_list(const struct options *options);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span>  * R=
eturns whether the current configuration has dco enabled.</span><br><span> =
 */</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/925?usp=3Demail">change 925</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.or=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/925?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9b6359076a61ae2bbb8e5cea00e=
33969cb5f92cf </div>
<div style=3D"display:none"> Gerrit-Change-Number: 925 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--e9sZzutzje4=--


From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 2 Apr 2025 18:32:20 +0000
In-Reply-To: <gerrit.1743175587000.I9b6359076a61ae2bbb8e5cea00e33969cb5f92cf@...2715...>
References: <gerrit.1743175587000.I9b6359076a61ae2bbb8e5cea00e33969cb5f92cf@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <73403bafe5829c8c182485c0cf67002cd5b4ddbe-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6VC0jZZOUHE="; charset=UTF-8
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
To: its_Giaan <gianmarco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6VC0jZZOUHE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/92=
5?usp=3Demail )

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
Gerrit-MessageType: merged

--6VC0jZZOUHE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/925?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Fix FreeBSD-DCO and Multisocket interaction<br=
><br>FreeBSD-DCO does not support TCP as transport protocol so in order to<=
br>be able to use DCO in a multi-socket environment we need to check the<br=
>local_list entries and disable DCO if any of the listening socket<br>is TC=
P.<br><br>While at it, removed some dead code left from Multisocket polishi=
ng.<br><br>Github: closes OpenVPN/openvpn#710<br><br>Change-Id: I9b6359076a=
61ae2bbb8e5cea00e33969cb5f92cf<br>Signed-off-by: Gianmarco De Gregori &lt;g=
ianmarco@...2726...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<b=
r>Message-Id: &lt;20250402132148.18810-1-gert@...1296...&gt;<br>URL: https:=
//www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31324.html<br=
>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvp=
n/dco.c<br>M src/openvpn/options.c<br>M src/openvpn/options.h<br>3 files ch=
anged, 9 insertions(+), 22 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>index=
 d00958d..7ad9cb3 100644</span><br><span>--- a/src/openvpn/dco.c</span><br>=
<span>+++ b/src/openvpn/dco.c</span><br><span>@@ -260,10 +260,16 @@</span><=
br><span>     }</span><br><span> </span><br><span> #if defined(TARGET_FREEB=
SD)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!proto_is_=
udp(ce-&gt;proto))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (ce-&gt;local_list)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        msg(msglevel, &quot;NOTE: TCP transport =
disables data channel offload on FreeBSD.&quot;);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; ce-&gt;local=
_list-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  if (!proto_is_dgram(ce-&gt;local_list-&gt;array[i]-&gt;proto))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                msg(msglevel, &quot;=
NOTE: TCP transport disables data channel offload on FreeBSD.&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                return fa=
lse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span>     }</span><br><span> #endif</span><br><span> </span><br><span>diff =
--git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>index=
 99dd60a..6605a42 100644</span><br><span>--- a/src/openvpn/options.c</span>=
<br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -9577,20 +9577,3 @=
@</span><br><span> </span><br><span>     return false;</span><br><span> }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-has_tcp_in_local_list(const struct options *options)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (options-&gt;ce.local_list)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        for (int i =3D 0; i &lt; options-&gt;ce.loca=
l_list-&gt;len; i++)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            i=
f (!proto_is_dgram(options-&gt;ce.local_list-&gt;array[i]-&gt;proto))</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                return true;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return=
 false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><s=
pan>diff --git a/src/openvpn/options.h b/src/openvpn/options.h</span><br><s=
pan>index fa617c8..8d1ef6c 100644</span><br><span>--- a/src/openvpn/options=
.h</span><br><span>+++ b/src/openvpn/options.h</span><br><span>@@ -921,8 +9=
21,6 @@</span><br><span> </span><br><span> bool has_udp_in_local_list(const=
 struct options *options);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-bool has_tcp_in_local_list(const struct options *opt=
ions);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n> /**</span><br><span>  * Returns whether the current configuration has dc=
o enabled.</span><br><span>  */</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/925?usp=3Demail">c=
hange 925</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/925?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--6VC0jZZOUHE=--


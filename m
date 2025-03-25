From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 25 Mar 2025 09:06:25 +0000
In-Reply-To: <gerrit.1742224441000.I1c8fcd5bb6e1fa0020d52879eefbafdb2630e7b5@...2715...>
References: <gerrit.1742224441000.I1c8fcd5bb6e1fa0020d52879eefbafdb2630e7b5@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <aa43f67a20696c2ee2052ea7c01deeccf68df8c1-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LKcFb+3rBWI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Mention address if
 not unspecific on DNS failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--LKcFb+3rBWI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld.

Hello cron2, flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/909?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


Change subject: Mention address if not unspecific on DNS failure
......................................................................

Mention address if not unspecific on DNS failure

With the recent changes breaking configs that included lport 0, it became
apparent that having  the address family in the error message when
resolving fails, would have made diagnosis in this case and probably others
much easier.

Change-Id: I1c8fcd5bb6e1fa0020d52879eefbafdb2630e7b5
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/socket.c
1 file changed, 20 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/09/909/2

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 6b32e30..c5ed6b8 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -445,6 +445,22 @@
     throw_signal_soft(SIGHUP, "Preresolving failed");
 }

+/**
+ * Small helper function for openvpn_getaddrinfo to print the address
+ * family when resolving fails
+ */
+static const char *
+getaddrinfo_addr_family_name(int af)
+{
+    switch (af)
+    {
+        case AF_INET:  return "[AF_INET]";
+
+        case AF_INET6: return "[AF_INET6]";
+    }
+    return "";
+}
+
 /*
  * Translate IPv4/IPv6 addr or hostname into struct addrinfo
  * If resolve error, try again for resolve_retry_seconds seconds.
@@ -545,11 +561,11 @@
             print_hostname =3D "undefined";
         }

-        fmt =3D "RESOLVE: Cannot resolve host address: %s:%s (%s)";
+        fmt =3D "RESOLVE: Cannot resolve host address: %s:%s%s (%s)";
         if ((flags & GETADDR_MENTION_RESOLVE_RETRY)
             && !resolve_retry_seconds)
         {
-            fmt =3D "RESOLVE: Cannot resolve host address: %s:%s (%s) "
+            fmt =3D "RESOLVE: Cannot resolve host address: %s:%s%s (%s) %s"
                   "(I would have retried this name query if you had "
                   "specified the --resolv-retry option.)";
         }
@@ -639,7 +655,8 @@
                 fmt,
                 print_hostname,
                 print_servname,
-                gai_strerror(status));
+                getaddrinfo_addr_family_name(ai_family),
+                ai_strerror(status));

             if (--resolve_retries <=3D 0)
             {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/909?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c8fcd5bb6e1fa0020d52879eefbafdb2630e7b5
Gerrit-Change-Number: 909
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--LKcFb+3rBWI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/909?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Mention address if not unspecific on DNS failure<br>=
<br>With the recent changes breaking configs that included lport 0, it beca=
me<br>apparent that having  the address family in the error message when<br=
>resolving fails, would have made diagnosis in this case and probably other=
s<br>much easier.<br><br>Change-Id: I1c8fcd5bb6e1fa0020d52879eefbafdb2630e7=
b5<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/o=
penvpn/socket.c<br>1 file changed, 20 insertions(+), 3 deletions(-)<br><br>=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/09/909/2</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><s=
pan>index 6b32e30..c5ed6b8 100644</span><br><span>--- a/src/openvpn/socket.=
c</span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -445,6 +445=
,22 @@</span><br><span>     throw_signal_soft(SIGHUP, &quot;Preresolving fa=
iled&quot;);</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Small helper function for openvpn_getaddrinfo to print the=
 address</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * family w=
hen resolving fails</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static const cha=
r *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+getaddrinfo_addr=
_family_name(int af)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (af)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        case AF_INET:  return &quot=
;[AF_INET]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case AF_INET6=
: return &quot;[AF_INET6]&quot;;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return &quot;&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> /*</span><br><span>  * Translate IPv4/IPv6 addr or hostname into struct=
 addrinfo</span><br><span>  * If resolve error, try again for resolve_retry=
_seconds seconds.</span><br><span>@@ -545,11 +561,11 @@</span><br><span>   =
          print_hostname =3D &quot;undefined&quot;;</span><br><span>       =
  }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        fmt =3D &quot;RESOLVE: Cannot resolve host address: %s:%s (%s)&quot=
;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fmt =3D &=
quot;RESOLVE: Cannot resolve host address: %s:%s%s (%s)&quot;;</span><br><s=
pan>         if ((flags &amp; GETADDR_MENTION_RESOLVE_RETRY)</span><br><spa=
n>             &amp;&amp; !resolve_retry_seconds)</span><br><span>         =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            fmt =3D =
&quot;RESOLVE: Cannot resolve host address: %s:%s (%s) &quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            fmt =3D &quot;RESOLVE=
: Cannot resolve host address: %s:%s%s (%s) %s&quot;</span><br><span>      =
             &quot;(I would have retried this name query if you had &quot;<=
/span><br><span>                   &quot;specified the --resolv-retry optio=
n.)&quot;;</span><br><span>         }</span><br><span>@@ -639,7 +655,8 @@</=
span><br><span>                 fmt,</span><br><span>                 print=
_hostname,</span><br><span>                 print_servname,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                gai_strerror(status))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ge=
taddrinfo_addr_family_name(ai_family),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                ai_strerror(status));</span><br><span> <=
/span><br><span>             if (--resolve_retries &lt;=3D 0)</span><br><sp=
an>             {</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/909?usp=3Demail">change 909</a>.=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/909?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c8fcd5bb6e1fa0020d52879eef=
bafdb2630e7b5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 909 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--LKcFb+3rBWI=--


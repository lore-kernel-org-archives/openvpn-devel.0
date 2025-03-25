From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 25 Mar 2025 21:23:56 +0000
In-Reply-To: <gerrit.1742224441000.I1c8fcd5bb6e1fa0020d52879eefbafdb2630e7b5@...2715...>
References: <gerrit.1742224441000.I1c8fcd5bb6e1fa0020d52879eefbafdb2630e7b5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <db7f2af7d4cbad85b027c48f97507d76e66df250-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qDqmCjihUes="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qDqmCjihUes=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/909?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Mention address if not unspecific on DNS failure
......................................................................

Mention address if not unspecific on DNS failure

With the recent changes breaking configs that included lport 0, it became
apparent that having  the address family in the error message when
resolving fails, would have made diagnosis in this case and probably others
much easier.

Change-Id: I1c8fcd5bb6e1fa0020d52879eefbafdb2630e7b5
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250325195750.7899-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
237.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/socket.c
1 file changed, 19 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/09/909/5

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 6b32e30..09de1b0 100644
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
+            fmt =3D "RESOLVE: Cannot resolve host address: %s:%s%s (%s)"
                   "(I would have retried this name query if you had "
                   "specified the --resolv-retry option.)";
         }
@@ -639,6 +655,7 @@
                 fmt,
                 print_hostname,
                 print_servname,
+                getaddrinfo_addr_family_name(ai_family),
                 gai_strerror(status));

             if (--resolve_retries <=3D 0)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/909?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c8fcd5bb6e1fa0020d52879eefbafdb2630e7b5
Gerrit-Change-Number: 909
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--qDqmCjihUes=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #5</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
909?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Mention address if not unspecific on DNS failure<br>=
<br>With the recent changes breaking configs that included lport 0, it beca=
me<br>apparent that having  the address family in the error message when<br=
>resolving fails, would have made diagnosis in this case and probably other=
s<br>much easier.<br><br>Change-Id: I1c8fcd5bb6e1fa0020d52879eefbafdb2630e7=
b5<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Gert=
 Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250325195750.7899-1-g=
ert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1697...=
.sourceforge.net/msg31237.html<br>Signed-off-by: Gert Doering &lt;gert@...1386...=
296...&gt;<br>---<br>M src/openvpn/socket.c<br>1 file changed, 19 insertion=
s(+), 2 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/open=
vpn refs/changes/09/909/5</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/socket.c b/src/o=
penvpn/socket.c</span><br><span>index 6b32e30..09de1b0 100644</span><br><sp=
an>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/openvpn/socket.c</s=
pan><br><span>@@ -445,6 +445,22 @@</span><br><span>     throw_signal_soft(S=
IGHUP, &quot;Preresolving failed&quot;);</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Small helper function for open=
vpn_getaddrinfo to print the address</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * family when resolving fails</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static const char *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+getaddrinfo_addr_family_name(int af)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    switch (af)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 case AF_INET:  return &quot;[AF_INET]&quot;;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        case AF_INET6: return &quot;[AF_INET6]&quot;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return &quot;&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Translate IPv4/IPv=
6 addr or hostname into struct addrinfo</span><br><span>  * If resolve erro=
r, try again for resolve_retry_seconds seconds.</span><br><span>@@ -545,11 =
+561,11 @@</span><br><span>             print_hostname =3D &quot;undefined&=
quot;;</span><br><span>         }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        fmt =3D &quot;RESOLVE: Cannot resol=
ve host address: %s:%s (%s)&quot;;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        fmt =3D &quot;RESOLVE: Cannot resolve host address: =
%s:%s%s (%s)&quot;;</span><br><span>         if ((flags &amp; GETADDR_MENTI=
ON_RESOLVE_RETRY)</span><br><span>             &amp;&amp; !resolve_retry_se=
conds)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            fmt =3D &quot;RESOLVE: Cannot resolve host address:=
 %s:%s (%s) &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           fmt =3D &quot;RESOLVE: Cannot resolve host address: %s:%s%s (%s)=
&quot;</span><br><span>                   &quot;(I would have retried this =
name query if you had &quot;</span><br><span>                   &quot;speci=
fied the --resolv-retry option.)&quot;;</span><br><span>         }</span><b=
r><span>@@ -639,6 +655,7 @@</span><br><span>                 fmt,</span><br=
><span>                 print_hostname,</span><br><span>                 pr=
int_servname,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          getaddrinfo_addr_family_name(ai_family),</span><br><span>        =
         gai_strerror(status));</span><br><span> </span><br><span>         =
    if (--resolve_retries &lt;=3D 0)</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/909?usp=3Dema=
il">change 909</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/909?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c8fcd5bb6e1fa0020d52879eef=
bafdb2630e7b5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 909 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--qDqmCjihUes=--


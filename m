From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 25 Mar 2025 17:33:03 +0000
In-Reply-To: <gerrit.1742224441000.I1c8fcd5bb6e1fa0020d52879eefbafdb2630e7b5@...2715...>
References: <gerrit.1742224441000.I1c8fcd5bb6e1fa0020d52879eefbafdb2630e7b5@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <d20944db624a08cda92bdf9ef1ff5b49e2ef3f4e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FdvLDBZe10Q="; charset=UTF-8
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

--FdvLDBZe10Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello cron2, flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/909?usp=3Demail

to look at the new patch set (#4).

The following approvals got outdated and were removed:
Code-Review+2 by cron2

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


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
1 file changed, 19 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/09/909/4

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
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--FdvLDBZe10Q=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p>plaisthos <strong>uploaded patch set #4</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/909?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><p>The change is no longer submittable: Code-Revi=
ew and checks~ChecksSubmitRule are unsatisfied now.</p><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">Mention address if not =
unspecific on DNS failure<br><br>With the recent changes breaking configs t=
hat included lport 0, it became<br>apparent that having  the address family=
 in the error message when<br>resolving fails, would have made diagnosis in=
 this case and probably others<br>much easier.<br><br>Change-Id: I1c8fcd5bb=
6e1fa0020d52879eefbafdb2630e7b5<br>Signed-off-by: Arne Schwabe &lt;arne@...493...=
1227...&gt;<br>---<br>M src/openvpn/socket.c<br>1 file changed, 19 insertio=
ns(+), 2 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/ope=
nvpn refs/changes/09/909/4</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/socket.c b/src/=
openvpn/socket.c</span><br><span>index 6b32e30..09de1b0 100644</span><br><s=
pan>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/openvpn/socket.c</=
span><br><span>@@ -445,6 +445,22 @@</span><br><span>     throw_signal_soft(=
SIGHUP, &quot;Preresolving failed&quot;);</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Small helper function for ope=
nvpn_getaddrinfo to print the address</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * family when resolving fails</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static const char *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+getaddrinfo_addr_family_name(int af)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    switch (af)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  case AF_INET:  return &quot;[AF_INET]&quot;;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        case AF_INET6: return &quot;[AF_INET6]&quot;;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return &quot;&quot;;</span><br><span style=
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
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--FdvLDBZe10Q=--


From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 17 Mar 2025 15:14:08 +0000
References: <gerrit.1742224441000.I1c8fcd5bb6e1fa0020d52879eefbafdb2630e7b5@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <885170f99ccebf00ec9e7501915538f8a35ea716-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UY0mXBvCozQ="; charset=UTF-8
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

--UY0mXBvCozQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/909?usp=3Demail

to review the following change.


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
1 file changed, 21 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/09/909/1

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 6b32e30..24c414d 100644
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
+gettaddrinfo_addr_family_name(int af)
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
@@ -561,6 +577,8 @@
             goto done;
         }

+
+
 #ifdef ENABLE_MANAGEMENT
         if (flags & GETADDR_UPDATE_MANAGEMENT_STATE)
         {
@@ -639,6 +657,7 @@
                 fmt,
                 print_hostname,
                 print_servname,
+                gettaddrinfo_addr_family_name(ai_family),
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--UY0mXBvCozQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/909?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Mention address if not unspecific on DNS failure<br><br>With =
the recent changes breaking configs that included lport 0, it became<br>app=
arent that having  the address family in the error message when<br>resolvin=
g fails, would have made diagnosis in this case and probably others<br>much=
 easier.<br><br>Change-Id: I1c8fcd5bb6e1fa0020d52879eefbafdb2630e7b5<br>Sig=
ned-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/so=
cket.c<br>1 file changed, 21 insertions(+), 2 deletions(-)<br><br></pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit.openvpn.net:29418/openvpn refs/changes/09/909/1</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>index=
 6b32e30..24c414d 100644</span><br><span>--- a/src/openvpn/socket.c</span><=
br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -445,6 +445,22 @@</s=
pan><br><span>     throw_signal_soft(SIGHUP, &quot;Preresolving failed&quot=
;);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Small helper function for openvpn_getaddrinfo to print the address<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * family when resol=
ving fails</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static const char *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+gettaddrinfo_addr_family_=
name(int af)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (af)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        case AF_INET:  return &quot;[AF_I=
NET]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        case AF_INET6: retu=
rn &quot;[AF_INET6]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn &quot;&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*=
</span><br><span>  * Translate IPv4/IPv6 addr or hostname into struct addri=
nfo</span><br><span>  * If resolve error, try again for resolve_retry_secon=
ds seconds.</span><br><span>@@ -545,11 +561,11 @@</span><br><span>         =
    print_hostname =3D &quot;undefined&quot;;</span><br><span>         }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  fmt =3D &quot;RESOLVE: Cannot resolve host address: %s:%s (%s)&quot;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        fmt =3D &quot;R=
ESOLVE: Cannot resolve host address: %s:%s%s (%s)&quot;;</span><br><span>  =
       if ((flags &amp; GETADDR_MENTION_RESOLVE_RETRY)</span><br><span>    =
         &amp;&amp; !resolve_retry_seconds)</span><br><span>         {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            fmt =3D &quot;=
RESOLVE: Cannot resolve host address: %s:%s (%s) &quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            fmt =3D &quot;RESOLVE: Cann=
ot resolve host address: %s:%s%s (%s) %s&quot;</span><br><span>            =
       &quot;(I would have retried this name query if you had &quot;</span>=
<br><span>                   &quot;specified the --resolv-retry option.)&qu=
ot;;</span><br><span>         }</span><br><span>@@ -561,6 +577,8 @@</span><=
br><span>             goto done;</span><br><span>         }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef ENABLE_MANA=
GEMENT</span><br><span>         if (flags &amp; GETADDR_UPDATE_MANAGEMENT_S=
TATE)</span><br><span>         {</span><br><span>@@ -639,6 +657,7 @@</span>=
<br><span>                 fmt,</span><br><span>                 print_host=
name,</span><br><span>                 print_servname,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                gettaddrinfo_addr_family=
_name(ai_family),</span><br><span>                 gai_strerror(status));</=
span><br><span> </span><br><span>             if (--resolve_retries &lt;=3D=
 0)</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/909?usp=3Demail">change 909</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.or=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/909?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c8fcd5bb6e1fa0020d52879eef=
bafdb2630e7b5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 909 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--UY0mXBvCozQ=--


From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 10 Dec 2025 09:45:30 +0000
In-Reply-To: <gerrit.1765297693000.I6debe8bbedd5a08da417bfee1243a43ef6df7980@...2715...>
References: <gerrit.1765297693000.I6debe8bbedd5a08da417bfee1243a43ef6df7980@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 selva.nair@...277..., openvpn-devel@lists.sourceforge.net
Message-ID: <125c5c2cde194e32ad6565f6eadb2c035482927f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DghNOp7X0vQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: iservice: set
 adapter DNS only with search domains
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: selvanair <selva.nair@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DghNOp7X0vQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
29?usp=3Demail )

Change subject: iservice: set adapter DNS only with search domains
......................................................................

iservice: set adapter DNS only with search domains

With NRPT the adapter name server configuration is not needed
theoretically. However DNS config is not showing with traditional
tools like ipconfig if they are left out. More importantly if
there are no DNS servers configured for an adapter the adapter
specific search domains are not recognized by the Windows resolver.

However, adding the servers to the adapter has the side effect, that
general look-ups are now also done using this adapter, which might
come as unexpected and yield wrong results, if there is some trickery
happening with the default DNS, for example.

As a workaround, set the adapter DNS only when strictly needed.

Github: OpenVPN/openvpn#473

Change-Id: I6debe8bbedd5a08da417bfee1243a43ef6df7980
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Selva Nair <selva.nair@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1429
Message-Id: <20251210072951.25753-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
968.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/interactive.c
1 file changed, 12 insertions(+), 4 deletions(-)




diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 6f04f6b..9327dfa 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2869,11 +2869,19 @@
         goto out;
     }

-    /* Set name servers */
-    err =3D SetNameServerAddresses(iid, msg->addresses);
-    if (err)
+    /*
+     * Set DNS on the adapter for search domains to be considered.
+     * If split DNS is configured, do this only when search domains
+     * are given, so that look-ups for other domains do not go over
+     * the VPN all the time.
+     */
+    if (msg->search_domains[0] || !msg->resolve_domains[0])
     {
-        goto out;
+        err =3D SetNameServerAddresses(iid, msg->addresses);
+        if (err)
+        {
+            goto out;
+        }
     }

     /* Set search domains, if any */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1429?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6debe8bbedd5a08da417bfee1243a43ef6df7980
Gerrit-Change-Number: 1429
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: selvanair <selva.nair@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DghNOp7X0vQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1429?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">iservice: set adapter DNS only with search domai=
ns<br><br>With NRPT the adapter name server configuration is not needed<br>=
theoretically. However DNS config is not showing with traditional<br>tools =
like ipconfig if they are left out. More importantly if<br>there are no DNS=
 servers configured for an adapter the adapter<br>specific search domains a=
re not recognized by the Windows resolver.<br><br>However, adding the serve=
rs to the adapter has the side effect, that<br>general look-ups are now als=
o done using this adapter, which might<br>come as unexpected and yield wron=
g results, if there is some trickery<br>happening with the default DNS, for=
 example.<br><br>As a workaround, set the adapter DNS only when strictly ne=
eded.<br><br>Github: OpenVPN/openvpn#473<br><br>Change-Id: I6debe8bbedd5a08=
da417bfee1243a43ef6df7980<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...=
&gt;<br>Acked-by: Selva Nair &lt;selva.nair@...277...&gt;<br>Gerrit URL: ht=
tps://gerrit.openvpn.net/c/openvpn/+/1429<br>Message-Id: &lt;20251210072951=
.25753-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-d=
evel@lists.sourceforge.net/msg34968.html<br>Signed-off-by: Gert Doering &lt=
;gert@...1296...&gt;<br>---<br>M src/openvpnserv/interactive.c<br>1 file ch=
anged, 12 insertions(+), 4 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive=
.c</span><br><span>index 6f04f6b..9327dfa 100644</span><br><span>--- a/src/=
openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive=
.c</span><br><span>@@ -2869,11 +2869,19 @@</span><br><span>         goto ou=
t;</span><br><span>     }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    /* Set name servers */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    err =3D SetNameServerAddresses(iid, msg-&gt;=
addresses);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (er=
r)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * Set DNS on the adapter =
for search domains to be considered.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * If split DNS is configured, do this only when searc=
h domains</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * are=
 given, so that look-ups for other domains do not go over</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * the VPN all the time.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (msg-&gt;search_domains[0] || !ms=
g-&gt;resolve_domains[0])</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        goto out;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        err =3D SetNameServerAddresses(iid, msg-&g=
t;addresses);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (err)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto ou=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span>     }</span><br><span> </span><br><span>     /* Set search domain=
s, if any */</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1429?usp=3Demail">change 1429</a>. To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemt=
ype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" i=
temtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1429?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6debe8bbedd5a08da417bfee124=
3a43ef6df7980 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1429 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: selvanair &lt;selva.nair@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--DghNOp7X0vQ=--


From: "d12fk (Code Review)" <gerrit@...515...>
Date: Tue, 9 Dec 2025 16:28:15 +0000
References: <gerrit.1765297693000.I6debe8bbedd5a08da417bfee1243a43ef6df7980@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <4ededcf1060c43b62924c0edaa39444e7c861c70-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UZAYdFVXSuo="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--UZAYdFVXSuo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1429?usp=3Demail

to review the following change.


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

Change-Id: I6debe8bbedd5a08da417bfee1243a43ef6df7980
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpnserv/interactive.c
1 file changed, 12 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/29/1429/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6debe8bbedd5a08da417bfee1243a43ef6df7980
Gerrit-Change-Number: 1429
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--UZAYdFVXSuo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>d12fk would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1429?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">iservice: set adapter DNS only with search =
domains<br><br>With NRPT the adapter name server configuration is not neede=
d<br>theoretically. However DNS config is not showing with traditional<br>t=
ools like ipconfig if they are left out. More importantly if<br>there are n=
o DNS servers configured for an adapter the adapter<br>specific search doma=
ins are not recognized by the Windows resolver.<br><br>However, adding the =
servers to the adapter has the side effect, that<br>general look-ups are no=
w also done using this adapter, which might<br>come as unexpected and yield=
 wrong results, if there is some trickery<br>happening with the default DNS=
, for example.<br><br>As a workaround, set the adapter DNS only when strict=
ly needed.<br><br>Change-Id: I6debe8bbedd5a08da417bfee1243a43ef6df7980<br>S=
igned-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>---<br>M src/openvpnse=
rv/interactive.c<br>1 file changed, 12 insertions(+), 4 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/c=
hanges/29/1429/1</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interactive.c b/src/o=
penvpnserv/interactive.c</span><br><span>index 6f04f6b..9327dfa 100644</spa=
n><br><span>--- a/src/openvpnserv/interactive.c</span><br><span>+++ b/src/o=
penvpnserv/interactive.c</span><br><span>@@ -2869,11 +2869,19 @@</span><br>=
<span>         goto out;</span><br><span>     }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    /* Set name servers */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    err =3D SetNameServerA=
ddresses(iid, msg-&gt;addresses);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (err)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * S=
et DNS on the adapter for search domains to be considered.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * If split DNS is configured, d=
o this only when search domains</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * are given, so that look-ups for other domains do not go =
over</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the VPN =
all the time.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (msg-&gt;se=
arch_domains[0] || !msg-&gt;resolve_domains[0])</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        goto out;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        err =3D SetNameServe=
rAddresses(iid, msg-&gt;addresses);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (err)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span>     }</span><br><span> </span><br><span>   =
  /* Set search domains, if any */</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1429?usp=3Demai=
l">change 1429</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1429?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6debe8bbedd5a08da417bfee124=
3a43ef6df7980 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1429 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--UZAYdFVXSuo=--


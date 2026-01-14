From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 14 Jan 2026 11:51:28 +0000
In-Reply-To: <gerrit.1768377240000.Idbd0a47ba4d297a833a350611a23f19fd9a797b5@...2715...>
References: <gerrit.1768377240000.Idbd0a47ba4d297a833a350611a23f19fd9a797b5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, antonio@...2726...
Message-ID: <519b72d4eb87e0838c33d2b82dc0b4ee72cb6cbc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gJmlFAT0fro="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Repair interaction
 between DCO and persist-tun after reconnection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gJmlFAT0fro=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
73?usp=3Demail )

Change subject: Repair interaction between DCO and persist-tun after reconn=
ection
......................................................................

Repair interaction between DCO and persist-tun after reconnection

When --persist-tun is active, openvpn userland on Linux and FreeBSD fails
to re-enable "poll for DCO events" after a reconnect (e.g. triggered by
a ping timeout).  The reconnect will still work fine, but the *next*
DCO event notification from the kernel will not be received by OpenVPN
userland, and so the system will get into an inconsistent state (Userland
assumes "all is well", kernel DCO has disconnected the peer, connection
is broken until the next tls-renegotion and/or manual restart, *and* the
next DCO key setup might fail due to "peer id gone").

This only affects client side, --server tun is always "persistent", and
there is no "full restart" (and the code path in question is also
only used for client and p2p server).

The root cause is an incorrect check for "is this interface up?" when
calling dco_event_set() in forard.c::io_wait() - "c2.did_open_tun" is
only true if the tun interface was actually configured on this reconnect,
which it isn't if --persist-tun is active.  Replace with a check for
"do we have a tuntap structure, and if yes, do we have active DCO?"
which reflects the original intent much better.

The original code also had a check for "out_socket & EVENT_READ" there,
which did to some extend avoid calling dco_event_set() for every single
UDP packet sent and received by userland - but this only worked on initial
connection, and is always true on reconnect, so this condition was removed
for simplicity.  We should come back here...

v2:
  - some language fixes on the commit message
  - do not check ->dco.open in forward.c, as this is not available if
    not on FreeBSD, or if compiled with --disable-dco.
    FreeBSD DCO does the "if (!dco || !dco->open)" check in dco_event_set()
    anyway, so it's not needed, and Linux DCO has "dco->nl_sock", which is
    also reliably set/unset, and checked by dco_event_set() already.

Github: OpenVPN/openvpn#947

Change-Id: Idbd0a47ba4d297a833a350611a23f19fd9a797b5
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1473
Message-Id: <20260114112403.7046-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
239.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/forward.c
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index d208c21..39ac3b3 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2197,7 +2197,7 @@
     multi_io_process_flags(c, c->c2.event_set, flags, &out_socket, &out_tu=
ntap);

 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
-    if (out_socket & EVENT_READ && c->c2.did_open_tun)
+    if (c->c1.tuntap)
     {
         dco_event_set(&c->c1.tuntap->dco, c->c2.event_set, (void *)dco_shi=
ft);
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1473?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idbd0a47ba4d297a833a350611a23f19fd9a797b5
Gerrit-Change-Number: 1473
Gerrit-PatchSet: 3
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gJmlFAT0fro=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1473?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Repair interaction between DCO and persist-tun a=
fter reconnection<br><br>When --persist-tun is active, openvpn userland on =
Linux and FreeBSD fails<br>to re-enable &quot;poll for DCO events&quot; aft=
er a reconnect (e.g. triggered by<br>a ping timeout).  The reconnect will s=
till work fine, but the *next*<br>DCO event notification from the kernel wi=
ll not be received by OpenVPN<br>userland, and so the system will get into =
an inconsistent state (Userland<br>assumes &quot;all is well&quot;, kernel =
DCO has disconnected the peer, connection<br>is broken until the next tls-r=
enegotion and/or manual restart, *and* the<br>next DCO key setup might fail=
 due to &quot;peer id gone&quot;).<br><br>This only affects client side, --=
server tun is always &quot;persistent&quot;, and<br>there is no &quot;full =
restart&quot; (and the code path in question is also<br>only used for clien=
t and p2p server).<br><br>The root cause is an incorrect check for &quot;is=
 this interface up?&quot; when<br>calling dco_event_set() in forard.c::io_w=
ait() - &quot;c2.did_open_tun&quot; is<br>only true if the tun interface wa=
s actually configured on this reconnect,<br>which it isn&#39;t if --persist=
-tun is active.  Replace with a check for<br>&quot;do we have a tuntap stru=
cture, and if yes, do we have active DCO?&quot;<br>which reflects the origi=
nal intent much better.<br><br>The original code also had a check for &quot=
;out_socket &amp; EVENT_READ&quot; there,<br>which did to some extend avoid=
 calling dco_event_set() for every single<br>UDP packet sent and received b=
y userland - but this only worked on initial<br>connection, and is always t=
rue on reconnect, so this condition was removed<br>for simplicity.  We shou=
ld come back here...<br><br>v2:<br>  - some language fixes on the commit me=
ssage<br>  - do not check -&gt;dco.open in forward.c, as this is not availa=
ble if<br>    not on FreeBSD, or if compiled with --disable-dco.<br>    Fre=
eBSD DCO does the &quot;if (!dco || !dco-&gt;open)&quot; check in dco_event=
_set()<br>    anyway, so it&#39;s not needed, and Linux DCO has &quot;dco-&=
gt;nl_sock&quot;, which is<br>    also reliably set/unset, and checked by d=
co_event_set() already.<br><br>Github: OpenVPN/openvpn#947<br><br>Change-Id=
: Idbd0a47ba4d297a833a350611a23f19fd9a797b5<br>Signed-off-by: Gert Doering =
&lt;gert@...1296...&gt;<br>Acked-by: Antonio Quartulli &lt;antonio@...2786...=
..&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1473<br>Messag=
e-Id: &lt;20260114112403.7046-1-gert@...1296...&gt;<br>URL: https://www.mai=
l-archive.com/openvpn-devel@lists.sourceforge.net/msg35239.html<br>Signed-o=
ff-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/forward=
.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><sp=
an>index d208c21..39ac3b3 100644</span><br><span>--- a/src/openvpn/forward.=
c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -2197,7 +2=
197,7 @@</span><br><span>     multi_io_process_flags(c, c-&gt;c2.event_set,=
 flags, &amp;out_socket, &amp;out_tuntap);</span><br><span> </span><br><spa=
n> #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (out_socket &amp; EVENT_READ &amp;=
&amp; c-&gt;c2.did_open_tun)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (c-&gt;c1.tuntap)</span><br><span>     {</span><br><span>  =
       dco_event_set(&amp;c-&gt;c1.tuntap-&gt;dco, c-&gt;c2.event_set, (voi=
d *)dco_shift);</span><br><span>     }</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1473?usp=3D=
email">change 1473</a>. To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1473?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idbd0a47ba4d297a833a350611a2=
3f19fd9a797b5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1473 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--gJmlFAT0fro=--


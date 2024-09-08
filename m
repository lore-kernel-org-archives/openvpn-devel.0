From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 8 Sep 2024 13:06:00 +0000
In-Reply-To: <gerrit.1723691967000.Ic6d63a319d272a56ac0e278f1356bc5241b56a34@...2715...>
References: <gerrit.1723691967000.Ic6d63a319d272a56ac0e278f1356bc5241b56a34@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5c908f95843ca8ce386288f9b4df400227ede977-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NTNdJeGhBMM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: proxy.c: Clear
 sensitive data after use
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selvanair <selva.nair@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--NTNdJeGhBMM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 selvanair. ( http://gerrit.openvpn.net/c/openvpn/+/727?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: proxy.c: Clear sensitive data after use
......................................................................

proxy.c: Clear sensitive data after use

Usage of credentials  is a bit odd in this file.
Actually the copy of "struct user_pass" kept in p->up is not
required at all. It just defeats the purpose of auth-nocahe
as it never gets cleared.

Removing it is beyond the scope of this patch -- we just ensure
it's purged after use.

Change-Id: Ic6d63a319d272a56ac0e278f1356bc5241b56a34
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240905100724.4105-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
061.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/proxy.c
1 file changed, 10 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/727/2

diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 5de0da4..eddacc9 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -247,7 +247,9 @@
     struct buffer out =3D alloc_buf_gc(strlen(p->up.username) + strlen(p->=
up.password) + 2, gc);
     ASSERT(strlen(p->up.username) > 0);
     buf_printf(&out, "%s:%s", p->up.username, p->up.password);
-    return (const char *)make_base64_string((const uint8_t *)BSTR(&out), g=
c);
+    char *ret =3D (char *)make_base64_string((const uint8_t *)BSTR(&out), =
gc);
+    secure_memzero(BSTR(&out), out.len);
+    return ret;
 }

 static void
@@ -736,6 +738,9 @@
                 ASSERT(0);
         }

+        /* clear any sensitive content in buf */
+        secure_memzero(buf, sizeof(buf));
+
         /* send empty CR, LF */
         if (!send_crlf(sd))
         {
@@ -983,6 +988,8 @@
                 {
                     goto error;
                 }
+                /* clear any sensitive content in buf */
+                secure_memzero(buf, sizeof(buf));

                 /* receive reply from proxy */
                 if (!recv_line(sd, buf, sizeof(buf), get_server_poll_remai=
ning_time(server_poll_timeout), true, NULL, signal_received))
@@ -1086,10 +1093,12 @@
 #endif

 done:
+    purge_user_pass(&p->up, true);
     gc_free(&gc);
     return ret;

 error:
+    purge_user_pass(&p->up, true);
     register_signal(sig_info, SIGUSR1, "HTTP proxy error"); /* SOFT-SIGUSR=
1 -- HTTP proxy error */
     gc_free(&gc);
     return ret;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/727?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic6d63a319d272a56ac0e278f1356bc5241b56a34
Gerrit-Change-Number: 727
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--NTNdJeGhBMM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by selvanair.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
727?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">proxy.c: Clear sensitive data after use<br><b=
r>Usage of credentials  is a bit odd in this file.<br>Actually the copy of =
&quot;struct user_pass&quot; kept in p-&gt;up is not<br>required at all. It=
 just defeats the purpose of auth-nocahe<br>as it never gets cleared.<br><b=
r>Removing it is beyond the scope of this patch -- we just ensure<br>it&#39=
;s purged after use.<br><br>Change-Id: Ic6d63a319d272a56ac0e278f1356bc5241b=
56a34<br>Signed-off-by: Selva Nair &lt;selva.nair@...277...&gt;<br>Acked-by=
: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;20240905100=
724.4105-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn=
-devel@lists.sourceforge.net/msg29061.html<br>Signed-off-by: Gert Doering &=
lt;gert@...1296...&gt;<br>---<br>M src/openvpn/proxy.c<br>1 file changed, 1=
0 insertions(+), 1 deletion(-)<br><br></pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/27/727/2</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/proxy.=
c b/src/openvpn/proxy.c</span><br><span>index 5de0da4..eddacc9 100644</span=
><br><span>--- a/src/openvpn/proxy.c</span><br><span>+++ b/src/openvpn/prox=
y.c</span><br><span>@@ -247,7 +247,9 @@</span><br><span>     struct buffer =
out =3D alloc_buf_gc(strlen(p-&gt;up.username) + strlen(p-&gt;up.password) =
+ 2, gc);</span><br><span>     ASSERT(strlen(p-&gt;up.username) &gt; 0);</s=
pan><br><span>     buf_printf(&amp;out, &quot;%s:%s&quot;, p-&gt;up.usernam=
e, p-&gt;up.password);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    return (const char *)make_base64_string((const uint8_t *)BSTR(&amp;out=
), gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *re=
t =3D (char *)make_base64_string((const uint8_t *)BSTR(&amp;out), gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    secure_memzero(BSTR(=
&amp;out), out.len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return ret;</span><br><span> }</span><br><span> </span><br><span> stat=
ic void</span><br><span>@@ -736,6 +738,9 @@</span><br><span>               =
  ASSERT(0);</span><br><span>         }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        /* clear any sensitive conten=
t in buf */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
secure_memzero(buf, sizeof(buf));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span>         /* send empty CR, LF */</span><br><=
span>         if (!send_crlf(sd))</span><br><span>         {</span><br><spa=
n>@@ -983,6 +988,8 @@</span><br><span>                 {</span><br><span>  =
                   goto error;</span><br><span>                 }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                /* clear any =
sensitive content in buf */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                secure_memzero(buf, sizeof(buf));</span><br><span> =
</span><br><span>                 /* receive reply from proxy */</span><br>=
<span>                 if (!recv_line(sd, buf, sizeof(buf), get_server_poll=
_remaining_time(server_poll_timeout), true, NULL, signal_received))</span><=
br><span>@@ -1086,10 +1093,12 @@</span><br><span> #endif</span><br><span> <=
/span><br><span> done:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    purge_user_pass(&amp;p-&gt;up, true);</span><br><span>     gc_free(&=
amp;gc);</span><br><span>     return ret;</span><br><span> </span><br><span=
> error:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    purge_u=
ser_pass(&amp;p-&gt;up, true);</span><br><span>     register_signal(sig_inf=
o, SIGUSR1, &quot;HTTP proxy error&quot;); /* SOFT-SIGUSR1 -- HTTP proxy er=
ror */</span><br><span>     gc_free(&amp;gc);</span><br><span>     return r=
et;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/727?usp=3Demail">change 727</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.or=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/727?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic6d63a319d272a56ac0e278f135=
6bc5241b56a34 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 727 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
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


--NTNdJeGhBMM=--


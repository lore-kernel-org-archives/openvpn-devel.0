From: "selvanair (Code Review)" <gerrit@...515...>
Date: Thu, 15 Aug 2024 03:19:31 +0000
References: <gerrit.1723691967000.Ic6d63a319d272a56ac0e278f1356bc5241b56a34@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ea76bd73ca4ffff1607e4082e054ca8087a5cf74-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MC6xJ/RV3Is="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--MC6xJ/RV3Is=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/727?usp=3Demail

to review the following change.


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
---
M src/openvpn/proxy.c
1 file changed, 10 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/727/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--MC6xJ/RV3Is=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>selvanair would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/727?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">proxy.c: Clear sensitive data after use<br><br>Usage of crede=
ntials  is a bit odd in this file.<br>Actually the copy of &quot;struct use=
r_pass&quot; kept in p-&gt;up is not<br>required at all. It just defeats th=
e purpose of auth-nocahe<br>as it never gets cleared.<br><br>Removing it is=
 beyond the scope of this patch -- we just ensure<br>it&#39;s purged after =
use.<br><br>Change-Id: Ic6d63a319d272a56ac0e278f1356bc5241b56a34<br>---<br>=
M src/openvpn/proxy.c<br>1 file changed, 10 insertions(+), 1 deletion(-)<br=
><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/727=
/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;"><span>diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c</span><br=
><span>index 5de0da4..eddacc9 100644</span><br><span>--- a/src/openvpn/prox=
y.c</span><br><span>+++ b/src/openvpn/proxy.c</span><br><span>@@ -247,7 +24=
7,9 @@</span><br><span>     struct buffer out =3D alloc_buf_gc(strlen(p-&gt=
;up.username) + strlen(p-&gt;up.password) + 2, gc);</span><br><span>     AS=
SERT(strlen(p-&gt;up.username) &gt; 0);</span><br><span>     buf_printf(&am=
p;out, &quot;%s:%s&quot;, p-&gt;up.username, p-&gt;up.password);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    return (const char *)make_ba=
se64_string((const uint8_t *)BSTR(&amp;out), gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    char *ret =3D (char *)make_base64_string(=
(const uint8_t *)BSTR(&amp;out), gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    secure_memzero(BSTR(&amp;out), out.len);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span>=
 }</span><br><span> </span><br><span> static void</span><br><span>@@ -736,6=
 +738,9 @@</span><br><span>                 ASSERT(0);</span><br><span>    =
     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        /* clear any sensitive content in buf */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        secure_memzero(buf, sizeof(buf));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>  =
       /* send empty CR, LF */</span><br><span>         if (!send_crlf(sd))=
</span><br><span>         {</span><br><span>@@ -983,6 +988,8 @@</span><br><=
span>                 {</span><br><span>                     goto error;</s=
pan><br><span>                 }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                /* clear any sensitive content in buf */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                secure_me=
mzero(buf, sizeof(buf));</span><br><span> </span><br><span>                =
 /* receive reply from proxy */</span><br><span>                 if (!recv_=
line(sd, buf, sizeof(buf), get_server_poll_remaining_time(server_poll_timeo=
ut), true, NULL, signal_received))</span><br><span>@@ -1086,10 +1093,12 @@<=
/span><br><span> #endif</span><br><span> </span><br><span> done:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    purge_user_pass(&amp;p-&gt=
;up, true);</span><br><span>     gc_free(&amp;gc);</span><br><span>     ret=
urn ret;</span><br><span> </span><br><span> error:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    purge_user_pass(&amp;p-&gt;up, true);</s=
pan><br><span>     register_signal(sig_info, SIGUSR1, &quot;HTTP proxy erro=
r&quot;); /* SOFT-SIGUSR1 -- HTTP proxy error */</span><br><span>     gc_fr=
ee(&amp;gc);</span><br><span>     return ret;</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/727?=
usp=3Demail">change 727</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/727?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic6d63a319d272a56ac0e278f135=
6bc5241b56a34 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 727 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--MC6xJ/RV3Is=--


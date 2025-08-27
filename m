From: "stipa (Code Review)" <gerrit@...515...>
Date: Wed, 27 Aug 2025 11:50:25 +0000
References: <gerrit.1756295422000.I7bc7de284fdbfd4be26a907ecd5c21c075bc5ac4@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a585b5370a0e02bf7ddbe7daa24c269447413fae-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dAxXhy6aXn8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Don't call bytecount
 client logic in server mode
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

--dAxXhy6aXn8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1157?usp=3Demail

to review the following change.


Change subject: Don't call bytecount client logic in server mode
......................................................................

Don't call bytecount client logic in server mode

Calling this in server mode is wrong because:

 - we only output those counters via management interface
 (>BYTECOUT:) in client mode, so in server mode this is no-op

 - the timer callback to fetch DCO stats is triggerer
 independenty for each peer. It is a waste of resources in server mode
 where we could fetch stats for all peers with the single ioctl.

Change-Id: I7bc7de284fdbfd4be26a907ecd5c21c075bc5ac4
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/forward.c
M src/openvpn/manage.c
M src/openvpn/manage.h
3 files changed, 5 insertions(+), 8 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/57/1157/1

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 75ca9d5..e8bdf35 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -818,7 +818,7 @@
 #ifdef ENABLE_MANAGEMENT
     if (management)
     {
-        management_check_bytecount(c, management, &c->c2.timeval);
+        management_check_bytecount_client(c, management, &c->c2.timeval);
     }
 #endif /* ENABLE_MANAGEMENT */
 }
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index aed04f5..f057fb2 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -4065,9 +4065,9 @@
 }

 void
-management_check_bytecount(struct context *c, struct management *man, stru=
ct timeval *timeval)
+management_check_bytecount_client(struct context *c, struct management *ma=
n, struct timeval *timeval)
 {
-    if (event_timeout_trigger(&man->connection.bytecount_update_interval, =
timeval, ETT_DEFAULT))
+    if (!(man->persist.callback.flags & MCF_SERVER) && event_timeout_trigg=
er(&man->connection.bytecount_update_interval, timeval, ETT_DEFAULT))
     {
         counter_type dco_read_bytes =3D 0;
         counter_type dco_write_bytes =3D 0;
@@ -4083,10 +4083,7 @@
             dco_write_bytes =3D c->c2.dco_write_bytes;
         }

-        if (!(man->persist.callback.flags & MCF_SERVER))
-        {
-            man_bytecount_output_client(man, dco_read_bytes, dco_write_byt=
es);
-        }
+        man_bytecount_output_client(man, dco_read_bytes, dco_write_bytes);
     }
 }

diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 083caf5..038691f 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -492,7 +492,7 @@
  * These functions drive the bytecount in/out counters.
  */

-void management_check_bytecount(struct context *c, struct management *man,=
 struct timeval *timeval);
+void management_check_bytecount_client(struct context *c, struct managemen=
t *man, struct timeval *timeval);

 static inline void
 management_bytes_client(struct management *man, const int size_in, const i=
nt size_out)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1157?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7bc7de284fdbfd4be26a907ecd5c21c075bc5ac4
Gerrit-Change-Number: 1157
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--dAxXhy6aXn8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1157?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Don&#39;t call bytecount client logic in server mode<br><br>=
Calling this in server mode is wrong because:<br><br> - we only output thos=
e counters via management interface<br> (&gt;BYTECOUT:) in client mode, so =
in server mode this is no-op<br><br> - the timer callback to fetch DCO stat=
s is triggerer<br> independenty for each peer. It is a waste of resources i=
n server mode<br> where we could fetch stats for all peers with the single =
ioctl.<br><br>Change-Id: I7bc7de284fdbfd4be26a907ecd5c21c075bc5ac4<br>Signe=
d-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>M src/openvpn/forwar=
d.c<br>M src/openvpn/manage.c<br>M src/openvpn/manage.h<br>3 files changed,=
 5 insertions(+), 8 deletions(-)<br><br></pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.ne=
t:29418/openvpn refs/changes/57/1157/1</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/for=
ward.c b/src/openvpn/forward.c</span><br><span>index 75ca9d5..e8bdf35 10064=
4</span><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/ope=
nvpn/forward.c</span><br><span>@@ -818,7 +818,7 @@</span><br><span> #ifdef =
ENABLE_MANAGEMENT</span><br><span>     if (management)</span><br><span>    =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        management_=
check_bytecount(c, management, &amp;c-&gt;c2.timeval);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        management_check_bytecount_clien=
t(c, management, &amp;c-&gt;c2.timeval);</span><br><span>     }</span><br><=
span> #endif /* ENABLE_MANAGEMENT */</span><br><span> }</span><br><span>dif=
f --git a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><span>index=
 aed04f5..f057fb2 100644</span><br><span>--- a/src/openvpn/manage.c</span><=
br><span>+++ b/src/openvpn/manage.c</span><br><span>@@ -4065,9 +4065,9 @@</=
span><br><span> }</span><br><span> </span><br><span> void</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-management_check_bytecount(struct conte=
xt *c, struct management *man, struct timeval *timeval)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+management_check_bytecount_client(struc=
t context *c, struct management *man, struct timeval *timeval)</span><br><s=
pan> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (event_t=
imeout_trigger(&amp;man-&gt;connection.bytecount_update_interval, timeval, =
ETT_DEFAULT))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (!(man-&gt;persist.callback.flags &amp; MCF_SERVER) &amp;&amp; event_timeo=
ut_trigger(&amp;man-&gt;connection.bytecount_update_interval, timeval, ETT_=
DEFAULT))</span><br><span>     {</span><br><span>         counter_type dco_=
read_bytes =3D 0;</span><br><span>         counter_type dco_write_bytes =3D=
 0;</span><br><span>@@ -4083,10 +4083,7 @@</span><br><span>             dco=
_write_bytes =3D c-&gt;c2.dco_write_bytes;</span><br><span>         }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (!(man-&gt;persist.callback.flags &amp; MCF_SERVER))</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            man_bytecount_output_client(man, dco_read_=
bytes, dco_write_bytes);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 man_bytecount_output_client(man, dco_read_bytes, dco_write_bytes);</span><=
br><span>     }</span><br><span> }</span><br><span> </span><br><span>diff -=
-git a/src/openvpn/manage.h b/src/openvpn/manage.h</span><br><span>index 08=
3caf5..038691f 100644</span><br><span>--- a/src/openvpn/manage.h</span><br>=
<span>+++ b/src/openvpn/manage.h</span><br><span>@@ -492,7 +492,7 @@</span>=
<br><span>  * These functions drive the bytecount in/out counters.</span><b=
r><span>  */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-void management_check_bytecount(struct context *c, struct manageme=
nt *man, struct timeval *timeval);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void management_check_bytecount_client(struct context *c, st=
ruct management *man, struct timeval *timeval);</span><br><span> </span><br=
><span> static inline void</span><br><span> management_bytes_client(struct =
management *man, const int size_in, const int size_out)</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1157?usp=3Demail">change 1157</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1157?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7bc7de284fdbfd4be26a907ecd5=
c21c075bc5ac4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1157 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
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


--dAxXhy6aXn8=--


From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 21 Oct 2025 16:17:49 +0000
References: <gerrit.1761063467000.I76babf08b041162ddedf7a9b7c2799847f15cbdc@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <3bf85336bb3e940b3580866d4acdc5aa66257a68-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/AJ/IelNSlE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi: Fix wrong
 usage of mroute_extract_openvpn_sockaddr
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

--/AJ/IelNSlE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1292?usp=3Demail

to review the following change.


Change subject: multi: Fix wrong usage of mroute_extract_openvpn_sockaddr
......................................................................

multi: Fix wrong usage of mroute_extract_openvpn_sockaddr

maddr.proto needs to be set before the call since that
will change the behavior.

Found by GCC "'maddr.proto' is used uninitialized"

Change-Id: I76babf08b041162ddedf7a9b7c2799847f15cbdc
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/multi.c
M src/openvpn/push.c
M src/openvpn/ssl_verify.c
3 files changed, 16 insertions(+), 20 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/92/1292/1

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index e907524..fa9c654 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3965,9 +3965,9 @@
     saddr.addr.in4.sin_family =3D AF_INET;
     saddr.addr.in4.sin_addr.s_addr =3D htonl(addr);
     saddr.addr.in4.sin_port =3D htons(port);
+    maddr.proto =3D proto;
     if (mroute_extract_openvpn_sockaddr(&maddr, &saddr, true))
     {
-        maddr.proto =3D proto;
         hash_iterator_init(m->iter, &hi);
         while ((he =3D hash_iterator_next(&hi)))
         {
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 2c717c7..1871816 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -429,11 +429,6 @@
     gc_free(&gc);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 bool
 send_auth_pending_messages(struct tls_multi *tls_multi, struct tls_session=
 *session,
                            const char *extra, unsigned int timeout)
@@ -449,7 +444,12 @@
     /* Calculate the maximum timeout and subtract the time we already wait=
ed */
     unsigned int max_timeout =3D
         max_uint(tls_multi->opt.renegotiate_seconds / 2, tls_multi->opt.ha=
ndshake_window);
-    max_timeout =3D max_timeout - (now - ks->initial);
+    time_t time_elapsed =3D now - ks->initial;
+    if (time_elapsed < 0 || time_elapsed >=3D (time_t)max_timeout)
+    {
+        return false;
+    }
+    max_timeout -=3D (unsigned int)time_elapsed;
     timeout =3D min_uint(max_timeout, timeout);

     struct gc_arena gc =3D gc_new();
@@ -734,6 +734,11 @@
     return true;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static bool
 send_push_options(struct context *c, struct buffer *buf, struct push_list =
*push_list, int safe_cap,
                   bool *push_sent, bool *multi_push)
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 04ef27e..fe95621 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -874,11 +874,6 @@
     return supported;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /**
  *  Checks if the deferred state should also send auth pending
  *  request to the client. Also removes the auth_pending control file
@@ -915,8 +910,9 @@
             buf_chomp(iv_buf);
             buf_chomp(extra_buf);

+            errno =3D 0;
             long timeout =3D strtol(BSTR(timeout_buf), NULL, 10);
-            if (timeout =3D=3D 0)
+            if (timeout <=3D 0 || timeout > UINT_MAX || errno)
             {
                 msg(M_WARN, "could not parse auth pending file timeout");
                 buffer_list_free(lines);
@@ -933,14 +929,13 @@
                          pending_method);
                 auth_set_client_reason(multi, buf);
                 msg(M_INFO,
-                    "Client does not supported auth pending method "
-                    "'%s'",
+                    "Client does not supported auth pending method '%s'",
                     pending_method);
                 ret =3D false;
             }
             else
             {
-                send_auth_pending_messages(multi, session, BSTR(extra_buf)=
, timeout);
+                send_auth_pending_messages(multi, session, BSTR(extra_buf)=
, (unsigned int)timeout);
             }
         }

@@ -950,10 +945,6 @@
     return ret;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /**
  *  Removes auth_pending and auth_control files from file system
  *  and key_state structure

--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1292?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I76babf08b041162ddedf7a9b7c2799847f15cbdc
Gerrit-Change-Number: 1292
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--/AJ/IelNSlE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1292?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">multi: Fix wrong usage of mroute_extract_op=
envpn_sockaddr<br><br>maddr.proto needs to be set before the call since tha=
t<br>will change the behavior.<br><br>Found by GCC &quot;&#39;maddr.proto&#=
39; is used uninitialized&quot;<br><br>Change-Id: I76babf08b041162ddedf7a9b=
7c2799847f15cbdc<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&g=
t;<br>---<br>M src/openvpn/multi.c<br>M src/openvpn/push.c<br>M src/openvpn=
/ssl_verify.c<br>3 files changed, 16 insertions(+), 20 deletions(-)<br><br>=
</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/ch=
anges/92/1292/1</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/src/openvpn/multi.c b/src/openvpn/mult=
i.c</span><br><span>index e907524..fa9c654 100644</span><br><span>--- a/src=
/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>=
@@ -3965,9 +3965,9 @@</span><br><span>     saddr.addr.in4.sin_family =3D AF=
_INET;</span><br><span>     saddr.addr.in4.sin_addr.s_addr =3D htonl(addr);=
</span><br><span>     saddr.addr.in4.sin_port =3D htons(port);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    maddr.proto =3D proto;</span=
><br><span>     if (mroute_extract_openvpn_sockaddr(&amp;maddr, &amp;saddr,=
 true))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        maddr.proto =3D proto;</span><br><span>         hash_itera=
tor_init(m-&gt;iter, &amp;hi);</span><br><span>         while ((he =3D hash=
_iterator_next(&amp;hi)))</span><br><span>         {</span><br><span>diff -=
-git a/src/openvpn/push.c b/src/openvpn/push.c</span><br><span>index 2c717c=
7..1871816 100644</span><br><span>--- a/src/openvpn/push.c</span><br><span>=
+++ b/src/openvpn/push.c</span><br><span>@@ -429,11 +429,6 @@</span><br><sp=
an>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(_=
_clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC =
diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragm=
a GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span> bool</span><br><span> send_auth_pending_mess=
ages(struct tls_multi *tls_multi, struct tls_session *session,</span><br><s=
pan>                            const char *extra, unsigned int timeout)</s=
pan><br><span>@@ -449,7 +444,12 @@</span><br><span>     /* Calculate the ma=
ximum timeout and subtract the time we already waited */</span><br><span>  =
   unsigned int max_timeout =3D</span><br><span>         max_uint(tls_multi=
-&gt;opt.renegotiate_seconds / 2, tls_multi-&gt;opt.handshake_window);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    max_timeout =3D max_ti=
meout - (now - ks-&gt;initial);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    time_t time_elapsed =3D now - ks-&gt;initial;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (time_elapsed &lt; 0 || ti=
me_elapsed &gt;=3D (time_t)max_timeout)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return false;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ma=
x_timeout -=3D (unsigned int)time_elapsed;</span><br><span>     timeout =3D=
 min_uint(max_timeout, timeout);</span><br><span> </span><br><span>     str=
uct gc_arena gc =3D gc_new();</span><br><span>@@ -734,6 +734,11 @@</span><b=
r><span>     return true;</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined=
(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma =
GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> static bool</span><br><span> send_=
push_options(struct context *c, struct buffer *buf, struct push_list *push_=
list, int safe_cap,</span><br><span>                   bool *push_sent, boo=
l *multi_push)</span><br><span>diff --git a/src/openvpn/ssl_verify.c b/src/=
openvpn/ssl_verify.c</span><br><span>index 04ef27e..fe95621 100644</span><b=
r><span>--- a/src/openvpn/ssl_verify.c</span><br><span>+++ b/src/openvpn/ss=
l_verify.c</span><br><span>@@ -874,11 +874,6 @@</span><br><span>     return=
 supported;</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pus=
h</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnost=
ic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span> /**</span><br><span>  *  Checks if the deferred state shou=
ld also send auth pending</span><br><span>  *  request to the client. Also =
removes the auth_pending control file</span><br><span>@@ -915,8 +910,9 @@</=
span><br><span>             buf_chomp(iv_buf);</span><br><span>            =
 buf_chomp(extra_buf);</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            errno =3D 0;</span><br><span>             =
long timeout =3D strtol(BSTR(timeout_buf), NULL, 10);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (timeout =3D=3D 0)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            if (timeout &lt;=
=3D 0 || timeout &gt; UINT_MAX || errno)</span><br><span>             {</sp=
an><br><span>                 msg(M_WARN, &quot;could not parse auth pendin=
g file timeout&quot;);</span><br><span>                 buffer_list_free(li=
nes);</span><br><span>@@ -933,14 +929,13 @@</span><br><span>               =
           pending_method);</span><br><span>                 auth_set_clien=
t_reason(multi, buf);</span><br><span>                 msg(M_INFO,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                    &quot;Clie=
nt does not supported auth pending method &quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                    &quot;&#39;%s&#39;&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    &q=
uot;Client does not supported auth pending method &#39;%s&#39;&quot;,</span=
><br><span>                     pending_method);</span><br><span>          =
       ret =3D false;</span><br><span>             }</span><br><span>      =
       else</span><br><span>             {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                send_auth_pending_messages(multi, sess=
ion, BSTR(extra_buf), timeout);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                send_auth_pending_messages(multi, session, BSTR=
(extra_buf), (unsigned int)timeout);</span><br><span>             }</span><=
br><span>         }</span><br><span> </span><br><span>@@ -950,10 +945,6 @@<=
/span><br><span>     return ret;</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || de=
fined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#prag=
ma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n> /**</span><br><span>  *  Removes auth_pending and auth_control files fro=
m file system</span><br><span>  *  and key_state structure</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1292?usp=3Demail">change 1292</a>. To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1292?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I76babf08b041162ddedf7a9b7c2=
799847f15cbdc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1292 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--/AJ/IelNSlE=--


From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 15 Jan 2026 09:39:04 +0000
In-Reply-To: <gerrit.1766154207000.I8a5efb2ed009a702f10dc8f40c677f014547b4c8@...2715...>
References: <gerrit.1766154207000.I8a5efb2ed009a702f10dc8f40c677f014547b4c8@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <204e2256f90731a5c5968cdc9cf8946d2f51f51d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dSgMFcKa5Lg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_verify: Fix
 parsing of timeout from auth pending file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--dSgMFcKa5Lg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
51?usp=3Demail )

Change subject: ssl_verify: Fix parsing of timeout from auth pending file
......................................................................

ssl_verify: Fix parsing of timeout from auth pending file

Make sure the value is not negative before casting
it to unsigned.

Change-Id: I8a5efb2ed009a702f10dc8f40c677f014547b4c8
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1451
Message-Id: <20260115093235.25635-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
275.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_verify.c
1 file changed, 6 insertions(+), 14 deletions(-)




diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index a3ba66e..0b02a2f 100644
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
@@ -888,7 +883,8 @@
  *  @returns false  The file had an invlaid format or another error occured
  */
 static bool
-key_state_check_auth_pending_file(struct auth_deferred_status *ads, struct=
 tls_multi *multi,
+key_state_check_auth_pending_file(struct auth_deferred_status *ads,
+                                  struct tls_multi *multi,
                                   struct tls_session *session)
 {
     bool ret =3D true;
@@ -916,7 +912,7 @@
             buf_chomp(extra_buf);

             long timeout =3D strtol(BSTR(timeout_buf), NULL, 10);
-            if (timeout =3D=3D 0)
+            if (timeout <=3D 0)
             {
                 msg(M_WARN, "could not parse auth pending file timeout");
                 buffer_list_free(lines);
@@ -933,14 +929,14 @@
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
+                send_auth_pending_messages(multi, session, BSTR(extra_buf),
+                                           (unsigned int)timeout);
             }
         }

@@ -950,10 +946,6 @@
     return ret;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /**
  *  Removes auth_pending and auth_control files from file system
  *  and key_state structure

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1451?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8a5efb2ed009a702f10dc8f40c677f014547b4c8
Gerrit-Change-Number: 1451
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--dSgMFcKa5Lg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1451?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">ssl_verify: Fix parsing of timeout from auth pen=
ding file<br><br>Make sure the value is not negative before casting<br>it t=
o unsigned.<br><br>Change-Id: I8a5efb2ed009a702f10dc8f40c677f014547b4c8<br>=
Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert=
 Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/=
c/openvpn/+/1451<br>Message-Id: &lt;20260115093235.25635-1-gert@...1296...&=
gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...475...=
t/msg35275.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>-=
--<br>M src/openvpn/ssl_verify.c<br>1 file changed, 6 insertions(+), 14 del=
etions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c</span><=
br><span>index a3ba66e..0b02a2f 100644</span><br><span>--- a/src/openvpn/ss=
l_verify.c</span><br><span>+++ b/src/openvpn/ssl_verify.c</span><br><span>@=
@ -874,11 +874,6 @@</span><br><span>     return supported;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversio=
n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><=
br><span>  *  Checks if the deferred state should also send auth pending</s=
pan><br><span>  *  request to the client. Also removes the auth_pending con=
trol file</span><br><span>@@ -888,7 +883,8 @@</span><br><span>  *  @returns=
 false  The file had an invlaid format or another error occured</span><br><=
span>  */</span><br><span> static bool</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-key_state_check_auth_pending_file(struct auth_deferred_sta=
tus *ads, struct tls_multi *multi,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+key_state_check_auth_pending_file(struct auth_deferred_statu=
s *ads,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                      struct tls_multi *multi,</span><br><span>            =
                       struct tls_session *session)</span><br><span> {</spa=
n><br><span>     bool ret =3D true;</span><br><span>@@ -916,7 +912,7 @@</sp=
an><br><span>             buf_chomp(extra_buf);</span><br><span> </span><br=
><span>             long timeout =3D strtol(BSTR(timeout_buf), NULL, 10);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (timeout=
 =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   if (timeout &lt;=3D 0)</span><br><span>             {</span><br><span>  =
               msg(M_WARN, &quot;could not parse auth pending file timeout&=
quot;);</span><br><span>                 buffer_list_free(lines);</span><br=
><span>@@ -933,14 +929,14 @@</span><br><span>                          pend=
ing_method);</span><br><span>                 auth_set_client_reason(multi,=
 buf);</span><br><span>                 msg(M_INFO,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    &quot;Client does not s=
upported auth pending method &quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                    &quot;&#39;%s&#39;&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                    &quot;Client do=
es not supported auth pending method &#39;%s&#39;&quot;,</span><br><span>  =
                   pending_method);</span><br><span>                 ret =
=3D false;</span><br><span>             }</span><br><span>             else=
</span><br><span>             {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                send_auth_pending_messages(multi, session, BSTR(e=
xtra_buf), timeout);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                send_auth_pending_messages(multi, session, BSTR(extra_buf)=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
                         (unsigned int)timeout);</span><br><span>          =
   }</span><br><span>         }</span><br><span> </span><br><span>@@ -950,1=
0 +946,6 @@</span><br><span>     return ret;</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__G=
NUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span> /**</span><br><span>  *  Removes auth_pending and auth_contr=
ol files from file system</span><br><span>  *  and key_state structure</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1451?usp=3Demail">change 1451</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1451?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8a5efb2ed009a702f10dc8f40c6=
77f014547b4c8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1451 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--dSgMFcKa5Lg=--


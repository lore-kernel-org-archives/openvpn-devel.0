From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 19 Dec 2025 14:23:30 +0000
References: <gerrit.1766154207000.I8a5efb2ed009a702f10dc8f40c677f014547b4c8@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <720edc163352e9f1fb3f349dd5701894a85ed473-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NxE18poGBsk="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--NxE18poGBsk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1451?usp=3Demail

to review the following change.


Change subject: ssl_verify: Fix parsing of timeout from auth pending file
......................................................................

ssl_verify: Fix parsing of timeout from auth pending file

Make sure the value is not negative before casting
it to unsigned.

Change-Id: I8a5efb2ed009a702f10dc8f40c677f014547b4c8
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/ssl_verify.c
1 file changed, 6 insertions(+), 14 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/51/1451/1

diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index a11003c..5effa2c 100644
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8a5efb2ed009a702f10dc8f40c677f014547b4c8
Gerrit-Change-Number: 1451
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--NxE18poGBsk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1451?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">ssl_verify: Fix parsing of timeout from aut=
h pending file<br><br>Make sure the value is not negative before casting<br=
>it to unsigned.<br><br>Change-Id: I8a5efb2ed009a702f10dc8f40c677f014547b4c=
8<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M =
src/openvpn/ssl_verify.c<br>1 file changed, 6 insertions(+), 14 deletions(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvp=
n refs/changes/51/1451/1</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_verify.c b/sr=
c/openvpn/ssl_verify.c</span><br><span>index a11003c..5effa2c 100644</span>=
<br><span>--- a/src/openvpn/ssl_verify.c</span><br><span>+++ b/src/openvpn/=
ssl_verify.c</span><br><span>@@ -874,11 +874,6 @@</span><br><span>     retu=
rn supported;</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic p=
ush</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagno=
stic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> /**</span><br><span>  *  Checks if the deferred state sh=
ould also send auth pending</span><br><span>  *  request to the client. Als=
o removes the auth_pending control file</span><br><span>@@ -888,7 +883,8 @@=
</span><br><span>  *  @returns false  The file had an invlaid format or ano=
ther error occured</span><br><span>  */</span><br><span> static bool</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-key_state_check_auth_pending=
_file(struct auth_deferred_status *ads, struct tls_multi *multi,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+key_state_check_auth_pending_f=
ile(struct auth_deferred_status *ads,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                  struct tls_multi *multi=
,</span><br><span>                                   struct tls_session *se=
ssion)</span><br><span> {</span><br><span>     bool ret =3D true;</span><br=
><span>@@ -916,7 +912,7 @@</span><br><span>             buf_chomp(extra_buf=
);</span><br><span> </span><br><span>             long timeout =3D strtol(B=
STR(timeout_buf), NULL, 10);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            if (timeout =3D=3D 0)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            if (timeout &lt;=3D 0)</span><br><span>   =
          {</span><br><span>                 msg(M_WARN, &quot;could not pa=
rse auth pending file timeout&quot;);</span><br><span>                 buff=
er_list_free(lines);</span><br><span>@@ -933,14 +929,14 @@</span><br><span>=
                          pending_method);</span><br><span>                =
 auth_set_client_reason(multi, buf);</span><br><span>                 msg(M=
_INFO,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
     &quot;Client does not supported auth pending method &quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    &quot;&#39;%s=
&#39;&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             &quot;Client does not supported auth pending method &#39;%s&#3=
9;&quot;,</span><br><span>                     pending_method);</span><br><=
span>                 ret =3D false;</span><br><span>             }</span><=
br><span>             else</span><br><span>             {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                send_auth_pending_messa=
ges(multi, session, BSTR(extra_buf), timeout);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                send_auth_pending_messages(multi=
, session, BSTR(extra_buf),</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                                           (unsigned int)timeout);<=
/span><br><span>             }</span><br><span>         }</span><br><span> =
</span><br><span>@@ -950,10 +946,6 @@</span><br><span>     return ret;</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span>  *  Removes a=
uth_pending and auth_control files from file system</span><br><span>  *  an=
d key_state structure</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/1451?usp=3Demail">change 145=
1</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1451?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8a5efb2ed009a702f10dc8f40c6=
77f014547b4c8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1451 </div>
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

--NxE18poGBsk=--


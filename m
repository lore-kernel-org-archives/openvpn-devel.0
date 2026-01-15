From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 15 Jan 2026 09:39:02 +0000
In-Reply-To: <gerrit.1766154207000.I8a5efb2ed009a702f10dc8f40c677f014547b4c8@...2715...>
References: <gerrit.1766154207000.I8a5efb2ed009a702f10dc8f40c677f014547b4c8@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <204e2256f90731a5c5968cdc9cf8946d2f51f51d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BDa9Mfwq9ak="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--BDa9Mfwq9ak=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1451?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/51/1451/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8a5efb2ed009a702f10dc8f40c677f014547b4c8
Gerrit-Change-Number: 1451
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--BDa9Mfwq9ak=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1451?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">ssl_verify: Fix parsing of timeout =
from auth pending file<br><br>Make sure the value is not negative before ca=
sting<br>it to unsigned.<br><br>Change-Id: I8a5efb2ed009a702f10dc8f40c677f0=
14547b4c8<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>A=
cked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit=
.openvpn.net/c/openvpn/+/1451<br>Message-Id: &lt;20260115093235.25635-1-ger=
t@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1096...=
ourceforge.net/msg35275.html<br>Signed-off-by: Gert Doering &lt;gert@...1826...=
6...&gt;<br>---<br>M src/openvpn/ssl_verify.c<br>1 file changed, 6 insertio=
ns(+), 14 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.ope=
nvpn.net:29418/openvpn refs/changes/51/1451/2</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/open=
vpn/ssl_verify.c b/src/openvpn/ssl_verify.c</span><br><span>index a3ba66e..=
0b02a2f 100644</span><br><span>--- a/src/openvpn/ssl_verify.c</span><br><sp=
an>+++ b/src/openvpn/ssl_verify.c</span><br><span>@@ -874,11 +874,6 @@</spa=
n><br><span>     return supported;</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || =
defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pr=
agma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span>  *  Checks if =
the deferred state should also send auth pending</span><br><span>  *  reque=
st to the client. Also removes the auth_pending control file</span><br><spa=
n>@@ -888,7 +883,8 @@</span><br><span>  *  @returns false  The file had an =
invlaid format or another error occured</span><br><span>  */</span><br><spa=
n> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-key_sta=
te_check_auth_pending_file(struct auth_deferred_status *ads, struct tls_mul=
ti *multi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+key_state=
_check_auth_pending_file(struct auth_deferred_status *ads,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                  st=
ruct tls_multi *multi,</span><br><span>                                   s=
truct tls_session *session)</span><br><span> {</span><br><span>     bool re=
t =3D true;</span><br><span>@@ -916,7 +912,7 @@</span><br><span>           =
  buf_chomp(extra_buf);</span><br><span> </span><br><span>             long=
 timeout =3D strtol(BSTR(timeout_buf), NULL, 10);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            if (timeout =3D=3D 0)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if (timeout &lt;=3D 0=
)</span><br><span>             {</span><br><span>                 msg(M_WAR=
N, &quot;could not parse auth pending file timeout&quot;);</span><br><span>=
                 buffer_list_free(lines);</span><br><span>@@ -933,14 +929,1=
4 @@</span><br><span>                          pending_method);</span><br><=
span>                 auth_set_client_reason(multi, buf);</span><br><span> =
                msg(M_INFO,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                    &quot;Client does not supported auth pending meth=
od &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
        &quot;&#39;%s&#39;&quot;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    &quot;Client does not supported auth pend=
ing method &#39;%s&#39;&quot;,</span><br><span>                     pending=
_method);</span><br><span>                 ret =3D false;</span><br><span> =
            }</span><br><span>             else</span><br><span>           =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                se=
nd_auth_pending_messages(multi, session, BSTR(extra_buf), timeout);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                send_auth_p=
ending_messages(multi, session, BSTR(extra_buf),</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                           (un=
signed int)timeout);</span><br><span>             }</span><br><span>       =
  }</span><br><span> </span><br><span>@@ -950,10 +946,6 @@</span><br><span>=
     return ret;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br=
><span>  *  Removes auth_pending and auth_control files from file system</s=
pan><br><span>  *  and key_state structure</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1451?us=
p=3Demail">change 1451</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1451?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--BDa9Mfwq9ak=--


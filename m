From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 29 Oct 2025 13:17:15 +0000
References: <gerrit.1761743833000.I6c502508026c6b85bb092ada4d16d985b20dd41f@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <0a0d2a0ddb850b8564a772236320f422add9257d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1tx5lnyQsaE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: clean up environment
 variable handling in verify_user_pass_script
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--1tx5lnyQsaE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1326?usp=3Demail

to review the following change.


Change subject: clean up environment variable handling in verify_user_pass_=
script
......................................................................

clean up environment variable handling in verify_user_pass_script

The username environment variable is already set by the
set_verify_user_pass_env function before the verify_user_pass_script
function is called, so this call is not doing anything but might erroneously
made people think that this needs to be cleaned up.

Also ensure that the password is clean from the env even in an error case.

Reported-by: Joshua Rogers <contact@...2949...>
Found-by: ZeroPath (https://zeropath.com/)
Change-Id: I6c502508026c6b85bb092ada4d16d985b20dd41f
---
M src/openvpn/ssl_verify.c
1 file changed, 6 insertions(+), 5 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/26/1326/1

diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 04ef27e..993d22c 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1329,7 +1329,7 @@
     }
     else
     {
-        setenv_str(session->opt->es, "username", up->username);
+        /* username env is already set by set_verify_user_pass_env */
         setenv_str(session->opt->es, "password", up->password);
     }

@@ -1377,10 +1377,6 @@
         /* purge auth control filename (and file itself) for non-deferred =
returns */
         key_state_rm_auth_control_files(&ks->script_auth);
     }
-    if (!session->opt->auth_user_pass_verify_script_via_file)
-    {
-        setenv_del(session->opt->es, "password");
-    }

 done:
     if (tmp_file && strlen(tmp_file) > 0)
@@ -1389,6 +1385,11 @@
     }

 error:
+    if (!session->opt->auth_user_pass_verify_script_via_file)
+    {
+        setenv_del(session->opt->es, "password");
+    }
+
     argv_free(&argv);
     gc_free(&gc);
     return retval;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1326?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6c502508026c6b85bb092ada4d16d985b20dd41f
Gerrit-Change-Number: 1326
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>

--1tx5lnyQsaE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1326?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">clean up environment variable handling in v=
erify_user_pass_script<br><br>The username environment variable is already =
set by the<br>set_verify_user_pass_env function before the verify_user_pass=
_script<br>function is called, so this call is not doing anything but might=
 erroneously<br>made people think that this needs to be cleaned up.<br><br>=
Also ensure that the password is clean from the env even in an error case.<=
br><br>Reported-by: Joshua Rogers &lt;contact@...2949...&gt;<br>Found-by: Z=
eroPath (https://zeropath.com/)<br>Change-Id: I6c502508026c6b85bb092ada4d16=
d985b20dd41f<br>---<br>M src/openvpn/ssl_verify.c<br>1 file changed, 6 inse=
rtions(+), 5 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.=
openvpn.net:29418/openvpn refs/changes/26/1326/1</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/ssl_verify.c b/src/openvpn/ssl_verify.c</span><br><span>index 04ef27=
e..993d22c 100644</span><br><span>--- a/src/openvpn/ssl_verify.c</span><br>=
<span>+++ b/src/openvpn/ssl_verify.c</span><br><span>@@ -1329,7 +1329,7 @@<=
/span><br><span>     }</span><br><span>     else</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        setenv_str(sessio=
n-&gt;opt-&gt;es, &quot;username&quot;, up-&gt;username);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        /* username env is already se=
t by set_verify_user_pass_env */</span><br><span>         setenv_str(sessio=
n-&gt;opt-&gt;es, &quot;password&quot;, up-&gt;password);</span><br><span> =
    }</span><br><span> </span><br><span>@@ -1377,10 +1377,6 @@</span><br><s=
pan>         /* purge auth control filename (and file itself) for non-defer=
red returns */</span><br><span>         key_state_rm_auth_control_files(&am=
p;ks-&gt;script_auth);</span><br><span>     }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (!session-&gt;opt-&gt;auth_user_pass_verify_=
script_via_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        setenv_del(se=
ssion-&gt;opt-&gt;es, &quot;password&quot;);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span> </span><br><span> done:</span=
><br><span>     if (tmp_file &amp;&amp; strlen(tmp_file) &gt; 0)</span><br>=
<span>@@ -1389,6 +1385,11 @@</span><br><span>     }</span><br><span> </span=
><br><span> error:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (!session-&gt;opt-&gt;auth_user_pass_verify_script_via_file)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        setenv_del(session-&gt;opt-&gt;es=
, &quot;password&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span>     argv_free(&amp;argv);</span><br><span>     gc_free(&amp;gc);</=
span><br><span>     return retval;</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1326?usp=3Demai=
l">change 1326</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1326?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6c502508026c6b85bb092ada4d1=
6d985b20dd41f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1326 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--1tx5lnyQsaE=--


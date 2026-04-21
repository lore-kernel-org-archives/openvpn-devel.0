From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 21 Apr 2026 10:40:06 +0000
References: <gerrit.1776768003000.I0737b769e78e6d271ec874cadb9fbd81bfefdec1@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <9c05111c6fbae66d5e8352c846e2ee51815c2653-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="p/zwj7SJQ7M="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Only announce
 support push updates/IV_NCP when actually supporting it
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--p/zwj7SJQ7M=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/1634?usp=3Demail )


Change subject: Only announce support push updates/IV_NCP when actually sup=
porting it
......................................................................

Only announce support push updates/IV_NCP when actually supporting it

Currently even p2p clients that do not accept push message announce the
PUSH UPDATE flag.

The change for IV_NCP is more a documentation bugfix as in mode server
we currently never have push_peer_info_detail > 0.

But change the message to indicate that IV_NCP nowadays is more a
legacy variable and replaced by IV_CIPHERS.

Change-Id: I0737b769e78e6d271ec874cadb9fbd81bfefdec1
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/ssl.c
1 file changed, 10 insertions(+), 9 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/34/1634/1

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 5868d53..86b6e42 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1920,15 +1920,15 @@
         /* support for exit notify via control channel */
         iv_proto |=3D IV_PROTO_CC_EXIT_NOTIFY;

-        /* currently push-update is not supported when DCO is enabled */
-        if (!session->opt->dco_enabled)
-        {
-            /* support push-updates */
-            iv_proto |=3D IV_PROTO_PUSH_UPDATE;
-        }
-
         if (session->opt->pull)
         {
+            /* currently push-update is not supported when DCO is enabled =
*/
+            if (!session->opt->dco_enabled)
+            {
+                /* support push-updates */
+                iv_proto |=3D IV_PROTO_PUSH_UPDATE;
+            }
+
             /* support for receiving push_reply before sending
              * push request, also signal that the client wants
              * to get push-reply messages without requiring a round
@@ -1945,9 +1945,10 @@
             buf_printf(&out, "IV_MTU=3D%d\n", session->opt->frame.tun_max_=
mtu);
         }

-        /* support for Negotiable Crypto Parameters */
-        if (session->opt->mode =3D=3D MODE_SERVER || session->opt->pull)
+        if (session->opt->pull)
         {
+            /* legacy support for Negotiable Crypto Parameters (deprecated=
 in favour
+             * of IV_CIPHERS */
             if (tls_item_in_cipher_list("AES-128-GCM", session->opt->confi=
g_ncp_ciphers)
                 && tls_item_in_cipher_list("AES-256-GCM", session->opt->co=
nfig_ncp_ciphers))
             {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1634?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0737b769e78e6d271ec874cadb9fbd81bfefdec1
Gerrit-Change-Number: 1634
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--p/zwj7SJQ7M=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>.</p><p><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1634?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Only announce support push updates/IV_NCP when actually supporting it<b=
r><br>Currently even p2p clients that do not accept push message announce t=
he<br>PUSH UPDATE flag.<br><br>The change for IV_NCP is more a documentatio=
n bugfix as in mode server<br>we currently never have push_peer_info_detail=
 &gt; 0.<br><br>But change the message to indicate that IV_NCP nowadays is =
more a<br>legacy variable and replaced by IV_CIPHERS.<br><br>Change-Id: I07=
37b769e78e6d271ec874cadb9fbd81bfefdec1<br>Signed-off-by: Arne Schwabe &lt;a=
rne@...1227...&gt;<br>---<br>M src/openvpn/ssl.c<br>1 file changed, 10 inse=
rtions(+), 9 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.=
openvpn.net:29418/openvpn refs/changes/34/1634/1</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index 5868d53..86b6e42 100=
644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openv=
pn/ssl.c</span><br><span>@@ -1920,15 +1920,15 @@</span><br><span>         /=
* support for exit notify via control channel */</span><br><span>         i=
v_proto |=3D IV_PROTO_CC_EXIT_NOTIFY;</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        /* currently push-update is not s=
upported when DCO is enabled */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (!session-&gt;opt-&gt;dco_enabled)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            /* support push-updates */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            iv_proto |=3D IV_PROTO_P=
USH_UPDATE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     =
    if (session-&gt;opt-&gt;pull)</span><br><span>         {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            /* currently push-upda=
te is not supported when DCO is enabled */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            if (!session-&gt;opt-&gt;dco_enabled)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                /* support p=
ush-updates */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           iv_proto |=3D IV_PROTO_PUSH_UPDATE;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span>             /* support for receiving=
 push_reply before sending</span><br><span>              * push request, al=
so signal that the client wants</span><br><span>              * to get push=
-reply messages without requiring a round</span><br><span>@@ -1945,9 +1945,=
10 @@</span><br><span>             buf_printf(&amp;out, &quot;IV_MTU=3D%d\n=
&quot;, session-&gt;opt-&gt;frame.tun_max_mtu);</span><br><span>         }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    /* support for Negotiable Crypto Parameters */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (session-&gt;opt-&gt;mode =3D=3D MO=
DE_SERVER || session-&gt;opt-&gt;pull)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (session-&gt;opt-&gt;pull)</span><br><span>  =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 /* legacy support for Negotiable Crypto Parameters (deprecated in favour</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * of IV_=
CIPHERS */</span><br><span>             if (tls_item_in_cipher_list(&quot;A=
ES-128-GCM&quot;, session-&gt;opt-&gt;config_ncp_ciphers)</span><br><span> =
                &amp;&amp; tls_item_in_cipher_list(&quot;AES-256-GCM&quot;,=
 session-&gt;opt-&gt;config_ncp_ciphers))</span><br><span>             {</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1634?usp=3Demail">change 1634</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1634?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0737b769e78e6d271ec874cadb9=
fbd81bfefdec1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1634 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--p/zwj7SJQ7M=--


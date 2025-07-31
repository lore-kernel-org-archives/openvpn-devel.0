From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 31 Jul 2025 10:56:16 +0000
References: <gerrit.1753959374000.Ife4d8fc5f8e2183e61226d66a76bbaa02c06f787@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <fb93695960d98823a7ebf79933aa8309af880303-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6fudm7fUOuY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix DNS options
 duplication on PUSH_UPDATE
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

--6fudm7fUOuY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1121?usp=3Demail

to review the following change.


Change subject: Fix DNS options duplication on PUSH_UPDATE
......................................................................

Fix DNS options duplication on PUSH_UPDATE

Commit

    2dfc4f ("dns: deal with --dhcp-options when --dns is active")

has removed reset of tuntap DNS options. Due to that, incoming --dns
options are added to existing ones instead of overwriting them.

It has also added a new storage for --dhcp-option. The push-update
code didn't clear it and as a result, incoming --dhcp-option options
were added to existing once instead of overwriting them.

Fixed by:

 - reseting tuntap DNS options (regression from abovementioned commit)
 - clearing dhcp options storage in push-update code

Change-Id: Ife4d8fc5f8e2183e61226d66a76bbaa02c06f787
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/options.c
1 file changed, 14 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/1121/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3753810..8ce57ff 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3527,7 +3527,13 @@
 #endif /* if defined(_WIN32) */

     /* Copy --dns options to tuntap_options */
+
     const struct dns_domain *d =3D dns->search_domains;
+    if (d)
+    {
+        tt->domain_search_list_len =3D 0;
+    }
+
     while (d && tt->domain_search_list_len + 1 < N_SEARCH_LIST_LEN)
     {
         tt->domain_search_list[tt->domain_search_list_len++] =3D d->name;
@@ -3539,6 +3545,12 @@
     }

     const struct dns_server *s =3D dns->servers;
+    if (s)
+    {
+        tt->dns_len =3D 0;
+        tt->dns6_len =3D 0;
+    }
+
     while (s)
     {
         bool non_standard_server_port =3D false;
@@ -6212,6 +6224,8 @@
             }
             o->disable_nbt =3D 0;
             o->dhcp_options =3D 0;
+
+            CLEAR(options->dns_options.from_dhcp);
 #if defined(TARGET_ANDROID)
             o->http_proxy_port =3D 0;
             o->http_proxy =3D NULL;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1121?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ife4d8fc5f8e2183e61226d66a76bbaa02c06f787
Gerrit-Change-Number: 1121
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--6fudm7fUOuY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1121?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Fix DNS options duplication on PUSH_UPDATE<br><br>Commit<br>=
<br>    2dfc4f (&quot;dns: deal with --dhcp-options when --dns is active&qu=
ot;)<br><br>has removed reset of tuntap DNS options. Due to that, incoming =
--dns<br>options are added to existing ones instead of overwriting them.<br=
><br>It has also added a new storage for --dhcp-option. The push-update<br>=
code didn&#39;t clear it and as a result, incoming --dhcp-option options<br=
>were added to existing once instead of overwriting them.<br><br>Fixed by:<=
br><br> - reseting tuntap DNS options (regression from abovementioned commi=
t)<br> - clearing dhcp options storage in push-update code<br><br>Change-Id=
: Ife4d8fc5f8e2183e61226d66a76bbaa02c06f787<br>Signed-off-by: Lev Stipakov =
&lt;lev@...515...&gt;<br>---<br>M src/openvpn/options.c<br>1 file changed, =
14 insertions(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.ne=
t:29418/openvpn refs/changes/21/1121/1</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/opt=
ions.c b/src/openvpn/options.c</span><br><span>index 3753810..8ce57ff 10064=
4</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/ope=
nvpn/options.c</span><br><span>@@ -3527,7 +3527,13 @@</span><br><span> #end=
if /* if defined(_WIN32) */</span><br><span> </span><br><span>     /* Copy =
--dns options to tuntap_options */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span>     const struct dns_domain *d =3D dns-&gt=
;search_domains;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (d)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        tt-&gt;domain_sear=
ch_list_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n>     while (d &amp;&amp; tt-&gt;domain_search_list_len + 1 &lt; N_SEARCH_=
LIST_LEN)</span><br><span>     {</span><br><span>         tt-&gt;domain_sea=
rch_list[tt-&gt;domain_search_list_len++] =3D d-&gt;name;</span><br><span>@=
@ -3539,6 +3545,12 @@</span><br><span>     }</span><br><span> </span><br><s=
pan>     const struct dns_server *s =3D dns-&gt;servers;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (s)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        tt-&gt;dns_len =3D 0;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        tt-&gt;dns6_len =3D 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span>     while (s)</span><br><span>     {=
</span><br><span>         bool non_standard_server_port =3D false;</span><b=
r><span>@@ -6212,6 +6224,8 @@</span><br><span>             }</span><br><spa=
n>             o-&gt;disable_nbt =3D 0;</span><br><span>             o-&gt;=
dhcp_options =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            CLEAR(o=
ptions-&gt;dns_options.from_dhcp);</span><br><span> #if defined(TARGET_ANDR=
OID)</span><br><span>             o-&gt;http_proxy_port =3D 0;</span><br><s=
pan>             o-&gt;http_proxy =3D NULL;</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1121?u=
sp=3Demail">change 1121</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1121?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ife4d8fc5f8e2183e61226d66a76=
bbaa02c06f787 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1121 </div>
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


--6fudm7fUOuY=--


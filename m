From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 31 Jul 2025 12:19:15 +0000
In-Reply-To: <gerrit.1753959374000.Ife4d8fc5f8e2183e61226d66a76bbaa02c06f787@...2715...>
References: <gerrit.1753959374000.Ife4d8fc5f8e2183e61226d66a76bbaa02c06f787@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <081d973d4c70fb608f1bcb381398322f58e37d39-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Kl7UUdscERE="; charset=UTF-8
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
Cc: d12fk <heiko@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Kl7UUdscERE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1121?usp=3Demail

to look at the new patch set (#3).


Change subject: Fix DNS options duplication on PUSH_UPDATE
......................................................................

Fix DNS options duplication on PUSH_UPDATE

Commit

    2dfc4f ("dns: deal with --dhcp-options when --dns is active")

has removed reset of tuntap DNS options. Due to that, incoming --dns
options are added to existing ones instead of overwriting them.

It has also added a new storage for --dhcp-option. The push-update
code didn't clear it and as a result, incoming --dhcp-option options
were added to existing ones instead of overwriting them.

Fixed by:

 - resetting tuntap DNS options (regression from abovementioned commit)
 - clearing dhcp options storage in push-update code

GitHub: fixes OpenVPN/openvpn#804

Change-Id: Ife4d8fc5f8e2183e61226d66a76bbaa02c06f787
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/options.c
1 file changed, 11 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/1121/3

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3753810..3ceada0 100644
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
@@ -3538,6 +3544,9 @@
         msg(M_WARN, "WARNING: couldn't copy all --dns search-domains to TU=
N/TAP");
     }

+    tt->dns_len =3D 0;
+    tt->dns6_len =3D 0;
+
     const struct dns_server *s =3D dns->servers;
     while (s)
     {
@@ -6212,6 +6221,8 @@
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
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: d12fk <heiko@...515...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--Kl7UUdscERE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, stipa. <=
/p>
<p>stipa <strong>uploaded patch set #3</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1121?usp=3Demail">View Change</=
a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">Fix DNS options duplication on PUSH_UPDATE<br><br>Commit<br><br>    2dfc=
4f (&quot;dns: deal with --dhcp-options when --dns is active&quot;)<br><br>=
has removed reset of tuntap DNS options. Due to that, incoming --dns<br>opt=
ions are added to existing ones instead of overwriting them.<br><br>It has =
also added a new storage for --dhcp-option. The push-update<br>code didn&#3=
9;t clear it and as a result, incoming --dhcp-option options<br>were added =
to existing ones instead of overwriting them.<br><br>Fixed by:<br><br> - re=
setting tuntap DNS options (regression from abovementioned commit)<br> - cl=
earing dhcp options storage in push-update code<br><br>GitHub: fixes OpenVP=
N/openvpn#804<br><br>Change-Id: Ife4d8fc5f8e2183e61226d66a76bbaa02c06f787<b=
r>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>M src/openvpn=
/options.c<br>1 file changed, 11 insertions(+), 0 deletions(-)<br><br></pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/1121/3</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><spa=
n>index 3753810..3ceada0 100644</span><br><span>--- a/src/openvpn/options.c=
</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -3527,7 +35=
27,13 @@</span><br><span> #endif /* if defined(_WIN32) */</span><br><span> =
</span><br><span>     /* Copy --dns options to tuntap_options */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     const st=
ruct dns_domain *d =3D dns-&gt;search_domains;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (d)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        tt-&gt;domain_search_list_len =3D 0;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span>     while (d &amp;&amp; tt-&gt;domain_sear=
ch_list_len + 1 &lt; N_SEARCH_LIST_LEN)</span><br><span>     {</span><br><s=
pan>         tt-&gt;domain_search_list[tt-&gt;domain_search_list_len++] =3D=
 d-&gt;name;</span><br><span>@@ -3538,6 +3544,9 @@</span><br><span>        =
 msg(M_WARN, &quot;WARNING: couldn&#39;t copy all --dns search-domains to T=
UN/TAP&quot;);</span><br><span>     }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    tt-&gt;dns_len =3D 0;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    tt-&gt;dns6_len =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     cons=
t struct dns_server *s =3D dns-&gt;servers;</span><br><span>     while (s)<=
/span><br><span>     {</span><br><span>@@ -6212,6 +6221,8 @@</span><br><spa=
n>             }</span><br><span>             o-&gt;disable_nbt =3D 0;</spa=
n><br><span>             o-&gt;dhcp_options =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            CLEAR(options-&gt;dns_options.from_dhcp);</span><br=
><span> #if defined(TARGET_ANDROID)</span><br><span>             o-&gt;http=
_proxy_port =3D 0;</span><br><span>             o-&gt;http_proxy =3D NULL;<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1121?usp=3Demail">change 1121</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1121?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ife4d8fc5f8e2183e61226d66a76=
bbaa02c06f787 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1121 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: d12fk &lt;heiko@...515...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--Kl7UUdscERE=--


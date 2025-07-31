From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 31 Jul 2025 12:56:47 +0000
In-Reply-To: <gerrit.1753959374000.Ife4d8fc5f8e2183e61226d66a76bbaa02c06f787@...2715...>
References: <gerrit.1753959374000.Ife4d8fc5f8e2183e61226d66a76bbaa02c06f787@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <73d99e32f43fe8b3d61b78e8236159510494d9a9-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PYQ9/A6TWXY="; charset=UTF-8
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
To: stipa <lstipakov@...277...>
Cc: d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--PYQ9/A6TWXY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
21?usp=3Demail )

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
Acked-by: Heiko Hund <heiko@...515...>
Message-Id: <20250731122410.12200-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
448.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
1 file changed, 11 insertions(+), 0 deletions(-)




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
=20
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
Gerrit-PatchSet: 4
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--PYQ9/A6TWXY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1121?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Fix DNS options duplication on PUSH_UPDATE<br=
><br>Commit<br><br>    2dfc4f (&quot;dns: deal with --dhcp-options when --d=
ns is active&quot;)<br><br>has removed reset of tuntap DNS options. Due to =
that, incoming --dns<br>options are added to existing ones instead of overw=
riting them.<br><br>It has also added a new storage for --dhcp-option. The =
push-update<br>code didn&#39;t clear it and as a result, incoming --dhcp-op=
tion options<br>were added to existing ones instead of overwriting them.<br=
><br>Fixed by:<br><br> - resetting tuntap DNS options (regression from abov=
ementioned commit)<br> - clearing dhcp options storage in push-update code<=
br><br>GitHub: fixes OpenVPN/openvpn#804<br><br>Change-Id: Ife4d8fc5f8e2183=
e61226d66a76bbaa02c06f787<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&=
gt;<br>Acked-by: Heiko Hund &lt;heiko@...515...&gt;<br>Message-Id: &lt;2025=
0731122410.12200-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com=
/openvpn-devel@lists.sourceforge.net/msg32448.html<br>Signed-off-by: Gert D=
oering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/options.c<br>1 file =
changed, 11 insertions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><sp=
an>index 3753810..3ceada0 100644</span><br><span>--- a/src/openvpn/options.=
c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -3527,7 +3=
527,13 @@</span><br><span> #endif /* if defined(_WIN32) */</span><br><span>=
 </span><br><span>     /* Copy --dns options to tuntap_options */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     const s=
truct dns_domain *d =3D dns-&gt;search_domains;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (d)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        tt-&gt;domain_search_list_len =3D 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span>     while (d &amp;&amp; tt-&gt;domain_sea=
rch_list_len + 1 &lt; N_SEARCH_LIST_LEN)</span><br><span>     {</span><br><=
span>         tt-&gt;domain_search_list[tt-&gt;domain_search_list_len++] =
=3D d-&gt;name;</span><br><span>@@ -3538,6 +3544,9 @@</span><br><span>     =
    msg(M_WARN, &quot;WARNING: couldn&#39;t copy all --dns search-domains t=
o TUN/TAP&quot;);</span><br><span>     }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    tt-&gt;dns_len =3D 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    tt-&gt;dns6_len =3D 0;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     c=
onst struct dns_server *s =3D dns-&gt;servers;</span><br><span>     while (=
s)</span><br><span>     {</span><br><span>@@ -6212,6 +6221,8 @@</span><br><=
span>             }</span><br><span>             o-&gt;disable_nbt =3D 0;</=
span><br><span>             o-&gt;dhcp_options =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            CLEAR(options-&gt;dns_options.from_dhcp);</span>=
<br><span> #if defined(TARGET_ANDROID)</span><br><span>             o-&gt;h=
ttp_proxy_port =3D 0;</span><br><span>             o-&gt;http_proxy =3D NUL=
L;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1121?usp=3Demail">change 1121</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1121?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ife4d8fc5f8e2183e61226d66a76=
bbaa02c06f787 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1121 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--PYQ9/A6TWXY=--


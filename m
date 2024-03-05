From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 5 Mar 2024 20:58:52 +0000
In-Reply-To: <gerrit.1709567200000.I38e70cb74c10848ab2981efc4c4c8863c5c8785d@...2715...>
References: <gerrit.1709567200000.I38e70cb74c10848ab2981efc4c4c8863c5c8785d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0e6f0f8747b229959edc8dc9c6b5bbe63ac7c1c2-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YABakYe7oQE="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix typo
 --data-cipher-fallback
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

--YABakYe7oQE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/534?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: Fix typo --data-cipher-fallback
......................................................................

Fix typo --data-cipher-fallback

Change-Id: I38e70cb74c10848ab2981efc4c4c8863c5c8785d
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20240305082236.17566-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
321.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/generic-options.rst
M src/openvpn/dco.c
2 files changed, 2 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/34/534/2

diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generi=
c-options.rst
index 95e4ca2..30c990d 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -75,7 +75,7 @@
     to the configuration if no other compression options are present.
   - 2.4.x or lower: The cipher in ``--cipher`` is appended to
     ``--data-ciphers``.
-  - 2.3.x or lower: ``--data-cipher-fallback`` is automatically added with
+  - 2.3.x or lower: ``--data-ciphers-fallback`` is automatically added with
     the same cipher as ``--cipher``.
   - 2.3.6 or lower: ``--tls-version-min 1.0`` is added to the configuration
     when ``--tls-version-min`` is not explicitly set.
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index cd3e0ad..14430d3 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -400,7 +400,7 @@
     if (o->enable_ncp_fallback
         && !tls_item_in_cipher_list(o->ciphername, dco_get_supported_ciphe=
rs()))
     {
-        msg(msglevel, "Note: --data-cipher-fallback with cipher '%s' "
+        msg(msglevel, "Note: --data-ciphers-fallback with cipher '%s' "
             "disables data channel offload.", o->ciphername);
         return false;
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/534?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I38e70cb74c10848ab2981efc4c4c8863c5c8785d
Gerrit-Change-Number: 534
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--YABakYe7oQE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/534?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Fix typo --data-cipher-fallback<br><br>Change-Id=
: I38e70cb74c10848ab2981efc4c4c8863c5c8785d<br>Signed-off-by: Frank Lichten=
held &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1186...=
.1227...&gt;<br>Message-Id: &lt;20240305082236.17566-1-gert@...1296...&gt;<=
br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/ms=
g28321.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<b=
r>M doc/man-sections/generic-options.rst<br>M src/openvpn/dco.c<br>2 files =
changed, 2 insertions(+), 2 deletions(-)<br><br></pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.op=
envpn.net:29418/openvpn refs/changes/34/534/2</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-=
sections/generic-options.rst b/doc/man-sections/generic-options.rst</span><=
br><span>index 95e4ca2..30c990d 100644</span><br><span>--- a/doc/man-sectio=
ns/generic-options.rst</span><br><span>+++ b/doc/man-sections/generic-optio=
ns.rst</span><br><span>@@ -75,7 +75,7 @@</span><br><span>     to the config=
uration if no other compression options are present.</span><br><span>   - 2=
.4.x or lower: The cipher in ``--cipher`` is appended to</span><br><span>  =
   ``--data-ciphers``.</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  - 2.3.x or lower: ``--data-cipher-fallback`` is automatically added with=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  - 2.3.x or lower:=
 ``--data-ciphers-fallback`` is automatically added with</span><br><span>  =
   the same cipher as ``--cipher``.</span><br><span>   - 2.3.6 or lower: ``=
--tls-version-min 1.0`` is added to the configuration</span><br><span>     =
when ``--tls-version-min`` is not explicitly set.</span><br><span>diff --gi=
t a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>index cd3e0ad..14=
430d3 100644</span><br><span>--- a/src/openvpn/dco.c</span><br><span>+++ b/=
src/openvpn/dco.c</span><br><span>@@ -400,7 +400,7 @@</span><br><span>     =
if (o-&gt;enable_ncp_fallback</span><br><span>         &amp;&amp; !tls_item=
_in_cipher_list(o-&gt;ciphername, dco_get_supported_ciphers()))</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ms=
g(msglevel, &quot;Note: --data-cipher-fallback with cipher &#39;%s&#39; &qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(msgl=
evel, &quot;Note: --data-ciphers-fallback with cipher &#39;%s&#39; &quot;</=
span><br><span>             &quot;disables data channel offload.&quot;, o-&=
gt;ciphername);</span><br><span>         return false;</span><br><span>    =
 }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/534?usp=3Demail">change 534</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/534?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I38e70cb74c10848ab2981efc4c4=
c8863c5c8785d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 534 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--YABakYe7oQE=--


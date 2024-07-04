From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 4 Jul 2024 06:11:39 +0000
In-Reply-To: <gerrit.1720021020000.Ibc641388d8016533c94dfef3618376f6dfa91f4e@...2715...>
References: <gerrit.1720021020000.Ibc641388d8016533c94dfef3618376f6dfa91f4e@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <968bf55e713cf83661fa95d9e2d7cd23bab32065-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="S9Uj7juyo4k="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: mbedtls: Warn if
 --tls-version-min is too low
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: MaxF <max@...2606...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--S9Uj7juyo4k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 MaxF. ( http://gerrit.openvpn.net/c/openvpn/+/684?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: mbedtls: Warn if --tls-version-min is too low
......................................................................

mbedtls: Warn if --tls-version-min is too low

Recent versions of mbedtls only support TLS 1.2. When the minimum
version is set to TLS 1.0 or 1.1, log a warning and use 1.2 as the
actual minimum version.

Change-Id: Ibc641388d8016533c94dfef3618376f6dfa91f4e
Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20240703174158.7137-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
865.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
1 file changed, 9 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/84/684/2

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index dbe1425..64e67aa 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8942,6 +8942,15 @@
             msg(msglevel, "unknown tls-version-min parameter: %s", p[1]);
             goto err;
         }
+
+#ifdef ENABLE_CRYPTO_MBEDTLS
+        if (ver < TLS_VER_1_2)
+        {
+            msg(M_WARN, "--tls-version-min %s is not supported by mbedtls,=
 using 1.2", p[1]);
+            ver =3D TLS_VER_1_2;
+        }
+#endif
+
         options->ssl_flags &=3D
             ~(SSLF_TLS_VERSION_MIN_MASK << SSLF_TLS_VERSION_MIN_SHIFT);
         options->ssl_flags |=3D (ver << SSLF_TLS_VERSION_MIN_SHIFT);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/684?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibc641388d8016533c94dfef3618376f6dfa91f4e
Gerrit-Change-Number: 684
Gerrit-PatchSet: 2
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--S9Uj7juyo4k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by MaxF.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/684?u=
sp=3Demail">View Change</a></p><p>The following approvals got outdated and =
were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">mbedtls: Warn if --tls-version-min is too low<br=
><br>Recent versions of mbedtls only support TLS 1.2. When the minimum<br>v=
ersion is set to TLS 1.0 or 1.1, log a warning and use 1.2 as the<br>actual=
 minimum version.<br><br>Change-Id: Ibc641388d8016533c94dfef3618376f6dfa91f=
4e<br>Signed-off-by: Max Fillinger &lt;maximilian.fillinger@...2507...&gt;<=
br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Message-Id: &l=
t;20240703174158.7137-1-gert@...1296...&gt;<br>URL: https://www.mail-archiv=
e.com/openvpn-devel@lists.sourceforge.net/msg28865.html<br>Signed-off-by: G=
ert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/options.c<br>1 =
file changed, 9 insertions(+), 0 deletions(-)<br><br></pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it.openvpn.net:29418/openvpn refs/changes/84/684/2</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpn/options.c b/src/openvpn/options.c</span><br><span>index dbe1425..6=
4e67aa 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+=
++ b/src/openvpn/options.c</span><br><span>@@ -8942,6 +8942,15 @@</span><br=
><span>             msg(msglevel, &quot;unknown tls-version-min parameter: =
%s&quot;, p[1]);</span><br><span>             goto err;</span><br><span>   =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_CRYPTO_MBEDTLS</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ver &lt; T=
LS_VER_1_2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_=
WARN, &quot;--tls-version-min %s is not supported by mbedtls, using 1.2&quo=
t;, p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   ver =3D TLS_VER_1_2;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>  =
       options-&gt;ssl_flags &amp;=3D</span><br><span>             ~(SSLF_T=
LS_VERSION_MIN_MASK &lt;&lt; SSLF_TLS_VERSION_MIN_SHIFT);</span><br><span> =
        options-&gt;ssl_flags |=3D (ver &lt;&lt; SSLF_TLS_VERSION_MIN_SHIFT=
);</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/684?usp=3Demail">change 684</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/684?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibc641388d8016533c94dfef3618=
376f6dfa91f4e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 684 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--S9Uj7juyo4k=--


From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 6 Aug 2025 14:29:42 +0000
References: <gerrit.1754490554000.I053ddbb71cc5b9ae16c5a49be833035d943d7eba@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <8a39784461c6f01dda47bc573b89b0a41edd31e8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gDWQ63BS0mk="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl: Fix
 -Wconversion warnings in pem_password_callback
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

--gDWQ63BS0mk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1137?usp=3Demail

to review the following change.


Change subject: ssl: Fix -Wconversion warnings in pem_password_callback
......................................................................

ssl: Fix -Wconversion warnings in pem_password_callback

The OpenSSL API is how it is, so adapt with casts.

Change-Id: I053ddbb71cc5b9ae16c5a49be833035d943d7eba
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/ssl.c
1 file changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/37/1137/1

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 17065aa..d586ba1 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -264,10 +264,10 @@
         /* prompt for password even if --askpass wasn't specified */
         pem_password_setup(NULL);
         ASSERT(!passbuf.protected);
-        strncpynt(buf, passbuf.password, size);
+        strncpynt(buf, passbuf.password, (size_t)size);
         purge_user_pass(&passbuf, false);

-        return strlen(buf);
+        return (int)strlen(buf);
     }
     return 0;
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1137?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I053ddbb71cc5b9ae16c5a49be833035d943d7eba
Gerrit-Change-Number: 1137
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--gDWQ63BS0mk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1137?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">ssl: Fix -Wconversion warnings in pem_password_callback<br><=
br>The OpenSSL API is how it is, so adapt with casts.<br><br>Change-Id: I05=
3ddbb71cc5b9ae16c5a49be833035d943d7eba<br>Signed-off-by: Frank Lichtenheld =
&lt;frank@...2641...&gt;<br>---<br>M src/openvpn/ssl.c<br>1 file changed, 2=
 insertions(+), 2 deletions(-)<br><br></pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/37/1137/1</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl.c=
 b/src/openvpn/ssl.c</span><br><span>index 17065aa..d586ba1 100644</span><b=
r><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</sp=
an><br><span>@@ -264,10 +264,10 @@</span><br><span>         /* prompt for p=
assword even if --askpass wasn&#39;t specified */</span><br><span>         =
pem_password_setup(NULL);</span><br><span>         ASSERT(!passbuf.protecte=
d);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strncpynt(=
buf, passbuf.password, size);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        strncpynt(buf, passbuf.password, (size_t)size);</span><br=
><span>         purge_user_pass(&amp;passbuf, false);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        return strlen(buf=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return (i=
nt)strlen(buf);</span><br><span>     }</span><br><span>     return 0;</span=
><br><span> }</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1137?usp=3Demail">change 1137</a>. T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http=
://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1137?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I053ddbb71cc5b9ae16c5a49be83=
3035d943d7eba </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1137 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--gDWQ63BS0mk=--


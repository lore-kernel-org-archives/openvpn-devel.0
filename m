From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 23 Sep 2025 09:15:33 +0000
In-Reply-To: <gerrit.1754490554000.I053ddbb71cc5b9ae16c5a49be833035d943d7eba@...2715...>
References: <gerrit.1754490554000.I053ddbb71cc5b9ae16c5a49be833035d943d7eba@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3ce21e0da1ea4ac319aa86d0b83ef2fcc60625e6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tLsgrqOmqMw="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--tLsgrqOmqMw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
37?usp=3Demail )

Change subject: ssl: Fix -Wconversion warnings in pem_password_callback
......................................................................

ssl: Fix -Wconversion warnings in pem_password_callback

The OpenSSL API is how it is, so adapt with casts.

Change-Id: I053ddbb71cc5b9ae16c5a49be833035d943d7eba
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1137
Message-Id: <20250922204158.23319-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
154.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl.c
1 file changed, 2 insertions(+), 2 deletions(-)




diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 9159b8c..ba6919b 100644
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
Gerrit-PatchSet: 10
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--tLsgrqOmqMw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1137?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">ssl: Fix -Wconversion warnings in pem_passwor=
d_callback<br><br>The OpenSSL API is how it is, so adapt with casts.<br><br=
>Change-Id: I053ddbb71cc5b9ae16c5a49be833035d943d7eba<br>Signed-off-by: Fra=
nk Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@=
...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1137<b=
r>Message-Id: &lt;20250922204158.23319-1-gert@...1296...&gt;<br>URL: https:=
//www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33154.html<br=
>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvp=
n/ssl.c<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index=
 9159b8c..ba6919b 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br>=
<span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -264,10 +264,10 @@</span><=
br><span>         /* prompt for password even if --askpass wasn&#39;t speci=
fied */</span><br><span>         pem_password_setup(NULL);</span><br><span>=
         ASSERT(!passbuf.protected);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        strncpynt(buf, passbuf.password, size);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        strncpynt(buf, passbuf.p=
assword, (size_t)size);</span><br><span>         purge_user_pass(&amp;passb=
uf, false);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        return strlen(buf);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return (int)strlen(buf);</span><br><span>     }</sp=
an><br><span>     return 0;</span><br><span> }</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/113=
7?usp=3Demail">change 1137</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1137?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I053ddbb71cc5b9ae16c5a49be83=
3035d943d7eba </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1137 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--tLsgrqOmqMw=--


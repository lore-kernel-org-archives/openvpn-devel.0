From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 23 Sep 2025 09:15:30 +0000
In-Reply-To: <gerrit.1754490554000.I053ddbb71cc5b9ae16c5a49be833035d943d7eba@...2715...>
References: <gerrit.1754490554000.I053ddbb71cc5b9ae16c5a49be833035d943d7eba@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3ce21e0da1ea4ac319aa86d0b83ef2fcc60625e6-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="17E486DtwE8="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--17E486DtwE8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#10) to the change originally created b=
y flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1137?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/37/1137/10

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
Gerrit-MessageType: newpatchset

--17E486DtwE8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #10</strong> to the change originally c=
reated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1137?usp=3Demail">View Change</a></p><p>The following approvals got out=
dated and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">ssl: Fix -Wconversion warnings in pem_password_callb=
ack<br><br>The OpenSSL API is how it is, so adapt with casts.<br><br>Change=
-Id: I053ddbb71cc5b9ae16c5a49be833035d943d7eba<br>Signed-off-by: Frank Lich=
tenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1726...=
...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1137<br>Messa=
ge-Id: &lt;20250922204158.23319-1-gert@...1296...&gt;<br>URL: https://www.m=
ail-archive.com/openvpn-devel@lists.sourceforge.net/msg33154.html<br>Signed=
-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/ssl.c=
<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/37/1137/10</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index 9159b8c..=
ba6919b 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ =
b/src/openvpn/ssl.c</span><br><span>@@ -264,10 +264,10 @@</span><br><span> =
        /* prompt for password even if --askpass wasn&#39;t specified */</s=
pan><br><span>         pem_password_setup(NULL);</span><br><span>         A=
SSERT(!passbuf.protected);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        strncpynt(buf, passbuf.password, size);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        strncpynt(buf, passbuf.password, =
(size_t)size);</span><br><span>         purge_user_pass(&amp;passbuf, false=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       return strlen(buf);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return (int)strlen(buf);</span><br><span>     }</span><br><s=
pan>     return 0;</span><br><span> }</span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1137?usp=3De=
mail">change 1137</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div it=
emscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1137?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--17E486DtwE8=--


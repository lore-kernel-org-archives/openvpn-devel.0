From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Oct 2025 09:34:56 +0000
In-Reply-To: <gerrit.1761599429000.I7b94de92723f9528b01cb932bb079eedf0f1f272@...2715...>
References: <gerrit.1761599429000.I7b94de92723f9528b01cb932bb079eedf0f1f272@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4eddf01f940af27ed49bcc4b617932f0bff94665-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Zkdkt9uNbZI="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Avoid possible race
 condition that kill OpenVPN itself
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

--Zkdkt9uNbZI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1319?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Avoid possible race condition that kill OpenVPN itself
......................................................................

Avoid possible race condition that kill OpenVPN itself

If for whatever reason the child pid is zero, we would kill ourselves
since killing 0 means killing the own process group.

Reported-By: Joshua Rogers <contact@...2949...>
Found-By: Zeropath
Change-Id: I7b94de92723f9528b01cb932bb079eedf0f1f272
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1319
Message-Id: <20251027213308.5588-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
910.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/tun_afunix.c
1 file changed, 6 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/19/1319/2

diff --git a/src/openvpn/tun_afunix.c b/src/openvpn/tun_afunix.c
index 4d48a31..124db6d 100644
--- a/src/openvpn/tun_afunix.c
+++ b/src/openvpn/tun_afunix.c
@@ -128,7 +128,12 @@
         close(tt->fd);
         tt->fd =3D 0;
     }
-    kill(tt->afunix.childprocess, SIGINT);
+    /* only kill the child process if the PID is not 0 to avoid killing
+     * ourselves by accident */
+    if (tt->afunix.childprocess)
+    {
+        kill(tt->afunix.childprocess, SIGINT);
+    }

     free(tt->actual_name);
     free(tt);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1319?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7b94de92723f9528b01cb932bb079eedf0f1f272
Gerrit-Change-Number: 1319
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Zkdkt9uNbZI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1319?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Avoid possible race condition that =
kill OpenVPN itself<br><br>If for whatever reason the child pid is zero, we=
 would kill ourselves<br>since killing 0 means killing the own process grou=
p.<br><br>Reported-By: Joshua Rogers &lt;contact@...2949...&gt;<br>Found-By=
: Zeropath<br>Change-Id: I7b94de92723f9528b01cb932bb079eedf0f1f272<br>Signe=
d-off-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Acked-by: Gert Do=
ering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/o=
penvpn/+/1319<br>Message-Id: &lt;20251027213308.5588-1-gert@...1296...&gt;<=
br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/ms=
g33910.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<b=
r>M src/openvpn/tun_afunix.c<br>1 file changed, 6 insertions(+), 1 deletion=
(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/open=
vpn refs/changes/19/1319/2</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/tun_afunix.c b/=
src/openvpn/tun_afunix.c</span><br><span>index 4d48a31..124db6d 100644</spa=
n><br><span>--- a/src/openvpn/tun_afunix.c</span><br><span>+++ b/src/openvp=
n/tun_afunix.c</span><br><span>@@ -128,7 +128,12 @@</span><br><span>       =
  close(tt-&gt;fd);</span><br><span>         tt-&gt;fd =3D 0;</span><br><sp=
an>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    kill(tt-=
&gt;afunix.childprocess, SIGINT);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    /* only kill the child process if the PID is not 0 to avo=
id killing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * ou=
rselves by accident */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (tt-&gt;afunix.childprocess)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        kill(tt-&gt;afunix.childprocess, SIGINT);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>=
     free(tt-&gt;actual_name);</span><br><span>     free(tt);</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1319?usp=3Demail">change 1319</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?u=
sp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1319?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7b94de92723f9528b01cb932bb0=
79eedf0f1f272 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1319 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--Zkdkt9uNbZI=--


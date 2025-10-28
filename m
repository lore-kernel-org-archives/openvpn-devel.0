From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Oct 2025 09:34:58 +0000
In-Reply-To: <gerrit.1761599429000.I7b94de92723f9528b01cb932bb079eedf0f1f272@...2715...>
References: <gerrit.1761599429000.I7b94de92723f9528b01cb932bb079eedf0f1f272@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4eddf01f940af27ed49bcc4b617932f0bff94665-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bFTABC2+rKk="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--bFTABC2+rKk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
19?usp=3Demail )

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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7b94de92723f9528b01cb932bb079eedf0f1f272
Gerrit-Change-Number: 1319
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--bFTABC2+rKk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1319?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Avoid possible race condition that kill OpenVPN =
itself<br><br>If for whatever reason the child pid is zero, we would kill o=
urselves<br>since killing 0 means killing the own process group.<br><br>Rep=
orted-By: Joshua Rogers &lt;contact@...2949...&gt;<br>Found-By: Zeropath<br=
>Change-Id: I7b94de92723f9528b01cb932bb079eedf0f1f272<br>Signed-off-by: Arn=
e Schwabe &lt;arne-openvpn@...1227...&gt;<br>Acked-by: Gert Doering &lt;ger=
t@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1319=
<br>Message-Id: &lt;20251027213308.5588-1-gert@...1296...&gt;<br>URL: https=
://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33910.html<b=
r>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openv=
pn/tun_afunix.c<br>1 file changed, 6 insertions(+), 1 deletion(-)<br><br></=
pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/tun_afunix.c b/src/openvpn/tun_afunix.c</span><=
br><span>index 4d48a31..124db6d 100644</span><br><span>--- a/src/openvpn/tu=
n_afunix.c</span><br><span>+++ b/src/openvpn/tun_afunix.c</span><br><span>@=
@ -128,7 +128,12 @@</span><br><span>         close(tt-&gt;fd);</span><br><s=
pan>         tt-&gt;fd =3D 0;</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    kill(tt-&gt;afunix.childprocess, SIGINT=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* only kill =
the child process if the PID is not 0 to avoid killing</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * ourselves by accident */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (tt-&gt;afunix.childp=
rocess)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        kill(tt-&gt;afunix=
.childprocess, SIGINT);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span> </span><br><span>     free(tt-&gt;actual_name);<=
/span><br><span>     free(tt);</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1319?usp=3Demail">c=
hange 1319</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><d=
iv itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1319?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--bFTABC2+rKk=--


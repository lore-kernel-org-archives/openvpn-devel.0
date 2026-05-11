From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 11 May 2026 17:13:03 +0000
In-Reply-To: <gerrit.1778239616000.I0aeb4583707a80592ec2577fbb060f7fbcb73e48@...2715...>
References: <gerrit.1778239616000.I0aeb4583707a80592ec2577fbb060f7fbcb73e48@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2c54ab7c6a28c6d2027e056c300f9e8f49fc4652-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9AFEsmXoGNY="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tun: Remove one
 useless if check
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

--9AFEsmXoGNY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/16=
77?usp=3Demail )

Change subject: tun: Remove one useless if check
......................................................................

tun: Remove one useless if check

The condition was already checked in an outer if check.

Identified by cppcheck.

Change-Id: I0aeb4583707a80592ec2577fbb060f7fbcb73e48
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1677
Message-Id: <20260508153458.13848-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
867.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/tun.c
1 file changed, 3 insertions(+), 6 deletions(-)




diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index f46802f..e7193d8 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5772,13 +5772,10 @@
                 continue;
             }

-            if (tt->backend_driver =3D=3D DRIVER_DCO)
+            const char *last_sep =3D strrchr(dev_if->device_interface, '\\=
');
+            if (!last_sep || strcmp(last_sep + 1, DCO_WIN_REFERENCE_STRING=
) !=3D 0)
             {
-                char *last_sep =3D strrchr(dev_if->device_interface, '\\');
-                if (!last_sep || strcmp(last_sep + 1, DCO_WIN_REFERENCE_ST=
RING) !=3D 0)
-                {
-                    continue;
-                }
+                continue;
             }

             path =3D dev_if->device_interface;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1677?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0aeb4583707a80592ec2577fbb060f7fbcb73e48
Gerrit-Change-Number: 1677
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--9AFEsmXoGNY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1677?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">tun: Remove one useless if check<br><br>The cond=
ition was already checked in an outer if check.<br><br>Identified by cppche=
ck.<br><br>Change-Id: I0aeb4583707a80592ec2577fbb060f7fbcb73e48<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering=
 &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvp=
n/+/1677<br>Message-Id: &lt;20260508153458.13848-1-gert@...1296...&gt;<br>U=
RL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg368=
67.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M =
src/openvpn/tun.c<br>1 file changed, 3 insertions(+), 6 deletions(-)<br><br=
></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index=
 f46802f..e7193d8 100644</span><br><span>--- a/src/openvpn/tun.c</span><br>=
<span>+++ b/src/openvpn/tun.c</span><br><span>@@ -5772,13 +5772,10 @@</span=
><br><span>                 continue;</span><br><span>             }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  if (tt-&gt;backend_driver =3D=3D DRIVER_DCO)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            const char *last_sep =3D strrchr(dev=
_if-&gt;device_interface, &#39;\\&#39;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            if (!last_sep || strcmp(last_sep + 1, DCO_=
WIN_REFERENCE_STRING) !=3D 0)</span><br><span>             {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                char *last_sep =3D s=
trrchr(dev_if-&gt;device_interface, &#39;\\&#39;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                if (!last_sep || strcmp(last_s=
ep + 1, DCO_WIN_REFERENCE_STRING) !=3D 0)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                    continue;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                continue;</span><br><span>           =
  }</span><br><span> </span><br><span>             path =3D dev_if-&gt;devi=
ce_interface;</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1677?usp=3Demail">change 1677</a>. T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope item=
type=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1677?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0aeb4583707a80592ec2577fbb0=
60f7fbcb73e48 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1677 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--9AFEsmXoGNY=--


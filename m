From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 8 May 2026 11:27:33 +0000
References: <gerrit.1778239616000.I0aeb4583707a80592ec2577fbb060f7fbcb73e48@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <144483b0372b193df493250e6b1d522979dfeb04-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="It9AF5DvWFE="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--It9AF5DvWFE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1677?usp=3Demail

to review the following change.


Change subject: tun: Remove one useless if check
......................................................................

tun: Remove one useless if check

The condition was already checked in an outer if check.

Identified by cppcheck.

Change-Id: I0aeb4583707a80592ec2577fbb060f7fbcb73e48
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/tun.c
1 file changed, 3 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/77/1677/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0aeb4583707a80592ec2577fbb060f7fbcb73e48
Gerrit-Change-Number: 1677
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--It9AF5DvWFE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1677?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">tun: Remove one useless if check<br><br>The=
 condition was already checked in an outer if check.<br><br>Identified by c=
ppcheck.<br><br>Change-Id: I0aeb4583707a80592ec2577fbb060f7fbcb73e48<br>Sig=
ned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/open=
vpn/tun.c<br>1 file changed, 3 insertions(+), 6 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/7=
7/1677/1</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><=
br><span>index f46802f..e7193d8 100644</span><br><span>--- a/src/openvpn/tu=
n.c</span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ -5772,13 +57=
72,10 @@</span><br><span>                 continue;</span><br><span>       =
      }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            if (tt-&gt;backend_driver =3D=3D DRIVER_DCO)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            const char *last_sep =
=3D strrchr(dev_if-&gt;device_interface, &#39;\\&#39;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            if (!last_sep || strcmp(las=
t_sep + 1, DCO_WIN_REFERENCE_STRING) !=3D 0)</span><br><span>             {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                char =
*last_sep =3D strrchr(dev_if-&gt;device_interface, &#39;\\&#39;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                if (!last_sep |=
| strcmp(last_sep + 1, DCO_WIN_REFERENCE_STRING) !=3D 0)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    continue;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                continue;</span><br><=
span>             }</span><br><span> </span><br><span>             path =3D=
 dev_if-&gt;device_interface;</span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1677?usp=3Demail">ch=
ange 1677</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1677?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0aeb4583707a80592ec2577fbb0=
60f7fbcb73e48 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1677 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--It9AF5DvWFE=--


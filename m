From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 14 Jul 2025 09:22:03 +0000
In-Reply-To: <gerrit.1752140383000.Icad1a52d14311a6f06bda081cab2f4bded8d47ed@...2715...>
References: <gerrit.1752140383000.Icad1a52d14311a6f06bda081cab2f4bded8d47ed@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <85ea2948fd4116ee48929409886bec23012d7c08-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lb9uknvPrbI="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix compiler
 warning in reliable.c with --disable-debug
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

--lb9uknvPrbI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1082?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: Fix compiler warning in reliable.c with --disable-debug
......................................................................

Fix compiler warning in reliable.c with --disable-debug

Use the easy way out. Using pre-compiler to completely
avoid n_active seems like overkill.

Change-Id: Icad1a52d14311a6f06bda081cab2f4bded8d47ed
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20250711100405.240625-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
107.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/reliable.c
1 file changed, 1 insertion(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/82/1082/2

diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 6aef112..424d194 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -648,6 +648,7 @@
             }
         }
     }
+    (void)n_active; /* dmsg might not generate code */
     dmsg(D_REL_DEBUG, "ACK reliable_can_send active=3D%d current=3D%d : %s=
",
          n_active,
          n_current,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1082?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icad1a52d14311a6f06bda081cab2f4bded8d47ed
Gerrit-Change-Number: 1082
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--lb9uknvPrbI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1082?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Fix compiler warning in reliable.c with --disabl=
e-debug<br><br>Use the easy way out. Using pre-compiler to completely<br>av=
oid n_active seems like overkill.<br><br>Change-Id: Icad1a52d14311a6f06bda0=
81cab2f4bded8d47ed<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...=
&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Message-I=
d: &lt;20250711100405.240625-1-frank@...2641...&gt;<br>URL: https://www.mai=
l-archive.com/openvpn-devel@lists.sourceforge.net/msg32107.html<br>Signed-o=
ff-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/reliabl=
e.c<br>1 file changed, 1 insertion(+), 0 deletions(-)<br><br></pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit.openvpn.net:29418/openvpn refs/changes/82/1082/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/reliable.c b/src/openvpn/reliable.c</span><br><span>index=
 6aef112..424d194 100644</span><br><span>--- a/src/openvpn/reliable.c</span=
><br><span>+++ b/src/openvpn/reliable.c</span><br><span>@@ -648,6 +648,7 @@=
</span><br><span>             }</span><br><span>         }</span><br><span>=
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    (void)n_a=
ctive; /* dmsg might not generate code */</span><br><span>     dmsg(D_REL_D=
EBUG, &quot;ACK reliable_can_send active=3D%d current=3D%d : %s&quot;,</spa=
n><br><span>          n_active,</span><br><span>          n_current,</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1082?usp=3Demail">change 1082</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1082?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icad1a52d14311a6f06bda081cab=
2f4bded8d47ed </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1082 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--lb9uknvPrbI=--


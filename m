From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 3 Aug 2025 14:48:29 +0000
In-Reply-To: <gerrit.1753966620000.Idfe5c615d1109a1038207c1c1b0e0de4da3279f5@...2715...>
References: <gerrit.1753966620000.Idfe5c615d1109a1038207c1c1b0e0de4da3279f5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b4614ec01b257991693aa927238f901c98523981-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4exFmQzWCHE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Update text of GPL
 to latest version from FSF
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

--4exFmQzWCHE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1123?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Update text of GPL to latest version from FSF
......................................................................

Update text of GPL to latest version from FSF

This mostly removes the postal address of the FSF.

This was triggered by rpmlint complaining about
that address being outdated.

Change-Id: Idfe5c615d1109a1038207c1c1b0e0de4da3279f5
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250803143939.15335-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
475.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M COPYRIGHT.GPL
M tests/unit_tests/openvpn/test_misc.c
2 files changed, 8 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/1123/3

diff --git a/COPYRIGHT.GPL b/COPYRIGHT.GPL
index 2a591d0..9efa6fb 100644
--- a/COPYRIGHT.GPL
+++ b/COPYRIGHT.GPL
@@ -2,7 +2,7 @@
                        Version 2, June 1991

  Copyright (C) 1989, 1991 Free Software Foundation, Inc.,
- 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ <https://fsf.org/>
  Everyone is permitted to copy and distribute verbatim copies
  of this license document, but changing it is not allowed.

@@ -294,8 +294,9 @@
     Copyright (C) <year>  <name of author>

     This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License version 2
-    as published by the Free Software Foundation.
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.

     This program is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
@@ -303,8 +304,7 @@
     GNU General Public License for more details.

     You should have received a copy of the GNU General Public License along
-    with this program; if not, write to the Free Software Foundation, Inc.,
-    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+    with this program; if not, see <https://www.gnu.org/licenses/>.

 Also add information on how to contact you by electronic and paper mail.

@@ -328,8 +328,8 @@
   Yoyodyne, Inc., hereby disclaims all copyright interest in the program
   `Gnomovision' (which makes passes at compilers) written by James Hacker.

-  <signature of Ty Coon>, 1 April 1989
-  Ty Coon, President of Vice
+  <signature of Moe Ghoul>, 1 April 1989
+  Moe Ghoul, President of Vice

 This General Public License does not permit incorporating your program into
 proprietary programs.  If your program is a subroutine library, you may
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvp=
n/test_misc.c
index 0c604ff..0981a1a 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -240,7 +240,7 @@
         while (c);
     }

-    assert_int_equal(wordcount, 2978);
+    assert_int_equal(wordcount, 2971);

     /* remove some words from the table */
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1123?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idfe5c615d1109a1038207c1c1b0e0de4da3279f5
Gerrit-Change-Number: 1123
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--4exFmQzWCHE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #3</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1123?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Update text of GPL to latest version from FSF<br><br=
>This mostly removes the postal address of the FSF.<br><br>This was trigger=
ed by rpmlint complaining about<br>that address being outdated.<br><br>Chan=
ge-Id: Idfe5c615d1109a1038207c1c1b0e0de4da3279f5<br>Signed-off-by: Frank Li=
chtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1711...=
96...&gt;<br>Message-Id: &lt;20250803143939.15335-1-gert@...1296...&gt;<br>=
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
475.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M=
 COPYRIGHT.GPL<br>M tests/unit_tests/openvpn/test_misc.c<br>2 files changed=
, 8 insertions(+), 8 deletions(-)<br><br></pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.n=
et:29418/openvpn refs/changes/23/1123/3</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/COPYRIGHT.GPL =
b/COPYRIGHT.GPL</span><br><span>index 2a591d0..9efa6fb 100644</span><br><sp=
an>--- a/COPYRIGHT.GPL</span><br><span>+++ b/COPYRIGHT.GPL</span><br><span>=
@@ -2,7 +2,7 @@</span><br><span>                        Version 2, June 199=
1</span><br><span> </span><br><span>  Copyright (C) 1989, 1991 Free Softwar=
e Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- 5=
1 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ &lt;https://fsf.org/&gt;</span><br><=
span>  Everyone is permitted to copy and distribute verbatim copies</span><=
br><span>  of this license document, but changing it is not allowed.</span>=
<br><span> </span><br><span>@@ -294,8 +294,9 @@</span><br><span>     Copyri=
ght (C) &lt;year&gt;  &lt;name of author&gt;</span><br><span> </span><br><s=
pan>     This program is free software; you can redistribute it and/or modi=
fy</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    it under the te=
rms of the GNU General Public License version 2</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    as published by the Free Software Foundation.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    it under the te=
rms of the GNU General Public License as published by</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    the Free Software Foundation; either =
version 2 of the License, or</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    (at your option) any later version.</span><br><span> </span><b=
r><span>     This program is distributed in the hope that it will be useful=
,</span><br><span>     but WITHOUT ANY WARRANTY; without even the implied w=
arranty of</span><br><span>@@ -303,8 +304,7 @@</span><br><span>     GNU Gen=
eral Public License for more details.</span><br><span> </span><br><span>   =
  You should have received a copy of the GNU General Public License along</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    with this program; =
if not, write to the Free Software Foundation, Inc.,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    51 Franklin Street, Fifth Floor, Boston=
, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.<=
/span><br><span> </span><br><span> Also add information on how to contact y=
ou by electronic and paper mail.</span><br><span> </span><br><span>@@ -328,=
8 +328,8 @@</span><br><span>   Yoyodyne, Inc., hereby disclaims all copyrig=
ht interest in the program</span><br><span>   `Gnomovision&#39; (which make=
s passes at compilers) written by James Hacker.</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;signature of Ty Coon&gt;,=
 1 April 1989</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Ty Coo=
n, President of Vice</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  &lt;signature of Moe Ghoul&gt;, 1 April 1989</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  Moe Ghoul, President of Vice</span><br><span>=
 </span><br><span> This General Public License does not permit incorporatin=
g your program into</span><br><span> proprietary programs.  If your program=
 is a subroutine library, you may</span><br><span>diff --git a/tests/unit_t=
ests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c</span><br><=
span>index 0c604ff..0981a1a 100644</span><br><span>--- a/tests/unit_tests/o=
penvpn/test_misc.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_misc=
.c</span><br><span>@@ -240,7 +240,7 @@</span><br><span>         while (c);<=
/span><br><span>     }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    assert_int_equal(wordcount, 2978);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(wordcount, 2971)=
;</span><br><span> </span><br><span>     /* remove some words from the tabl=
e */</span><br><span>     {</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1123?usp=3Demail">chan=
ge 1123</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope it=
emtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action=
" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1123?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idfe5c615d1109a1038207c1c1b0=
e0de4da3279f5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1123 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--4exFmQzWCHE=--


From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 31 Jul 2025 12:57:10 +0000
References: <gerrit.1753966620000.Idfe5c615d1109a1038207c1c1b0e0de4da3279f5@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <4d3ab05c9b57b42642ff9ed54a81403749339736-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ymVbpkCvnxM="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ymVbpkCvnxM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1123?usp=3Demail

to review the following change.


Change subject: Update text of GPL to latest version from FSF
......................................................................

Update text of GPL to latest version from FSF

This mostly removes the postal address of the
FSF.

This was triggered by rpmlint complaining about
that address being outdated.

Change-Id: Idfe5c615d1109a1038207c1c1b0e0de4da3279f5
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M COPYRIGHT.GPL
1 file changed, 7 insertions(+), 7 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/1123/1

diff --git a/COPYRIGHT.GPL b/COPYRIGHT.GPL
index 2a591d0..9efa6fb 100644
--- a/COPYRIGHT.GPL
+++ b/COPYRIGHT.GPL
@@ -2,7 +2,7 @@
                        Version 2, June 1991
=20
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1123?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idfe5c615d1109a1038207c1c1b0e0de4da3279f5
Gerrit-Change-Number: 1123
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--ymVbpkCvnxM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1123?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Update text of GPL to latest version from FSF<br><br>This mo=
stly removes the postal address of the<br>FSF.<br><br>This was triggered by=
 rpmlint complaining about<br>that address being outdated.<br><br>Change-Id=
: Idfe5c615d1109a1038207c1c1b0e0de4da3279f5<br>Signed-off-by: Frank Lichten=
held &lt;frank@...2641...&gt;<br>---<br>M COPYRIGHT.GPL<br>1 file changed, =
7 insertions(+), 7 deletions(-)<br><br></pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net=
:29418/openvpn refs/changes/23/1123/1</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/COPYRIGHT.GPL b/=
COPYRIGHT.GPL</span><br><span>index 2a591d0..9efa6fb 100644</span><br><span=
>--- a/COPYRIGHT.GPL</span><br><span>+++ b/COPYRIGHT.GPL</span><br><span>@@=
 -2,7 +2,7 @@</span><br><span>                        Version 2, June 1991<=
/span><br><span> </span><br><span>  Copyright (C) 1989, 1991 Free Software =
Foundation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- 51 =
Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ &lt;https://fsf.org/&gt;</span><br><sp=
an>  Everyone is permitted to copy and distribute verbatim copies</span><br=
><span>  of this license document, but changing it is not allowed.</span><b=
r><span> </span><br><span>@@ -294,8 +294,9 @@</span><br><span>     Copyrigh=
t (C) &lt;year&gt;  &lt;name of author&gt;</span><br><span> </span><br><spa=
n>     This program is free software; you can redistribute it and/or modify=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    it under the term=
s of the GNU General Public License version 2</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    as published by the Free Software Foundation.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    it under the term=
s of the GNU General Public License as published by</span><br><span style=
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
 is a subroutine library, you may</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1123?usp=3Demail=
">change 1123</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1123?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idfe5c615d1109a1038207c1c1b0=
e0de4da3279f5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1123 </div>
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


--ymVbpkCvnxM=--


From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 3 Aug 2025 14:48:31 +0000
In-Reply-To: <gerrit.1753966620000.Idfe5c615d1109a1038207c1c1b0e0de4da3279f5@...2715...>
References: <gerrit.1753966620000.Idfe5c615d1109a1038207c1c1b0e0de4da3279f5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b4614ec01b257991693aa927238f901c98523981-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yhLxdQzZ+QY="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--yhLxdQzZ+QY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
23?usp=3Demail )

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
Gerrit-MessageType: merged

--yhLxdQzZ+QY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1123?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Update text of GPL to latest version from FSF=
<br><br>This mostly removes the postal address of the FSF.<br><br>This was =
triggered by rpmlint complaining about<br>that address being outdated.<br><=
br>Change-Id: Idfe5c615d1109a1038207c1c1b0e0de4da3279f5<br>Signed-off-by: F=
rank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;ger=
t@...1296...&gt;<br>Message-Id: &lt;20250803143939.15335-1-gert@...1296...&=
gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...475...=
t/msg32475.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>-=
--<br>M COPYRIGHT.GPL<br>M tests/unit_tests/openvpn/test_misc.c<br>2 files =
changed, 8 insertions(+), 8 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/COPYRIGHT.GPL b/COPYRIGHT.GPL</span><br><span>index 2a591d0=
..9efa6fb 100644</span><br><span>--- a/COPYRIGHT.GPL</span><br><span>+++ b/=
COPYRIGHT.GPL</span><br><span>@@ -2,7 +2,7 @@</span><br><span>             =
           Version 2, June 1991</span><br><span> </span><br><span>  Copyrig=
ht (C) 1989, 1991 Free Software Foundation, Inc.,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- 51 Franklin Street, Fifth Floor, Boston, MA 02=
110-1301 USA</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ &lt;ht=
tps://fsf.org/&gt;</span><br><span>  Everyone is permitted to copy and dist=
ribute verbatim copies</span><br><span>  of this license document, but chan=
ging it is not allowed.</span><br><span> </span><br><span>@@ -294,8 +294,9 =
@@</span><br><span>     Copyright (C) &lt;year&gt;  &lt;name of author&gt;<=
/span><br><span> </span><br><span>     This program is free software; you c=
an redistribute it and/or modify</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    it under the terms of the GNU General Public License version=
 2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    as published by=
 the Free Software Foundation.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    it under the terms of the GNU General Public License as publ=
ished by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    the Fre=
e Software Foundation; either version 2 of the License, or</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    (at your option) any later versi=
on.</span><br><span> </span><br><span>     This program is distributed in t=
he hope that it will be useful,</span><br><span>     but WITHOUT ANY WARRAN=
TY; without even the implied warranty of</span><br><span>@@ -303,8 +304,7 @=
@</span><br><span>     GNU General Public License for more details.</span><=
br><span> </span><br><span>     You should have received a copy of the GNU =
General Public License along</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    with this program; if not, write to the Free Software Foundation=
, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    51 Frankli=
n Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    with this program; if not, see &lt;https:=
//www.gnu.org/licenses/&gt;.</span><br><span> </span><br><span> Also add in=
formation on how to contact you by electronic and paper mail.</span><br><sp=
an> </span><br><span>@@ -328,8 +328,8 @@</span><br><span>   Yoyodyne, Inc.,=
 hereby disclaims all copyright interest in the program</span><br><span>   =
`Gnomovision&#39; (which makes passes at compilers) written by James Hacker=
.</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
&lt;signature of Ty Coon&gt;, 1 April 1989</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  Ty Coon, President of Vice</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  &lt;signature of Moe Ghoul&gt;, 1 April 198=
9</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Moe Ghoul, Presi=
dent of Vice</span><br><span> </span><br><span> This General Public License=
 does not permit incorporating your program into</span><br><span> proprieta=
ry programs.  If your program is a subroutine library, you may</span><br><s=
pan>diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/op=
envpn/test_misc.c</span><br><span>index 0c604ff..0981a1a 100644</span><br><=
span>--- a/tests/unit_tests/openvpn/test_misc.c</span><br><span>+++ b/tests=
/unit_tests/openvpn/test_misc.c</span><br><span>@@ -240,7 +240,7 @@</span><=
br><span>         while (c);</span><br><span>     }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(wordco=
unt, 2978);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(wordcount, 2971);</span><br><span> </span><br><span>     /* re=
move some words from the table */</span><br><span>     {</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1123?usp=3Demail">change 1123</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1123?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--yhLxdQzZ+QY=--


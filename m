From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 9 Apr 2025 12:46:10 +0000
References: <gerrit.1744202768000.Ia7186b528773c0549748f1051c1c8d1db39a7e11@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <43ef315cce2f38f8c9eb06213127dc325f28a38d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EswHDtamKPU="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Doxygen: Remove
 useless Python information
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

--EswHDtamKPU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/939?usp=3Demail

to review the following change.


Change subject: Doxygen: Remove useless Python information
......................................................................

Doxygen: Remove useless Python information

Do not include information for the trivial Python
scripts we have. Completely eliminates the "Namespaces"
page as well.

Change-Id: Ia7186b528773c0549748f1051c1c8d1db39a7e11
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M doc/doxygen/openvpn.doxyfile.in
1 file changed, 1 insertion(+), 30 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/939/1

diff --git a/doc/doxygen/openvpn.doxyfile.in b/doc/doxygen/openvpn.doxyfile=
.in
index 573b7c2..edecc54 100644
--- a/doc/doxygen/openvpn.doxyfile.in
+++ b/doc/doxygen/openvpn.doxyfile.in
@@ -894,36 +894,7 @@
 # *.ucf, *.qsf and *.ice.

 FILE_PATTERNS          =3D *.c \
-                         *.cc \
-                         *.cxx \
-                         *.cpp \
-                         *.c++ \
-                         *.d \
-                         *.java \
-                         *.ii \
-                         *.ixx \
-                         *.ipp \
-                         *.i++ \
-                         *.inl \
-                         *.h \
-                         *.hh \
-                         *.hxx \
-                         *.hpp \
-                         *.h++ \
-                         *.idl \
-                         *.odl \
-                         *.cs \
-                         *.php \
-                         *.php3 \
-                         *.inc \
-                         *.m \
-                         *.mm \
-                         *.dox \
-                         *.py \
-                         *.f90 \
-                         *.f \
-                         *.vhd \
-                         *.vhdl
+                         *.h

 # The RECURSIVE tag can be used to specify whether or not subdirectories s=
hould
 # be searched for input files as well.

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/939?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia7186b528773c0549748f1051c1c8d1db39a7e11
Gerrit-Change-Number: 939
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--EswHDtamKPU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/939?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Doxygen: Remove useless Python information<br><br>Do not incl=
ude information for the trivial Python<br>scripts we have. Completely elimi=
nates the &quot;Namespaces&quot;<br>page as well.<br><br>Change-Id: Ia7186b=
528773c0549748f1051c1c8d1db39a7e11<br>Signed-off-by: Frank Lichtenheld &lt;=
frank@...2641...&gt;<br>---<br>M doc/doxygen/openvpn.doxyfile.in<br>1 file =
changed, 1 insertion(+), 30 deletions(-)<br><br></pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.op=
envpn.net:29418/openvpn refs/changes/39/939/1</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/doxy=
gen/openvpn.doxyfile.in b/doc/doxygen/openvpn.doxyfile.in</span><br><span>i=
ndex 573b7c2..edecc54 100644</span><br><span>--- a/doc/doxygen/openvpn.doxy=
file.in</span><br><span>+++ b/doc/doxygen/openvpn.doxyfile.in</span><br><sp=
an>@@ -894,36 +894,7 @@</span><br><span> # *.ucf, *.qsf and *.ice.</span><b=
r><span> </span><br><span> FILE_PATTERNS          =3D *.c \</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                         *.cc \</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                         *.=
cxx \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
         *.cpp \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                    *.c++ \</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                         *.d \</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                         *.java \</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                         *.ii \</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                         *.ixx \</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                         *.=
ipp \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
         *.i++ \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                    *.inl \</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                         *.h \</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                         *.hh \</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                         *.hxx \</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                         *.hpp \</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                         *.h=
++ \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
        *.idl \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                   *.odl \</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                         *.cs \</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                         *.php \</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                         *.php3 \</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                         *.inc \</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                         *=
.m \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
        *.mm \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                  *.dox \</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                         *.py \</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                         *.f90 \</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                         *.f \</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                         *.vhd \</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                         *.vhd=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
       *.h</span><br><span> </span><br><span> # The RECURSIVE tag can be us=
ed to specify whether or not subdirectories should</span><br><span> # be se=
arched for input files as well.</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/939?usp=3Demail">c=
hange 939</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/939?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia7186b528773c0549748f1051c1=
c8d1db39a7e11 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 939 </div>
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


--EswHDtamKPU=--


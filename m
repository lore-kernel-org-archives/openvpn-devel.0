From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 15 Apr 2025 18:14:46 +0000
In-Reply-To: <gerrit.1744202768000.Ia7186b528773c0549748f1051c1c8d1db39a7e11@...2715...>
References: <gerrit.1744202768000.Ia7186b528773c0549748f1051c1c8d1db39a7e11@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6cc751b8a7ec56cad45f168035e22ce324671906-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="88T4isyAMec="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--88T4isyAMec=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/93=
9?usp=3Demail )

Change subject: Doxygen: Remove useless Python information
......................................................................

Doxygen: Remove useless Python information

Do not include information for the trivial Python
scripts we have. Completely eliminates the "Namespaces"
page as well.

Change-Id: Ia7186b528773c0549748f1051c1c8d1db39a7e11
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20250415155656.12963-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
433.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/doxygen/openvpn.doxyfile.in
1 file changed, 1 insertion(+), 30 deletions(-)




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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--88T4isyAMec=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/939?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Doxygen: Remove useless Python information<br>=
<br>Do not include information for the trivial Python<br>scripts we have. C=
ompletely eliminates the &quot;Namespaces&quot;<br>page as well.<br><br>Cha=
nge-Id: Ia7186b528773c0549748f1051c1c8d1db39a7e11<br>Signed-off-by: Frank L=
ichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-open=
vpn@...1227...&gt;<br>Message-Id: &lt;20250415155656.12963-1-gert@...2132...=
.&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...290...=
net/msg31433.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br=
>---<br>M doc/doxygen/openvpn.doxyfile.in<br>1 file changed, 1 insertion(+)=
, 30 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/doxygen/openvpn.doxyfile.in b/doc/doxygen/openvpn.doxyf=
ile.in</span><br><span>index 573b7c2..edecc54 100644</span><br><span>--- a/=
doc/doxygen/openvpn.doxyfile.in</span><br><span>+++ b/doc/doxygen/openvpn.d=
oxyfile.in</span><br><span>@@ -894,36 +894,7 @@</span><br><span> # *.ucf, *=
.qsf and *.ice.</span><br><span> </span><br><span> FILE_PATTERNS          =
=3D *.c \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
             *.cc \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                       *.cxx \</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                         *.cpp \</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                         *.c++ \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                         *.d \</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                         *.java \<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
   *.ii \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
             *.ixx \</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                        *.ipp \</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                         *.i++ \</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                         *.inl \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                         *.h \</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                         *.hh \</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
 *.hxx \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
            *.hpp \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                       *.h++ \</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                         *.idl \</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                         *.odl \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                         *.cs \</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                         *.php \<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
   *.php3 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
               *.inc \</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                         *.m \</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                         *.mm \</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                         *.dox \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                         *.py \</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                         *.f90 \<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
   *.f \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
            *.vhd \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                       *.vhdl</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                         *.h</span><br><span> </span><br><span> #=
 The RECURSIVE tag can be used to specify whether or not subdirectories sho=
uld</span><br><span> # be searched for input files as well.</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/939?usp=3Demail">change 939</a>. To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">sett=
ings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/939?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia7186b528773c0549748f1051c1=
c8d1db39a7e11 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 939 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--88T4isyAMec=--


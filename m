From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 27 Nov 2025 12:04:31 +0000
In-Reply-To: <gerrit.1764239370000.Ib15bd4148872db39a4c8291796a5da211bb20a87@...2715...>
References: <gerrit.1764239370000.Ib15bd4148872db39a4c8291796a5da211bb20a87@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5f2f5686995f421d0254cb390f5c0ddde512c8d1-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5C+SiDINRHk="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Remove remainders
 of --no-name-remapping option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5C+SiDINRHk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
11?usp=3Demail )

Change subject: Remove remainders of --no-name-remapping option
......................................................................

Remove remainders of --no-name-remapping option

This option was removed in 2.5 (commit c3f565f059) but still showed
up in the ``openvpn --help`` text and in a Q&A section of the man page.

Change-Id: Ib15bd4148872db39a4c8291796a5da211bb20a87
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1411
Message-Id: <20251127115737.3598-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
754.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/script-options.rst
M src/openvpn/options.c
2 files changed, 2 insertions(+), 4 deletions(-)




diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-=
options.rst
index 670cd33..cadd464 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -571,8 +571,8 @@
     a filename, etc.

 *Q: Can string remapping be disabled?*
-    Yes, by using the ``--no-name-remapping`` option, however this
-    should be considered an advanced option.
+    No.  The options ``--no-name-remapping`` and ``--compat-names`` have
+    been removed in 2.5 because they were considered too insecure.

 Here is a brief rundown of OpenVPN's current string types and the
 permitted character class for each string:
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 5e73196..a3fc19d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -474,8 +474,6 @@
     "                  for generated tokens can be set.\n"
     "--auth-user-pass-optional : Allow connections by clients that don't\n"
     "                  specify a username/password.\n"
-    "--no-name-remapping : (DEPRECATED) Allow Common Name and X509 Subject=
 to include\n"
-    "                      any printable character.\n"
     "--client-to-client : Internally route client-to-client traffic.\n"
     "--duplicate-cn  : Allow multiple clients with the same common name to=
\n"
     "                  concurrently connect.\n"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1411?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib15bd4148872db39a4c8291796a5da211bb20a87
Gerrit-Change-Number: 1411
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5C+SiDINRHk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1411?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Remove remainders of --no-name-remapping option<=
br><br>This option was removed in 2.5 (commit c3f565f059) but still showed<=
br>up in the ``openvpn --help`` text and in a Q&amp;A section of the man pa=
ge.<br><br>Change-Id: Ib15bd4148872db39a4c8291796a5da211bb20a87<br>Signed-o=
ff-by: Gert Doering &lt;gert@...1296...&gt;<br>Acked-by: Frank Lichtenheld =
&lt;frank@...2641...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvp=
n/+/1411<br>Message-Id: &lt;20251127115737.3598-1-gert@...1296...&gt;<br>UR=
L: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg3475=
4.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M d=
oc/man-sections/script-options.rst<br>M src/openvpn/options.c<br>2 files ch=
anged, 2 insertions(+), 4 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/scri=
pt-options.rst</span><br><span>index 670cd33..cadd464 100644</span><br><spa=
n>--- a/doc/man-sections/script-options.rst</span><br><span>+++ b/doc/man-s=
ections/script-options.rst</span><br><span>@@ -571,8 +571,8 @@</span><br><s=
pan>     a filename, etc.</span><br><span> </span><br><span> *Q: Can string=
 remapping be disabled?*</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    Yes, by using the ``--no-name-remapping`` option, however this</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    should be considered an=
 advanced option.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  No.  The options ``--no-name-remapping`` and ``--compat-names`` have</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    been removed in 2.5 =
because they were considered too insecure.</span><br><span> </span><br><spa=
n> Here is a brief rundown of OpenVPN&#39;s current string types and the</s=
pan><br><span> permitted character class for each string:</span><br><span>d=
iff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>i=
ndex 5e73196..a3fc19d 100644</span><br><span>--- a/src/openvpn/options.c</s=
pan><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -474,8 +474,6 =
@@</span><br><span>     &quot;                  for generated tokens can be=
 set.\n&quot;</span><br><span>     &quot;--auth-user-pass-optional : Allow =
connections by clients that don&#39;t\n&quot;</span><br><span>     &quot;  =
                specify a username/password.\n&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &quot;--no-name-remapping : (DEPRECATED=
) Allow Common Name and X509 Subject to include\n&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    &quot;                      any print=
able character.\n&quot;</span><br><span>     &quot;--client-to-client : Int=
ernally route client-to-client traffic.\n&quot;</span><br><span>     &quot;=
--duplicate-cn  : Allow multiple clients with the same common name to\n&quo=
t;</span><br><span>     &quot;                  concurrently connect.\n&quo=
t;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1411?usp=3Demail">change 1411</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1411?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib15bd4148872db39a4c8291796a=
5da211bb20a87 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1411 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--5C+SiDINRHk=--


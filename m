From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 27 Nov 2025 10:29:33 +0000
References: <gerrit.1764239370000.Ib15bd4148872db39a4c8291796a5da211bb20a87@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <bf8a11e1bdc4348376ad8f2e72a455241ca79911-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7eFGzInITZ8="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Remove remainders
 of --no-name-remaping option
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

--7eFGzInITZ8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1411?usp=3Demail

to review the following change.


Change subject: Remove remainders of --no-name-remaping option
......................................................................

Remove remainders of --no-name-remaping option

This option was removed in 2.5 (commit c3f565f059) but still showed
up in the ``openvpn --help`` text and in a Q&A section of the man page.

Change-Id: Ib15bd4148872db39a4c8291796a5da211bb20a87
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/script-options.rst
M src/openvpn/options.c
2 files changed, 2 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/11/1411/1

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
index 4794315..0257418f 100644
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib15bd4148872db39a4c8291796a5da211bb20a87
Gerrit-Change-Number: 1411
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--7eFGzInITZ8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>cron2 would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1411?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Remove remainders of --no-name-remaping opt=
ion<br><br>This option was removed in 2.5 (commit c3f565f059) but still sho=
wed<br>up in the ``openvpn --help`` text and in a Q&amp;A section of the ma=
n page.<br><br>Change-Id: Ib15bd4148872db39a4c8291796a5da211bb20a87<br>Sign=
ed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M doc/man-section=
s/script-options.rst<br>M src/openvpn/options.c<br>2 files changed, 2 inser=
tions(+), 4 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.o=
penvpn.net:29418/openvpn refs/changes/11/1411/1</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/ma=
n-sections/script-options.rst b/doc/man-sections/script-options.rst</span><=
br><span>index 670cd33..cadd464 100644</span><br><span>--- a/doc/man-sectio=
ns/script-options.rst</span><br><span>+++ b/doc/man-sections/script-options=
.rst</span><br><span>@@ -571,8 +571,8 @@</span><br><span>     a filename, e=
tc.</span><br><span> </span><br><span> *Q: Can string remapping be disabled=
?*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Yes, by using t=
he ``--no-name-remapping`` option, however this</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    should be considered an advanced option.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    No.  The options ``-=
-no-name-remapping`` and ``--compat-names`` have</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    been removed in 2.5 because they were cons=
idered too insecure.</span><br><span> </span><br><span> Here is a brief run=
down of OpenVPN&#39;s current string types and the</span><br><span> permitt=
ed character class for each string:</span><br><span>diff --git a/src/openvp=
n/options.c b/src/openvpn/options.c</span><br><span>index 4794315..0257418f=
 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/s=
rc/openvpn/options.c</span><br><span>@@ -474,8 +474,6 @@</span><br><span>  =
   &quot;                  for generated tokens can be set.\n&quot;</span><=
br><span>     &quot;--auth-user-pass-optional : Allow connections by client=
s that don&#39;t\n&quot;</span><br><span>     &quot;                  speci=
fy a username/password.\n&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    &quot;--no-name-remapping : (DEPRECATED) Allow Common Name an=
d X509 Subject to include\n&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    &quot;                      any printable character.\n&quot=
;</span><br><span>     &quot;--client-to-client : Internally route client-t=
o-client traffic.\n&quot;</span><br><span>     &quot;--duplicate-cn  : Allo=
w multiple clients with the same common name to\n&quot;</span><br><span>   =
  &quot;                  concurrently connect.\n&quot;</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1411?usp=3Demail">change 1411</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3De=
mail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1411?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib15bd4148872db39a4c8291796a=
5da211bb20a87 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1411 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--7eFGzInITZ8=--


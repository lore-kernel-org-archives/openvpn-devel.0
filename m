From: "selvanair (Code Review)" <gerrit@...515...>
Date: Thu, 4 Dec 2025 01:44:23 +0000
References: <gerrit.1764812658000.I2c8d40038e52fbdff1c56f93db1e6a2f9255c59a@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <c4207f645b9a2fdb86e5a97d68ae987cecd34c8a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kkIKeFxxhH8="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: pull-filter:
 improve documentation
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

--kkIKeFxxhH8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1415?usp=3Demail

to review the following change.


Change subject: pull-filter: improve documentation
......................................................................

pull-filter: improve documentation

Pull-filter uses a simple string comparison and could be defeated by
unusual formatting of pushed option strings. Document that this
option is not meant to be used as a security measure.

Reported by: <aarnav@...2953...>

Change-Id: I2c8d40038e52fbdff1c56f93db1e6a2f9255c59a
Signed-off-by: Selva Nair <selva.nair@...277...>
---
M doc/man-sections/client-options.rst
1 file changed, 8 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/15/1415/1

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-=
options.rst
index e8523d9..f3073f8 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -345,6 +345,14 @@
   next remote succeeds. To silently ignore an option pushed by the server,
   use :code:`ignore`.

+  *Warning:* ``pull-filter`` cannot be relied upon as a security measure to
+  protect against offending options pushed by a server. For example, the
+  filter could be defeated by pushing options with extra spaces between
+  tokens or other formatting variations. In such situations, an "allow-lis=
t"
+  approach using a generic ``pull-filter ignore`` followed by more specific
+  ``pull-filter accept`` directives should be preferred over a "deny-list"
+  approach.
+
 --push-peer-info
   Push additional information about the client to server. The following
   data is always pushed to the server:

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1415?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2c8d40038e52fbdff1c56f93db1e6a2f9255c59a
Gerrit-Change-Number: 1415
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--kkIKeFxxhH8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>selvanair would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1415?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">pull-filter: improve documentation<br><br>P=
ull-filter uses a simple string comparison and could be defeated by<br>unus=
ual formatting of pushed option strings. Document that this<br>option is no=
t meant to be used as a security measure.<br><br>Reported by: &lt;aarnav@...1186...=
.2953...&gt;<br><br>Change-Id: I2c8d40038e52fbdff1c56f93db1e6a2f9255c59a<br=
>Signed-off-by: Selva Nair &lt;selva.nair@...277...&gt;<br>---<br>M doc/man=
-sections/client-options.rst<br>1 file changed, 8 insertions(+), 0 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/ope=
nvpn refs/changes/15/1415/1</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/client-op=
tions.rst b/doc/man-sections/client-options.rst</span><br><span>index e8523=
d9..f3073f8 100644</span><br><span>--- a/doc/man-sections/client-options.rs=
t</span><br><span>+++ b/doc/man-sections/client-options.rst</span><br><span=
>@@ -345,6 +345,14 @@</span><br><span>   next remote succeeds. To silently =
ignore an option pushed by the server,</span><br><span>   use :code:`ignore=
`.</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  *Warning:* ``pull-filter`` cannot be relied upon as a security measure t=
o</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  protect against =
offending options pushed by a server. For example, the</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  filter could be defeated by pushing op=
tions with extra spaces between</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  tokens or other formatting variations. In such situations, an=
 &quot;allow-list&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  approach using a generic ``pull-filter ignore`` followed by more spec=
ific</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``pull-filter=
 accept`` directives should be preferred over a &quot;deny-list&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  approach.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --push-peer-inf=
o</span><br><span>   Push additional information about the client to server=
. The following</span><br><span>   data is always pushed to the server:</sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1415?usp=3Demail">change 1415</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1415?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2c8d40038e52fbdff1c56f93db1=
e6a2f9255c59a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1415 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--kkIKeFxxhH8=--


From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 9 Dec 2025 09:00:53 +0000
In-Reply-To: <gerrit.1764812658000.I2c8d40038e52fbdff1c56f93db1e6a2f9255c59a@...2715...>
References: <gerrit.1764812658000.I2c8d40038e52fbdff1c56f93db1e6a2f9255c59a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <705ab28722243a980a8c6e29c09377b42e28b260-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="L8T3BiRz1HI="; charset=UTF-8
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
To: selvanair <selva.nair@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--L8T3BiRz1HI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
15?usp=3Demail )

Change subject: pull-filter: improve documentation
......................................................................

pull-filter: improve documentation

Pull-filter uses a simple string comparison and could be defeated by
unusual formatting of pushed option strings. Document that this
option is not meant to be used as a security measure.

Reported by: <aarnav@...2953...>

Change-Id: I2c8d40038e52fbdff1c56f93db1e6a2f9255c59a
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1415
Message-Id: <20251209070218.4467-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
930.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/client-options.rst
1 file changed, 5 insertions(+), 0 deletions(-)




diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-=
options.rst
index ca4c8e9..b9ae7ce 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -345,6 +345,11 @@
   next remote succeeds. To silently ignore an option pushed by the server,
   use :code:`ignore`.

+  *Warning:* ``pull-filter`` cannot be relied upon as a security measure to
+  protect against offending options pushed by a server. For example, the
+  filter could be defeated by pushing options with extra spaces between
+  tokens or other formatting variations.
+
 --push-peer-info
   Push additional information about the client to server. The following
   data is always pushed to the server:

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1415?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2c8d40038e52fbdff1c56f93db1e6a2f9255c59a
Gerrit-Change-Number: 1415
Gerrit-PatchSet: 4
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--L8T3BiRz1HI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1415?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">pull-filter: improve documentation<br><br>Pull-f=
ilter uses a simple string comparison and could be defeated by<br>unusual f=
ormatting of pushed option strings. Document that this<br>option is not mea=
nt to be used as a security measure.<br><br>Reported by: &lt;aarnav@...2974...=
...&gt;<br><br>Change-Id: I2c8d40038e52fbdff1c56f93db1e6a2f9255c59a<br>Sign=
ed-off-by: Selva Nair &lt;selva.nair@...277...&gt;<br>Acked-by: Gert Doerin=
g &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openv=
pn/+/1415<br>Message-Id: &lt;20251209070218.4467-1-gert@...1296...&gt;<br>U=
RL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg349=
30.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M =
doc/man-sections/client-options.rst<br>1 file changed, 5 insertions(+), 0 d=
eletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/clie=
nt-options.rst</span><br><span>index ca4c8e9..b9ae7ce 100644</span><br><spa=
n>--- a/doc/man-sections/client-options.rst</span><br><span>+++ b/doc/man-s=
ections/client-options.rst</span><br><span>@@ -345,6 +345,11 @@</span><br><=
span>   next remote succeeds. To silently ignore an option pushed by the se=
rver,</span><br><span>   use :code:`ignore`.</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  *Warning:* ``pull-filter`` can=
not be relied upon as a security measure to</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  protect against offending options pushed by a ser=
ver. For example, the</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  filter could be defeated by pushing options with extra spaces between</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  tokens or other for=
matting variations.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> --push-peer-info</span><br><span>   Push additional infor=
mation about the client to server. The following</span><br><span>   data is=
 always pushed to the server:</span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1415?usp=3Demail">ch=
ange 1415</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1415?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2c8d40038e52fbdff1c56f93db1=
e6a2f9255c59a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1415 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--L8T3BiRz1HI=--


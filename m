From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 8 Mar 2024 13:09:26 +0000
In-Reply-To: <gerrit.1709557301000.If9cb7d66f079fe1c87fcb5b4e59bc887533d77fa@...2715...>
References: <gerrit.1709557301000.If9cb7d66f079fe1c87fcb5b4e59bc887533d77fa@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <53a8b7f9f21318a50e0b8e940231491e0ecccf36-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DH0nM1S5ixs="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: gerrit-send-mail:
 add missing Signed-off-by
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

--DH0nM1S5ixs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/530?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: gerrit-send-mail: add missing Signed-off-by
......................................................................

gerrit-send-mail: add missing Signed-off-by

Our development documentation says we add this
automatically when it is missing. So let's do that
here as well.

Change-Id: If9cb7d66f079fe1c87fcb5b4e59bc887533d77fa
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240308120557.9065-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
362.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M dev-tools/gerrit-send-mail.py
1 file changed, 13 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/30/530/2

diff --git a/dev-tools/gerrit-send-mail.py b/dev-tools/gerrit-send-mail.py
index 67a2cf1..10305e2 100755
--- a/dev-tools/gerrit-send-mail.py
+++ b/dev-tools/gerrit-send-mail.py
@@ -50,6 +50,12 @@
                 ack =3D f"{reviewer_name} <{reviewer_mail}>"
                 print(f"Acked-by: {ack}")
                 acked_by.append(ack)
+    # construct Signed-off-by in case it is missing
+    owner =3D json_data["owner"]
+    owner_name =3D owner.get("display_name", owner["name"])
+    owner_mail =3D owner.get("email", owner["name"])
+    sign_off =3D f"{owner_name} <{owner_mail}>"
+    print(f"Signed-off-by: {sign_off}")
     change_id =3D json_data["change_id"]
     # assumes that the created date in Gerrit is in UTC
     utc_stamp =3D (
@@ -67,6 +73,7 @@
         "target": json_data["branch"],
         "msg_id": msg_id,
         "acked_by": acked_by,
+        "sign_off": sign_off,
     }


@@ -81,10 +88,14 @@

 def apply_patch_mods(patch_text, details, args):
     comment_start =3D patch_text.index("\n---\n") + len("\n---\n")
+    signed_off_text =3D ""
+    signed_off_comment =3D ""
     try:
         signed_off_start =3D patch_text.rindex("\nSigned-off-by: ")
         signed_off_end =3D patch_text.index("\n", signed_off_start + 1) + 1
     except ValueError:  # Signed-off missing
+        signed_off_text =3D f"Signed-off-by: {details['sign_off']}\n"
+        signed_off_comment =3D "\nSigned-off-by line for the author was ad=
ded as per our policy.\n"
         signed_off_end =3D patch_text.index("\n---\n") + 1
     assert comment_start > signed_off_end
     acked_by_text =3D ""
@@ -94,6 +105,7 @@
         acked_by_names +=3D f"{ack}\n"
     patch_text_mod =3D (
         patch_text[:signed_off_end]
+        + signed_off_text
         + acked_by_text
         + patch_text[signed_off_end:comment_start]
         + f"""
@@ -102,6 +114,7 @@

 Gerrit URL: {args.url}/c/{details["project"]}/+/{args.changeid}
 This mail reflects revision {details["revision"]} of this Change.
+{signed_off_comment}
 Acked-by according to Gerrit (reflected above):
 {acked_by_names}
         """

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/530?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If9cb7d66f079fe1c87fcb5b4e59bc887533d77fa
Gerrit-Change-Number: 530
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--DH0nM1S5ixs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/530?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">gerrit-send-mail: add missing Signed-off-by<br><br>O=
ur development documentation says we add this<br>automatically when it is m=
issing. So let&#39;s do that<br>here as well.<br><br>Change-Id: If9cb7d66f0=
79fe1c87fcb5b4e59bc887533d77fa<br>Signed-off-by: Frank Lichtenheld &lt;fran=
k@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Messa=
ge-Id: &lt;20240308120557.9065-1-gert@...1296...&gt;<br>URL: https://www.ma=
il-archive.com/openvpn-devel@lists.sourceforge.net/msg28362.html<br>Signed-=
off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M dev-tools/gerrit-s=
end-mail.py<br>1 file changed, 13 insertions(+), 0 deletions(-)<br><br></pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/30/530/2</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/dev-tools/gerrit-send-mail.py b/dev-tools/gerrit-send-mail.p=
y</span><br><span>index 67a2cf1..10305e2 100755</span><br><span>--- a/dev-t=
ools/gerrit-send-mail.py</span><br><span>+++ b/dev-tools/gerrit-send-mail.p=
y</span><br><span>@@ -50,6 +50,12 @@</span><br><span>                 ack =
=3D f&quot;{reviewer_name} &lt;{reviewer_mail}&gt;&quot;</span><br><span>  =
               print(f&quot;Acked-by: {ack}&quot;)</span><br><span>        =
         acked_by.append(ack)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    # construct Signed-off-by in case it is missing</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    owner =3D json_data[&quot;own=
er&quot;]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    owner_=
name =3D owner.get(&quot;display_name&quot;, owner[&quot;name&quot;])</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    owner_mail =3D owner.=
get(&quot;email&quot;, owner[&quot;name&quot;])</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    sign_off =3D f&quot;{owner_name} &lt;{owner=
_mail}&gt;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 print(f&quot;Signed-off-by: {sign_off}&quot;)</span><br><span>     change_=
id =3D json_data[&quot;change_id&quot;]</span><br><span>     # assumes that=
 the created date in Gerrit is in UTC</span><br><span>     utc_stamp =3D (<=
/span><br><span>@@ -67,6 +73,7 @@</span><br><span>         &quot;target&quo=
t;: json_data[&quot;branch&quot;],</span><br><span>         &quot;msg_id&qu=
ot;: msg_id,</span><br><span>         &quot;acked_by&quot;: acked_by,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;sign_off&qu=
ot;: sign_off,</span><br><span>     }</span><br><span> </span><br><span> </=
span><br><span>@@ -81,10 +88,14 @@</span><br><span> </span><br><span> def a=
pply_patch_mods(patch_text, details, args):</span><br><span>     comment_st=
art =3D patch_text.index(&quot;\n---\n&quot;) + len(&quot;\n---\n&quot;)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    signed_off_text =
=3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 signed_off_comment =3D &quot;&quot;</span><br><span>     try:</span><br><s=
pan>         signed_off_start =3D patch_text.rindex(&quot;\nSigned-off-by: =
&quot;)</span><br><span>         signed_off_end =3D patch_text.index(&quot;=
\n&quot;, signed_off_start + 1) + 1</span><br><span>     except ValueError:=
  # Signed-off missing</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        signed_off_text =3D f&quot;Signed-off-by: {details[&#39;sign_off=
&#39;]}\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    signed_off_comment =3D &quot;\nSigned-off-by line for the author was ad=
ded as per our policy.\n&quot;</span><br><span>         signed_off_end =3D =
patch_text.index(&quot;\n---\n&quot;) + 1</span><br><span>     assert comme=
nt_start &gt; signed_off_end</span><br><span>     acked_by_text =3D &quot;&=
quot;</span><br><span>@@ -94,6 +105,7 @@</span><br><span>         acked_by_=
names +=3D f&quot;{ack}\n&quot;</span><br><span>     patch_text_mod =3D (</=
span><br><span>         patch_text[:signed_off_end]</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        + signed_off_text</span><br><span=
>         + acked_by_text</span><br><span>         + patch_text[signed_off_=
end:comment_start]</span><br><span>         + f&quot;&quot;&quot;</span><br=
><span>@@ -102,6 +114,7 @@</span><br><span> </span><br><span> Gerrit URL: {=
args.url}/c/{details[&quot;project&quot;]}/+/{args.changeid}</span><br><spa=
n> This mail reflects revision {details[&quot;revision&quot;]} of this Chan=
ge.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{signed_off_comm=
ent}</span><br><span> Acked-by according to Gerrit (reflected above):</span=
><br><span> {acked_by_names}</span><br><span>         &quot;&quot;&quot;</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/530?usp=3Demail">change 530</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/530?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If9cb7d66f079fe1c87fcb5b4e59=
bc887533d77fa </div>
<div style=3D"display:none"> Gerrit-Change-Number: 530 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--DH0nM1S5ixs=--


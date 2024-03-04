From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 4 Mar 2024 13:01:47 +0000
References: <gerrit.1709557301000.If9cb7d66f079fe1c87fcb5b4e59bc887533d77fa@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <f2d3d85807e5c786e198a1bb771285232c72c0b9-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="G7C5Sbn6Ghk="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--G7C5Sbn6Ghk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/530?usp=3Demail

to review the following change.


Change subject: gerrit-send-mail: add missing Signed-off-by
......................................................................

gerrit-send-mail: add missing Signed-off-by

Our development documentation says we add this
automatically when it is missing. So let's do that
here as well.

Change-Id: If9cb7d66f079fe1c87fcb5b4e59bc887533d77fa
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M dev-tools/gerrit-send-mail.py
1 file changed, 13 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/30/530/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--G7C5Sbn6Ghk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/530?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">gerrit-send-mail: add missing Signed-off-by<br><br>Our develo=
pment documentation says we add this<br>automatically when it is missing. S=
o let&#39;s do that<br>here as well.<br><br>Change-Id: If9cb7d66f079fe1c87f=
cb5b4e59bc887533d77fa<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2746...=
...&gt;<br>---<br>M dev-tools/gerrit-send-mail.py<br>1 file changed, 13 ins=
ertions(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2941=
8/openvpn refs/changes/30/530/1</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/dev-tools/gerrit-send-=
mail.py b/dev-tools/gerrit-send-mail.py</span><br><span>index 67a2cf1..1030=
5e2 100755</span><br><span>--- a/dev-tools/gerrit-send-mail.py</span><br><s=
pan>+++ b/dev-tools/gerrit-send-mail.py</span><br><span>@@ -50,6 +50,12 @@<=
/span><br><span>                 ack =3D f&quot;{reviewer_name} &lt;{review=
er_mail}&gt;&quot;</span><br><span>                 print(f&quot;Acked-by: =
{ack}&quot;)</span><br><span>                 acked_by.append(ack)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    # construct Signed-off-b=
y in case it is missing</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    owner =3D json_data[&quot;owner&quot;]</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    owner_name =3D owner.get(&quot;display_name&=
quot;, owner[&quot;name&quot;])</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    owner_mail =3D owner.get(&quot;email&quot;, owner[&quot;nam=
e&quot;])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sign_o=
ff =3D f&quot;{owner_name} &lt;{owner_mail}&gt;&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    print(f&quot;Signed-off-by: {sign_off=
}&quot;)</span><br><span>     change_id =3D json_data[&quot;change_id&quot;=
]</span><br><span>     # assumes that the created date in Gerrit is in UTC<=
/span><br><span>     utc_stamp =3D (</span><br><span>@@ -67,6 +73,7 @@</spa=
n><br><span>         &quot;target&quot;: json_data[&quot;branch&quot;],</sp=
an><br><span>         &quot;msg_id&quot;: msg_id,</span><br><span>         =
&quot;acked_by&quot;: acked_by,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        &quot;sign_off&quot;: sign_off,</span><br><span>     }<=
/span><br><span> </span><br><span> </span><br><span>@@ -81,10 +88,14 @@</sp=
an><br><span> </span><br><span> def apply_patch_mods(patch_text, details, a=
rgs):</span><br><span>     comment_start =3D patch_text.index(&quot;\n---\n=
&quot;) + len(&quot;\n---\n&quot;)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    signed_off_text =3D &quot;&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    signed_off_comment =3D &quot;&quot;</=
span><br><span>     try:</span><br><span>         signed_off_start =3D patc=
h_text.rindex(&quot;\nSigned-off-by: &quot;)</span><br><span>         signe=
d_off_end =3D patch_text.index(&quot;\n&quot;, signed_off_start + 1) + 1</s=
pan><br><span>     except ValueError:  # Signed-off missing</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        signed_off_text =3D f&quot;=
Signed-off-by: {details[&#39;sign_off&#39;]}\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        signed_off_comment =3D &quot;\nSi=
gned-off-by line for the author was added as per our policy.\n&quot;</span>=
<br><span>         signed_off_end =3D patch_text.index(&quot;\n---\n&quot;)=
 + 1</span><br><span>     assert comment_start &gt; signed_off_end</span><b=
r><span>     acked_by_text =3D &quot;&quot;</span><br><span>@@ -94,6 +105,7=
 @@</span><br><span>         acked_by_names +=3D f&quot;{ack}\n&quot;</span=
><br><span>     patch_text_mod =3D (</span><br><span>         patch_text[:s=
igned_off_end]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   + signed_off_text</span><br><span>         + acked_by_text</span><br><sp=
an>         + patch_text[signed_off_end:comment_start]</span><br><span>    =
     + f&quot;&quot;&quot;</span><br><span>@@ -102,6 +114,7 @@</span><br><s=
pan> </span><br><span> Gerrit URL: {args.url}/c/{details[&quot;project&quot=
;]}/+/{args.changeid}</span><br><span> This mail reflects revision {details=
[&quot;revision&quot;]} of this Change.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{signed_off_comment}</span><br><span> Acked-by accordin=
g to Gerrit (reflected above):</span><br><span> {acked_by_names}</span><br>=
<span>         &quot;&quot;&quot;</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/530?usp=3Demail"=
>change 530</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/530?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If9cb7d66f079fe1c87fcb5b4e59=
bc887533d77fa </div>
<div style=3D"display:none"> Gerrit-Change-Number: 530 </div>
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


--G7C5Sbn6Ghk=--


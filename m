From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 20 Sep 2023 12:32:38 +0000
References: <gerrit.1695213156000.If4e9c2e58441efb3fd00872cd62d1cc6c607f160@...2715...>
Reply-To: frank@...2641..., openvpn-devel@lists.sourceforge.net
Message-ID: <b8de12901c47492000cdee19b832003c83e4224d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="v3E/9HpGSKU="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]:
 dev-tools/gerrit-send-mail.py: tool to send Gerrit patchsets to Patch...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--v3E/9HpGSKU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

flichtenheld has uploaded this change for review. ( http://gerrit.openvpn.n=
et/c/openvpn/+/361?usp=3Demail )


Change subject: dev-tools/gerrit-send-mail.py: tool to send Gerrit patchset=
s to Patchwork
......................................................................

dev-tools/gerrit-send-mail.py: tool to send Gerrit patchsets to Patchwork

Since we're trying to use Gerrit for patch reviews, but the actual
merge process is still implemented against the ML and Patchwork,
I wrote a script that attempts to bridge the gap.

It extracts all relevant information about a patch from Gerrit
and converts it into a mail compatible to git-am. Mostly this
work is done by Gerrit already, since we can get the original
patch in git format-patch format. But we add Acked-by information
according to the approvals in Gerrit and some other metadata.

This should allow the merge to happen based on this one mail
alone.

Change-Id: If4e9c2e58441efb3fd00872cd62d1cc6c607f160
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
A dev-tools/gerrit-send-mail.py
1 file changed, 116 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/61/361/1

diff --git a/dev-tools/gerrit-send-mail.py b/dev-tools/gerrit-send-mail.py
new file mode 100644
index 0000000..9aa7a5a
--- /dev/null
+++ b/dev-tools/gerrit-send-mail.py
@@ -0,0 +1,116 @@
+#!/usr/bin/env python3
+
+#  Copyright (C) 2023 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2023 Frank Lichtenheld <frank.lichtenheld@...515...>
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License version 2
+#  as published by the Free Software Foundation.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#  GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License along
+#  with this program; if not, write to the Free Software Foundation, Inc.,
+#  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+# Extract a patch from Gerrit and transform it in a file suitable as input
+# for git send-email.
+
+import argparse
+import base64
+from datetime import timezone
+import json
+import sys
+from urllib.parse import urlparse
+
+import dateutil.parser
+import requests
+
+def get_details(args):
+    params =3D { 'o': [ 'CURRENT_REVISION', 'LABELS', 'DETAILED_ACCOUNTS' =
] }
+    r =3D requests.get(args.url + '/changes/' + args.changeid, params=3Dpa=
rams)
+    print(r.url)
+    json_txt =3D r.text.removeprefix(")]}'\n")
+    json_data =3D json.loads(json_txt)
+    assert len(json_data["revisions"]) =3D=3D 1 # CURRENT_REVISION works a=
s expected
+    revision =3D json_data["revisions"].popitem()[1]["_number"]
+    assert "Code-Review" in json_data["labels"]
+    acked_by =3D []
+    for reviewer in json_data["labels"]["Code-Review"]["all"]:
+        if "value" in reviewer:
+            assert reviewer["value"] >=3D 0 # no NACK
+            if reviewer["value"] =3D=3D 2:
+                ack =3D "{} <{}>".format(reviewer["display_name"], reviewe=
r["email"])
+                print("Acked-by: " + ack)
+                acked_by.append(ack)
+    change_id =3D json_data["change_id"]
+    # assumes that the created date in Gerrit is in UTC
+    utc_stamp =3D dateutil.parser.parse(json_data["created"]).replace(tzin=
fo=3Dtimezone.utc).timestamp()
+    # convert to milliseconds as used in message id
+    created_stamp =3D int(utc_stamp * 1000)
+    hostname =3D urlparse(args.url).hostname
+    msg_id =3D f"gerrit.{created_stamp}.{change_id}@{hostname}"
+    return { "revision": revision,
+             "project": json_data["project"],
+             "target": json_data["branch"],
+             "msg_id": msg_id,
+             "acked_by": acked_by }
+
+def get_patch(details, args):
+    r =3D requests.get("{}/changes/{}/revisions/{}/patch?download".format(=
args.url, args.changeid, details["revision"]))
+    print(r.url)
+    patch_text =3D base64.b64decode(r.text).decode()
+    return patch_text
+
+def apply_patch_mods(patch_text, details, args):
+    signed_off_start =3D patch_text.rindex("\nSigned-off-by: ")
+    signed_off_end =3D patch_text.index("\n", signed_off_start + 1) + 1;
+    comment_start =3D patch_text.index("\n---\n") + len("\n---\n")
+    assert comment_start > signed_off_end
+    acked_by_text =3D ""
+    acked_by_names =3D ""
+    for ack in details["acked_by"]:
+        acked_by_text +=3D f"Acked-by: {ack}\n"
+        acked_by_names +=3D f"{ack}\n"
+    patch_text_mod =3D patch_text[:signed_off_end] \
+        + acked_by_text \
+        + patch_text[signed_off_end:comment_start] \
+        + """
+This change was reviewed on Gerrit and approved by at least one
+developer. I request to merge it to {target}.
+
+Gerrit URL: {url}/c/{project}/+/{changeid}
+This mail reflects revision {revision} of this Change.
+Acked-by according to Gerrit (reflected above):
+{acked_by_names}
+        """.format(
+            url=3Dargs.url,
+            changeid=3Dargs.changeid,
+            acked_by_names=3Dacked_by_names,
+            **details
+        ) \
+        + patch_text[comment_start:]
+    filename =3D "gerrit-{}-{}.patch".format(args.changeid, details["revis=
ion"])
+    with open(filename, "w") as patch_file:
+        patch_file.write(patch_text_mod)
+    print("send with:")
+    print("git send-email --in-reply-to {} {}".format(details["msg_id"], f=
ilename))
+
+def main():
+    parser =3D argparse.ArgumentParser(
+        prog=3D"gerrit-send-mail",
+        description=3D"Send patchset from Gerrit to mailing list",
+    )
+    parser.add_argument('changeid')
+    parser.add_argument('-u', '--url', default=3D'https://gerrit.openvpn.n=
et')
+    args =3D parser.parse_args()
+
+    details =3D get_details(args)
+    patch =3D get_patch(details, args)
+    apply_patch_mods(patch, details, args)
+
+if __name__ =3D=3D "__main__":
+    sys.exit(main())

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/361?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If4e9c2e58441efb3fd00872cd62d1cc6c607f160
Gerrit-Change-Number: 361
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newchange

--v3E/9HpGSKU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>flichtenheld has uploaded this change for <strong>review</strong>.</p><p=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/361?usp=3Demail">View Cha=
nge</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">dev-tools/gerrit-send-mail.py: tool to send Gerrit patchsets to Pat=
chwork<br><br>Since we&#39;re trying to use Gerrit for patch reviews, but t=
he actual<br>merge process is still implemented against the ML and Patchwor=
k,<br>I wrote a script that attempts to bridge the gap.<br><br>It extracts =
all relevant information about a patch from Gerrit<br>and converts it into =
a mail compatible to git-am. Mostly this<br>work is done by Gerrit already,=
 since we can get the original<br>patch in git format-patch format. But we =
add Acked-by information<br>according to the approvals in Gerrit and some o=
ther metadata.<br><br>This should allow the merge to happen based on this o=
ne mail<br>alone.<br><br>Change-Id: If4e9c2e58441efb3fd00872cd62d1cc6c607f1=
60<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>A=
 dev-tools/gerrit-send-mail.py<br>1 file changed, 116 insertions(+), 0 dele=
tions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/cha=
nges/61/361/1</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/dev-tools/gerrit-send-mail.py b/dev-tool=
s/gerrit-send-mail.py</span><br><span>new file mode 100644</span><br><span>=
index 0000000..9aa7a5a</span><br><span>--- /dev/null</span><br><span>+++ b/=
dev-tools/gerrit-send-mail.py</span><br><span>@@ -0,0 +1,116 @@</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#!/usr/bin/env python3</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#  Copyright (C) 2023 OpenVPN Inc &lt;sales@...493...=
515...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  Copyri=
ght (C) 2023 Frank Lichtenheld &lt;frank.lichtenheld@...515...&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#  This program is free software; you can redi=
stribute it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#  it under the terms of the GNU General Public License version 2</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#  as published by the =
Free Software Foundation.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  This prog=
ram is distributed in the hope that it will be useful,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#  but WITHOUT ANY WARRANTY; without eve=
n the implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#  GNU General Public Li=
cense for more details.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  You should =
have received a copy of the GNU General Public License along</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#  with this program; if not, writ=
e to the Free Software Foundation, Inc.,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#  51 Franklin Street, Fifth Floor, Boston, MA 02110-1=
301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# Extract a patch from Gerrit =
and transform it in a file suitable as input</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+# for git send-email.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+import argparse</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+import base64</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fr=
om datetime import timezone</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+import json</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
import sys</span><br><span style=3D"color: hsl(120, 100%, 40%);">+from urll=
ib.parse import urlparse</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import dateuti=
l.parser</span><br><span style=3D"color: hsl(120, 100%, 40%);">+import requ=
ests</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+def get_details(args):</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    params =3D { &#39;o&#39;: [=
 &#39;CURRENT_REVISION&#39;, &#39;LABELS&#39;, &#39;DETAILED_ACCOUNTS&#39; =
] }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r =3D reques=
ts.get(args.url + &#39;/changes/&#39; + args.changeid, params=3Dparams)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    print(r.url)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    json_txt =3D r.text.re=
moveprefix(&quot;)]}&#39;\n&quot;)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    json_data =3D json.loads(json_txt)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert len(json_data[&quot;revisions&=
quot;]) =3D=3D 1 # CURRENT_REVISION works as expected</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    revision =3D json_data[&quot;revision=
s&quot;].popitem()[1][&quot;_number&quot;]</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert &quot;Code-Review&quot; in json_data[&quo=
t;labels&quot;]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
acked_by =3D []</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
for reviewer in json_data[&quot;labels&quot;][&quot;Code-Review&quot;][&quo=
t;all&quot;]:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if &quot;value&quot; in reviewer:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            assert reviewer[&quot;value&quot;] &gt;=3D 0 # =
no NACK</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
if reviewer[&quot;value&quot;] =3D=3D 2:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                ack =3D &quot;{} &lt;{}&gt;&quot;.form=
at(reviewer[&quot;display_name&quot;], reviewer[&quot;email&quot;])</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                print(&quot=
;Acked-by: &quot; + ack)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                acked_by.append(ack)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    change_id =3D json_data[&quot;change_id&quot;]</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    # assumes that the=
 created date in Gerrit is in UTC</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    utc_stamp =3D dateutil.parser.parse(json_data[&quot;creat=
ed&quot;]).replace(tzinfo=3Dtimezone.utc).timestamp()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    # convert to milliseconds as used in =
message id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    creat=
ed_stamp =3D int(utc_stamp * 1000)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    hostname =3D urlparse(args.url).hostname</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    msg_id =3D f&quot;gerrit.{creat=
ed_stamp}.{change_id}@{hostname}&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return { &quot;revision&quot;: revision,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+             &quot;project&quot=
;: json_data[&quot;project&quot;],</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+             &quot;target&quot;: json_data[&quot;branch&quot=
;],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             &qu=
ot;msg_id&quot;: msg_id,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+             &quot;acked_by&quot;: acked_by }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+def get_patch(details, args):</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    r =3D requests.get(&quot;{}/changes/{}/revisions/=
{}/patch?download&quot;.format(args.url, args.changeid, details[&quot;revis=
ion&quot;]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pri=
nt(r.url)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    patch_=
text =3D base64.b64decode(r.text).decode()</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return patch_text</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+def apply_patch_mods(patch_text, details, args):</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    signed_off_start =3D patch_text.rind=
ex(&quot;\nSigned-off-by: &quot;)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    signed_off_end =3D patch_text.index(&quot;\n&quot;, signe=
d_off_start + 1) + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    comment_start =3D patch_text.index(&quot;\n---\n&quot;) + len(&quot;\=
n---\n&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert comment_start &gt; signed_off_end</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    acked_by_text =3D &quot;&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    acked_by_names =3D &quot;&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    for ack in details[&q=
uot;acked_by&quot;]:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        acked_by_text +=3D f&quot;Acked-by: {ack}\n&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        acked_by_names +=3D f&quot;{=
ack}\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pat=
ch_text_mod =3D patch_text[:signed_off_end] \</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        + acked_by_text \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        + patch_text[signed_off_end:comme=
nt_start] \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
+ &quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+This change was reviewed on Gerrit and approved by at least one</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+developer. I request to merge =
it to {target}.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+Gerrit URL: {url}/c/{pr=
oject}/+/{changeid}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
This mail reflects revision {revision} of this Change.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+Acked-by according to Gerrit (reflected =
above):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{acked_by_na=
mes}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;&=
quot;&quot;.format(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            url=3Dargs.url,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            changeid=3Dargs.changeid,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            acked_by_names=3Dacked_by_names,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            **details</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        ) \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        + patch_text[comment_s=
tart:]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    filename =
=3D &quot;gerrit-{}-{}.patch&quot;.format(args.changeid, details[&quot;revi=
sion&quot;])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wit=
h open(filename, &quot;w&quot;) as patch_file:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        patch_file.write(patch_text_mod)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    print(&quot;send with:&=
quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    print(&qu=
ot;git send-email --in-reply-to {} {}&quot;.format(details[&quot;msg_id&quo=
t;], filename))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+def main():</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    parser =3D argparse.Argumen=
tParser(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        pro=
g=3D&quot;gerrit-send-mail&quot;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        description=3D&quot;Send patchset from Gerrit to mail=
ing list&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    parser.add_arg=
ument(&#39;changeid&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    parser.add_argument(&#39;-u&#39;, &#39;--url&#39;, default=3D&#39=
;https://gerrit.openvpn.net&#39;)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    args =3D parser.parse_args()</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    details =3D get_details(args)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    patch =3D get_patch(details, args)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    apply_patch_mods(patch, detail=
s, args)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+if __name__ =3D=3D &quot;__mai=
n__&quot;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sys.e=
xit(main())</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/361?usp=3Demail">change 361</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/361?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If4e9c2e58441efb3fd00872cd62=
d1cc6c607f160 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 361 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--v3E/9HpGSKU=--


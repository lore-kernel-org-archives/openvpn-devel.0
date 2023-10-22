From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 22 Oct 2023 11:10:26 +0000
In-Reply-To: <gerrit.1695213156000.If4e9c2e58441efb3fd00872cd62d1cc6c607f160@...2715...>
References: <gerrit.1695213156000.If4e9c2e58441efb3fd00872cd62d1cc6c607f160@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 flichtenheld79@...277..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <7765c799a8a7e27472faf6fcc3d2c847a2d4698f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="U/L2TLq8BNA="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: d12fk <heiko@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, unauthorized <flichtenheld79@...277...>

--U/L2TLq8BNA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/361?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+1 by plaisthos, Code-Review+2 by cron2


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

v3:
 - handle missing display_name and email fields for reviewers
   gracefully
 - handle missing Signed-off-by line gracefully
v4:
 - use formatted string consistently

Change-Id: If4e9c2e58441efb3fd00872cd62d1cc6c607f160
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20231022105919.21779-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
279.html
Signed-off-by: Gert Doering <gert@...1296...>
---
A dev-tools/gerrit-send-mail.py
1 file changed, 132 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/61/361/6

diff --git a/dev-tools/gerrit-send-mail.py b/dev-tools/gerrit-send-mail.py
new file mode 100755
index 0000000..851a20a
--- /dev/null
+++ b/dev-tools/gerrit-send-mail.py
@@ -0,0 +1,132 @@
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
+
+def get_details(args):
+    params =3D {"o": ["CURRENT_REVISION", "LABELS", "DETAILED_ACCOUNTS"]}
+    r =3D requests.get(f"{args.url}/changes/{args.changeid}", params=3Dpar=
ams)
+    print(r.url)
+    json_txt =3D r.text.removeprefix(")]}'\n")
+    json_data =3D json.loads(json_txt)
+    assert len(json_data["revisions"]) =3D=3D 1  # CURRENT_REVISION works =
as expected
+    revision =3D json_data["revisions"].popitem()[1]["_number"]
+    assert "Code-Review" in json_data["labels"]
+    acked_by =3D []
+    for reviewer in json_data["labels"]["Code-Review"]["all"]:
+        if "value" in reviewer:
+            assert reviewer["value"] >=3D 0  # no NACK
+            if reviewer["value"] =3D=3D 2:
+                # fall back to user name if optional fields are not set
+                reviewer_name =3D reviewer.get("display_name", reviewer["n=
ame"])
+                reviewer_mail =3D reviewer.get("email", reviewer["name"])
+                ack =3D f"{reviewer_name} <{reviewer_mail}>"
+                print(f"Acked-by: {ack}")
+                acked_by.append(ack)
+    change_id =3D json_data["change_id"]
+    # assumes that the created date in Gerrit is in UTC
+    utc_stamp =3D (
+        dateutil.parser.parse(json_data["created"])
+        .replace(tzinfo=3Dtimezone.utc)
+        .timestamp()
+    )
+    # convert to milliseconds as used in message id
+    created_stamp =3D int(utc_stamp * 1000)
+    hostname =3D urlparse(args.url).hostname
+    msg_id =3D f"gerrit.{created_stamp}.{change_id}@{hostname}"
+    return {
+        "revision": revision,
+        "project": json_data["project"],
+        "target": json_data["branch"],
+        "msg_id": msg_id,
+        "acked_by": acked_by,
+    }
+
+
+def get_patch(details, args):
+    r =3D requests.get(
+        f"{args.url}/changes/{args.changeid}/revisions/{details['revision'=
]}/patch?download"
+    )
+    print(r.url)
+    patch_text =3D base64.b64decode(r.text).decode()
+    return patch_text
+
+
+def apply_patch_mods(patch_text, details, args):
+    comment_start =3D patch_text.index("\n---\n") + len("\n---\n")
+    try:
+        signed_off_start =3D patch_text.rindex("\nSigned-off-by: ")
+        signed_off_end =3D patch_text.index("\n", signed_off_start + 1) + 1
+    except ValueError:  # Signed-off missing
+        signed_off_end =3D patch_text.index("\n---\n") + 1
+    assert comment_start > signed_off_end
+    acked_by_text =3D ""
+    acked_by_names =3D ""
+    for ack in details["acked_by"]:
+        acked_by_text +=3D f"Acked-by: {ack}\n"
+        acked_by_names +=3D f"{ack}\n"
+    patch_text_mod =3D (
+        patch_text[:signed_off_end]
+        + acked_by_text
+        + patch_text[signed_off_end:comment_start]
+        + f"""
+This change was reviewed on Gerrit and approved by at least one
+developer. I request to merge it to {details["target"]}.
+
+Gerrit URL: {args.url}/c/{details["project"]}/+/{args.changeid}
+This mail reflects revision {details["revision"]} of this Change.
+Acked-by according to Gerrit (reflected above):
+{acked_by_names}
+        """
+        + patch_text[comment_start:]
+    )
+    filename =3D f"gerrit-{args.changeid}-{details['revision']}.patch"
+    with open(filename, "w") as patch_file:
+        patch_file.write(patch_text_mod)
+    print("send with:")
+    print(f"git send-email --in-reply-to {details['msg_id']} {filename}")
+
+
+def main():
+    parser =3D argparse.ArgumentParser(
+        prog=3D"gerrit-send-mail",
+        description=3D"Send patchset from Gerrit to mailing list",
+    )
+    parser.add_argument("changeid")
+    parser.add_argument("-u", "--url", default=3D"https://gerrit.openvpn.n=
et")
+    args =3D parser.parse_args()
+
+    details =3D get_details(args)
+    patch =3D get_patch(details, args)
+    apply_patch_mods(patch, details, args)
+
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
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: d12fk <heiko@...515...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: unauthorized <flichtenheld79@...277...>
Gerrit-MessageType: newpatchset

--U/L2TLq8BNA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #6</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/361?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+1 by plaisthos, Code-Review+2 by cron2</p><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">dev-tools/gerrit-send-ma=
il.py: tool to send Gerrit patchsets to Patchwork<br><br>Since we&#39;re tr=
ying to use Gerrit for patch reviews, but the actual<br>merge process is st=
ill implemented against the ML and Patchwork,<br>I wrote a script that atte=
mpts to bridge the gap.<br><br>It extracts all relevant information about a=
 patch from Gerrit<br>and converts it into a mail compatible to git-am. Mos=
tly this<br>work is done by Gerrit already, since we can get the original<b=
r>patch in git format-patch format. But we add Acked-by information<br>acco=
rding to the approvals in Gerrit and some other metadata.<br><br>This shoul=
d allow the merge to happen based on this one mail<br>alone.<br><br>v3:<br>=
 - handle missing display_name and email fields for reviewers<br>   gracefu=
lly<br> - handle missing Signed-off-by line gracefully<br>v4:<br> - use for=
matted string consistently<br><br>Change-Id: If4e9c2e58441efb3fd00872cd62d1=
cc6c607f160<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br=
>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20231022=
105919.21779-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/ope=
nvpn-devel@lists.sourceforge.net/msg27279.html<br>Signed-off-by: Gert Doeri=
ng &lt;gert@...1296...&gt;<br>---<br>A dev-tools/gerrit-send-mail.py<br>1 f=
ile changed, 132 insertions(+), 0 deletions(-)<br><br></pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit.openvpn.net:29418/openvpn refs/changes/61/361/6</pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/de=
v-tools/gerrit-send-mail.py b/dev-tools/gerrit-send-mail.py</span><br><span=
>new file mode 100755</span><br><span>index 0000000..851a20a</span><br><spa=
n>--- /dev/null</span><br><span>+++ b/dev-tools/gerrit-send-mail.py</span><=
br><span>@@ -0,0 +1,132 @@</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#!/usr/bin/env python3</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  Copyri=
ght (C) 2023 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#  Copyright (C) 2023 Frank Lichtenheld &lt;fr=
ank.lichtenheld@...515...&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  This =
program is free software; you can redistribute it and/or modify</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#  it under the terms of the GN=
U General Public License version 2</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#  as published by the Free Software Foundation.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#  This program is distributed in the hope that i=
t will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
 but WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#  MERCHANTABILITY or FITNESS F=
OR A PARTICULAR PURPOSE.  See the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#  GNU General Public License for more details.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#  You should have received a copy of the GNU Gener=
al Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#  with this program; if not, write to the Free Software Foundation, In=
c.,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  51 Franklin S=
treet, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# Extract a patch from Gerrit and transform it in a file suitable a=
s input</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# for git se=
nd-email.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+import argparse</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+import base64</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+from datetime import timezone</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+import json</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+import sys</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+from urllib.parse import urlparse</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+import dateutil.parser</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+import requests</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+def get_details=
(args):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    params =
=3D {&quot;o&quot;: [&quot;CURRENT_REVISION&quot;, &quot;LABELS&quot;, &quo=
t;DETAILED_ACCOUNTS&quot;]}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    r =3D requests.get(f&quot;{args.url}/changes/{args.changeid}&qu=
ot;, params=3Dparams)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    print(r.url)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   json_txt =3D r.text.removeprefix(&quot;)]}&#39;\n&quot;)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    json_data =3D json.loads(json_t=
xt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert len(j=
son_data[&quot;revisions&quot;]) =3D=3D 1  # CURRENT_REVISION works as expe=
cted</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    revision =
=3D json_data[&quot;revisions&quot;].popitem()[1][&quot;_number&quot;]</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert &quot;Code-Re=
view&quot; in json_data[&quot;labels&quot;]</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    acked_by =3D []</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    for reviewer in json_data[&quot;labels&quot;][&=
quot;Code-Review&quot;][&quot;all&quot;]:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if &quot;value&quot; in reviewer:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            assert reviewer[&qu=
ot;value&quot;] &gt;=3D 0  # no NACK</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            if reviewer[&quot;value&quot;] =3D=3D 2:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                # fall ba=
ck to user name if optional fields are not set</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                reviewer_name =3D reviewer.get(&=
quot;display_name&quot;, reviewer[&quot;name&quot;])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                reviewer_mail =3D reviewe=
r.get(&quot;email&quot;, reviewer[&quot;name&quot;])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                ack =3D f&quot;{reviewer_=
name} &lt;{reviewer_mail}&gt;&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                print(f&quot;Acked-by: {ack}&quot;)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                acked_by.ap=
pend(ack)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    change=
_id =3D json_data[&quot;change_id&quot;]</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    # assumes that the created date in Gerrit is in UT=
C</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    utc_stamp =3D =
(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dateutil.p=
arser.parse(json_data[&quot;created&quot;])</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        .replace(tzinfo=3Dtimezone.utc)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        .timestamp()</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    )</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    # convert to milliseconds as used in mes=
sage id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    created_=
stamp =3D int(utc_stamp * 1000)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    hostname =3D urlparse(args.url).hostname</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    msg_id =3D f&quot;gerrit.{created_=
stamp}.{change_id}@{hostname}&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        &quot;revision&quot;: revision,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        &quot;project&quot;: json_data[&quot;p=
roject&quot;],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   &quot;target&quot;: json_data[&quot;branch&quot;],</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        &quot;msg_id&quot;: msg_id,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;acked_by&qu=
ot;: acked_by,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+def get_patch(details, args):</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    r =3D requests.get(</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        f&quot;{args.url}/changes/{args.c=
hangeid}/revisions/{details[&#39;revision&#39;]}/patch?download&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    )</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    print(r.url)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    patch_text =3D base64.b64decode(r.tex=
t).decode()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn patch_text</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+def apply_patch_mods(patch_text, details, ar=
gs):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    comment_sta=
rt =3D patch_text.index(&quot;\n---\n&quot;) + len(&quot;\n---\n&quot;)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    try:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        signed_off_start =3D patch=
_text.rindex(&quot;\nSigned-off-by: &quot;)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        signed_off_end =3D patch_text.index(&quot;\=
n&quot;, signed_off_start + 1) + 1</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    except ValueError:  # Signed-off missing</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        signed_off_end =3D patch_te=
xt.index(&quot;\n---\n&quot;) + 1</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert comment_start &gt; signed_off_end</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    acked_by_text =3D &quot;&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    acked_by_names =
=3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 for ack in details[&quot;acked_by&quot;]:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        acked_by_text +=3D f&quot;Acked-by: {ack}\n&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        acked_=
by_names +=3D f&quot;{ack}\n&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    patch_text_mod =3D (</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        patch_text[:signed_off_end]</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        + acked_by_text</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        + patch_text[signed_off_end=
:comment_start]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    + f&quot;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+This change was reviewed on Gerrit and approved by at least one</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+developer. I request to m=
erge it to {details[&quot;target&quot;]}.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+Gerrit URL: {args.url}/c/{details[&quot;project&quot;]}/+/{args.changeid=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+This mail reflects=
 revision {details[&quot;revision&quot;]} of this Change.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+Acked-by according to Gerrit (reflect=
ed above):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{acked_by=
_names}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quo=
t;&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   + patch_text[comment_start:]</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  filename =3D f&quot;gerrit-{args.changeid}-{details[&#39;revision&#39;]}.=
patch&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    with=
 open(filename, &quot;w&quot;) as patch_file:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        patch_file.write(patch_text_mod)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    print(&quot;send with:&q=
uot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    print(f&qu=
ot;git send-email --in-reply-to {details[&#39;msg_id&#39;]} {filename}&quot=
;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+def main():</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    parser =3D argparse.ArgumentParser(</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        prog=3D&quot;gerrit-send-mail&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        descript=
ion=3D&quot;Send patchset from Gerrit to mailing list&quot;,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    )</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    parser.add_argument(&quot;changeid&quot;)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    parser.add_argumen=
t(&quot;-u&quot;, &quot;--url&quot;, default=3D&quot;https://gerrit.openvpn=
.net&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    args=
 =3D parser.parse_args()</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    details =
=3D get_details(args)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    patch =3D get_patch(details, args)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    apply_patch_mods(patch, details, args)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+if __name__ =3D=3D &quot;__main__&quot;:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    sys.exit(main())</span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/36=
1?usp=3Demail">change 361</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/361?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If4e9c2e58441efb3fd00872cd62=
d1cc6c607f160 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 361 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: d12fk &lt;heiko@...515...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: unauthorized &lt;flichtenheld79@...493...=
277...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--U/L2TLq8BNA=--


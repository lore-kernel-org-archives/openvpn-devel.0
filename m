From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 29 Oct 2025 07:10:43 +0000
In-Reply-To: <gerrit.1761676579000.I7f4c7b0ca748975defca1e5104e7077a761cd49c@...2715...>
References: <gerrit.1761676579000.I7f4c7b0ca748975defca1e5104e7077a761cd49c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f3d089c8c2e11b47ca1349411e674c70ae2f6cd3-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5OdRe/o1mao="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: zeroize struct
 image in packet_id_persist_save() before writing to disk
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5OdRe/o1mao=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1323?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: zeroize struct image in packet_id_persist_save() before wri=
ting to disk
......................................................................

zeroize struct image in packet_id_persist_save() before writing to disk

while this really is only a debug function, ensuring that no uninitialized
heap content ends up in padding in the structure and thus to disk is good
practice.

Reported-by: Joshua Rogers <contact@...2949...>
Found-by: ZeroPath (https://zeropath.com/)

Change-Id: I7f4c7b0ca748975defca1e5104e7077a761cd49c
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1323
Message-Id: <20251028203156.11697-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
983.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/packet_id.c
1 file changed, 1 insertion(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/1323/2

diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index 880eee1..08d9d9b 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -511,6 +511,7 @@
         && (p->time !=3D p->time_last_written || p->id !=3D p->id_last_wri=
tten))
     {
         struct packet_id_persist_file_image image;
+        CLEAR(image);
         ssize_t n;
         off_t seek_ret;
         struct gc_arena gc =3D gc_new();

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1323?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7f4c7b0ca748975defca1e5104e7077a761cd49c
Gerrit-Change-Number: 1323
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5OdRe/o1mao=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to this change.</p><p><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1323?usp=3Demail">View Change</a></p><p>The followi=
ng approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">zeroize struct image in pack=
et_id_persist_save() before writing to disk<br><br>while this really is onl=
y a debug function, ensuring that no uninitialized<br>heap content ends up =
in padding in the structure and thus to disk is good<br>practice.<br><br>Re=
ported-by: Joshua Rogers &lt;contact@...2949...&gt;<br>Found-by: ZeroPath (=
https://zeropath.com/)<br><br>Change-Id: I7f4c7b0ca748975defca1e5104e7077a7=
61cd49c<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>Acked-by:=
 Frank Lichtenheld &lt;frank@...2641...&gt;<br>Gerrit URL: https://gerrit.o=
penvpn.net/c/openvpn/+/1323<br>Message-Id: &lt;20251028203156.11697-1-gert@=
...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1885...=
rceforge.net/msg33983.html<br>Signed-off-by: Gert Doering &lt;gert@...1725...=
..&gt;<br>---<br>M src/openvpn/packet_id.c<br>1 file changed, 1 insertion(+=
), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.=
net:29418/openvpn refs/changes/23/1323/2</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/p=
acket_id.c b/src/openvpn/packet_id.c</span><br><span>index 880eee1..08d9d9b=
 100644</span><br><span>--- a/src/openvpn/packet_id.c</span><br><span>+++ b=
/src/openvpn/packet_id.c</span><br><span>@@ -511,6 +511,7 @@</span><br><spa=
n>         &amp;&amp; (p-&gt;time !=3D p-&gt;time_last_written || p-&gt;id =
!=3D p-&gt;id_last_written))</span><br><span>     {</span><br><span>       =
  struct packet_id_persist_file_image image;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        CLEAR(image);</span><br><span>         ssi=
ze_t n;</span><br><span>         off_t seek_ret;</span><br><span>         s=
truct gc_arena gc =3D gc_new();</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1323?usp=3Demail">=
change 1323</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1323?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7f4c7b0ca748975defca1e5104e=
7077a761cd49c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1323 </div>
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

--5OdRe/o1mao=--


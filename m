From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Oct 2025 18:36:23 +0000
References: <gerrit.1761676579000.I7f4c7b0ca748975defca1e5104e7077a761cd49c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d0c4160d5af06e0f7e4fa5497662bde3b4f568d7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="To2x91FfucI="; charset=UTF-8
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

--To2x91FfucI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1323?usp=3Demail

to review the following change.


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
---
M src/openvpn/packet_id.c
1 file changed, 1 insertion(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/1323/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7f4c7b0ca748975defca1e5104e7077a761cd49c
Gerrit-Change-Number: 1323
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--To2x91FfucI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>cron2 would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1323?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">zeroize struct image in packet_id_persist_s=
ave() before writing to disk<br><br>while this really is only a debug funct=
ion, ensuring that no uninitialized<br>heap content ends up in padding in t=
he structure and thus to disk is good<br>practice.<br><br>Reported-by: Josh=
ua Rogers &lt;contact@...2949...&gt;<br>Found-by: ZeroPath (https://zeropat=
h.com/)<br><br>Change-Id: I7f4c7b0ca748975defca1e5104e7077a761cd49c<br>Sign=
ed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/pac=
ket_id.c<br>1 file changed, 1 insertion(+), 0 deletions(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/=
1323/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id=
.c</span><br><span>index 880eee1..08d9d9b 100644</span><br><span>--- a/src/=
openvpn/packet_id.c</span><br><span>+++ b/src/openvpn/packet_id.c</span><br=
><span>@@ -511,6 +511,7 @@</span><br><span>         &amp;&amp; (p-&gt;time =
!=3D p-&gt;time_last_written || p-&gt;id !=3D p-&gt;id_last_written))</span=
><br><span>     {</span><br><span>         struct packet_id_persist_file_im=
age image;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        C=
LEAR(image);</span><br><span>         ssize_t n;</span><br><span>         o=
ff_t seek_ret;</span><br><span>         struct gc_arena gc =3D gc_new();</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1323?usp=3Demail">change 1323</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1323?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7f4c7b0ca748975defca1e5104e=
7077a761cd49c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1323 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--To2x91FfucI=--


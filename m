From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 16 Dec 2025 07:20:39 +0000
References: <gerrit.1765869635000.I950863eeba67b8c006c794245a1a08752cd79fb0@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <8f6455eee97d1de5bf96bd2ef0ee252c5ee6004e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Vvqpan+11qU="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]: multi: Warn
 about failing read in multi_process_file_closed()
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

--Vvqpan+11qU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1444?usp=3Demail

to review the following change.


Change subject: multi: Warn about failing read in multi_process_file_closed=
()
......................................................................

multi: Warn about failing read in multi_process_file_closed()

Handle failure explicitly instead of the implicit
handling by "while (buffer_i < r)".

Backport of 18d1b1fe008a4bbfd5a56ca7bb59f6f8cb58114a and the relevant
type fix of 5e5ead5ba019fc2a8266f77a7d840b30fd545198

Reported-by: Marc Heuse <marc@...2953...>
Github: openvpn-private-issues#101
Change-Id: I950863eeba67b8c006c794245a1a08752cd79fb0
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/multi.c
1 file changed, 7 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/44/1444/1

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 94e623b..69497a6 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2830,8 +2830,13 @@
 multi_process_file_closed(struct multi_context *m, const unsigned int mpp_=
flags)
 {
     char buffer[INOTIFY_EVENT_BUFFER_SIZE];
-    size_t buffer_i =3D 0;
-    int r =3D read(m->top.c2.inotify_fd, buffer, INOTIFY_EVENT_BUFFER_SIZE=
);
+    ssize_t buffer_i =3D 0;
+    ssize_t r =3D read(m->top.c2.inotify_fd, buffer, INOTIFY_EVENT_BUFFER_=
SIZE);
+    if (r < 0)
+    {
+        msg(M_WARN | M_ERRNO, "MULTI: multi_process_file_closed error");
+        return;
+    }

     while (buffer_i < r)
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1444?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I950863eeba67b8c006c794245a1a08752cd79fb0
Gerrit-Change-Number: 1444
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--Vvqpan+11qU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>cron2 would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1444?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">multi: Warn about failing read in multi_pro=
cess_file_closed()<br><br>Handle failure explicitly instead of the implicit=
<br>handling by &quot;while (buffer_i &lt; r)&quot;.<br><br>Backport of 18d=
1b1fe008a4bbfd5a56ca7bb59f6f8cb58114a and the relevant<br>type fix of 5e5ea=
d5ba019fc2a8266f77a7d840b30fd545198<br><br>Reported-by: Marc Heuse &lt;marc=
@...2953...&gt;<br>Github: openvpn-private-issues#101<br>Change-Id: I950863=
eeba67b8c006c794245a1a08752cd79fb0<br>Signed-off-by: Gert Doering &lt;gert@=
...1296...&gt;<br>---<br>M src/openvpn/multi.c<br>1 file changed, 7 inserti=
ons(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.ope=
nvpn.net:29418/openvpn refs/changes/44/1444/1</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/open=
vpn/multi.c b/src/openvpn/multi.c</span><br><span>index 94e623b..69497a6 10=
0644</span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/op=
envpn/multi.c</span><br><span>@@ -2830,8 +2830,13 @@</span><br><span> multi=
_process_file_closed(struct multi_context *m, const unsigned int mpp_flags)=
</span><br><span> {</span><br><span>     char buffer[INOTIFY_EVENT_BUFFER_S=
IZE];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t buffe=
r_i =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int r =
=3D read(m-&gt;top.c2.inotify_fd, buffer, INOTIFY_EVENT_BUFFER_SIZE);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ssize_t buffer_i =3D =
0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ssize_t r =3D=
 read(m-&gt;top.c2.inotify_fd, buffer, INOTIFY_EVENT_BUFFER_SIZE);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (r &lt; 0)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;MULTI: m=
ulti_process_file_closed error&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span> </span><br><span>     while (buffer_i=
 &lt; r)</span><br><span>     {</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1444?usp=3Demail">=
change 1444</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1444?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I950863eeba67b8c006c794245a1=
a08752cd79fb0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1444 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: flichtenheld &lt;frank@...2641...&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--Vvqpan+11qU=--


From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 29 Dec 2025 16:12:54 +0000
In-Reply-To: <gerrit.1765869635000.I950863eeba67b8c006c794245a1a08752cd79fb0@...2715...>
References: <gerrit.1765869635000.I950863eeba67b8c006c794245a1a08752cd79fb0@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <9db7c4c89e05511722347d47a337cfbbf29a6045-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rewoRdJ/sfU="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--rewoRdJ/sfU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
44?usp=3Demail )

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
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1444
Message-Id: <20251216111544.27133-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
113.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/multi.c
1 file changed, 7 insertions(+), 2 deletions(-)




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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I950863eeba67b8c006c794245a1a08752cd79fb0
Gerrit-Change-Number: 1444
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--rewoRdJ/sfU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1444?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">multi: Warn about failing read in multi_process_=
file_closed()<br><br>Handle failure explicitly instead of the implicit<br>h=
andling by &quot;while (buffer_i &lt; r)&quot;.<br><br>Backport of 18d1b1fe=
008a4bbfd5a56ca7bb59f6f8cb58114a and the relevant<br>type fix of 5e5ead5ba0=
19fc2a8266f77a7d840b30fd545198<br><br>Reported-by: Marc Heuse &lt;marc@...1665...=
953...&gt;<br>Github: openvpn-private-issues#101<br>Change-Id: I950863eeba6=
7b8c006c794245a1a08752cd79fb0<br>Signed-off-by: Gert Doering &lt;gert@...1711...=
96...&gt;<br>Acked-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>Gerr=
it URL: https://gerrit.openvpn.net/c/openvpn/+/1444<br>Message-Id: &lt;2025=
1216111544.27133-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com=
/openvpn-devel@lists.sourceforge.net/msg35113.html<br>Signed-off-by: Gert D=
oering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/multi.c<br>1 file ch=
anged, 7 insertions(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>i=
ndex 94e623b..69497a6 100644</span><br><span>--- a/src/openvpn/multi.c</spa=
n><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -2830,8 +2830,13 @=
@</span><br><span> multi_process_file_closed(struct multi_context *m, const=
 unsigned int mpp_flags)</span><br><span> {</span><br><span>     char buffe=
r[INOTIFY_EVENT_BUFFER_SIZE];</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    size_t buffer_i =3D 0;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    int r =3D read(m-&gt;top.c2.inotify_fd, buffer, INOTIFY_EV=
ENT_BUFFER_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  ssize_t buffer_i =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ssize_t r =3D read(m-&gt;top.c2.inotify_fd, buffer, INOTIFY_EVENT=
_BUFFER_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (r &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | =
M_ERRNO, &quot;MULTI: multi_process_file_closed error&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><sp=
an>     while (buffer_i &lt; r)</span><br><span>     {</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1444?usp=3Demail">change 1444</a>. To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Dem=
ail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1444?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I950863eeba67b8c006c794245a1=
a08752cd79fb0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1444 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: flichtenheld &lt;frank@...2641...&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--rewoRdJ/sfU=--


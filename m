From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 15 Dec 2025 17:26:04 +0000
In-Reply-To: <gerrit.1765813841000.Ie982f620a8af80564a70d993e6e84ec4e525236a@...2715...>
References: <gerrit.1765813841000.Ie982f620a8af80564a70d993e6e84ec4e525236a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b11cad1b22d678f2834018c7e2aa85e06c620ee9-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qP7MvPop/+E="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: multi: Warn about
 failing read in multi_process_file_closed()
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

--qP7MvPop/+E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
43?usp=3Demail )

Change subject: multi: Warn about failing read in multi_process_file_closed=
()
......................................................................

multi: Warn about failing read in multi_process_file_closed()

Handle failure explicitly instead of the implicit
handling by "while (buffer_i < r)". That error
checking was previously broken but was fixed by
commit 5e5ead5ba019fc2a8266f77a7d840b30fd545198.

Reported-by: Marc Heuse <marc@...2953...>
Github: openvpn-private-issues#101
Change-Id: Ie982f620a8af80564a70d993e6e84ec4e525236a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1443
Message-Id: <20251215155652.23362-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
095.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/multi.c
1 file changed, 5 insertions(+), 0 deletions(-)




diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 92eac6f..329d0a3 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2806,6 +2806,11 @@
     char buffer[INOTIFY_EVENT_BUFFER_SIZE];
     ssize_t buffer_i =3D 0;
     ssize_t r =3D read(m->top.c2.inotify_fd, buffer, INOTIFY_EVENT_BUFFER_=
SIZE);
+    if (r < 0)
+    {
+        msg(M_WARN | M_ERRNO, "MULTI: multi_process_file_closed error");
+        return;
+    }

     while (buffer_i < r)
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1443?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie982f620a8af80564a70d993e6e84ec4e525236a
Gerrit-Change-Number: 1443
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qP7MvPop/+E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1443?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">multi: Warn about failing read in multi_process_=
file_closed()<br><br>Handle failure explicitly instead of the implicit<br>h=
andling by &quot;while (buffer_i &lt; r)&quot;. That error<br>checking was =
previously broken but was fixed by<br>commit 5e5ead5ba019fc2a8266f77a7d840b=
30fd545198.<br><br>Reported-by: Marc Heuse &lt;marc@...2953...&gt;<br>Githu=
b: openvpn-private-issues#101<br>Change-Id: Ie982f620a8af80564a70d993e6e84e=
c4e525236a<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>=
Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerri=
t.openvpn.net/c/openvpn/+/1443<br>Message-Id: &lt;20251215155652.23362-1-ge=
rt@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1199...=
sourceforge.net/msg35095.html<br>Signed-off-by: Gert Doering &lt;gert@...1711...=
96...&gt;<br>---<br>M src/openvpn/multi.c<br>1 file changed, 5 insertions(+=
), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>i=
ndex 92eac6f..329d0a3 100644</span><br><span>--- a/src/openvpn/multi.c</spa=
n><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -2806,6 +2806,11 @=
@</span><br><span>     char buffer[INOTIFY_EVENT_BUFFER_SIZE];</span><br><s=
pan>     ssize_t buffer_i =3D 0;</span><br><span>     ssize_t r =3D read(m-=
&gt;top.c2.inotify_fd, buffer, INOTIFY_EVENT_BUFFER_SIZE);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (r &lt; 0)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;MULTI: multi_pro=
cess_file_closed error&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span> </span><br><span>     while (buffer_i &lt; r)=
</span><br><span>     {</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1443?usp=3Demail">change 1=
443</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1443?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie982f620a8af80564a70d993e6e=
84ec4e525236a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1443 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--qP7MvPop/+E=--


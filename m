From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 15 Dec 2025 15:50:44 +0000
References: <gerrit.1765813841000.Ie982f620a8af80564a70d993e6e84ec4e525236a@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <a9440168537221a75d1af67af2ca1371d1c89da7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="L0TOPUMxaWc="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--L0TOPUMxaWc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1443?usp=3Demail

to review the following change.


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
---
M src/openvpn/multi.c
1 file changed, 5 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/43/1443/1

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
=20
     while (buffer_i < r)
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1443?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie982f620a8af80564a70d993e6e84ec4e525236a
Gerrit-Change-Number: 1443
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--L0TOPUMxaWc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1443?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">multi: Warn about failing read in multi_pro=
cess_file_closed()<br><br>Handle failure explicitly instead of the implicit=
<br>handling by &quot;while (buffer_i &lt; r)&quot;. That error<br>checking=
 was previously broken but was fixed by<br>commit 5e5ead5ba019fc2a8266f77a7=
d840b30fd545198.<br><br>Reported-by: Marc Heuse &lt;marc@...2953...&gt;<br>=
Github: openvpn-private-issues#101<br>Change-Id: Ie982f620a8af80564a70d993e=
6e84ec4e525236a<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt=
;<br>---<br>M src/openvpn/multi.c<br>1 file changed, 5 insertions(+), 0 del=
etions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2941=
8/openvpn refs/changes/43/1443/1</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/multi.c b=
/src/openvpn/multi.c</span><br><span>index 92eac6f..329d0a3 100644</span><b=
r><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c=
</span><br><span>@@ -2806,6 +2806,11 @@</span><br><span>     char buffer[IN=
OTIFY_EVENT_BUFFER_SIZE];</span><br><span>     ssize_t buffer_i =3D 0;</spa=
n><br><span>     ssize_t r =3D read(m-&gt;top.c2.inotify_fd, buffer, INOTIF=
Y_EVENT_BUFFER_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (r &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_=
WARN | M_ERRNO, &quot;MULTI: multi_process_file_closed error&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span>=
<br><span>     while (buffer_i &lt; r)</span><br><span>     {</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1443?usp=3Demail">change 1443</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?u=
sp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1443?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie982f620a8af80564a70d993e6e=
84ec4e525236a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1443 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--L0TOPUMxaWc=--


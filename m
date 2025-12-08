From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 8 Dec 2025 16:49:10 +0000
References: <gerrit.1765212547000.I999916f9561a638214b70cf43de78060e9e0e792@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <556ef85850a806398aec6dbea725f6d4def04a7e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xFQjmtJSOPU="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: socket: Initialize
 struct in_addr_t in getaddr()
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

--xFQjmtJSOPU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1420?usp=3Demail

to review the following change.


Change subject: socket: Initialize struct in_addr_t in getaddr()
......................................................................

socket: Initialize struct in_addr_t in getaddr()

We have false-positive "=E2=80=98addr=E2=80=99 may be used uninitialized"
warnings with MinGW 13.0.0 compiler. Work around them.

Change-Id: I999916f9561a638214b70cf43de78060e9e0e792
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/socket.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/20/1420/1

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 80c2895..3e90833 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -202,7 +202,7 @@
 getaddr(unsigned int flags, const char *hostname, int resolve_retry_second=
s, bool *succeeded,
         struct signal_info *sig_info)
 {
-    in_addr_t addr;
+    in_addr_t addr =3D { 0 };
     int status;

     status =3D get_addr_generic(AF_INET, flags, hostname, &addr, NULL, res=
olve_retry_seconds,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1420?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I999916f9561a638214b70cf43de78060e9e0e792
Gerrit-Change-Number: 1420
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--xFQjmtJSOPU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1420?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">socket: Initialize struct in_addr_t in geta=
ddr()<br><br>We have false-positive &quot;=E2=80=98addr=E2=80=99 may be use=
d uninitialized&quot;<br>warnings with MinGW 13.0.0 compiler. Work around t=
hem.<br><br>Change-Id: I999916f9561a638214b70cf43de78060e9e0e792<br>Signed-=
off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/=
socket.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/20/1=
420/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</spa=
n><br><span>index 80c2895..3e90833 100644</span><br><span>--- a/src/openvpn=
/socket.c</span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -20=
2,7 +202,7 @@</span><br><span> getaddr(unsigned int flags, const char *host=
name, int resolve_retry_seconds, bool *succeeded,</span><br><span>         =
struct signal_info *sig_info)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    in_addr_t addr;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    in_addr_t addr =3D { 0 };</span><br><span>  =
   int status;</span><br><span> </span><br><span>     status =3D get_addr_g=
eneric(AF_INET, flags, hostname, &amp;addr, NULL, resolve_retry_seconds,</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1420?usp=3Demail">change 1420</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1420?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I999916f9561a638214b70cf43de=
78060e9e0e792 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1420 </div>
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

--xFQjmtJSOPU=--


From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 13 Feb 2026 18:54:59 +0000
References: <gerrit.1771008896000.I2ca40d0d86599896b38ea1467313b6a6cdc8339c@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <70b4941ebec3313b8ef2a69f055569509180dbb9-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="u+Ykn141kHY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tun: Avoid
 sign-compare warning in header_modify_read_write_return
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

--u+Ykn141kHY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1527?usp=3Demail

to review the following change.


Change subject: tun: Avoid sign-compare warning in header_modify_read_write=
_return
......................................................................

tun: Avoid sign-compare warning in header_modify_read_write_return

Since we already check that the value is positive
just make the implicit cast explicit.

Change-Id: I2ca40d0d86599896b38ea1467313b6a6cdc8339c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/tun.c
1 file changed, 1 insertion(+), 10 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/1527/1

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index a909e96..638611b 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1706,17 +1706,12 @@
 #include <netinet/ip.h>
 #include <sys/uio.h>

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 static inline ssize_t
 header_modify_read_write_return(ssize_t len)
 {
     if (len > 0)
     {
-        return len > sizeof(u_int32_t) ? len - sizeof(u_int32_t) : 0;
+        return (size_t)len > sizeof(u_int32_t) ? len - sizeof(u_int32_t) :=
 0;
     }
     else
     {
@@ -1724,10 +1719,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static ssize_t
 write_tun_header(struct tuntap *tt, uint8_t *buf, int len)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1527?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2ca40d0d86599896b38ea1467313b6a6cdc8339c
Gerrit-Change-Number: 1527
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--u+Ykn141kHY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1527?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">tun: Avoid sign-compare warning in header_m=
odify_read_write_return<br><br>Since we already check that the value is pos=
itive<br>just make the implicit cast explicit.<br><br>Change-Id: I2ca40d0d8=
6599896b38ea1467313b6a6cdc8339c<br>Signed-off-by: Frank Lichtenheld &lt;fra=
nk@...2641...&gt;<br>---<br>M src/openvpn/tun.c<br>1 file changed, 1 insert=
ion(+), 10 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.op=
envpn.net:29418/openvpn refs/changes/27/1527/1</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/ope=
nvpn/tun.c b/src/openvpn/tun.c</span><br><span>index a909e96..638611b 10064=
4</span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn=
/tun.c</span><br><span>@@ -1706,17 +1706,12 @@</span><br><span> #include &l=
t;netinet/ip.h&gt;</span><br><span> #include &lt;sys/uio.h&gt;</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GN=
UC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static inline ssize_t</s=
pan><br><span> header_modify_read_write_return(ssize_t len)</span><br><span=
> {</span><br><span>     if (len &gt; 0)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        return len &gt; sizeof(u_=
int32_t) ? len - sizeof(u_int32_t) : 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return (size_t)len &gt; sizeof(u_int32_t) ? len=
 - sizeof(u_int32_t) : 0;</span><br><span>     }</span><br><span>     else<=
/span><br><span>     {</span><br><span>@@ -1724,10 +1719,6 @@</span><br><sp=
an>     }</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static ssize_t</span=
><br><span> write_tun_header(struct tuntap *tt, uint8_t *buf, int len)</spa=
n><br><span> {</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1527?usp=3Demail">change 1527</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1527?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2ca40d0d86599896b38ea146731=
3b6a6cdc8339c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1527 </div>
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

--u+Ykn141kHY=--


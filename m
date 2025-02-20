From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 20 Feb 2025 07:40:26 +0000
References: <gerrit.1740037224000.Ie57f7b11157ab5ca8ff01e1c4f03a308117ff937@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6e4ca50667afb356e895dfe791f872ef67d9af99-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Zq8BejSmeZg="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco-win: simplify
 control packets prepend code
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

--Zq8BejSmeZg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/900?usp=3Demail

to review the following change.


Change subject: dco-win: simplify control packets prepend code
......................................................................

dco-win: simplify control packets prepend code

Eliminate unneeded temporary struct sockaddr_in buffer.

Change-Id: Ie57f7b11157ab5ca8ff01e1c4f03a308117ff937
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/socket.h
1 file changed, 2 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/00/900/1

diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index c370f2c..ee04a96 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -1125,15 +1125,11 @@
     {
         if (to->dest.addr.sa.sa_family =3D=3D AF_INET)
         {
-            struct sockaddr_in sa;
-            memcpy(&sa, &to->dest.addr.in4, sizeof(sa));
-            buf_write_prepend(buf, &sa, sizeof(sa));
+            buf_write_prepend(buf,  &to->dest.addr.in4, sizeof(struct sock=
addr_in));
         }
         else
         {
-            struct sockaddr_in6 sa;
-            memcpy(&sa, &to->dest.addr.in6, sizeof(sa));
-            buf_write_prepend(buf, &sa, sizeof(sa));
+            buf_write_prepend(buf, &to->dest.addr.in6, sizeof(struct socka=
ddr_in6));
         }
     }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/900?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie57f7b11157ab5ca8ff01e1c4f03a308117ff937
Gerrit-Change-Number: 900
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--Zq8BejSmeZg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/900?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">dco-win: simplify control packets prepend code<br><br>Elimina=
te unneeded temporary struct sockaddr_in buffer.<br><br>Change-Id: Ie57f7b1=
1157ab5ca8ff01e1c4f03a308117ff937<br>Signed-off-by: Lev Stipakov &lt;lev@...1186...=
.515...&gt;<br>---<br>M src/openvpn/socket.h<br>1 file changed, 2 insertion=
s(+), 6 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/open=
vpn refs/changes/00/900/1</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/socket.h b/src/o=
penvpn/socket.h</span><br><span>index c370f2c..ee04a96 100644</span><br><sp=
an>--- a/src/openvpn/socket.h</span><br><span>+++ b/src/openvpn/socket.h</s=
pan><br><span>@@ -1125,15 +1125,11 @@</span><br><span>     {</span><br><spa=
n>         if (to-&gt;dest.addr.sa.sa_family =3D=3D AF_INET)</span><br><spa=
n>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   struct sockaddr_in sa;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            memcpy(&amp;sa, &amp;to-&gt;dest.addr.in4, sizeof(sa));</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            buf_write_pre=
pend(buf, &amp;sa, sizeof(sa));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            buf_write_prepend(buf,  &amp;to-&gt;dest.addr.in4, =
sizeof(struct sockaddr_in));</span><br><span>         }</span><br><span>   =
      else</span><br><span>         {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            struct sockaddr_in6 sa;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            memcpy(&amp;sa, &amp;to-&gt;des=
t.addr.in6, sizeof(sa));</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            buf_write_prepend(buf, &amp;sa, sizeof(sa));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            buf_write_prepend(buf, =
&amp;to-&gt;dest.addr.in6, sizeof(struct sockaddr_in6));</span><br><span>  =
       }</span><br><span>     }</span><br><span> </span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
900?usp=3Demail">change 900</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/900?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie57f7b11157ab5ca8ff01e1c4f0=
3a308117ff937 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 900 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--Zq8BejSmeZg=--


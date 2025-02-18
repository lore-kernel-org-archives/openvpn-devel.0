From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 18 Feb 2025 16:33:06 +0000
In-Reply-To: <gerrit.1727098847000.I31bbf87e4e568021445c7512ecefadfd4a69b363@...2715...>
References: <gerrit.1727098847000.I31bbf87e4e568021445c7512ecefadfd4a69b363@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., a@...2181...
Message-ID: <b9b9d50f58a931c7af5630c5b2b77da211f246c4-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8Bon5jkr5GU="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add support for
 simultaneous use of UDP and TCP sockets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8Bon5jkr5GU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, ordex, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/764?usp=3Demail )

Change subject: Add support for simultaneous use of UDP and TCP sockets
......................................................................


Patch Set 19:

(1 comment)

Patchset:

PS19:
without DCO it also crashes, though it takes a bit longer.  Might be just r=
andom chance of timing...

These are the last few lines

```
2025-02-18 17:31:52 us=3D617953 tcp4-server:194.97.140.21:39821 TCPv4_SERVE=
R READ [299] from [AF_INET]194.97.140.21:39821: P_CONTROL_V1 kid=3D0 [ 0 ] =
pid=3D1 DATA len=3D273
2025-02-18 17:31:52 us=3D628842 tcp4-server:194.97.140.21:39821 TCPv4_SERVE=
R WRITE [1222] to [AF_INET]194.97.140.21:39821: P_CONTROL_V1 kid=3D0 [ 1 0 =
] pid=3D1 DATA len=3D1192
2025-02-18 17:31:52 us=3D628925 tcp4-server:194.97.140.21:39821 TCPv4_SERVE=
R WRITE [887] to [AF_INET]194.97.140.21:39821: P_CONTROL_V1 kid=3D0 [ 1 0 ]=
 pid=3D2 DATA len=3D857
2025-02-18 17:31:52 us=3D629004 Connection Attempt Assertion failed at forw=
ard.c:1756 (link_socket_actual_defined(c->c2.to_link_addr))
2025-02-18 17:31:52 us=3D629029 Connection Attempt Exiting due to fatal err=
or
2025-02-18 17:31:52 us=3D629077 Connection Attempt Closing tun/tap interface
```



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I31bbf87e4e568021445c7512ecefadfd4a69b363
Gerrit-Change-Number: 764
Gerrit-PatchSet: 19
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Tue, 18 Feb 2025 16:33:06 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--8Bon5jkr5GU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: its_Giaan, ordex, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/7=
64?tab=3Dcomments">Patch Set #19:</a> </p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">without DCO it also crashes, though it takes a bi=
t longer.  Might be just random chance of timing...</p><p style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">These are the last few lines</p><p s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">```<br>2025-02-18 17=
:31:52 us=3D617953 tcp4-server:194.97.140.21:39821 TCPv4_SERVER READ [299] =
from [AF_INET]194.97.140.21:39821: P_CONTROL_V1 kid=3D0 [ 0 ] pid=3D1 DATA =
len=3D273<br>2025-02-18 17:31:52 us=3D628842 tcp4-server:194.97.140.21:3982=
1 TCPv4_SERVER WRITE [1222] to [AF_INET]194.97.140.21:39821: P_CONTROL_V1 k=
id=3D0 [ 1 0 ] pid=3D1 DATA len=3D1192<br>2025-02-18 17:31:52 us=3D628925 t=
cp4-server:194.97.140.21:39821 TCPv4_SERVER WRITE [887] to [AF_INET]194.97.=
140.21:39821: P_CONTROL_V1 kid=3D0 [ 1 0 ] pid=3D2 DATA len=3D857<br>2025-0=
2-18 17:31:52 us=3D629004 Connection Attempt Assertion failed at forward.c:=
1756 (link_socket_actual_defined(c-&gt;c2.to_link_addr))<br>2025-02-18 17:3=
1:52 us=3D629029 Connection Attempt Exiting due to fatal error<br>2025-02-1=
8 17:31:52 us=3D629077 Connection Attempt Closing tun/tap interface<br>```<=
/p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/764?usp=3Demail">change 764</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/76=
4?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I31bbf87e4e568021445c7512ece=
fadfd4a69b363 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 764 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 19 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 18 Feb 2025 16:33:06=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--8Bon5jkr5GU=--


From: "stipa (Code Review)" <gerrit@...515...>
Date: Tue, 13 May 2025 14:25:13 +0000
In-Reply-To: <gerrit.1747046041000.I43ec390040bffeec05270271ea7fb54fb219c536@...2715...>
References: <gerrit.1747046041000.I43ec390040bffeec05270271ea7fb54fb219c536@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <8782afe3179192b8fc10ac732a2e0e3ed61c40c4-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="X6RHHAMpiRc="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: win: remove Wintun
 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--X6RHHAMpiRc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

stipa has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1021?usp=3Demail )

Change subject: win: remove Wintun support
......................................................................


Patch Set 2:

(3 comments)

File include/openvpn-msg.h:

http://gerrit.openvpn.net/c/openvpn/+/1021/comment/8f9f9442_c5569e1b :
PS2, Line 47:     msg_register_ring_buffers,
> I am a bit worried about taking out message number enums, leading to test=
ing challenges when having  [=E2=80=A6]
Done


File src/openvpn/forward.h:

http://gerrit.openvpn.net/c/openvpn/+/1021/comment/0d807ff9_8c3bd023 :
PS2, Line 406:         }
> is that related to wintun? ("it does not say so, and I'm not aware of the=
 origins of this code")
Yes, this is from "wintun: ring buffers based I/O" patch

https://github.com/OpenVPN/openvpn/commit/d5fc4bd41616ee01816df873cb6b65678=
72a29e2#diff-b955244e0fcf190f9a22548de16381cac34b6efaad20300d7a04c5691cd101=
7aR382-R412


File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/1021/comment/ab5875dc_3a7846ca :
PS2, Line 2230:         }
> this is similar to the thing in `forward. [=E2=80=A6]
This is from "wintun: ring buffers based I/O" patch

https://github.com/OpenVPN/openvpn/commit/d5fc4bd41616ee01816df873cb6b65678=
72a29e2#diff-b955244e0fcf190f9a22548de16381cac34b6efaad20300d7a04c5691cd101=
7aL406



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1021?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I43ec390040bffeec05270271ea7fb54fb219c536
Gerrit-Change-Number: 1021
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 13 May 2025 14:25:13 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--X6RHHAMpiRc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1021?usp=3Demail">View =
Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File include/openvpn-msg.h:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1021/comment/8f9f9442_c5569e1b">Patch Set #2, Line 47:</=
a> <code style=3D"font-family:monospace,monospace">    msg_register_ring_bu=
ffers,</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">I am a bit worried about taking out message nu=
mber enums, leading to testing challenges when having  [=E2=80=A6]</blockqu=
ote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p>=
</li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/for=
ward.h:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1021/comment/0d807ff9_8c3bd023">Patch Set =
#2, Line 406:</a> <code style=3D"font-family:monospace,monospace">        }=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">is that related to wintun? (&quot;it does not say so=
, and I&#39;m not aware of the origins of this code&quot;)</blockquote></p>=
<p style=3D"white-space: pre-wrap; word-wrap: break-word;">Yes, this is fro=
m &quot;wintun: ring buffers based I/O&quot; patch </p><p style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">https://github.com/OpenVPN/openvpn/c=
ommit/d5fc4bd41616ee01816df873cb6b6567872a29e2#diff-b955244e0fcf190f9a22548=
de16381cac34b6efaad20300d7a04c5691cd1017aR382-R412</p></li></ul></li><li st=
yle=3D"margin: 0; padding: 0;"><p>File src/openvpn/forward.c:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1021/comment/ab5875dc_3a7846ca">Patch Set #2, Line 2230:</a> <=
code style=3D"font-family:monospace,monospace">        }</code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">this is similar to the thing in `forward. [=E2=80=A6]</blockquote></p><=
p style=3D"white-space: pre-wrap; word-wrap: break-word;">This is from &quo=
t;wintun: ring buffers based I/O&quot; patch</p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">https://github.com/OpenVPN/openvpn/commit/d=
5fc4bd41616ee01816df873cb6b6567872a29e2#diff-b955244e0fcf190f9a22548de16381=
cac34b6efaad20300d7a04c5691cd1017aL406</p></li></ul></li></ul><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1021?usp=3Demail">cha=
nge 1021</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1021?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I43ec390040bffeec05270271ea7=
fb54fb219c536 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1021 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 13 May 2025 14:25:13=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--X6RHHAMpiRc=--


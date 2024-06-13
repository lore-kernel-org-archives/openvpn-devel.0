From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 13 Jun 2024 07:57:26 +0000
In-Reply-To: <gerrit.1717758396000.I1b54da258c7d15551b6c3de7522a0d19afdb66de@...2715...>
References: <gerrit.1717758396000.I1b54da258c7d15551b6c3de7522a0d19afdb66de@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., samuli@...515...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <06709e04c368447009a6def4ad04b93f8c8fd504-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sancmBqNptI="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add t_server_null
 test suite
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mattock <samuli@...515...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--sancmBqNptI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: mattock, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/663?usp=3Demail )

Change subject: Add t_server_null test suite
......................................................................


Patch Set 2: Code-Review+2

(2 comments)

File tests/t_server_null_client.sh:

http://gerrit.openvpn.net/c/openvpn/+/663/comment/995176b3_cae59746 :
PS1, Line 1: #!/usr/bin/env bash
> bash is not necessarily available on BSD.
Done


http://gerrit.openvpn.net/c/openvpn/+/663/comment/0e0d21a2_a852e248 :
PS1, Line 74: # Wait until servers are up. This check is based on the prese=
nce of processes
> This check does not work correctly. You often see something like this in =
the output of the test: [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/663?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1b54da258c7d15551b6c3de7522a0d19afdb66de
Gerrit-Change-Number: 663
Gerrit-PatchSet: 2
Gerrit-Owner: mattock <samuli@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: mattock <samuli@...515...>
Gerrit-Comment-Date: Thu, 13 Jun 2024 07:57:26 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--sancmBqNptI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: mattock, plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/663?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File tests/t_server_null_client=
.sh:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/663/comment/995176b3_cae59746">Patch Set #1, =
Line 1:</a> <code style=3D"font-family:monospace,monospace">#!/usr/bin/env =
bash</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;">bash is not necessarily available on BSD.</block=
quote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</=
p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/663/comment/0e0=
d21a2_a852e248">Patch Set #1, Line 74:</a> <code style=3D"font-family:monos=
pace,monospace"># Wait until servers are up. This check is based on the pre=
sence of processes</code></p><p><blockquote style=3D"border-left: 1px solid=
 #aaa; margin: 10px 0; padding: 0 10px;">This check does not work correctly=
. You often see something like this in the output of the test: [=E2=80=A6]<=
/blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/663?usp=3Demail">change 663</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/663?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1b54da258c7d15551b6c3de7522=
a0d19afdb66de </div>
<div style=3D"display:none"> Gerrit-Change-Number: 663 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: mattock &lt;samuli@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mattock &lt;samuli@...515...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 13 Jun 2024 07:57:26=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--sancmBqNptI=--


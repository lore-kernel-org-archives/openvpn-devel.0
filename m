From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 7 Jun 2024 11:36:25 +0000
In-Reply-To: <gerrit.1717758396000.I1b54da258c7d15551b6c3de7522a0d19afdb66de@...2715...>
References: <gerrit.1717758396000.I1b54da258c7d15551b6c3de7522a0d19afdb66de@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., samuli@...515...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <7f07cb6c56f35968b6eef49fd1e6b8074736cfc8-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jvRJcBbhGMY="; charset=UTF-8
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

--jvRJcBbhGMY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: mattock, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/663?usp=3Demail )

Change subject: Add t_server_null test suite
......................................................................


Patch Set 1: Code-Review-2

(2 comments)

File tests/t_server_null_client.sh:

http://gerrit.openvpn.net/c/openvpn/+/663/comment/923993f1_1319ae66 :
PS1, Line 1: #!/usr/bin/env bash
bash is not necessarily available on BSD.


http://gerrit.openvpn.net/c/openvpn/+/663/comment/54cb0bde_ba12a5e5 :
PS1, Line 74: # Wait until servers are up. This check is based on the prese=
nce of processes
This check does not work correctly. You often see something like this in th=
e output of the test:

cat: t_server_null_server-1194_udp.pid: No such file or directory
cat: t_server_null_server-1195_tcp.pid: No such file or directory
error: list of process IDs must follow -p
Usage:
 ps [options]
 Try 'ps --help <simple|list|output|threads|misc|all>'
  or 'ps --help <s|l|o|t|m|a>'
 for additional help text.
For more details see ps(1).
OpenVPN test servers up: 0/0

Does not necessarily fail the test but definitely does not do what it is su=
pposed
to do.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/663?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1b54da258c7d15551b6c3de7522a0d19afdb66de
Gerrit-Change-Number: 663
Gerrit-PatchSet: 1
Gerrit-Owner: mattock <samuli@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: mattock <samuli@...515...>
Gerrit-Comment-Date: Fri, 07 Jun 2024 11:36:25 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--jvRJcBbhGMY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: mattock, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/663?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File tests/t_server_null_client=
.sh:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/663/comment/923993f1_1319ae66">Patch Set #1, =
Line 1:</a> <code style=3D"font-family:monospace,monospace">#!/usr/bin/env =
bash</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">b=
ash is not necessarily available on BSD.</p></li><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/663/comment/54cb0bde_ba12a5e5">Patch Set #1, Lin=
e 74:</a> <code style=3D"font-family:monospace,monospace"># Wait until serv=
ers are up. This check is based on the presence of processes</code></p><p s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">This check does not =
work correctly. You often see something like this in the output of the test=
:</p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">cat: t_server_null_server-1194_udp.pid: No such file or directory<br>cat:=
 t_server_null_server-1195_tcp.pid: No such file or directory<br>error: lis=
t of process IDs must follow -p<br>Usage:<br> ps [options]<br> Try &#39;ps =
--help &lt;simple|list|output|threads|misc|all&gt;&#39;<br>  or &#39;ps --h=
elp &lt;s|l|o|t|m|a&gt;&#39;<br> for additional help text.<br>For more deta=
ils see ps(1).<br>OpenVPN test servers up: 0/0</pre><p style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Does not necessarily fail the test but =
definitely does not do what it is supposed<br>to do.</p></li></ul></li></ul=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/663?usp=
=3Demail">change 663</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/663?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1b54da258c7d15551b6c3de7522=
a0d19afdb66de </div>
<div style=3D"display:none"> Gerrit-Change-Number: 663 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 07 Jun 2024 11:36:25=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--jvRJcBbhGMY=--


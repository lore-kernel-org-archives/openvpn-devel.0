From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 5 Jun 2024 13:51:57 +0000
In-Reply-To: <gerrit.1717583228000.I1b54da258c7d15551b6c3de7522a0d19afdb66de@...2715...>
References: <gerrit.1717583228000.I1b54da258c7d15551b6c3de7522a0d19afdb66de@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 samuli.seppanen@...277..., openvpn-devel@lists.sourceforge.net
Message-ID: <38370fc85d84e9bfca9bb4b07600f03465c3ddf9-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="D28+WL7qHko="; charset=UTF-8
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
To: mattock <samuli.seppanen@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--D28+WL7qHko=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: mattock, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/643?usp=3Demail )

Change subject: Add t_server_null test suite
......................................................................


Patch Set 2:

(1 comment)

File tests/t_server_null_client.sh:

http://gerrit.openvpn.net/c/openvpn/+/643/comment/52da0659_0e3d50cb :
PS2, Line 74: # Wait until servers are up. This check is based on the prese=
nce of processes
This code does not seem to work reliably. I often see something like this i=
n the build logs:

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

So that means that the servers hadn't created the pid files yet and so the =
test suceeded? Probably server_count should be based on the amount of defin=
ed servers and not server_pids?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/643?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1b54da258c7d15551b6c3de7522a0d19afdb66de
Gerrit-Change-Number: 643
Gerrit-PatchSet: 2
Gerrit-Owner: mattock <samuli.seppanen@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: mattock <samuli.seppanen@...277...>
Gerrit-Comment-Date: Wed, 05 Jun 2024 13:51:57 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--D28+WL7qHko=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: mattock, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/643?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File tests/t_server_null_client.sh:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/643/comment/52da0659_0e3d50cb">Patch Set #2, Line =
74:</a> <code style=3D"font-family:monospace,monospace"># Wait until server=
s are up. This check is based on the presence of processes</code></p><p sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">This code does not see=
m to work reliably. I often see something like this in the build logs:</p><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">cat:=
 t_server_null_server-1194_udp.pid: No such file or directory<br>cat: t_ser=
ver_null_server-1195_tcp.pid: No such file or directory<br>error: list of p=
rocess IDs must follow -p<br>Usage:<br> ps [options]<br> Try &#39;ps --help=
 &lt;simple|list|output|threads|misc|all&gt;&#39;<br>  or &#39;ps --help &l=
t;s|l|o|t|m|a&gt;&#39;<br> for additional help text.<br>For more details se=
e ps(1).<br>OpenVPN test servers up: 0/0</pre><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">So that means that the servers hadn&#39;t cre=
ated the pid files yet and so the test suceeded? Probably server_count shou=
ld be based on the amount of defined servers and not server_pids?</p></li><=
/ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/643?usp=3Demail">change 643</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/643?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1b54da258c7d15551b6c3de7522=
a0d19afdb66de </div>
<div style=3D"display:none"> Gerrit-Change-Number: 643 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: mattock &lt;samuli.seppanen@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mattock &lt;samuli.seppanen@=
...277...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 05 Jun 2024 13:51:57=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--D28+WL7qHko=--


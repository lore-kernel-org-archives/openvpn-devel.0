From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 16 Sep 2024 15:10:46 +0000
In-Reply-To: <gerrit.1726491830000.I65099ef00822d08fd3f5480c80892f3bf86c56e7@...2715...>
References: <gerrit.1726491830000.I65099ef00822d08fd3f5480c80892f3bf86c56e7@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <b7d29d05bfb4c33a9032df46955c0adc0496da78-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="t/5SgEEubnM="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Introduce
 DRIVER_AFUNIX backend for use with lwipovpn
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

--t/5SgEEubnM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/747?usp=3Demail )

Change subject: Introduce DRIVER_AFUNIX backend for use with lwipovpn
......................................................................


Patch Set 2: Code-Review-1

(12 comments)

File Changes.rst:

http://gerrit.openvpn.net/c/openvpn/+/747/comment/99476969_1d8d6408 :
PS1, Line 19:     ``dev-node:/path/to/lwipovpn`` can emulate a full client =
that
Shouldn't that be "unix:" ?


http://gerrit.openvpn.net/c/openvpn/+/747/comment/4595f086_fbf96ee6 :
PS1, Line 20:     can be pinged, can server a website and more without requ=
iring any
"serve"


File doc/man-sections/vpn-network-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/747/comment/8717edec_dfc8d582 :
PS1, Line 123:   will pass the tun configuration as environment variables.
". It will pass" ?


http://gerrit.openvpn.net/c/openvpn/+/747/comment/cd99d110_cddddeda :
PS1, Line 124:   The temporary unix will be be passed in the environment va=
riable
"unix domain socket" ?


File src/openvpn/run_command.h:

http://gerrit.openvpn.net/c/openvpn/+/747/comment/7a11ae03_196cec21 :
PS1, Line 50: /** instead of waiting for child process exist status return =
the
"exist" -> "exit"?


File src/openvpn/run_command.c:

http://gerrit.openvpn.net/c/openvpn/+/747/comment/3b124102_8e33ed47 :
PS1, Line 196: openvpn_execve
Aren't there changes missing to openvpn_execve in this patch?


File src/openvpn/ssl.h:

http://gerrit.openvpn.net/c/openvpn/+/747/comment/d01d26be_8db826f8 :
PS1, Line 222: \
Spurious change?


File src/openvpn/tun.h:

http://gerrit.openvpn.net/c/openvpn/+/747/comment/f4047f82_66d132b0 :
PS1, Line 54:      *  this is always defined. We error out if a user tries =
to open this type
". This"


http://gerrit.openvpn.net/c/openvpn/+/747/comment/99d6ccec_0c9c6678 :
PS1, Line 55:      *  on unsupported platforms*/
"platforms. "


File src/openvpn/tun_afunix.h:

http://gerrit.openvpn.net/c/openvpn/+/747/comment/89a22cf1_1fdfde67 :
PS1, Line 32:  * the user provided to that will take care of implementing t=
he actual tun
Superfluous "to"?


http://gerrit.openvpn.net/c/openvpn/+/747/comment/7325e601_60f01d40 :
PS1, Line 33:  * device
Missing full stop "."


http://gerrit.openvpn.net/c/openvpn/+/747/comment/5cee7cb8_700a23b3 :
PS1, Line 56:  * Reads a packet from a AF_UNIX based tun devices
"device"



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/747?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I65099ef00822d08fd3f5480c80892f3bf86c56e7
Gerrit-Change-Number: 747
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Mon, 16 Sep 2024 15:10:46 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--t/5SgEEubnM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/747?usp=3Demail">Vi=
ew Change</a></p><p>12 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>File Changes.rst:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/747/comment/99476969_1d8d6408">Patch Set #1, Line 19:</a> <cod=
e style=3D"font-family:monospace,monospace">    ``dev-node:/path/to/lwipovp=
n`` can emulate a full client that</code></p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Shouldn&#39;t that be &quot;unix:&quot; ?</p><=
/li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/747/comment/4595f0=
86_fbf96ee6">Patch Set #1, Line 20:</a> <code style=3D"font-family:monospac=
e,monospace">    can be pinged, can server a website and more without requi=
ring any</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word=
;">&quot;serve&quot;</p></li></ul></li><li style=3D"margin: 0; padding: 0;"=
><p>File doc/man-sections/vpn-network-options.rst:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/747/comment/8717edec_dfc8d582">Patch Set #1, Line 123:</a> <code style=3D"=
font-family:monospace,monospace">  will pass the tun configuration as envir=
onment variables.</code></p><p style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">&quot;. It will pass&quot; ?</p></li><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/747/comment/cd99d110_cddddeda">Patch Set #1, Lin=
e 124:</a> <code style=3D"font-family:monospace,monospace">  The temporary =
unix will be be passed in the environment variable</code></p><p style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">&quot;unix domain socket&quot;=
 ?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openv=
pn/run_command.h:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/747/comment/7a11ae03_196cec21">=
Patch Set #1, Line 50:</a> <code style=3D"font-family:monospace,monospace">=
/** instead of waiting for child process exist status return the</code></p>=
<p style=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;exist&quot=
; -&gt; &quot;exit&quot;?</p></li></ul></li><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/run_command.c:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/747/comme=
nt/3b124102_8e33ed47">Patch Set #1, Line 196:</a> <code style=3D"font-famil=
y:monospace,monospace">openvpn_execve</code></p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Aren&#39;t there changes missing to openvpn=
_execve in this patch?</p></li></ul></li><li style=3D"margin: 0; padding: 0=
;"><p>File src/openvpn/ssl.h:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/747/comment/d01d26be=
_8db826f8">Patch Set #1, Line 222:</a> <code style=3D"font-family:monospace=
,monospace">\</code></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Spurious change?</p></li></ul></li><li style=3D"margin: 0; padding:=
 0;"><p>File src/openvpn/tun.h:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/747/comment/f4047f=
82_66d132b0">Patch Set #1, Line 54:</a> <code style=3D"font-family:monospac=
e,monospace">     *  this is always defined. We error out if a user tries t=
o open this type</code></p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">&quot;. This&quot;</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/747/comment/99d6ccec_0c9c6678">Patch Set #1, Line 55:</a> <=
code style=3D"font-family:monospace,monospace">     *  on unsupported platf=
orms*/</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>&quot;platforms. &quot;</p></li></ul></li><li style=3D"margin: 0; padding:=
 0;"><p>File src/openvpn/tun_afunix.h:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/747/comment=
/89a22cf1_1fdfde67">Patch Set #1, Line 32:</a> <code style=3D"font-family:m=
onospace,monospace"> * the user provided to that will take care of implemen=
ting the actual tun</code></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Superfluous &quot;to&quot;?</p></li><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/747/comment/7325e601_60f01d40">Patch Set #1, Li=
ne 33:</a> <code style=3D"font-family:monospace,monospace"> * device</code>=
</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Missing full=
 stop &quot;.&quot;</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/747/comment/5cee7cb8_700a23b3">Patch Set #1, Line 56:</a> <code style=
=3D"font-family:monospace,monospace"> * Reads a packet from a AF_UNIX based=
 tun devices</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-=
word;">&quot;device&quot;</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/747?usp=3Demail">change 747</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/747?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I65099ef00822d08fd3f5480c808=
92f3bf86c56e7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 747 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 16 Sep 2024 15:10:46=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--t/5SgEEubnM=--


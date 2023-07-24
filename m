From: "stipa (Code Review)" <gerrit@...515...>
Date: Mon, 24 Jul 2023 12:48:53 +0000
In-Reply-To: <gerrit.1689947729000.I6de18261d5dc7f8561612184059656c73f33a5f2@...2715...>
References: <gerrit.1689947729000.I6de18261d5dc7f8561612184059656c73f33a5f2@...2715...>
Reply-To: lstipakov@...277..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <1e15e5e1ebc72f09912352ccb25c912beb91182d-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="d1q7Ng23+Qc="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[release/2.6]: CMake:
 backport CMake buildsystem from master to release/2.6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--d1q7Ng23+Qc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

stipa has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/315?usp=3Demail )

Change subject: CMake: backport CMake buildsystem from master to release/2.6
......................................................................


Patch Set 1:

(1 comment)

File CMakeLists.txt:

http://gerrit.openvpn.net/c/openvpn/+/315/comment/a88d6de4_30bc577d :
PS1, Line 294: # TODO remove later when msvc-config.h is removed and we can=
 always include config.h
This comment seems to be outdated, since we got rid of config-msvc.h



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/315?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I6de18261d5dc7f8561612184059656c73f33a5f2
Gerrit-Change-Number: 315
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 24 Jul 2023 12:48:53 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--d1q7Ng23+Qc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/315?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File CMakeLists.txt:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/315/comment/a88d6de4_30bc577d">Patch Set #1, Line 294:</a> <code =
style=3D"font-family:monospace,monospace"># TODO remove later when msvc-con=
fig.h is removed and we can always include config.h</code></p><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">This comment seems to be outd=
ated, since we got rid of config-msvc.h</p></li></ul></li></ul><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/315?usp=3Demail">cha=
nge 315</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope it=
emtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action=
" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/315?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6de18261d5dc7f8561612184059=
656c73f33a5f2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 315 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 24 Jul 2023 12:48:53=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--d1q7Ng23+Qc=--


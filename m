From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Wed, 15 Apr 2026 15:33:01 +0000
In-Reply-To: <gerrit.1775741612000.I6319c951327a9b994ffae0ba35270b0887455203@...2715...>
References: <gerrit.1775741612000.I6319c951327a9b994ffae0ba35270b0887455203@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e9271f000c4d54dda1a9d17391d23b18f1ce459d-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wIzyUys55iM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Enable per-socket
 bind_dev via --local
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--wIzyUys55iM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

its_Giaan has posted comments on this change by its_Giaan. ( http://gerrit.=
openvpn.net/c/openvpn/+/1625?usp=3Demail )

Change subject: Enable per-socket bind_dev via --local
......................................................................


Patch Set 3:

(2 comments)

Patchset:

PS2:
> Please also update the usage section in options. [=E2=80=A6]
Done


File doc/man-sections/link-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/1625/comment/f9bbece1_e8584586?usp=3D=
email :
PS1, Line 114:      local host|* [port] [protocol] [bind device]
> That mention under `--bind-dev` is okay, but I actually meant to add a po=
inter to `--bind-dev` here  [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1625?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6319c951327a9b994ffae0ba35270b0887455203
Gerrit-Change-Number: 1625
Gerrit-PatchSet: 3
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 15 Apr 2026 15:33:01 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: its_Giaan <gianmarco@...2726...>
Comment-In-Reply-To: flichtenheld <frank@...2641...>

--wIzyUys55iM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1625?usp=3Demail">View =
Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1625?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Ple=
ase also update the usage section in options. [=E2=80=A6]</blockquote></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File doc/man=
-sections/link-options.rst:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1625/comment/f9bbece1_=
e8584586?usp=3Demail">Patch Set #1, Line 114:</a> <code style=3D"font-famil=
y:monospace,monospace">     local host|* [port] [protocol] [bind device]</c=
ode></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;">That mention under `--bind-dev` is okay, but I actually=
 meant to add a pointer to `--bind-dev` here  [=E2=80=A6]</blockquote></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1625?usp=3Demail">change 1625</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1625?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6319c951327a9b994ffae0ba352=
70b0887455203 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1625 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 15 Apr 2026 15:33:01=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: its_Giaan &lt;gianmarco@...220...=
..2726...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>

</body></html>=

--wIzyUys55iM=--


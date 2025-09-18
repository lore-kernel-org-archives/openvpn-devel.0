From: "selvanair (Code Review)" <gerrit@...515...>
Date: Thu, 18 Sep 2025 17:45:45 +0000
In-Reply-To: <gerrit.1758178873000.I071e8190dac28f429257b8af1c6f9e68f8896bc0@...2715...>
References: <gerrit.1758178873000.I071e8190dac28f429257b8af1c6f9e68f8896bc0@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277..., gert@...1296...
Message-ID: <f7f824da940f208b4a1b20f5b3e4ce6cd88ae877-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IIk82nMm7wc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: fix building of
 openvpnsrvmsg.dll from eventmsg.mc in mingw builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: stipa <lstipakov@...277...>, flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--IIk82nMm7wc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos, stipa.

selvanair has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/1197?usp=3Demail )

Change subject: fix building of openvpnsrvmsg.dll from eventmsg.mc in mingw=
 builds
......................................................................


Patch Set 4:

(2 comments)

Patchset:

PS4:
Very nice.. cmake-mingw also works now.
The dlls built using autotools also work on Windows event viewer.


File src/openvpnserv/Makefile.am:

http://gerrit.openvpn.net/c/openvpn/+/1197/comment/fe997674_e9daf92f :
PS4, Line 46: 	$(CC) -shared -Wl,--entry=3D0 -nostdlib -nostartfiles -o $@ =
$<
Adhoc build of this dll is fine, but fwiw, here is my try to use libtool in=
stead: https://github.com/selvanair/openvpn/commit/bc94c62ac66a377df4904484=
2515351aa256adcd

The resulting dll is larger, but could be stripped as we do with other bina=
ries.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1197?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I071e8190dac28f429257b8af1c6f9e68f8896bc0
Gerrit-Change-Number: 1197
Gerrit-PatchSet: 4
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: selvanair <selva.nair@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Thu, 18 Sep 2025 17:45:45 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--IIk82nMm7wc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos, stipa. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1197?usp=3Demail">View =
Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1197?tab=3Dcomments">Patch Set #4:</a> </p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Very nice.. cmake-mingw also works now.<br>The =
dlls built using autotools also work on Windows event viewer.</p></li></ul>=
</li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/Makefile.=
am:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1197/comment/fe997674_e9daf92f">Patch Set #4, =
Line 46:</a> <code style=3D"font-family:monospace,monospace">	$(CC) -shared=
 -Wl,--entry=3D0 -nostdlib -nostartfiles -o $@ $&lt;</code></p><p style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Adhoc build of this dll is f=
ine, but fwiw, here is my try to use libtool instead: https://github.com/se=
lvanair/openvpn/commit/bc94c62ac66a377df49044842515351aa256adcd</p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">The resulting dll is lar=
ger, but could be stripped as we do with other binaries.</p></li></ul></li>=
</ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/119=
7?usp=3Demail">change 1197</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1197?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I071e8190dac28f429257b8af1c6=
f9e68f8896bc0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1197 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: selvanair &lt;selva.nair@...277...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 18 Sep 2025 17:45:45=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--IIk82nMm7wc=--


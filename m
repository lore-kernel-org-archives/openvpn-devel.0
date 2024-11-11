From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 11 Nov 2024 18:03:35 +0000
In-Reply-To: <gerrit.1731290343000.I74216d776d3e0a8dc987ec7b1671c8e8dcccdbd6@...2715...>
References: <gerrit.1731290343000.I74216d776d3e0a8dc987ec7b1671c8e8dcccdbd6@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <068e068bc833a7d4cd4270a288f8d16f50fd71fc-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Et2s+MBOPSs="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Use XOR instead of
 concatenation for calculation of IV from implicit IV
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Et2s+MBOPSs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/797?usp=3Demail )

Change subject: Use XOR instead of concatenation for calculation of  IV fro=
m implicit IV
......................................................................


Patch Set 2:

(5 comments)

Patchset:

PS2:
this is beyond my pay grade, but I found a few typos, I think...


File src/openvpn/dco_freebsd.c:

http://gerrit.openvpn.net/c/openvpn/+/797/comment/3336b2fb_a6fe95b6 :
PS2, Line 398:         /* FreeBSD uses the contact operation, need to skip =
the first 4 null
concat?


File src/openvpn/dco_linux.c:

http://gerrit.openvpn.net/c/openvpn/+/797/comment/e129cd6f_c502323f :
PS2, Line 588:         /* First 4 zero bytes as the kernel does concat inst=
ead of XOR */
"skip" first 4 zero bytes?


http://gerrit.openvpn.net/c/openvpn/+/797/comment/e717840e_40e36894 :
PS2, Line 599:         /* First 4 zero bytes as the kernel does concat inst=
ead of XOR */
as above


File src/openvpn/dco_win.c:

http://gerrit.openvpn.net/c/openvpn/+/797/comment/716de75f_9490d075 :
PS2, Line 317:     /* First 4 zero bytes as ovpn-dco-win does concat instea=
d of XOR */
same comment as for Linux DCO, but no +4 here?  confusing



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/797?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I74216d776d3e0a8dc987ec7b1671c8e8dcccdbd6
Gerrit-Change-Number: 797
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 11 Nov 2024 18:03:35 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--Et2s+MBOPSs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/797?usp=3Demail">View C=
hange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
797?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">this is beyond my pay grade, but I found a few ty=
pos, I think...</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>F=
ile src/openvpn/dco_freebsd.c:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/797/comment/3336b2f=
b_a6fe95b6">Patch Set #2, Line 398:</a> <code style=3D"font-family:monospac=
e,monospace">        /* FreeBSD uses the contact operation, need to skip th=
e first 4 null</code></p><p style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">concat?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>=
File src/openvpn/dco_linux.c:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/797/comment/e129cd6f=
_c502323f">Patch Set #2, Line 588:</a> <code style=3D"font-family:monospace=
,monospace">        /* First 4 zero bytes as the kernel does concat instead=
 of XOR */</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">&quot;skip&quot; first 4 zero bytes?</p></li><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/797/comment/e717840e_40e36894">Patch Set #2, Li=
ne 599:</a> <code style=3D"font-family:monospace,monospace">        /* Firs=
t 4 zero bytes as the kernel does concat instead of XOR */</code></p><p sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">as above</p></li></ul>=
</li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco_win.c:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/797/comment/716de75f_9490d075">Patch Set #2, Line 31=
7:</a> <code style=3D"font-family:monospace,monospace">    /* First 4 zero =
bytes as ovpn-dco-win does concat instead of XOR */</code></p><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">same comment as for Linux DCO=
, but no +4 here?  confusing</p></li></ul></li></ul><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/797?usp=3Demail">change 797</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/797?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I74216d776d3e0a8dc987ec7b167=
1c8e8dcccdbd6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 797 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 11 Nov 2024 18:03:35=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--Et2s+MBOPSs=--


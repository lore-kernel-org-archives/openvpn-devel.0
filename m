From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 16 Nov 2025 12:11:32 +0000
In-Reply-To: <gerrit.1762955252000.I270f679505c90ef78a5afbad1e05219f166be089@...2715...>
References: <gerrit.1762955252000.I270f679505c90ef78a5afbad1e05219f166be089@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, lstipakov@...277...
Message-ID: <6144b3e658fed0919c0959db999d2c3757a8df4a-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="W6W7stkbnmY="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: tapctl: refactor
 'create' command
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--W6W7stkbnmY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa.

cron2 has posted comments on this change by stipa. ( http://gerrit.openvpn.=
net/c/openvpn/+/1374?usp=3Demail )

Change subject: tapctl: refactor 'create' command
......................................................................


Patch Set 2: Code-Review+2

(3 comments)

Patchset:

PS2:
some room for improvement left, but moving on


File src/tapctl/main.c:

http://gerrit.openvpn.net/c/openvpn/+/1374/comment/341b165d_9f6f6845?usp=3D=
email :
PS2, Line 221:         }
this code is a bit silly - two `free(value)` and `break`, where the second =
one would nicely cover what is in the `if()` above.  But it's not going to =
break anything, we can fix this later.


http://gerrit.openvpn.net/c/openvpn/+/1374/comment/327981bf_81d31cdf?usp=3D=
email :
PS2, Line 362:     }
I did not manage to trigger this one - `tapctl create --hwid dings` will fa=
il earlier on (`DiInstallDevice failed`), so I guess I need a valid hwid ye=
t unknown to tapctl to trigger this.  But the code is ok.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1374?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I270f679505c90ef78a5afbad1e05219f166be089
Gerrit-Change-Number: 1374
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Sun, 16 Nov 2025 12:11:32 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--W6W7stkbnmY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1374?usp=3Demail">V=
iew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1374?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">some room =
for improvement left, but moving on</p></li></ul></li><li style=3D"margin: =
0; padding: 0;"><p>File src/tapctl/main.c:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1374/co=
mment/341b165d_9f6f6845?usp=3Demail">Patch Set #2, Line 221:</a> <code styl=
e=3D"font-family:monospace,monospace">        }</code></p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">this code is a b=
it silly - two `free(value)` and `break`, where the second one would nicely=
 cover what is in the `if()` above.  But it&#39;s not going to break anythi=
ng, we can fix this later.</p></li><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1374/comment/327981bf_81d31cdf?usp=3Demail">Patch Set #2, Line=
 362:</a> <code style=3D"font-family:monospace,monospace">    }</code></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
I did not manage to trigger this one - `tapctl create --hwid dings` will fa=
il earlier on (`DiInstallDevice failed`), so I guess I need a valid hwid ye=
t unknown to tapctl to trigger this.  But the code is ok.</p></li></ul></li=
></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/13=
74?usp=3Demail">change 1374</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">se=
ttings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1374?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I270f679505c90ef78a5afbad1e0=
5219f166be089 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1374 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 16 Nov 2025 12:11:32=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--W6W7stkbnmY=--


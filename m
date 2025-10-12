From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 12 Oct 2025 12:55:11 +0000
In-Reply-To: <gerrit.1757957943000.I83295e00d1a756dfa44050b0a4493095fb050fff@...2715...>
References: <gerrit.1757957943000.I83295e00d1a756dfa44050b0a4493095fb050fff@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <d32e1e2d27f0422711138304a71ab28d7c4a7710-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sxeN0UWrCgE="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Install host routes
 for ifconfig-push routes when DCO is enabled
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: d12fk <heiko@...515...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--sxeN0UWrCgE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos.

cron2 has posted comments on this change by plaisthos. ( http://gerrit.open=
vpn.net/c/openvpn/+/1192?usp=3Demail )

Change subject: Install host routes for ifconfig-push routes when DCO is en=
abled
......................................................................


Patch Set 8: Code-Review-2

(5 comments)

Patchset:

PS8:
this got broken during review / respin...  conceptually I have nothing to c=
omplain, but the MR_ONLINK_ADDR vs. MR_ONLINK_DCO_ADDR needs to be fixed.  =
Admittedly I do not understand why it compiles at all (!?)...

```
$ git grep MR_ONLINK
src/openvpn/dco.c:    if (addr->type & MR_ONLINK_DCO_ADDR)
src/openvpn/dco.c:        if (addr->type & MR_ONLINK_ADDR)
src/openvpn/dco.c:        if (addr->type & MR_ONLINK_ADDR)
src/openvpn/mroute.h:#define MR_ONLINK_DCO_ADDR 64
src/openvpn/multi.c:        addr.type |=3D MR_ONLINK_DCO_ADDR;
src/openvpn/multi.c:        addr.type |=3D MR_ONLINK_DCO_ADDR;
```

so MR_ONLINK_ADDR is referenced, but not defined anywhere - and it still co=
mpiles.  Huh.


File src/openvpn/dco.c:

http://gerrit.openvpn.net/c/openvpn/+/1192/comment/785dfadb_41bb07c6?usp=3D=
email :
PS8, Line 686:
This got broken in patch iterations - initially everything was `MR_ONLINK_A=
DDR` and then the define got changed to `MR_ONLINK_DCO_ADDR` but the "not w=
in32" platform was not adjusted?


http://gerrit.openvpn.net/c/openvpn/+/1192/comment/c26431d1_ead0937a?usp=3D=
email :
PS8, Line 700:         if (addr->type & MR_ONLINK_ADDR)
_DCO_


http://gerrit.openvpn.net/c/openvpn/+/1192/comment/b9ffbe40_0e0e1234?usp=3D=
email :
PS8, Line 745:         }
this looks wrong.  The !not WIN32 code calls `dco_win_`?


http://gerrit.openvpn.net/c/openvpn/+/1192/comment/6e19a3ae_10206ebe?usp=3D=
email :
PS8, Line 771:         }
This is asymmetric to IPv4 - I guess this is from early tests, and the `dco=
_win_del...()` think needs to go out?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I83295e00d1a756dfa44050b0a4493095fb050fff
Gerrit-Change-Number: 1192
Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Comment-Date: Sun, 12 Oct 2025 12:55:11 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--sxeN0UWrCgE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, ordex, plaisthos. </p>
<p>Patch set 8:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demail">V=
iew Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1192?tab=3Dcomments&amp;usp=3Demail">Patch Set #8:</a> </p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">this got b=
roken during review / respin...  conceptually I have nothing to complain, b=
ut the MR_ONLINK_ADDR vs. MR_ONLINK_DCO_ADDR needs to be fixed.  Admittedly=
 I do not understand why it compiles at all (!?)...</p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">```<br>$ git grep M=
R_ONLINK<br>src/openvpn/dco.c:    if (addr-&gt;type &amp; MR_ONLINK_DCO_ADD=
R)<br>src/openvpn/dco.c:        if (addr-&gt;type &amp; MR_ONLINK_ADDR)<br>=
src/openvpn/dco.c:        if (addr-&gt;type &amp; MR_ONLINK_ADDR)<br>src/op=
envpn/mroute.h:#define MR_ONLINK_DCO_ADDR 64<br>src/openvpn/multi.c:       =
 addr.type |=3D MR_ONLINK_DCO_ADDR;<br>src/openvpn/multi.c:        addr.typ=
e |=3D MR_ONLINK_DCO_ADDR;<br>```</p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">so MR_ONLINK_ADDR is referenced, but =
not defined anywhere - and it still compiles.  Huh.</p></li></ul></li><li s=
tyle=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco.c:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1192/comment/785dfadb_41bb07c6?usp=3Demail">Patch Set #8, Line 686=
:</a> <code style=3D"font-family:monospace,monospace"></code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This go=
t broken in patch iterations - initially everything was `MR_ONLINK_ADDR` an=
d then the define got changed to `MR_ONLINK_DCO_ADDR` but the &quot;not win=
32&quot; platform was not adjusted?</p></li><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1192/comment/c26431d1_ead0937a?usp=3Demail">Patch Set=
 #8, Line 700:</a> <code style=3D"font-family:monospace,monospace">        =
if (addr-&gt;type &amp; MR_ONLINK_ADDR)</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">_DCO_</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1192/comment/b9ffbe40_0e0e1234?=
usp=3Demail">Patch Set #8, Line 745:</a> <code style=3D"font-family:monospa=
ce,monospace">        }</code></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">this looks wrong.  The !not WIN32 code c=
alls `dco_win_`?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1192/comment/6e19a3ae_10206ebe?usp=3Demail">Patch Set #8, Line 771:</a> =
<code style=3D"font-family:monospace,monospace">        }</code></p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This i=
s asymmetric to IPv4 - I guess this is from early tests, and the `dco_win_d=
el...()` think needs to go out?</p></li></ul></li></ul><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demail">change 119=
2</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I83295e00d1a756dfa44050b0a44=
93095fb050fff </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1192 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 12 Oct 2025 12:55:11=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--sxeN0UWrCgE=--


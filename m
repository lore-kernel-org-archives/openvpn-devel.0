From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 18 Jul 2025 19:16:48 +0000
In-Reply-To: <gerrit.1752849659000.I217cfb319b85fd75a88f7d4d50c374d28771df28@...2715...>
References: <gerrit.1752849659000.I217cfb319b85fd75a88f7d4d50c374d28771df28@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., frank@...2641...
Message-ID: <9c1481d7f5c27b18805a3dd4f1b6af645f58f1e8-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kVy/ACUsamg="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: improve float
 collision logging
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf_lici <ralf@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--kVy/ACUsamg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1091?usp=3Demail )

Change subject: improve float collision logging
......................................................................


Patch Set 1: Code-Review+2

(1 comment)

Patchset:

PS1:
works!

Disabled the "goto done" part from the "same peer-id" check, and played wit=
h the LAN cable :-) - resulting in

```
2025-07-18 21:14:25 us=3D793140 cron2-freebsd-tc-amd64/udp6:193.149.48.173:=
49409 peer-id=3D0 disallowing peer 0 (cron2-freebsd-tc-amd64) from floating=
 to its own address (udp6:193.149.48.173:49409)
2025-07-18 21:14:25 us=3D793175 cron2-freebsd-tc-amd64/udp6:193.149.48.173:=
49409 peer-id=3D0 closing instance cron2-freebsd-tc-amd64/udp6:193.149.48.1=
73:49409 peer-id=3D0 due to float collision with cron2-freebsd-tc-amd64/udp=
6:193.149.48.173:49409 peer-id=3D0 using the same certificate
```

(and then, of course, it SIGSEGVs, but that's expected - so the extra loggi=
ng makes this a much clearer picture.  Could not reproduce with two differe=
nt clients, but I don't think this will add extra testing coverage)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1091?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I217cfb319b85fd75a88f7d4d50c374d28771df28
Gerrit-Change-Number: 1091
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-Comment-Date: Fri, 18 Jul 2025 19:16:48 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--kVy/ACUsamg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, ralf_lic=
i. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1091?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1091?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">works!</p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Disabled the &quot;goto done&quot; part from the &=
quot;same peer-id&quot; check, and played with the LAN cable :-) - resultin=
g in</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">```<br>2=
025-07-18 21:14:25 us=3D793140 cron2-freebsd-tc-amd64/udp6:193.149.48.173:4=
9409 peer-id=3D0 disallowing peer 0 (cron2-freebsd-tc-amd64) from floating =
to its own address (udp6:193.149.48.173:49409)<br>2025-07-18 21:14:25 us=3D=
793175 cron2-freebsd-tc-amd64/udp6:193.149.48.173:49409 peer-id=3D0 closing=
 instance cron2-freebsd-tc-amd64/udp6:193.149.48.173:49409 peer-id=3D0 due =
to float collision with cron2-freebsd-tc-amd64/udp6:193.149.48.173:49409 pe=
er-id=3D0 using the same certificate<br>```</p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">(and then, of course, it SIGSEGVs, but that&=
#39;s expected - so the extra logging makes this a much clearer picture.  C=
ould not reproduce with two different clients, but I don&#39;t think this w=
ill add extra testing coverage)</p></li></ul></li></ul><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/1091?usp=3Demail">change 109=
1</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1091?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I217cfb319b85fd75a88f7d4d50c=
374d28771df28 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1091 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
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
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 18 Jul 2025 19:16:48=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--kVy/ACUsamg=--


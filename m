From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 17 Oct 2025 20:18:52 +0000
In-Reply-To: <gerrit.1759855064000.I07a8ddd9026eef64b6f5abde98702a9801616a5f@...2715...>
References: <gerrit.1759855064000.I07a8ddd9026eef64b6f5abde98702a9801616a5f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <9c466a368e429b680354b18030040ce142048d5b-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3GFO35WFqFc="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: PUSH_UPDATE server:
 remove old IP(s) from vhash after sending a messa...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mrbff <marco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3GFO35WFqFc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, ordex, plaisthos.

cron2 has posted comments on this change by mrbff. ( http://gerrit.openvpn.=
net/c/openvpn/+/1253?usp=3Demail )

Change subject: PUSH_UPDATE server: remove old IP(s) from vhash after sendi=
ng a message containing ifconfig(-ipv6)
......................................................................


Patch Set 7: Code-Review+2

(3 comments)

Patchset:

PS7:
This looks good now.  Tested a sequence of "change ifconfig, change ifconfi=
g, change to -ifconfig, send new ifconfig" and it always learned/unlearned =
the expected things

```
Oct 17 22:11:37 gentoo tun-udp-p2mp[13761]: MULTI: Learn: 10.204.2.46 -> fr=
eebsd-14-amd64/udp6:194.97.140.5:60204
Oct 17 22:11:37 gentoo tun-udp-p2mp[13761]: MULTI: primary virtual IP for f=
reebsd-14-amd64/udp6:194.97.140.5:60204: 10.204.2.46
Oct 17 22:11:37 gentoo tun-udp-p2mp[13761]: MULTI: Learn: fd00:abcd:204:2::=
100a -> freebsd-14-amd64/udp6:194.97.140.5:60204
Oct 17 22:11:37 gentoo tun-udp-p2mp[13761]: MULTI: primary virtual IPv6 for=
 freebsd-14-amd64/udp6:194.97.140.5:60204: fd00:abcd:204:2::100a
Oct 17 22:13:15 gentoo tun-udp-p2mp[13761]: MULTI: Unlearn: 10.204.2.46 -> =
freebsd-14-amd64/udp6:194.97.140.5:60204
Oct 17 22:13:15 gentoo tun-udp-p2mp[13761]: MULTI: Learn: 10.204.2.99 -> fr=
eebsd-14-amd64/udp6:194.97.140.5:60204
Oct 17 22:13:38 gentoo tun-udp-p2mp[13761]: MULTI: Unlearn: 10.204.2.99 -> =
freebsd-14-amd64/udp6:194.97.140.5:60204
Oct 17 22:13:38 gentoo tun-udp-p2mp[13761]: MULTI: Learn: 10.204.2.146 -> f=
reebsd-14-amd64/udp6:194.97.140.5:60204
Oct 17 22:14:40 gentoo tun-udp-p2mp[13761]: MULTI: Unlearn: 10.204.2.146 ->=
 freebsd-14-amd64/udp6:194.97.140.5:60204
Oct 17 22:14:57 gentoo tun-udp-p2mp[13761]: MULTI: Learn: 10.204.2.99 -> fr=
eebsd-14-amd64/udp6:194.97.140.5:60204
```

also the logging is symmetric now (thanks again).  Very nice.

I also tested IPv6, though it mains me to send "PUSH_UPDATE,-ifconfig-ipv6"=
 - but it still works :-)


File src/openvpn/push_util.c:

http://gerrit.openvpn.net/c/openvpn/+/1253/comment/831de5dd_a3d9baac?usp=3D=
email :
PS6, Line 165:     o.ifconfig_local =3D canary;
> the canary is mostly to be less invasive as possible. [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/1253/comment/baeb5012_d8c04c16?usp=3D=
email :
PS6, Line 166:     o.ifconfig_ipv6_local =3D canary;
> same for this obviously.
While I agree that this is not pretty, I would still leave it at that (and =
mrbff admitted that "it is ugly").  I do like the rest of the code a lot in=
 this latest iteration, and want to move it forward so it's in beta4...  so=
 I'm willing to accept this part of limited beauty.  We can improve it late=
r - right now it's "not working" which is definitely less useful ;-)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1253?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I07a8ddd9026eef64b6f5abde98702a9801616a5f
Gerrit-Change-Number: 1253
Gerrit-PatchSet: 7
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <antonio@...2726...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-Comment-Date: Fri, 17 Oct 2025 20:18:52 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: ordex <antonio@...2726...>
Comment-In-Reply-To: mrbff <marco@...2726...>

--3GFO35WFqFc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, mrbff, ordex, plaisthos. </p>
<p>Patch set 7:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1253?usp=3Demail">V=
iew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1253?tab=3Dcomments&amp;usp=3Demail">Patch Set #7:</a> </p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This looks=
 good now.  Tested a sequence of &quot;change ifconfig, change ifconfig, ch=
ange to -ifconfig, send new ifconfig&quot; and it always learned/unlearned =
the expected things</p><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;">```<br>Oct 17 22:11:37 gentoo tun-udp-p2mp[13761]: =
MULTI: Learn: 10.204.2.46 -&gt; freebsd-14-amd64/udp6:194.97.140.5:60204<br=
>Oct 17 22:11:37 gentoo tun-udp-p2mp[13761]: MULTI: primary virtual IP for =
freebsd-14-amd64/udp6:194.97.140.5:60204: 10.204.2.46<br>Oct 17 22:11:37 ge=
ntoo tun-udp-p2mp[13761]: MULTI: Learn: fd00:abcd:204:2::100a -&gt; freebsd=
-14-amd64/udp6:194.97.140.5:60204<br>Oct 17 22:11:37 gentoo tun-udp-p2mp[13=
761]: MULTI: primary virtual IPv6 for freebsd-14-amd64/udp6:194.97.140.5:60=
204: fd00:abcd:204:2::100a<br>Oct 17 22:13:15 gentoo tun-udp-p2mp[13761]: M=
ULTI: Unlearn: 10.204.2.46 -&gt; freebsd-14-amd64/udp6:194.97.140.5:60204<b=
r>Oct 17 22:13:15 gentoo tun-udp-p2mp[13761]: MULTI: Learn: 10.204.2.99 -&g=
t; freebsd-14-amd64/udp6:194.97.140.5:60204<br>Oct 17 22:13:38 gentoo tun-u=
dp-p2mp[13761]: MULTI: Unlearn: 10.204.2.99 -&gt; freebsd-14-amd64/udp6:194=
.97.140.5:60204<br>Oct 17 22:13:38 gentoo tun-udp-p2mp[13761]: MULTI: Learn=
: 10.204.2.146 -&gt; freebsd-14-amd64/udp6:194.97.140.5:60204<br>Oct 17 22:=
14:40 gentoo tun-udp-p2mp[13761]: MULTI: Unlearn: 10.204.2.146 -&gt; freebs=
d-14-amd64/udp6:194.97.140.5:60204<br>Oct 17 22:14:57 gentoo tun-udp-p2mp[1=
3761]: MULTI: Learn: 10.204.2.99 -&gt; freebsd-14-amd64/udp6:194.97.140.5:6=
0204<br>```</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">also the logging is symmetric now (thanks again).  Very nic=
e.</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">I also tested IPv6, though it mains me to send &quot;PUSH_UPDATE,-if=
config-ipv6&quot; - but it still works :-)</p></li></ul></li><li style=3D"m=
argin: 0; padding: 0;"><p>File src/openvpn/push_util.c:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1253/comment/831de5dd_a3d9baac?usp=3Demail">Patch Set #6, Line 165:</=
a> <code style=3D"font-family:monospace,monospace">    o.ifconfig_local =3D=
 canary;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; mar=
gin: 10px 0; padding: 0 10px;">the canary is mostly to be less invasive as =
possible. [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/1253/comment/baeb5012_d8c04c16?usp=3Demail">P=
atch Set #6, Line 166:</a> <code style=3D"font-family:monospace,monospace">=
    o.ifconfig_ipv6_local =3D canary;</code></p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">same for this o=
bviously.</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">While I agree that this is not pretty, I would s=
till leave it at that (and mrbff admitted that &quot;it is ugly&quot;).  I =
do like the rest of the code a lot in this latest iteration, and want to mo=
ve it forward so it&#39;s in beta4...  so I&#39;m willing to accept this pa=
rt of limited beauty.  We can improve it later - right now it&#39;s &quot;n=
ot working&quot; which is definitely less useful ;-)</p></li></ul></li></ul=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1253?us=
p=3Demail">change 1253</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1253?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I07a8ddd9026eef64b6f5abde987=
02a9801616a5f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1253 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@...2726...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 17 Oct 2025 20:18:52=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;antonio@...2787...=
...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: mrbff &lt;marco@...2804...=
.&gt; </div>

</body></html>=

--3GFO35WFqFc=--


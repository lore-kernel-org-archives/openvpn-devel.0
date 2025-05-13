From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 13 May 2025 17:13:04 +0000
In-Reply-To: <gerrit.1733989644000.Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10@...2715...>
References: <gerrit.1733989644000.Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <dd4ae9968250ad883a413cd0c48c27afc4e874d1-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WXCwBIAhisw="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dns: apply settings
 via script on unixoid systems
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--WXCwBIAhisw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/838?usp=3Demail )

Change subject: dns: apply settings via script on unixoid systems
......................................................................


Patch Set 24: Code-Review-1

(3 comments)

Patchset:

PS22:
> What about incoming dhcp-options?  These still do not make it into a `--d=
ns-updown` call - having th [=E2=80=A6]
Clarified that on IRC: internal "decoupling of what-goes-in from what-goes-=
out" happens in gerrit#904.


Patchset:

PS24:
getting really close :-) - OpenBSD and OpenSolaris tested, both *work*, but=
 have the annoying habit of leaving an extra blank line at the top of the r=
estored resolv.conf (accumulating).  So one `\n` needs to go.


File distro/dns-scripts/resolvconf_file-dns-updown.sh:

http://gerrit.openvpn.net/c/openvpn/+/838/comment/438f64f9_6cfc18d5 :
PS22, Line 85:
> Still does not work, but it's way more interesting now. [=E2=80=A6]
We are getting very close... but... the concatenation part "new text plus e=
xisting config" is adding a newline, which leads to the resulting file grow=
ing an extra newline for each openvpn call

```
obsd75$ cat /etc/resolv.conf
### openvpn tun1 begin ###
nameserver 10.194.0.1
nameserver fd00:abcd:194::1
### openvpn tun1 end ###


lookup file bind
nameserver 195.30.0.2
nameserver 195.30.0.1
nameserver 2001:608::2
```

... this file started out with no empty lines...



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10
Gerrit-Change-Number: 838
Gerrit-PatchSet: 24
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Tue, 13 May 2025 17:13:04 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: cron2 <gert@...1296...>
Comment-In-Reply-To: d12fk <heiko@...515...>
Gerrit-MessageType: comment

--WXCwBIAhisw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, flichtenheld, plaisthos. <=
/p>
<p>Patch set 24:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail">V=
iew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/838?tab=3Dcomments">Patch Set #22:</a> </p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">What about inco=
ming dhcp-options?  These still do not make it into a `--dns-updown` call -=
 having th [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">Clarified that on IRC: internal &quot;decoupling of =
what-goes-in from what-goes-out&quot; happens in gerrit#904.</p></li></ul><=
/li><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/838?tab=3Dcomments">Patch Set #24:</a> </p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">getting really close :-) - OpenBSD and OpenS=
olaris tested, both *work*, but have the annoying habit of leaving an extra=
 blank line at the top of the restored resolv.conf (accumulating).  So one =
`\n` needs to go.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p=
>File distro/dns-scripts/resolvconf_file-dns-updown.sh:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/838/comment/438f64f9_6cfc18d5">Patch Set #22, Line 85:</a> <code styl=
e=3D"font-family:monospace,monospace"></code></p><p><blockquote style=3D"bo=
rder-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Still does not=
 work, but it&#39;s way more interesting now. [=E2=80=A6]</blockquote></p><=
p style=3D"white-space: pre-wrap; word-wrap: break-word;">We are getting ve=
ry close... but... the concatenation part &quot;new text plus existing conf=
ig&quot; is adding a newline, which leads to the resulting file growing an =
extra newline for each openvpn call</p><p style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">```<br>obsd75$ cat /etc/resolv.conf<br>### openvpn t=
un1 begin ###<br>nameserver 10.194.0.1<br>nameserver fd00:abcd:194::1<br>##=
# openvpn tun1 end ###</p><p style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;"><br>lookup file bind<br>nameserver 195.30.0.2<br>nameserver 195.3=
0.0.1<br>nameserver 2001:608::2 <br>```</p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">... this file started out with no empty lines...=
</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/838?usp=3Demail">change 838</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/8=
38?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifbe4ffb44d3bfcaa50adb38cacb=
3436fcdc71b10 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 838 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 24 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
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
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 13 May 2025 17:13:04=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: d12fk &lt;heiko@...515...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--WXCwBIAhisw=--


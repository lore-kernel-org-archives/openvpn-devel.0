From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 19 Jan 2026 19:13:22 +0000
In-Reply-To: <gerrit.1768848003000.I3d506725e69c09a9c77d6a9ba71a00e112e7abb6@...2715...>
References: <gerrit.1768848003000.I3d506725e69c09a9c77d6a9ba71a00e112e7abb6@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 ralf@...2726...
Message-ID: <33df3216629107617d46e3732b4963e173556bb7-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TFQAG3IsLUQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: ignore key
 transition window logic
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf_lici <ralf@...2726...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TFQAG3IsLUQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ralf_lici.

plaisthos has posted comments on this change by ralf_lici. ( http://gerrit.=
openvpn.net/c/openvpn/+/1479?usp=3Demail )

Change subject: dco: ignore key transition window logic
......................................................................


Patch Set 1: Code-Review-2

(1 comment)

Patchset:

PS1:
>Although the DCO part
> of this mechanism is set up in userspace, none of the drivers actually
>implements it in the kernel.

We implement this with secondary and primary key for the kernel as well. Op=
enVPN assume that the primary key is always used for encryption and that th=
e secondary key can be used for decryption.

Currently dco_update_keys also installs the new negotiated key first as sec=
ondary key and then only when it becomes the primary key we call dco_swap_k=
eys. Which we do after the transition period. So we basically have this tra=
nsition period in user space.

Which part of that is not implemented in kernel space? Is secondary ignored=
 or what? The commit is missing what part exactly is not implemented in the=
 DCO drivers here.

If you ignore the period and switch to the new key as soon as you get it, y=
ou get packet loss as there is no way around a packet loss unless you have =
a transition period where both keys are active for decryption.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1479?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3d506725e69c09a9c77d6a9ba71a00e112e7abb6
Gerrit-Change-Number: 1479
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-Comment-Date: Mon, 19 Jan 2026 19:13:22 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--TFQAG3IsLUQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ralf_lici. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1479?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1479?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">&gt;Althoug=
h the DCO part<br>&gt; of this mechanism is set up in userspace, none of th=
e drivers actually<br>&gt;implements it in the kernel.</p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">We implement thi=
s with secondary and primary key for the kernel as well. OpenVPN assume tha=
t the primary key is always used for encryption and that the secondary key =
can be used for decryption. </p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Currently dco_update_keys also installs th=
e new negotiated key first as secondary key and then only when it becomes t=
he primary key we call dco_swap_keys. Which we do after the transition peri=
od. So we basically have this transition period in user space. </p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Which p=
art of that is not implemented in kernel space? Is secondary ignored or wha=
t? The commit is missing what part exactly is not implemented in the DCO dr=
ivers here.</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">If you ignore the period and switch to the new key as soon =
as you get it, you get packet loss as there is no way around a packet loss =
unless you have a transition period where both keys are active for decrypti=
on.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1479?usp=3Demail">change 1479</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1479?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3d506725e69c09a9c77d6a9ba71=
a00e112e7abb6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1479 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 19 Jan 2026 19:13:22=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--TFQAG3IsLUQ=--


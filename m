From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 29 Oct 2025 06:52:59 +0000
In-Reply-To: <gerrit.1761604654000.I76eb584024610a6054a069340adbac988abf686c@...2715...>
References: <gerrit.1761604654000.I76eb584024610a6054a069340adbac988abf686c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f4503a65cd8c2a2eb099806fa414f7ca9d9b3553-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ta+j3+MM9lo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix logic when
 pushed cipher triggers tun reopen and ignore more options
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

--Ta+j3+MM9lo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change by plaisthos. ( http://gerrit.open=
vpn.net/c/openvpn/+/1321?usp=3Demail )

Change subject: Fix logic when pushed cipher triggers tun reopen and ignore=
 more options
......................................................................


Patch Set 1: Code-Review+2

(1 comment)

Patchset:

PS1:
> welcome to openvpn logic. link-mtu and tun-mtu are mutally exclusive. [=
=E2=80=A6]
Right, this is why the code should check for `link_mtu_defined` and not `tu=
n_mtu_defined`.  Right?  `if (cipher && !link_mtu_defined) { skip this }`.

But you're right, I misread this - `tun_mtu_defined` implies `!link_mtu_def=
ined`, so while I find the other one easier to follow ("if link_mtu defined=
, tun_mtu is derived from cipher etc.") the code is correct.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1321?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I76eb584024610a6054a069340adbac988abf686c
Gerrit-Change-Number: 1321
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 29 Oct 2025 06:52:59 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Comment-In-Reply-To: cron2 <gert@...1296...>

--Ta+j3+MM9lo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1321?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1321?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
welcome to openvpn logic. link-mtu and tun-mtu are mutally exclusive. [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Right, this is why the code should check for `link=
_mtu_defined` and not `tun_mtu_defined`.  Right?  `if (cipher &amp;&amp; !l=
ink_mtu_defined) { skip this }`.</p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">But you&#39;re right, I misread this -=
 `tun_mtu_defined` implies `!link_mtu_defined`, so while I find the other o=
ne easier to follow (&quot;if link_mtu defined, tun_mtu is derived from cip=
her etc.&quot;) the code is correct.</p></li></ul></li></ul><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1321?usp=3Demail">chang=
e 1321</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1321?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I76eb584024610a6054a069340ad=
bac988abf686c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1321 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 29 Oct 2025 06:52:59=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>

</body></html>=

--Ta+j3+MM9lo=--


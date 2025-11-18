From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 18 Nov 2025 14:14:45 +0000
In-Reply-To: <gerrit.1763474625000.I23ea00dbd62271838aa72e913b743cc679ff2386@...2715...>
References: <gerrit.1763474625000.I23ea00dbd62271838aa72e913b743cc679ff2386@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <7eb03d4b146de21d141cb3d02ae625dec08f32c8-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pT2AzLhEFVo="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: doc: Document
 potential filesystem pitfalls of client-config-dir
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--pT2AzLhEFVo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change by flichtenheld. ( http://gerr=
it.openvpn.net/c/openvpn/+/1380?usp=3Demail )

Change subject: doc: Document potential filesystem pitfalls of client-confi=
g-dir
......................................................................


Patch Set 1: Code-Review+2

(1 comment)

File doc/man-sections/server-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/1380/comment/524cf1ed_ee00fa22?usp=3D=
email :
PS1, Line 153:   different to not cause issues.
Maybe we should spell it out a bit more:

If the CA you are trusting and using is malicious, it could issue certifica=
tes with different cases to bypass this verification.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1380?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I23ea00dbd62271838aa72e913b743cc679ff2386
Gerrit-Change-Number: 1380
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 18 Nov 2025 14:14:45 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--pT2AzLhEFVo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1380?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/server-op=
tions.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1380/comment/524cf1ed_ee00fa22?usp=3Dem=
ail">Patch Set #1, Line 153:</a> <code style=3D"font-family:monospace,monos=
pace">  different to not cause issues.</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Maybe we should spell it=
 out a bit more:</p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">If the CA you are trusting and using is malicious, it =
could issue certificates with different cases to bypass this verification.<=
/p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1380?usp=3Demail">change 1380</a>. To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setting=
s?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.or=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1380?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I23ea00dbd62271838aa72e913b7=
43cc679ff2386 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1380 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 18 Nov 2025 14:14:45=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--pT2AzLhEFVo=--


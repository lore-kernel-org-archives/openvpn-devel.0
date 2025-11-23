From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 23 Nov 2025 11:48:28 +0000
In-Reply-To: <gerrit.1763880426000.I16f9426e57f4802ba038ab51f5b70161464b9428@...2715...>
References: <gerrit.1763880426000.I16f9426e57f4802ba038ab51f5b70161464b9428@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <6680cebe6966aff997d3f87e92a27d533b17966e-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SRi5ptSqZYM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: iservice: fix
 calculation of converted domains size
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--SRi5ptSqZYM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos.

cron2 has posted comments on this change by d12fk. ( http://gerrit.openvpn.=
net/c/openvpn/+/1390?usp=3Demail )

Change subject: iservice: fix calculation of converted domains size
......................................................................


Patch Set 1: Code-Review-1

(2 comments)

Patchset:

PS1:
I might be misreading this, but I think there is still an char/wchar mixup =
here


File src/openvpnserv/interactive.c:

http://gerrit.openvpn.net/c/openvpn/+/1390/comment/d13a1328_0f71fd2d?usp=3D=
email :
PS1, Line 2207:                 domain_size +=3D 1;
shouldn't that be `+=3D one_glyph` here?  A wide-character dot will still t=
ake 2 bytes?

Maybe just move the `size_t domain_size =3D domain_len * one_glyph` down he=
re so it will get the +1 right away?  (Also it feels a bit more logical to =
do this after the ListContainsDomain() block, where it is used)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1390?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I16f9426e57f4802ba038ab51f5b70161464b9428
Gerrit-Change-Number: 1390
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Sun, 23 Nov 2025 11:48:28 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--SRi5ptSqZYM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: d12fk, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1390?usp=3Demail">V=
iew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1390?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I might be=
 misreading this, but I think there is still an char/wchar mixup here</p></=
li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/i=
nteractive.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1390/comment/d13a1328_0f71fd2d?usp=
=3Demail">Patch Set #1, Line 2207:</a> <code style=3D"font-family:monospace=
,monospace">                domain_size +=3D 1;</code></p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">shouldn&#39;t th=
at be `+=3D one_glyph` here?  A wide-character dot will still take 2 bytes?=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Maybe just move the `size_t domain_size =3D domain_len * one_glyph` do=
wn here so it will get the +1 right away?  (Also it feels a bit more logica=
l to do this after the ListContainsDomain() block, where it is used)</p></l=
i></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1390?usp=3Demail">change 1390</a>. To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1390?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I16f9426e57f4802ba038ab51f5b=
70161464b9428 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1390 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 23 Nov 2025 11:48:28=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--SRi5ptSqZYM=--


From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 4 Mar 2026 11:40:35 +0000
In-Reply-To: <gerrit.1771373435000.I0f7237720b0892f5ba0caf60f941f9cc2241cdb6@...2715...>
References: <gerrit.1771373435000.I0f7237720b0892f5ba0caf60f941f9cc2241cdb6@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <1c9500b48b46651905dbe341e9f335bc1835b0b3-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MODtn9NGWSc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: wfp: add flag to
 allow DNS traffic to loopback
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

--MODtn9NGWSc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos.

flichtenheld has posted comments on this change by d12fk. ( http://gerrit.o=
penvpn.net/c/openvpn/+/1541?usp=3Demail )

Change subject: wfp: add flag to allow DNS traffic to loopback
......................................................................


Patch Set 1: Code-Review-1

(2 comments)

File doc/man-sections/windows-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/1541/comment/d5bb05f2_99eae1b5?usp=3D=
email :
PS1, Line 23:   Windows XP) to ignore said error. Note that pushing unknown=
 options from
Can we maybe remove this Windows XP mention as a drive-by fix?


File src/openvpnserv/interactive.c:

http://gerrit.openvpn.net/c/openvpn/+/1541/comment/c9ad5c85_76b9cf5a?usp=3D=
email :
PS1, Line 855:     if (msg->block_type >=3D 0 && msg->block_type < wfp_bloc=
k_type_count)
I don't understand this conditional. So if block_type is between 0 and wfp_=
block_type_count, that is an error? Why?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1541?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0f7237720b0892f5ba0caf60f941f9cc2241cdb6
Gerrit-Change-Number: 1541
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Wed, 04 Mar 2026 11:40:35 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--MODtn9NGWSc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: d12fk, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1541?usp=3Demail">V=
iew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/windows-=
options.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1541/comment/d5bb05f2_99eae1b5?usp=3D=
email">Patch Set #1, Line 23:</a> <code style=3D"font-family:monospace,mono=
space">  Windows XP) to ignore said error. Note that pushing unknown option=
s from</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Can we maybe remove this Windows XP mention as a drive-by=
 fix?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/op=
envpnserv/interactive.c:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1541/comment/c9ad5c85_76b=
9cf5a?usp=3Demail">Patch Set #1, Line 855:</a> <code style=3D"font-family:m=
onospace,monospace">    if (msg-&gt;block_type &gt;=3D 0 &amp;&amp; msg-&gt=
;block_type &lt; wfp_block_type_count)</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">I don&#39;t understand t=
his conditional. So if block_type is between 0 and wfp_block_type_count, th=
at is an error? Why?</p></li></ul></li></ul><p>To view, visit <a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1541?usp=3Demail">change 1541</a>. To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1541?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0f7237720b0892f5ba0caf60f94=
1f9cc2241cdb6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1541 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 04 Mar 2026 11:40:35=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--MODtn9NGWSc=--


From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 27 Oct 2025 16:19:32 +0000
In-Reply-To: <gerrit.1761488400000.I0579d18c784e2ac16973d5553992c28f281a0900@...2715...>
References: <gerrit.1761488400000.I0579d18c784e2ac16973d5553992c28f281a0900@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., max@...2606...
Message-ID: <b84aa2d2c3a0fd91954fe24d99bc50c38319065f-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aidJ97eJkvg="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add option to check
 tls-crypt-v2 key timestamps
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: MaxF <max@...2606...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--aidJ97eJkvg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF.

plaisthos has posted comments on this change by MaxF. ( http://gerrit.openv=
pn.net/c/openvpn/+/1304?usp=3Demail )

Change subject: Add option to check tls-crypt-v2 key timestamps
......................................................................


Patch Set 4:

(4 comments)

Patchset:

PS4:
Looks good but I would like a few minor issues to be addressed


File doc/man-sections/tls-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/1304/comment/17d09927_5a722c44?usp=3D=
email :
PS4, Line 573:   no timestamp.
should add in the description what happen if tls-crypt-v2 client keys are u=
sed that don't use the timestamp.


File src/openvpn/tls_crypt.c:

http://gerrit.openvpn.net/c/openvpn/+/1304/comment/5baff829_139564bf?usp=3D=
email :
PS4, Line 537:         msg(M_WARN, "ERROR: Client key doesn't have a timest=
amp.");
I would go for the bit more formal form here and use "does not" instead of =
the short form "doesn't"


http://gerrit.openvpn.net/c/openvpn/+/1304/comment/7d9d8afb_144c9475?usp=3D=
email :
PS4, Line 541:     memcpy(&timestamp, metadata + 1, sizeof(int64_t));
I think we should add a length check here to ensure that the metadata is lo=
ng enough.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1304?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0579d18c784e2ac16973d5553992c28f281a0900
Gerrit-Change-Number: 1304
Gerrit-PatchSet: 4
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Mon, 27 Oct 2025 16:19:32 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--aidJ97eJkvg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1304?usp=3Demail">View =
Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1304?tab=3Dcomments&amp;usp=3Demail">Patch Set #4:</a> </p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Looks good but=
 I would like a few minor issues to be addressed</p></li></ul></li><li styl=
e=3D"margin: 0; padding: 0;"><p>File doc/man-sections/tls-options.rst:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1304/comment/17d09927_5a722c44?usp=3Demail">Patch Set =
#4, Line 573:</a> <code style=3D"font-family:monospace,monospace">  no time=
stamp.</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">should add in the description what happen if tls-crypt-v2=
 client keys are used that don&#39;t use the timestamp.</p></li></ul></li><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/tls_crypt.c:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1304/comment/5baff829_139564bf?usp=3Demail">Patch Set #4=
, Line 537:</a> <code style=3D"font-family:monospace,monospace">        msg=
(M_WARN, &quot;ERROR: Client key doesn&#39;t have a timestamp.&quot;);</cod=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">I would go for the bit more formal form here and use &quot;does not&=
quot; instead of the short form &quot;doesn&#39;t&quot;</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1304/comment/7d9d8afb_144c9475?=
usp=3Demail">Patch Set #4, Line 541:</a> <code style=3D"font-family:monospa=
ce,monospace">    memcpy(&amp;timestamp, metadata + 1, sizeof(int64_t));</c=
ode></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">I think we should add a length check here to ensure that the metad=
ata is long enough.</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1304?usp=3Demail">change 1304</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1304?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0579d18c784e2ac16973d555399=
2c28f281a0900 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1304 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 27 Oct 2025 16:19:32=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>=

--aidJ97eJkvg=--


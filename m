From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 11 Nov 2025 11:49:11 +0000
In-Reply-To: <gerrit.1761324750000.I3309265edf8d6bea7bd73b21eef589a92ede6e0a@...2715...>
References: <gerrit.1761324750000.I3309265edf8d6bea7bd73b21eef589a92ede6e0a@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <4b7cb6eea397b486d8b273af0b0ab5b2bc7ddbba-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cJxnX/A0sNk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: Clean up type
 handling in write_string()
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

--cJxnX/A0sNk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change by flichtenheld. ( http://gerr=
it.openvpn.net/c/openvpn/+/1300?usp=3Demail )

Change subject: ssl: Clean up type handling in write_string()
......................................................................


Patch Set 5:

(1 comment)

File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1300/comment/37ea3b83_e5eb84eb?usp=3D=
email :
PS5, Line 1787:     const size_t real_maxlen =3D (maxlen >=3D 0 && maxlen <=
=3D UINT16_MAX) ? (size_t)maxlen : UINT16_MAX;
> ```suggestion [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1300?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3309265edf8d6bea7bd73b21eef589a92ede6e0a
Gerrit-Change-Number: 1300
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 11 Nov 2025 11:49:11 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>

--cJxnX/A0sNk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1300?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl.c:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1300/comment/37ea3b83_e5eb84eb?usp=3Demail">Patch Set #5, Lin=
e 1787:</a> <code style=3D"font-family:monospace,monospace">    const size_=
t real_maxlen =3D (maxlen &gt;=3D 0 &amp;&amp; maxlen &lt;=3D UINT16_MAX) ?=
 (size_t)maxlen : UINT16_MAX;</code></p><p><blockquote style=3D"border-left=
: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">```suggestion [=E2=80=
=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1300?usp=3Demail">change 1300</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1300?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3309265edf8d6bea7bd73b21eef=
589a92ede6e0a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1300 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 11 Nov 2025 11:49:11=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>

</body></html>=

--cJxnX/A0sNk=--


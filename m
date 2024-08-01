From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 1 Aug 2024 12:12:34 +0000
In-Reply-To: <gerrit.1706186293000.I01e258e97351b5aa4b9e561f5b35ddc2318569e2@...2715...>
References: <gerrit.1706186293000.I01e258e97351b5aa4b9e561f5b35ddc2318569e2@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., lstipakov@...277...
Message-ID: <e61fc92bea2b08e83cc357766cc31a27683e6fc8-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mEnn7iy/Kzg="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Implement support
 for larger packet counter sizes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: stipa <lstipakov@...277...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mEnn7iy/Kzg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/507?usp=3Demail )

Change subject: Implement support for larger packet counter sizes
......................................................................


Patch Set 6:

(3 comments)

File src/openvpn/crypto.c:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/339be4fb_e4a7dcd8 :
PS6, Line 364: openvpn_decrypt_aead(struct buffer *buf, struct buffer work,
> Is it so that for DATA_V1: [=E2=80=A6]
yes. But that has been always the case.


File src/openvpn/ssl_common.h:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/ed094001_4358b379 :
PS6, Line 314:     bool disable_occ;
> this looks like an unrelated change
Yes. But I don't think it warranted an extra commit and I modify that part =
anyway.


http://gerrit.openvpn.net/c/openvpn/+/507/comment/a566bc93_6c0e149b :
PS6, Line 493:     int limit_next;             /* used for traffic shaping =
on the control channel */
> ditto
same, just removing an unused variable



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/507?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I01e258e97351b5aa4b9e561f5b35ddc2318569e2
Gerrit-Change-Number: 507
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Thu, 01 Aug 2024 12:12:34 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: stipa <lstipakov@...277...>
Gerrit-MessageType: comment

--mEnn7iy/Kzg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: stipa. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/507?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto.c:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/507/comment/339be4fb_e4a7dcd8">Patch Set #6, Line 364:</a>=
 <code style=3D"font-family:monospace,monospace">openvpn_decrypt_aead(struc=
t buffer *buf, struct buffer work,</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Is it so that for =
DATA_V1: [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">yes. But that has been always the case.</p></li></ul><=
/li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_common.h:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/507/comment/ed094001_4358b379">Patch Set #6, Line =
314:</a> <code style=3D"font-family:monospace,monospace">    bool disable_o=
cc;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: =
10px 0; padding: 0 10px;">this looks like an unrelated change</blockquote><=
/p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Yes. But I do=
n&#39;t think it warranted an extra commit and I modify that part anyway.</=
p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/507/comment/a56=
6bc93_6c0e149b">Patch Set #6, Line 493:</a> <code style=3D"font-family:mono=
space,monospace">    int limit_next;             /* used for traffic shapin=
g on the control channel */</code></p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;">ditto</blockquote></p><p =
style=3D"white-space: pre-wrap; word-wrap: break-word;">same, just removing=
 an unused variable</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/507?usp=3Demail">change 507</a>. To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.o=
penvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/507?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I01e258e97351b5aa4b9e561f5b3=
5ddc2318569e2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 507 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 01 Aug 2024 12:12:34=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: stipa &lt;lstipakov@...1664...=
7...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--mEnn7iy/Kzg=--


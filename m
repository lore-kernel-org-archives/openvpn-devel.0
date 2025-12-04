From: "ordex (Code Review)" <gerrit@...515...>
Date: Thu, 4 Dec 2025 12:47:20 +0000
In-Reply-To: <gerrit.1757957943000.I34e6b680618a52003d8408852d415c8aeac01feb@...2715...>
References: <gerrit.1757957943000.I34e6b680618a52003d8408852d415c8aeac01feb@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1f693b4fbb8ff6bc24a34f04e87b0eb97865dd62-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WAfTLsjcvlc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Clarify some code in
 epoch with better comments
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

--WAfTLsjcvlc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

ordex has posted comments on this change by plaisthos. ( http://gerrit.open=
vpn.net/c/openvpn/+/1190?usp=3Demail )

Change subject: Clarify some code in epoch with better comments
......................................................................


Patch Set 2: Code-Review-1

(2 comments)

File src/openvpn/crypto.h:

http://gerrit.openvpn.net/c/openvpn/+/1190/comment/7157deb0_b889163c?usp=3D=
email :
PS2, Line 312:      * limit is reached. */
shouldn't the closing */ be on a new line like all other multiline comments?


File src/openvpn/crypto.c:

http://gerrit.openvpn.net/c/openvpn/+/1190/comment/ccf561c6_6036bff1?usp=3D=
email :
PS2, Line 105:              * iterate the epoch */
same here



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1190?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I34e6b680618a52003d8408852d415c8aeac01feb
Gerrit-Change-Number: 1190
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Thu, 04 Dec 2025 12:47:20 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--WAfTLsjcvlc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1190?usp=3Demail">V=
iew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto.h:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1190/comment/7157deb0_b889163c?usp=3Demail">Patch Set=
 #2, Line 312:</a> <code style=3D"font-family:monospace,monospace">     * l=
imit is reached. */</code></p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">shouldn&#39;t the closing */ be on a new lin=
e like all other multiline comments?</p></li></ul></li><li style=3D"margin:=
 0; padding: 0;"><p>File src/openvpn/crypto.c:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
190/comment/ccf561c6_6036bff1?usp=3Demail">Patch Set #2, Line 105:</a> <cod=
e style=3D"font-family:monospace,monospace">             * iterate the epoc=
h */</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">same here</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1190?usp=3Demail">change 1190</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1190?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I34e6b680618a52003d8408852d4=
15c8aeac01feb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1190 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 04 Dec 2025 12:47:20=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--WAfTLsjcvlc=--


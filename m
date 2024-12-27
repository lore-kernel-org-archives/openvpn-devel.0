From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 27 Dec 2024 18:17:30 +0000
In-Reply-To: <gerrit.1731290343000.I2a104decdb1e77a460f7a6976bcd0560b67a07b5@...2715...>
References: <gerrit.1731290343000.I2a104decdb1e77a460f7a6976bcd0560b67a07b5@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., lstipakov@...277...
Message-ID: <6669592b6578fa0cf2a118a78dd4dbfeb88358dd-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HWyPC96NYFw="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add methods to
 read/write packet ids for epoch data
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--HWyPC96NYFw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, stipa.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/803?usp=3Demail )

Change subject: Add methods to read/write packet ids for epoch data
......................................................................


Patch Set 8:

(3 comments)

File src/openvpn/packet_id.h:

http://gerrit.openvpn.net/c/openvpn/+/803/comment/f34723d4_5781004e :
PS8, Line 49: /** Maks of the bits that make out the epoch in the packet co=
unter */
> "Maks" -> "Mask". [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/803/comment/6fc94b17_3cb2fa5b :
PS8, Line 333:  * @param buf       buffer to write the packet id/epcoh to
> "epoch"
Done


File src/openvpn/packet_id.c:

http://gerrit.openvpn.net/c/openvpn/+/803/comment/3a7675bb_c3f00413 :
PS8, Line 684:      * integer contain our counter but the upper two bytes a=
re always 0 */
> This is confusing. [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/803?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2a104decdb1e77a460f7a6976bcd0560b67a07b5
Gerrit-Change-Number: 803
Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Fri, 27 Dec 2024 18:17:30 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--HWyPC96NYFw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, stipa. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/803?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/packet_id.h:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/803/comment/f34723d4_5781004e">Patch Set #8, Line 49:</=
a> <code style=3D"font-family:monospace,monospace">/** Maks of the bits tha=
t make out the epoch in the packet counter */</code></p><p><blockquote styl=
e=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;M=
aks&quot; -&gt; &quot;Mask&quot;. [=E2=80=A6]</blockquote></p><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/803/comment/6fc94b17_3cb2fa5b">Patch S=
et #8, Line 333:</a> <code style=3D"font-family:monospace,monospace"> * @pa=
ram buf       buffer to write the packet id/epcoh to</code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
&quot;epoch&quot;</blockquote></p><p style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0=
;"><p>File src/openvpn/packet_id.c:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/803/comment/3a=
7675bb_c3f00413">Patch Set #8, Line 684:</a> <code style=3D"font-family:mon=
ospace,monospace">     * integer contain our counter but the upper two byte=
s are always 0 */</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">This is confusing. [=E2=80=A6]</blo=
ckquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done=
</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/803?usp=3Demail">change 803</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/8=
03?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2a104decdb1e77a460f7a6976bc=
d0560b67a07b5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 803 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 27 Dec 2024 18:17:30=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--HWyPC96NYFw=--


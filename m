From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 9 Feb 2025 15:27:21 +0000
In-Reply-To: <gerrit.1731290343000.I00751c42cb04e30205ba8e6584530831e0d143c5@...2715...>
References: <gerrit.1731290343000.I00751c42cb04e30205ba8e6584530831e0d143c5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <b5425082df8feebc996428b2f5f63a8eb5a8a198-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="l3BvcO5wKW8="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Implement epoch key
 data format
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: MaxF <max@...2606...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--l3BvcO5wKW8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/806?usp=3Demail )

Change subject: Implement epoch key data format
......................................................................


Patch Set 19: Code-Review+1

(1 comment)

File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/806/comment/38db66c9_2bc36ec9 :
PS18, Line 3040:     if (ks->crypto_options.flags & CO_EPOCH_DATA_KEY_FORMA=
T)
> if we need to do another round of this patch, it would be nice to be cons=
istent with all the other c [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/806?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I00751c42cb04e30205ba8e6584530831e0d143c5
Gerrit-Change-Number: 806
Gerrit-PatchSet: 19
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: MaxF <max@...2606...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Sun, 09 Feb 2025 15:27:21 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--l3BvcO5wKW8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: MaxF, flichtenheld, plaisthos. </=
p>
<p>Patch set 19:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +1</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/806?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl.c:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/806/comment/38db66c9_2bc36ec9">Patch Set #18, Line 3040:<=
/a> <code style=3D"font-family:monospace,monospace">    if (ks-&gt;crypto_o=
ptions.flags &amp; CO_EPOCH_DATA_KEY_FORMAT)</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">if we ne=
ed to do another round of this patch, it would be nice to be consistent wit=
h all the other c [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/806?usp=3Demail">change 8=
06</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/806?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I00751c42cb04e30205ba8e65845=
30831e0d143c5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 806 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 19 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: MaxF &lt;max@...2606...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 09 Feb 2025 15:27:21=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--l3BvcO5wKW8=--


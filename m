From: "MaxF (Code Review)" <gerrit@...515...>
Date: Wed, 5 Feb 2025 17:01:22 +0000
In-Reply-To: <gerrit.1731290343000.I00751c42cb04e30205ba8e6584530831e0d143c5@...2715...>
References: <gerrit.1731290343000.I00751c42cb04e30205ba8e6584530831e0d143c5@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <64140210568e6b9f564873c937266cbe6b1fd19c-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZQGn/+RSdxw="; charset=UTF-8
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
Cc: cron2 <gert@...1296...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZQGn/+RSdxw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

MaxF has posted comments on this change. ( http://gerrit.openvpn.net/c/open=
vpn/+/806?usp=3Demail )

Change subject: Implement epoch key data format
......................................................................


Patch Set 18:

(3 comments)

Patchset:

PS18:
Some minor comments.

Also, I'll read the tests again later. I don't think I fully got them yet.


File tests/unit_tests/openvpn/test_crypto.c:

http://gerrit.openvpn.net/c/openvpn/+/806/comment/42fb5434_e8016878 :
PS18, Line 877:      * the end of array. Iterating through all 65k keys tak=
es a 2-3s, so we
Why is this number changed?


File tests/unit_tests/openvpn/test_ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/806/comment/47bafe95_4b39c681 :
PS18, Line 642:         const uint8_t exp_tag_short[16] =3D
What makes this short? It's exactly as long as the other.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/806?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I00751c42cb04e30205ba8e6584530831e0d143c5
Gerrit-Change-Number: 806
Gerrit-PatchSet: 18
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: MaxF <max@...2606...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 05 Feb 2025 17:01:22 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--ZQGn/+RSdxw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/806?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
806?tab=3Dcomments">Patch Set #18:</a> </p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Some minor comments.</p><p style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Also, I&#39;ll read the tests again late=
r. I don&#39;t think I fully got them yet.</p></li></ul></li><li style=3D"m=
argin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_crypto.c:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/806/comment/42fb5434_e8016878">Patch Set #18, Line 877=
:</a> <code style=3D"font-family:monospace,monospace">     * the end of arr=
ay. Iterating through all 65k keys takes a 2-3s, so we</code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Why is this number chang=
ed?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/un=
it_tests/openvpn/test_ssl.c:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/806/comment/47bafe95_=
4b39c681">Patch Set #18, Line 642:</a> <code style=3D"font-family:monospace=
,monospace">        const uint8_t exp_tag_short[16] =3D</code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">What makes this short? I=
t&#39;s exactly as long as the other.</p></li></ul></li></ul><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/806?usp=3Demail">chang=
e 806</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/806?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I00751c42cb04e30205ba8e65845=
30831e0d143c5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 806 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 18 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 05 Feb 2025 17:01:22=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--ZQGn/+RSdxw=--


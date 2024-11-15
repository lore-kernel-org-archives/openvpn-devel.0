From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 15 Nov 2024 11:59:33 +0000
In-Reply-To: <gerrit.1731290343000.I74216d776d3e0a8dc987ec7b1671c8e8dcccdbd6@...2715...>
References: <gerrit.1731290343000.I74216d776d3e0a8dc987ec7b1671c8e8dcccdbd6@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296..., a@...2181...
Message-ID: <19d740b385a2a081fe486787aac57b5a3b2fb940-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HOfYIr0NxLs="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Use XOR instead of
 concatenation for calculation of IV from implicit IV
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: cron2 <gert@...1296...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--HOfYIr0NxLs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, ordex.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/797?usp=3Demail )

Change subject: Use XOR instead of concatenation for calculation of  IV fro=
m implicit IV
......................................................................


Patch Set 3:

(2 comments)

File src/openvpn/crypto.c:

http://gerrit.openvpn.net/c/openvpn/+/797/comment/9dbf827d_d3cd9727 :
PS3, Line 435:         const size_t packet_iv_len =3D packet_id_size(false);
> nit: since you are keeping this declaration here, I think it is more desc=
riptive to use packet_iv_le [=E2=80=A6]
I don't really follow. Where do you want me to use packet_iv_len and instea=
d of what?


File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/797/comment/24afc1eb_4d268ad7 :
PS3, Line 1566:         /* The first bytes of the IV are filled with the pa=
cket id */
> is the extension to 96 bits implicit IV coming with a future patch? (i.e.=
 DATA_V3 patchset?) [=E2=80=A6]
Yes. That is being done in a one of the future patches.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/797?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I74216d776d3e0a8dc987ec7b1671c8e8dcccdbd6
Gerrit-Change-Number: 797
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Fri, 15 Nov 2024 11:59:33 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: ordex <a@...2181...>
Gerrit-MessageType: comment

--HOfYIr0NxLs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, ordex. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/797?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto.c:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/797/comment/9dbf827d_d3cd9727">Patch Set #3, Line 435:</a>=
 <code style=3D"font-family:monospace,monospace">        const size_t packe=
t_iv_len =3D packet_id_size(false);</code></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">nit: since you ar=
e keeping this declaration here, I think it is more descriptive to use pack=
et_iv_le [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">I don&#39;t really follow. Where do you want me to use=
 packet_iv_len and instead of what?</p></li></ul></li><li style=3D"margin: =
0; padding: 0;"><p>File src/openvpn/ssl.c:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/797/com=
ment/24afc1eb_4d268ad7">Patch Set #3, Line 1566:</a> <code style=3D"font-fa=
mily:monospace,monospace">        /* The first bytes of the IV are filled w=
ith the packet id */</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">is the extension to 96 bits impl=
icit IV coming with a future patch? (i.e. DATA_V3 patchset?) [=E2=80=A6]</b=
lockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Ye=
s. That is being done in a one of the future patches.</p></li></ul></li></u=
l><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/797?us=
p=3Demail">change 797</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/797?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I74216d776d3e0a8dc987ec7b167=
1c8e8dcccdbd6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 797 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 15 Nov 2024 11:59:33=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;a@...2181...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--HOfYIr0NxLs=--


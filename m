From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 18 Jun 2025 09:12:08 +0000
In-Reply-To: <gerrit.1750235257000.Ie0529c2074964b3be034f01e0ef53090a6edbd35@...2715...>
References: <gerrit.1750235257000.Ie0529c2074964b3be034f01e0ef53090a6edbd35@...2715...>
Reply-To: arne-openvpn@...1227..., rein.vanbaaren@...1435...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <82de1c9e35ed1b4615fedb040ae4b6d63421ebbb-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lNuGNNUh0FM="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Added PQE to WolfSSL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: comododragon <rein.vanbaaren@...1435...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--lNuGNNUh0FM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: comododragon, flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/1046?usp=3Demail )

Change subject: Added PQE to WolfSSL
......................................................................


Patch Set 1:

(1 comment)

Patchset:

PS1:
You don't need to close/reopen to update your patch, you can just push the =
change again. But here is the same comment that I had on the original versi=
on of the patch:

I feel this is the wrong approach. We are trying to avoid the NID dance. An=
d it seems that wolfSSL already has a function

int wolfSSL_CTX_set1_groups_list(WOLFSSL_CTX *ctx, const char *list)

that has the same (better) functionality of its SSL_CTX_set1_groups_list Op=
enSSL equivalent. So rather than doing this NID dance, I would prefer that =
we use the proper function instead.

Maybe wolfSSL upstream can also be convinced to map this to SSL_CTX_set1_gr=
oups_list as well.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1046?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie0529c2074964b3be034f01e0ef53090a6edbd35
Gerrit-Change-Number: 1046
Gerrit-PatchSet: 1
Gerrit-Owner: comododragon <rein.vanbaaren@...1435...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: comododragon <rein.vanbaaren@...1435...>
Gerrit-Comment-Date: Wed, 18 Jun 2025 09:12:08 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--lNuGNNUh0FM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: comododragon, flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1046?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1046?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">You don&#39;t need to close/reopen to update you=
r patch, you can just push the change again. But here is the same comment t=
hat I had on the original version of the patch:</p><p style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">I feel this is the wrong approach. We ar=
e trying to avoid the NID dance. And it seems that wolfSSL already has a fu=
nction </p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">int w=
olfSSL_CTX_set1_groups_list(WOLFSSL_CTX *ctx, const char *list)</p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">that has the same (bette=
r) functionality of its SSL_CTX_set1_groups_list OpenSSL equivalent. So rat=
her than doing this NID dance, I would prefer that we use the proper functi=
on instead. </p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Maybe wolfSSL upstream can also be convinced to map this to SSL_CTX_set1_gr=
oups_list as well.</p></li></ul></li></ul><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1046?usp=3Demail">change 1046</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1046?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie0529c2074964b3be034f01e0ef=
53090a6edbd35 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1046 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: comododragon &lt;rein.vanbaaren@=
...1435...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: comododragon &lt;rein.vanbaa=
ren@...1435...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 18 Jun 2025 09:12:08=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--lNuGNNUh0FM=--


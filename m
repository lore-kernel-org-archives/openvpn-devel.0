From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 16 Jun 2025 16:03:50 +0000
In-Reply-To: <gerrit.1750084016000.Id4293137a577f93ea9f2178ece7ef86c4e1429c8@...2715...>
References: <gerrit.1750084016000.Id4293137a577f93ea9f2178ece7ef86c4e1429c8@...2715...>
Reply-To: arne-openvpn@...1227..., rein.vanbaaren@...1435...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f1c62cacaf50baee2598efda3f0cc6586793577d-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="J0QvdchOHKM="; charset=UTF-8
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

--J0QvdchOHKM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/1044?usp=3Demail )

Change subject: Added PQE to WolfSSL
......................................................................


Patch Set 1:

(1 comment)

Patchset:

PS1:
I feel this is the wrong approach. We are trying to avoid the NID dance. An=
d it seems that wolfSSL already has a function

int wolfSSL_CTX_set1_groups_list(WOLFSSL_CTX *ctx, const char *list)

that has the same (better) functionality of its SSL_CTX_set1_groups_list Op=
enSSL equivalent. So rather than doing this NID dance, I would prefer that =
we use the proper function instead.

Maybe wolfSSL upstream can also be convinced to map this to SSL_CTX_set1_gr=
oups_list as well.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1044?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id4293137a577f93ea9f2178ece7ef86c4e1429c8
Gerrit-Change-Number: 1044
Gerrit-PatchSet: 1
Gerrit-Owner: comododragon <rein.vanbaaren@...1435...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Comment-Date: Mon, 16 Jun 2025 16:03:50 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--J0QvdchOHKM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1044?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1044?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">I feel this is the wrong approach. We are trying=
 to avoid the NID dance. And it seems that wolfSSL already has a function <=
/p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">int wolfSSL_C=
TX_set1_groups_list(WOLFSSL_CTX *ctx, const char *list)</p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">that has the same (better) funct=
ionality of its SSL_CTX_set1_groups_list OpenSSL equivalent. So rather than=
 doing this NID dance, I would prefer that we use the proper function inste=
ad. </p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Maybe wo=
lfSSL upstream can also be convinced to map this to SSL_CTX_set1_groups_lis=
t as well.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/1044?usp=3Demail">change 1044</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1044?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id4293137a577f93ea9f2178ece7=
ef86c4e1429c8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1044 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: comododragon &lt;rein.vanbaaren@=
...1435...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 16 Jun 2025 16:03:50=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--J0QvdchOHKM=--


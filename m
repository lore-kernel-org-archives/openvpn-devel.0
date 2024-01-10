From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 10 Jan 2024 16:12:36 +0000
In-Reply-To: <gerrit.1700595358000.Ic74195a4ed340547c5e862dc2438f95be318c286@...2715...>
References: <gerrit.1700595358000.Ic74195a4ed340547c5e862dc2438f95be318c286@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <fa93decc7703a063a82841c08c3795c39c42a144-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XWBpm/q7U/M="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement generating
 TLS 1.0 PRF using new OpenSSL 3.0 APIs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--XWBpm/q7U/M=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/457?usp=3Demail )

Change subject: Implement generating TLS 1.0 PRF using new OpenSSL 3.0 APIs
......................................................................


Patch Set 8: -Code-Review


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/457?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic74195a4ed340547c5e862dc2438f95be318c286
Gerrit-Change-Number: 457
Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Comment-Date: Wed, 10 Jan 2024 16:12:36 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--XWBpm/q7U/M=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>Patch set 8:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ddd;">-Code-Review</span></p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/457?usp=3Demail">View Ch=
ange</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/457?usp=3Demail">chang=
e 457</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/457?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic74195a4ed340547c5e862dc243=
8f95be318c286 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 457 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 10 Jan 2024 16:12:36=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--XWBpm/q7U/M=--


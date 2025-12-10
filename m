From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 10 Dec 2025 13:56:15 +0000
In-Reply-To: <gerrit.1760995553000.I31ac2a763209114267c35c4a9182a12d8d82f6fe@...2715...>
References: <gerrit.1760995553000.I31ac2a763209114267c35c4a9182a12d8d82f6fe@...2715...>
Reply-To: arne-openvpn@...1227..., davidben@...410...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <fc8e6231e3843d6f6e00eb670b811bf798913a8a-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kghzbkl6EAU="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: ssl_openssl: Fix
 some CRL mixups
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: davidben <davidben@...410...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--kghzbkl6EAU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: davidben, flichtenheld.

plaisthos has posted comments on this change by davidben. ( http://gerrit.o=
penvpn.net/c/openvpn/+/1289?usp=3Demail )

Change subject: ssl_openssl: Fix some CRL mixups
......................................................................


Patch Set 2:

(1 comment)

Patchset:

PS2:
In do_init_crypto_tls we do=20

    to.ssl_ctx =3D c->c1.ks.ssl_ctx;

which copies the context and also the stack



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1289?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I31ac2a763209114267c35c4a9182a12d8d82f6fe
Gerrit-Change-Number: 1289
Gerrit-PatchSet: 2
Gerrit-Owner: davidben <davidben@...410...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: davidben <davidben@...410...>
Gerrit-Comment-Date: Wed, 10 Dec 2025 13:56:15 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--kghzbkl6EAU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: davidben, flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1289?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1289?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">In do_init_cryp=
to_tls we do </p><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">    to.ssl_ctx =3D c-&gt;c1.ks.ssl_ctx;</pre=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">which copies the context and also the stack</p></li></ul></li></ul><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1289?usp=3Dema=
il">change 1289</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1289?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I31ac2a763209114267c35c4a918=
2a12d8d82f6fe </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1289 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: davidben &lt;davidben@...410...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: davidben &lt;davidben@...2975...=
...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 10 Dec 2025 13:56:15=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>=

--kghzbkl6EAU=--


From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Wed, 26 Nov 2025 21:12:33 +0000
In-Reply-To: <gerrit.1764165538000.I80aed8a91259374d4b2b2155a8f47e286f2def75@...2715...>
References: <gerrit.1764165538000.I80aed8a91259374d4b2b2155a8f47e286f2def75@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <525e47ffc7adbe31623fbb186cdc92ab6322fe0d-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6JWPNHz3E0k="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Properly log
 peer-id in P2P mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6JWPNHz3E0k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

its_Giaan has posted comments on this change by its_Giaan. ( http://gerrit.=
openvpn.net/c/openvpn/+/1406?usp=3Demail )

Change subject: Properly log peer-id in P2P mode
......................................................................


Patch Set 1:

(1 comment)

File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/1406/comment/1cdc608c_a8b77cad?usp=3D=
email :
PS1, Line 2544:     c->options.peer_id =3D c->c2.tls_multi->peer_id;
> I feel this the wrong fix. [=E2=80=A6]
Yeah I strongly agree, and we indeed look for options->peer_id in tls_print=
_deferred_options_results() in fact in the asym-peer-id patch I've arbitrar=
y switched to tls_multi->peer_id, so if we're fine with that I will do the =
same, but as you can see the tls_print_deferred_options_results() talks abo=
ut options so not sure.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1406?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I80aed8a91259374d4b2b2155a8f47e286f2def75
Gerrit-Change-Number: 1406
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Wed, 26 Nov 2025 21:12:33 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>

--6JWPNHz3E0k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1406?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init.c:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1406/comment/1cdc608c_a8b77cad?usp=3Demail">Patch Set #1, Li=
ne 2544:</a> <code style=3D"font-family:monospace,monospace">    c-&gt;opti=
ons.peer_id =3D c-&gt;c2.tls_multi-&gt;peer_id;</code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I fee=
l this the wrong fix. [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Yeah I strongly agree, a=
nd we indeed look for options-&gt;peer_id in tls_print_deferred_options_res=
ults() in fact in the asym-peer-id patch I&#39;ve arbitrary switched to tls=
_multi-&gt;peer_id, so if we&#39;re fine with that I will do the same, but =
as you can see the tls_print_deferred_options_results() talks about options=
 so not sure.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1406?usp=3Demail">change 1406</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1406?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I80aed8a91259374d4b2b2155a8f=
47e286f2def75 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1406 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 26 Nov 2025 21:12:33=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>

</body></html>=

--6JWPNHz3E0k=--


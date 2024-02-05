From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 5 Feb 2024 12:35:28 +0000
In-Reply-To: <gerrit.1705939439000.Ifa5ae96165d17b3cae4afc53e844bb34d1610e58@...2715...>
References: <gerrit.1705939439000.Ifa5ae96165d17b3cae4afc53e844bb34d1610e58@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <0b3e1a466bc937ec20d11d96443419801b7f8bf3-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="y6QkRNCSF3o="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add unit test for
 encrypting/decrypting data channel
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

--y6QkRNCSF3o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/505?usp=3Demail )

Change subject: Add unit test for encrypting/decrypting data channel
......................................................................


Patch Set 3: Code-Review+2

(2 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/505/comment/cdd6570d_b4598d99 :
PS3, Line 13: Change-Id: Ifa5ae96165d17b3cae4afc53e844bb34d1610e58
Missing sign-off


File tests/unit_tests/openvpn/test_ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/505/comment/197b238b_17f15314 :
PS3, Line 133:         size_t impl_iv_len =3D cipher_ctx_iv_length(cipher) =
- sizeof(packet_id_type);
can make this "const"



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/505?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifa5ae96165d17b3cae4afc53e844bb34d1610e58
Gerrit-Change-Number: 505
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Mon, 05 Feb 2024 12:35:28 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--y6QkRNCSF3o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/505?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/505/comment/cdd6570d_b4598d99">Patch Set #3, Line 13:</a> <code s=
tyle=3D"font-family:monospace,monospace">Change-Id: Ifa5ae96165d17b3cae4afc=
53e844bb34d1610e58</code></p><p style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Missing sign-off</p></li></ul></li><li style=3D"margin: 0; pad=
ding: 0;"><p>File tests/unit_tests/openvpn/test_ssl.c:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/505/comment/197b238b_17f15314">Patch Set #3, Line 133:</a> <code style=
=3D"font-family:monospace,monospace">        size_t impl_iv_len =3D cipher_=
ctx_iv_length(cipher) - sizeof(packet_id_type);</code></p><p style=3D"white=
-space: pre-wrap; word-wrap: break-word;">can make this &quot;const&quot;</=
p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/505?usp=3Demail">change 505</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">=
settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/505=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifa5ae96165d17b3cae4afc53e84=
4bb34d1610e58 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 505 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 05 Feb 2024 12:35:28=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--y6QkRNCSF3o=--


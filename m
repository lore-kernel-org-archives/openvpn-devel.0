From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 29 Nov 2024 16:59:26 +0000
In-Reply-To: <gerrit.1731290343000.I4a981c5a70717e2276d89bf83a06c7fdbe6712d7@...2715...>
References: <gerrit.1731290343000.I4a981c5a70717e2276d89bf83a06c7fdbe6712d7@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <fb5dda5acec2bcecb152d621c4b510618f7f281b-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RBzvBzwG0Z8="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change API of
 init_key_ctx to use struct key_paramters
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

--RBzvBzwG0Z8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/801?usp=3Demail )

Change subject: Change API of init_key_ctx to use struct key_paramters
......................................................................


Patch Set 5: Code-Review-2

(5 comments)

File src/openvpn/crypto.h:

http://gerrit.openvpn.net/c/openvpn/+/801/comment/5982a4b7_c94afe48 :
PS5, Line 158: /** internal structure similar to struct key that hold key i=
nformation
"holds"


File src/openvpn/crypto.c:

http://gerrit.openvpn.net/c/openvpn/+/801/comment/c483a455_001f6aab :
PS5, Line 902: ,
Needs update


http://gerrit.openvpn.net/c/openvpn/+/801/comment/59b2558f_a402ae56 :
PS5, Line 915: impl_iv_len
Change to `ASSERT(impl_iv_len <=3D key->hmac_size);` to keep consistency


http://gerrit.openvpn.net/c/openvpn/+/801/comment/9992be96_25c470fb :
PS5, Line 1128:     key_params->cipher_size =3D MAX_HMAC_KEY_LENGTH;
`MAX_CIPHER_KEY_LENGTH`


http://gerrit.openvpn.net/c/openvpn/+/801/comment/b7fb9ae2_fc643aa9 :
PS5, Line 1129: MAX_CIPHER_KEY_LENGTH
`MAX_HMAC_KEY_LENGTH`



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/801?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4a981c5a70717e2276d89bf83a06c7fdbe6712d7
Gerrit-Change-Number: 801
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Fri, 29 Nov 2024 16:59:26 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--RBzvBzwG0Z8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 5:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/801?usp=3Demail">Vi=
ew Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto.h:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/801/comment/5982a4b7_c94afe48">Patch Set #5, Line 158:=
</a> <code style=3D"font-family:monospace,monospace">/** internal structure=
 similar to struct key that hold key information</code></p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">&quot;holds&quot;</p></li></ul><=
/li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto.c:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/801/comment/c483a455_001f6aab">Patch Set #5, Line 902:=
</a> <code style=3D"font-family:monospace,monospace">,</code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Needs update</p></li><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/801/comment/59b2558f_a402=
ae56">Patch Set #5, Line 915:</a> <code style=3D"font-family:monospace,mono=
space">impl_iv_len</code></p><p style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Change to `ASSERT(impl_iv_len &lt;=3D key-&gt;hmac_size);` to =
keep consistency</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/801/comment/9992be96_25c470fb">Patch Set #5, Line 1128:</a> <code style=
=3D"font-family:monospace,monospace">    key_params-&gt;cipher_size =3D MAX=
_HMAC_KEY_LENGTH;</code></p><p style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">`MAX_CIPHER_KEY_LENGTH`</p></li><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/801/comment/b7fb9ae2_fc643aa9">Patch Set #5, Line 112=
9:</a> <code style=3D"font-family:monospace,monospace">MAX_CIPHER_KEY_LENGT=
H</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">`MAX=
_HMAC_KEY_LENGTH`</p></li></ul></li></ul><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/801?usp=3Demail">change 801</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/801?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4a981c5a70717e2276d89bf83a0=
6c7fdbe6712d7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 801 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 29 Nov 2024 16:59:26=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--RBzvBzwG0Z8=--


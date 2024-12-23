From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 23 Dec 2024 11:39:32 +0000
In-Reply-To: <gerrit.1731290343000.I4a981c5a70717e2276d89bf83a06c7fdbe6712d7@...2715...>
References: <gerrit.1731290343000.I4a981c5a70717e2276d89bf83a06c7fdbe6712d7@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <67ea97028ce8305c475b6d85e7d9d57a142f7e50-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0yT3XXAHv8w="; charset=UTF-8
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

--0yT3XXAHv8w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/801?usp=3Demail )

Change subject: Change API of init_key_ctx to use struct key_paramters
......................................................................


Patch Set 8: Code-Review-1

(7 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/801/comment/d5dc012d_2cbbcd2a :
PS8, Line 7: Change API of init_key_ctx to use struct key_paramters
key_parameters


http://gerrit.openvpn.net/c/openvpn/+/801/comment/4aa5e0d0_d728fca3 :
PS8, Line 9: This introduces a new structure key_paramters. The reason is t=
hat the
key_parameters


Patchset:

PS8:
Typos and nitpicks


File src/openvpn/crypto.h:

http://gerrit.openvpn.net/c/openvpn/+/801/comment/475bd1eb_01333a7a :
PS8, Line 176:  * Converts a struct key representation into a struct key_pa=
rams representation.
key_parameters


File tests/unit_tests/openvpn/test_auth_token.c:

http://gerrit.openvpn.net/c/openvpn/+/801/comment/aaed804b_181e091c :
PS8, Line 91:     key.hmac_size =3D 64;     /* 64 byte of 0 */
Use `MAX_HMAC_KEY_LENGTH` instead?


File tests/unit_tests/openvpn/test_tls_crypt.c:

http://gerrit.openvpn.net/c/openvpn/+/801/comment/491ee4f7_038e96a7 :
PS8, Line 160:     struct key_parameters key =3D { .cipher =3D { 0 }, .hmac=
 =3D { 0 }, .hmac_size =3D 64, .cipher_size =3D 64 };
Use `MAX_HMAC_KEY_LENGTH` and `MAX_CIPHER_KEY_LENGTH` instead?


http://gerrit.openvpn.net/c/openvpn/+/801/comment/09708593_0ee44299 :
PS8, Line 370:     struct key_parameters key =3D { .cipher =3D { 1 }, .hmac=
 =3D { 1 }, .cipher_size =3D 64, .hmac_size =3D 64 };
Use `MAX_HMAC_KEY_LENGTH` and `MAX_CIPHER_KEY_LENGTH` instead?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/801?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4a981c5a70717e2276d89bf83a06c7fdbe6712d7
Gerrit-Change-Number: 801
Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Mon, 23 Dec 2024 11:39:32 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--0yT3XXAHv8w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 8:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/801?usp=3Demail">Vi=
ew Change</a></p><p>7 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/801/comment/d5dc012d_2cbbcd2a">Patch Set #8, Line 7:</a> <code st=
yle=3D"font-family:monospace,monospace">Change API of init_key_ctx to use s=
truct key_paramters</code></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">key_parameters</p></li><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/801/comment/4aa5e0d0_d728fca3">Patch Set #8, Line 9:</a> <co=
de style=3D"font-family:monospace,monospace">This introduces a new structur=
e key_paramters. The reason is that the</code></p><p style=3D"white-space: =
pre-wrap; word-wrap: break-word;">key_parameters</p></li></ul></li><li styl=
e=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none;=
 padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/801?tab=
=3Dcomments">Patch Set #8:</a> </p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Typos and nitpicks</p></li></ul></li><li style=3D"margin=
: 0; padding: 0;"><p>File src/openvpn/crypto.h:</p><ul style=3D"list-style:=
 none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/8=
01/comment/475bd1eb_01333a7a">Patch Set #8, Line 176:</a> <code style=3D"fo=
nt-family:monospace,monospace"> * Converts a struct key representation into=
 a struct key_params representation.</code></p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">key_parameters</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_auth_toke=
n.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/801/comment/aaed804b_181e091c">Patch Set #8, =
Line 91:</a> <code style=3D"font-family:monospace,monospace">    key.hmac_s=
ize =3D 64;     /* 64 byte of 0 */</code></p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Use `MAX_HMAC_KEY_LENGTH` instead?</p></li></u=
l></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvp=
n/test_tls_crypt.c:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/801/comment/491ee4f7_038e96a7"=
>Patch Set #8, Line 160:</a> <code style=3D"font-family:monospace,monospace=
">    struct key_parameters key =3D { .cipher =3D { 0 }, .hmac =3D { 0 }, .=
hmac_size =3D 64, .cipher_size =3D 64 };</code></p><p style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Use `MAX_HMAC_KEY_LENGTH` and `MAX_CIPHE=
R_KEY_LENGTH` instead?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/801/comment/09708593_0ee44299">Patch Set #8, Line 370:</a> <code s=
tyle=3D"font-family:monospace,monospace">    struct key_parameters key =3D =
{ .cipher =3D { 1 }, .hmac =3D { 1 }, .cipher_size =3D 64, .hmac_size =3D 6=
4 };</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">U=
se `MAX_HMAC_KEY_LENGTH` and `MAX_CIPHER_KEY_LENGTH` instead?</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/801?usp=3Demail">change 801</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/801?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4a981c5a70717e2276d89bf83a0=
6c7fdbe6712d7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 801 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 23 Dec 2024 11:39:32=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--0yT3XXAHv8w=--


From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 27 Dec 2024 11:02:22 +0000
In-Reply-To: <gerrit.1731290343000.I4a981c5a70717e2276d89bf83a06c7fdbe6712d7@...2715...>
References: <gerrit.1731290343000.I4a981c5a70717e2276d89bf83a06c7fdbe6712d7@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e353ad67d971d73be2ed340ccd3af5aea2091115-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wEiWOeO8esc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change API of
 init_key_ctx to use struct key_parameters
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

--wEiWOeO8esc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/801?usp=3Demail )

Change subject: Change API of init_key_ctx to use struct key_parameters
......................................................................


Patch Set 9: Code-Review+2

(6 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/801/comment/b730dde1_23369276 :
PS8, Line 7: Change API of init_key_ctx to use struct key_paramters
> key_parameters
Done


http://gerrit.openvpn.net/c/openvpn/+/801/comment/38a47023_5a01c0b0 :
PS8, Line 9: This introduces a new structure key_paramters. The reason is t=
hat the
> key_parameters
Done


File src/openvpn/crypto.h:

http://gerrit.openvpn.net/c/openvpn/+/801/comment/a8cbf2dd_988a8316 :
PS8, Line 176:  * Converts a struct key representation into a struct key_pa=
rams representation.
> key_parameters
Done


File tests/unit_tests/openvpn/test_auth_token.c:

http://gerrit.openvpn.net/c/openvpn/+/801/comment/a13bc939_51cc0c94 :
PS8, Line 91:     key.hmac_size =3D 64;     /* 64 byte of 0 */
> Use `MAX_HMAC_KEY_LENGTH` instead?
Done


File tests/unit_tests/openvpn/test_tls_crypt.c:

http://gerrit.openvpn.net/c/openvpn/+/801/comment/0f742488_2a2784c8 :
PS8, Line 160:     struct key_parameters key =3D { .cipher =3D { 0 }, .hmac=
 =3D { 0 }, .hmac_size =3D 64, .cipher_size =3D 64 };
> Use `MAX_HMAC_KEY_LENGTH` and `MAX_CIPHER_KEY_LENGTH` instead?
Done


http://gerrit.openvpn.net/c/openvpn/+/801/comment/a43379bc_85313073 :
PS8, Line 370:     struct key_parameters key =3D { .cipher =3D { 1 }, .hmac=
 =3D { 1 }, .cipher_size =3D 64, .hmac_size =3D 64 };
> Use `MAX_HMAC_KEY_LENGTH` and `MAX_CIPHER_KEY_LENGTH` instead?
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/801?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4a981c5a70717e2276d89bf83a06c7fdbe6712d7
Gerrit-Change-Number: 801
Gerrit-PatchSet: 9
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Fri, 27 Dec 2024 11:02:22 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--wEiWOeO8esc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 9:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/801?usp=3Demail">Vi=
ew Change</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/801/comment/b730dde1_23369276">Patch Set #8, Line 7:</a> <code st=
yle=3D"font-family:monospace,monospace">Change API of init_key_ctx to use s=
truct key_paramters</code></p><p><blockquote style=3D"border-left: 1px soli=
d #aaa; margin: 10px 0; padding: 0 10px;">key_parameters</blockquote></p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/801/comment/38a47023_5a01c0=
b0">Patch Set #8, Line 9:</a> <code style=3D"font-family:monospace,monospac=
e">This introduces a new structure key_paramters. The reason is that the</c=
ode></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;">key_parameters</blockquote></p><p style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/crypto.h:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
801/comment/a8cbf2dd_988a8316">Patch Set #8, Line 176:</a> <code style=3D"f=
ont-family:monospace,monospace"> * Converts a struct key representation int=
o a struct key_params representation.</code></p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">key_parameters<=
/blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/u=
nit_tests/openvpn/test_auth_token.c:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/801/comment/a=
13bc939_51cc0c94">Patch Set #8, Line 91:</a> <code style=3D"font-family:mon=
ospace,monospace">    key.hmac_size =3D 64;     /* 64 byte of 0 */</code></=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;">Use `MAX_HMAC_KEY_LENGTH` instead?</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><=
li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_t=
ls_crypt.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/801/comment/0f742488_2a2784c8">Patch S=
et #8, Line 160:</a> <code style=3D"font-family:monospace,monospace">    st=
ruct key_parameters key =3D { .cipher =3D { 0 }, .hmac =3D { 0 }, .hmac_siz=
e =3D 64, .cipher_size =3D 64 };</code></p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Use `MAX_HMAC_KEY_LE=
NGTH` and `MAX_CIPHER_KEY_LENGTH` instead?</blockquote></p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/801/comment/a43379bc_85313073">Patch Set =
#8, Line 370:</a> <code style=3D"font-family:monospace,monospace">    struc=
t key_parameters key =3D { .cipher =3D { 1 }, .hmac =3D { 1 }, .cipher_size=
 =3D 64, .hmac_size =3D 64 };</code></p><p><blockquote style=3D"border-left=
: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Use `MAX_HMAC_KEY_LENGT=
H` and `MAX_CIPHER_KEY_LENGTH` instead?</blockquote></p><p style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/801?usp=3Demail=
">change 801</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsco=
pe itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/801?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4a981c5a70717e2276d89bf83a0=
6c7fdbe6712d7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 801 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 27 Dec 2024 11:02:22=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--wEiWOeO8esc=--


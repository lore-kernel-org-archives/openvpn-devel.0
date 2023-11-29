From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 29 Nov 2023 12:15:50 +0000
In-Reply-To: <gerrit.1700595358000.Ic74195a4ed340547c5e862dc2438f95be318c286@...2715...>
References: <gerrit.1700595358000.Ic74195a4ed340547c5e862dc2438f95be318c286@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <67629304985354bcf3eb1fc3d29c37af0bdae69b-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="r3Sk5AoEmJg="; charset=UTF-8
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
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--r3Sk5AoEmJg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/457?usp=3Demail )

Change subject: Implement generating TLS 1.0 PRF using new OpenSSL 3.0 APIs
......................................................................


Patch Set 5:

(3 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/457/comment/ae29b807_47365dcf :
PS5, Line 13: using OpenSSL 3.0, it gives the same error as with the older =
API but
> missing "in FIPS mode"? My understanding is that this still works with "n=
ormal" OpenSSL 3?
Done


Patchset:

PS5:
> I have my doubts whether this change is worth it if it doesn't actually f=
ixes anything? [=E2=80=A6]
One advantage is that we at least are now compatible with compiling against=
 an OpenSSL that has been compiled with OPENSSL_NO_MD5. Otherwise we fail a=
t the EVP_md5_sha1 function call.


File src/openvpn/crypto_openssl.c:

http://gerrit.openvpn.net/c/openvpn/+/457/comment/fd9542a8_f818ca77 :
PS5, Line 1404:                                                   secret, (=
size_t) secret_len);
> ../../../src/openvpn/crypto_openssl. [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/457?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic74195a4ed340547c5e862dc2438f95be318c286
Gerrit-Change-Number: 457
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 29 Nov 2023 12:15:50 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--r3Sk5AoEmJg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/457?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/457/comment/ae29b807_47365dcf">Patch Set #5, Line 13:</a> <code style=
=3D"font-family:monospace,monospace">using OpenSSL 3.0, it gives the same e=
rror as with the older API but</code></p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">missing &quot;in FIPS =
mode&quot;? My understanding is that this still works with &quot;normal&quo=
t; OpenSSL 3?</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><=
p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/457?tab=3Dcomments">Patch Set #5:</a> =
</p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pa=
dding: 0 10px;">I have my doubts whether this change is worth it if it does=
n&#39;t actually fixes anything? [=E2=80=A6]</blockquote></p><p style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">One advantage is that we at le=
ast are now compatible with compiling against an OpenSSL that has been comp=
iled with OPENSSL_NO_MD5. Otherwise we fail at the EVP_md5_sha1 function ca=
ll.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/open=
vpn/crypto_openssl.c:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/457/comment/fd9542a8_f818ca7=
7">Patch Set #5, Line 1404:</a> <code style=3D"font-family:monospace,monosp=
ace">                                                  secret, (size_t) sec=
ret_len);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;">../../../src/openvpn/crypto_openssl. [=E2=
=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/457?usp=3Demail">change 457</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/457?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic74195a4ed340547c5e862dc243=
8f95be318c286 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 457 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 29 Nov 2023 12:15:50=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--r3Sk5AoEmJg=--


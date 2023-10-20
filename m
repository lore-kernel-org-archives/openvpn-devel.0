From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 20 Oct 2023 15:01:24 +0000
In-Reply-To: <gerrit.1697562354000.I445a93e84dc54b865b757038d22318ac427fce96@...2715...>
References: <gerrit.1697562354000.I445a93e84dc54b865b757038d22318ac427fce96@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, max@...2606...
Message-ID: <7676efd3a3f93ac09f484400114f8c72c3cd360b-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sOv4qT8JkIU="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add support for
 mbedtls 3.X.Y
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: MaxF <max@...2606...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--sOv4qT8JkIU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/370?usp=3Demail )

Change subject: Add support for mbedtls 3.X.Y
......................................................................


Patch Set 6:

(3 comments)

Patchset:

PS6:
Still some potential issues, but mostly good


File src/openvpn/crypto_mbedtls.c:

http://gerrit.openvpn.net/c/openvpn/+/370/comment/70a97fed_b5c81c6d :
PS6, Line 576:     size_t key_len =3D mbedtls_cipher_info_get_key_bitlen(kt=
)/8;
Hmm, you are aware that all usages in the function actually multiply the va=
lue by 8 again?


File src/openvpn/ssl_mbedtls.c:

http://gerrit.openvpn.net/c/openvpn/+/370/comment/31a92c09_578a756e :
PS6, Line 53: #include <mbedtls/net_sockets.h>
Since you reverted the change that required > 2.16, you need to revert this=
 change as well, right?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/370?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I445a93e84dc54b865b757038d22318ac427fce96
Gerrit-Change-Number: 370
Gerrit-PatchSet: 6
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Fri, 20 Oct 2023 15:01:24 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--sOv4qT8JkIU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: MaxF, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/370?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
370?tab=3Dcomments">Patch Set #6:</a> </p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Still some potential issues, but mostly good</p><=
/li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/cryp=
to_mbedtls.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/370/comment/70a97fed_b5c81c6d">Patch=
 Set #6, Line 576:</a> <code style=3D"font-family:monospace,monospace">    =
size_t key_len =3D mbedtls_cipher_info_get_key_bitlen(kt)/8;</code></p><p s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Hmm, you are aware t=
hat all usages in the function actually multiply the value by 8 again?</p><=
/li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_=
mbedtls.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/370/comment/31a92c09_578a756e">Patch Se=
t #6, Line 53:</a> <code style=3D"font-family:monospace,monospace">#include=
 &lt;mbedtls/net_sockets.h&gt;</code></p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Since you reverted the change that required &gt; 2=
.16, you need to revert this change as well, right?</p></li></ul></li></ul>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/370?usp=
=3Demail">change 370</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/370?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I445a93e84dc54b865b757038d22=
318ac427fce96 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 370 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 20 Oct 2023 15:01:24=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--sOv4qT8JkIU=--


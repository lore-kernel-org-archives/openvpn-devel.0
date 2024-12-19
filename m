From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 19 Dec 2024 18:05:32 +0000
In-Reply-To: <gerrit.1733833084000.Ia1c5209022d3ab4c0dac6438c41891c7d059f812@...2715...>
References: <gerrit.1733833084000.Ia1c5209022d3ab4c0dac6438c41891c7d059f812@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <0eb8aebb5097b3c0686a7ebd9ecf56fd06310762-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="D2QCeI2TIJE="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Allow DEFAULT in
 data-ciphers and report both expanded and user set o...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--D2QCeI2TIJE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/828?usp=3Demail )

Change subject: Allow DEFAULT in data-ciphers and report both expanded and =
user set option
......................................................................


Patch Set 1:

(5 comments)

File doc/man-sections/protocol-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/828/comment/51d7502e_31b1c083 :
PS1, Line 181:   Starting with OpenVPN 2.7 the special keyword DEFAULT can =
be used in the
> Probably makes sense to use ``DEFAULT`` here.
Done


File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/828/comment/d1714501_fb5ceee1 :
PS1, Line 1905:             "Server data-ciphers: '%s'%s, client supports c=
ipher '%s'",
> make consistent with the other case. Either '%s%s' or '%s'%s, but not bot=
h.
Done


File src/openvpn/ssl_ncp.h:

http://gerrit.openvpn.net/c/openvpn/+/828/comment/0e004a12_dc41d0f5 :
PS1, Line 174:  *  The returned string will be allocated in the passed \par=
am gc
> If you want to format a word as param use \p, \param is for documenting p=
arameters.
I will use \c since \c and \p are the same according to documentation and s=
eem to use \c rather than \p in OpenVPN 2.x


File src/openvpn/ssl_ncp.c:

http://gerrit.openvpn.net/c/openvpn/+/828/comment/711f6f13_504c6970 :
PS1, Line 537:  * Replaces the string DEFAULT with the string \param replac=
e. The
> \p
Done


File tests/unit_tests/openvpn/test_ncp.c:

http://gerrit.openvpn.net/c/openvpn/+/828/comment/b36dcfd7_095812e3 :
PS1, Line 356: test_ncp_expand(void **state)
> I would suggest to add a testcase here where ncp_cipher_conf contains DEF=
AULT but is not equal to DE [=E2=80=A6]
added



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/828?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia1c5209022d3ab4c0dac6438c41891c7d059f812
Gerrit-Change-Number: 828
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Thu, 19 Dec 2024 18:05:32 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--D2QCeI2TIJE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/828?usp=3Demail">View C=
hange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/protocol-opti=
ons.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/828/comment/51d7502e_31b1c083">Patch Set =
#1, Line 181:</a> <code style=3D"font-family:monospace,monospace">  Startin=
g with OpenVPN 2.7 the special keyword DEFAULT can be used in the</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">Probably makes sense to use ``DEFAULT`` here.</blockquote></p>=
<p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></u=
l></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi.c:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/828/comment/d1714501_fb5ceee1">Patch Set #1, Line 19=
05:</a> <code style=3D"font-family:monospace,monospace">            &quot;S=
erver data-ciphers: &#39;%s&#39;%s, client supports cipher &#39;%s&#39;&quo=
t;,</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: =
10px 0; padding: 0 10px;">make consistent with the other case. Either &#39;=
%s%s&#39; or &#39;%s&#39;%s, but not both.</blockquote></p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_ncp.h:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/828/comment/0e004a12_dc41d0f5">Patch Set #1, Line 174:</a> <code s=
tyle=3D"font-family:monospace,monospace"> *  The returned string will be al=
located in the passed \param gc</code></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">If you want to format=
 a word as param use \p, \param is for documenting parameters.</blockquote>=
</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">I will use \=
c since \c and \p are the same according to documentation and seem to use \=
c rather than \p in OpenVPN 2.x</p></li></ul></li><li style=3D"margin: 0; p=
adding: 0;"><p>File src/openvpn/ssl_ncp.c:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/828/com=
ment/711f6f13_504c6970">Patch Set #1, Line 537:</a> <code style=3D"font-fam=
ily:monospace,monospace"> * Replaces the string DEFAULT with the string \pa=
ram replace. The</code></p><p><blockquote style=3D"border-left: 1px solid #=
aaa; margin: 10px 0; padding: 0 10px;">\p</blockquote></p><p style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_ncp.c:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/828/comment/b36dcfd7_095812e3">Patch Set #1, Line 35=
6:</a> <code style=3D"font-family:monospace,monospace">test_ncp_expand(void=
 **state)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;">I would suggest to add a testcase here wher=
e ncp_cipher_conf contains DEFAULT but is not equal to DE [=E2=80=A6]</bloc=
kquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">added=
</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/828?usp=3Demail">change 828</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/8=
28?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia1c5209022d3ab4c0dac6438c41=
891c7d059f812 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 828 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 19 Dec 2024 18:05:32=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--D2QCeI2TIJE=--


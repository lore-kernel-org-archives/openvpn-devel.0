From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 10 Dec 2024 17:35:16 +0000
In-Reply-To: <gerrit.1733833084000.Ia1c5209022d3ab4c0dac6438c41891c7d059f812@...2715...>
References: <gerrit.1733833084000.Ia1c5209022d3ab4c0dac6438c41891c7d059f812@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <ffce36c87807a775beae7032ca1ccc058d8cf93e-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YbrOm9arLvc="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YbrOm9arLvc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/828?usp=3Demail )

Change subject: Allow DEFAULT in data-ciphers and report both expanded and =
user set option
......................................................................


Patch Set 1: Code-Review-1

(6 comments)

Patchset:

PS1:
Some nitpicks


File doc/man-sections/protocol-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/828/comment/5f75330f_045154c7 :
PS1, Line 181:   Starting with OpenVPN 2.7 the special keyword DEFAULT can =
be used in the
Probably makes sense to use ``DEFAULT`` here.


File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/828/comment/9501c1ac_eab351db :
PS1, Line 1905:             "Server data-ciphers: '%s'%s, client supports c=
ipher '%s'",
make consistent with the other case. Either '%s%s' or '%s'%s, but not both.


File src/openvpn/ssl_ncp.h:

http://gerrit.openvpn.net/c/openvpn/+/828/comment/1d04131f_fb1c7b2c :
PS1, Line 174:  *  The returned string will be allocated in the passed \par=
am gc
If you want to format a word as param use \p, \param is for documenting par=
ameters.


File src/openvpn/ssl_ncp.c:

http://gerrit.openvpn.net/c/openvpn/+/828/comment/c25085e2_a57ade0c :
PS1, Line 537:  * Replaces the string DEFAULT with the string \param replac=
e. The
\p


File tests/unit_tests/openvpn/test_ncp.c:

http://gerrit.openvpn.net/c/openvpn/+/828/comment/87f080cb_fef0e6b6 :
PS1, Line 356: test_ncp_expand(void **state)
I would suggest to add a testcase here where ncp_cipher_conf contains DEFAU=
LT but is not equal to DEFAULT.



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
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Tue, 10 Dec 2024 17:35:16 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--YbrOm9arLvc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/828?usp=3Demail">Vi=
ew Change</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/828?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Some nitpicks</p></li></ul></li><li style=3D"=
margin: 0; padding: 0;"><p>File doc/man-sections/protocol-options.rst:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/828/comment/5f75330f_045154c7">Patch Set #1, Line 181:=
</a> <code style=3D"font-family:monospace,monospace">  Starting with OpenVP=
N 2.7 the special keyword DEFAULT can be used in the</code></p><p style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Probably makes sense to use =
``DEFAULT`` here.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p=
>File src/openvpn/multi.c:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/828/comment/9501c1ac_ea=
b351db">Patch Set #1, Line 1905:</a> <code style=3D"font-family:monospace,m=
onospace">            &quot;Server data-ciphers: &#39;%s&#39;%s, client sup=
ports cipher &#39;%s&#39;&quot;,</code></p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">make consistent with the other case. Either &#39=
;%s%s&#39; or &#39;%s&#39;%s, but not both.</p></li></ul></li><li style=3D"=
margin: 0; padding: 0;"><p>File src/openvpn/ssl_ncp.h:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/828/comment/1d04131f_fb1c7b2c">Patch Set #1, Line 174:</a> <code style=
=3D"font-family:monospace,monospace"> *  The returned string will be alloca=
ted in the passed \param gc</code></p><p style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">If you want to format a word as param use \p, \param =
is for documenting parameters.</p></li></ul></li><li style=3D"margin: 0; pa=
dding: 0;"><p>File src/openvpn/ssl_ncp.c:</p><ul style=3D"list-style: none;=
 padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/828/comm=
ent/c25085e2_a57ade0c">Patch Set #1, Line 537:</a> <code style=3D"font-fami=
ly:monospace,monospace"> * Replaces the string DEFAULT with the string \par=
am replace. The</code></p><p style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">\p</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File=
 tests/unit_tests/openvpn/test_ncp.c:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/828/comment/=
87f080cb_fef0e6b6">Patch Set #1, Line 356:</a> <code style=3D"font-family:m=
onospace,monospace">test_ncp_expand(void **state)</code></p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">I would suggest to add a testca=
se here where ncp_cipher_conf contains DEFAULT but is not equal to DEFAULT.=
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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 10 Dec 2024 17:35:16=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--YbrOm9arLvc=--


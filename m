From: "MaxF (Code Review)" <gerrit@...515...>
Date: Wed, 29 Jan 2025 18:22:58 +0000
In-Reply-To: <gerrit.1737027245000.I15c7cfdddb06d4530d669b222a3c65db5169b29a@...2715...>
References: <gerrit.1737027245000.I15c7cfdddb06d4530d669b222a3c65db5169b29a@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <419bf9d5ded494a7ec8814bd34eadf3e65b61af3-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="atFw4MPmcz4="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Extend the unit test
 for data channel packets with aead limit tests
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--atFw4MPmcz4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

MaxF has posted comments on this change. ( http://gerrit.openvpn.net/c/open=
vpn/+/868?usp=3Demail )

Change subject: Extend the unit test for data channel packets with aead lim=
it tests
......................................................................


Patch Set 2:

(4 comments)

Patchset:

PS2:
Looks good!


File tests/unit_tests/openvpn/test_ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/868/comment/aaf1046f_c7682d5e :
PS2, Line 369:
Nitpick: Did you mean to put 2 blank lines here?


http://gerrit.openvpn.net/c/openvpn/+/868/comment/90415ab6_73c373e1 :
PS2, Line 403: \
Why a line continuation?


http://gerrit.openvpn.net/c/openvpn/+/868/comment/a772ba34_52699165 :
PS2, Line 432:    /* Ensure that we are still on the initial key (unit test=
 uses 4)
             :      * or that it is 0 when epoch is not in use */
             :     assert_int_equal(co->key_ctx_bi.encrypt.epoch, expected_=
epoch);
I was confused where the 4 comes from. I guess the previous test sets it th=
at way?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/868?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I15c7cfdddb06d4530d669b222a3c65db5169b29a
Gerrit-Change-Number: 868
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: MaxF <max@...2606...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 29 Jan 2025 18:22:58 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--atFw4MPmcz4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/868?usp=3Demail">View C=
hange</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
868?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Looks good!</p></li></ul></li><li style=3D"margin=
: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_ssl.c:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/868/comment/aaf1046f_c7682d5e">Patch Set #2, Line 369:</a> <co=
de style=3D"font-family:monospace,monospace"></code></p><p style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Nitpick: Did you mean to put 2 blan=
k lines here?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
868/comment/90415ab6_73c373e1">Patch Set #2, Line 403:</a> <code style=3D"f=
ont-family:monospace,monospace">\</code></p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Why a line continuation?</p></li><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/868/comment/a772ba34_52699165">Patch=
 Set #2, Line 432:</a> </p><p><blockquote style=3D"border-left: 1px solid #=
aaa; margin: 10px 0; padding: 0 10px;"><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">   /* Ensure that we are still on the i=
nitial key (unit test uses 4)<br>     * or that it is 0 when epoch is not i=
n use */<br>    assert_int_equal(co-&gt;key_ctx_bi.encrypt.epoch, expected_=
epoch);<br></pre></blockquote></p><p style=3D"white-space: pre-wrap; word-w=
rap: break-word;">I was confused where the 4 comes from. I guess the previo=
us test sets it that way?</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/868?usp=3Demail">change 868</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/868?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I15c7cfdddb06d4530d669b222a3=
c65db5169b29a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 868 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: MaxF &lt;max@...2606...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 29 Jan 2025 18:22:58=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--atFw4MPmcz4=--


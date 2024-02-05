From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 5 Feb 2024 13:43:11 +0000
In-Reply-To: <gerrit.1700478678000.I7511bc43cd6a0bcb89476f27d5822ab4a78d0d21@...2715...>
References: <gerrit.1700478678000.I7511bc43cd6a0bcb89476f27d5822ab4a78d0d21@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <682960e273c54f8b1026567b5f594b9ed64a9f09-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ye7ynpN4Qfw="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Turn dead list test
 code into unit test
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ye7ynpN4Qfw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/446?usp=3Demail )

Change subject: Turn dead list test code into unit test
......................................................................


Patch Set 4:

(3 comments)

File tests/unit_tests/openvpn/test_misc.c:

http://gerrit.openvpn.net/c/openvpn/+/446/comment/7dac6168_d24ef656 :
PS2, Line 203:                         ASSERT(hash_add(hash, w->word, w, fa=
lse));
> Should probably use the cmocka assert_true here?
Done


http://gerrit.openvpn.net/c/openvpn/+/446/comment/e8916ca3_ce20ce1e :
PS2, Line 261:         ASSERT(count =3D=3D hash_n_elements(hash));
> should use assert_int_equal
Done


http://gerrit.openvpn.net/c/openvpn/+/446/comment/1c366976_7d353c43 :
PS2, Line 268:             hash_remove_by_value(nhash, (void *) i);
> can we test that this was successful?
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/446?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7511bc43cd6a0bcb89476f27d5822ab4a78d0d21
Gerrit-Change-Number: 446
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 05 Feb 2024 13:43:11 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--ye7ynpN4Qfw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/446?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_=
misc.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/446/comment/7dac6168_d24ef656">Patch Set #=
2, Line 203:</a> <code style=3D"font-family:monospace,monospace">          =
              ASSERT(hash_add(hash, w-&gt;word, w, false));</code></p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">Should probably use the cmocka assert_true here?</blockquote></p><p =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/446/comment/e8916ca3_ce20ce1=
e">Patch Set #2, Line 261:</a> <code style=3D"font-family:monospace,monospa=
ce">        ASSERT(count =3D=3D hash_n_elements(hash));</code></p><p><block=
quote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px=
;">should use assert_int_equal</blockquote></p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/446/comment/1c366976_7d353c43">Patch Set #2, Line 268=
:</a> <code style=3D"font-family:monospace,monospace">            hash_remo=
ve_by_value(nhash, (void *) i);</code></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">can we test that this=
 was successful?</blockquote></p><p style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/446?usp=3Demail">change 446</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/446?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7511bc43cd6a0bcb89476f27d58=
22ab4a78d0d21 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 446 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 05 Feb 2024 13:43:11=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--ye7ynpN4Qfw=--


From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 11 Sep 2025 14:40:24 +0000
In-Reply-To: <gerrit.1757600733000.I73f8ad9bf105920f4bde357ea9dcf0e485f3f3cb@...2715...>
References: <gerrit.1757600733000.I73f8ad9bf105920f4bde357ea9dcf0e485f3f3cb@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <85e2b4e85618b8e94fb569d01f8270849850ae42-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DYF8T8QBY+M="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: push-update-server:
 comment about `buf_string_compare_advance()` usag...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mrbff <marco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DYF8T8QBY+M=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: mrbff, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/1177?usp=3Demail )

Change subject: push-update-server: comment about `buf_string_compare_advan=
ce()` usage in `send_single_push_updaate()`
......................................................................


Patch Set 1: Code-Review-1

(2 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/1177/comment/706858ca_c00b22de :
PS1, Line 7: push-update-server: comment about `buf_string_compare_advance(=
)` usage in `send_single_push_updaate()`
Typo "updaate"
Please remove useless quoting from commit message


File src/openvpn/push_util.c:

http://gerrit.openvpn.net/c/openvpn/+/1177/comment/c573bb74_31f8a270 :
PS1, Line 164:          * Using `buf_string_compare_advance()` we mimic the=
 behavio
Typo "behavio"



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1177?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I73f8ad9bf105920f4bde357ea9dcf0e485f3f3cb
Gerrit-Change-Number: 1177
Gerrit-PatchSet: 1
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-Comment-Date: Thu, 11 Sep 2025 14:40:24 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--DYF8T8QBY+M=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: mrbff, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1177?usp=3Demail">V=
iew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1177/comment/706858ca_c00b22de">Patch Set #1, Line 7:</a> <cod=
e style=3D"font-family:monospace,monospace">push-update-server: comment abo=
ut `buf_string_compare_advance()` usage in `send_single_push_updaate()`</co=
de></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Typo &quo=
t;updaate&quot;<br>Please remove useless quoting from commit message</p></l=
i></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/push_u=
til.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1177/comment/c573bb74_31f8a270">Patch Set #=
1, Line 164:</a> <code style=3D"font-family:monospace,monospace">         *=
 Using `buf_string_compare_advance()` we mimic the behavio</code></p><p sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Typo &quot;behavio&quo=
t;</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1177?usp=3Demail">change 1177</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1177?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I73f8ad9bf105920f4bde357ea9d=
cf0e485f3f3cb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1177 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 11 Sep 2025 14:40:24=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--DYF8T8QBY+M=--


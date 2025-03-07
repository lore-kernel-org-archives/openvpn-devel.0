From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 7 Mar 2025 10:37:11 +0000
In-Reply-To: <gerrit.1733989644000.Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10@...2715...>
References: <gerrit.1733989644000.Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <b9dae247e529a22ee0ff93ee51e9f060b65ea298-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZYqyua73YjQ="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dns: apply settings
 via script on unixoid systems
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZYqyua73YjQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/838?usp=3Demail )

Change subject: dns: apply settings via script on unixoid systems
......................................................................


Patch Set 12: Code-Review-1

(7 comments)

Patchset:

PS12:
Documentation still not quite right...


File doc/man-sections/script-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/838/comment/a70abe1d_54f8b426 :
PS12, Line 246: script
No, this doesn't work. rst is very specific here, only one argument is allo=
wed. Which is why we do the weird "args" "Valid syntaxes" dance for many op=
tions. I specifically only asked you to put the `| disable` in the usage te=
xt, not here.


http://gerrit.openvpn.net/c/openvpn/+/838/comment/44abd65b_de60dd5a :
PS12, Line 253: on
"in the order"


http://gerrit.openvpn.net/c/openvpn/+/838/comment/7490ff27_e8edc43e :
PS12, Line 258: option
`` `s `` does not work. `` `'s `` seems to work.


http://gerrit.openvpn.net/c/openvpn/+/838/comment/794ec9d2_6cd36626 :
PS12, Line 259: option
same


http://gerrit.openvpn.net/c/openvpn/+/838/comment/15d13f22_008f6f3d :
PS12, Line 261:   ``--up`` and ``--down`` hooks for backward compatibility.
I think it is "backward*s* compatibility"


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/838/comment/be2e97aa_62e6de9d :
PS12, Line 531:     "--dns-script cmd : Run cmd as user defined dns configu=
ration script\n"
Add the `|disable` here



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10
Gerrit-Change-Number: 838
Gerrit-PatchSet: 12
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Fri, 07 Mar 2025 10:37:11 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--ZYqyua73YjQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, plaisthos. </p>
<p>Patch set 12:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail">V=
iew Change</a></p><p>7 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/838?tab=3Dcomments">Patch Set #12:</a> </p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Documentation still not quite right...</p><=
/li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections=
/script-options.rst:</p><ul style=3D"list-style: none; padding: 0;"><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/838/comment/a70abe1d_54f8b426=
">Patch Set #12, Line 246:</a> <code style=3D"font-family:monospace,monospa=
ce">script</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">No, this doesn&#39;t work. rst is very specific here, only one argumen=
t is allowed. Which is why we do the weird &quot;args&quot; &quot;Valid syn=
taxes&quot; dance for many options. I specifically only asked you to put th=
e `| disable` in the usage text, not here.</p></li><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/838/comment/44abd65b_de60dd5a">Patch Set #12, =
Line 253:</a> <code style=3D"font-family:monospace,monospace">on</code></p>=
<p style=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;in the ord=
er&quot;</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/838/c=
omment/7490ff27_e8edc43e">Patch Set #12, Line 258:</a> <code style=3D"font-=
family:monospace,monospace">option</code></p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">`` `s `` does not work. `` `&#39;s `` seems to=
 work.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/838/com=
ment/794ec9d2_6cd36626">Patch Set #12, Line 259:</a> <code style=3D"font-fa=
mily:monospace,monospace">option</code></p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">same</p></li><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/838/comment/15d13f22_008f6f3d">Patch Set #12, Line 261:</=
a> <code style=3D"font-family:monospace,monospace">  ``--up`` and ``--down`=
` hooks for backward compatibility.</code></p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">I think it is &quot;backward*s* compatibility=
&quot;</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/o=
penvpn/options.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/838/comment/be2e97aa_62e6de9d">=
Patch Set #12, Line 531:</a> <code style=3D"font-family:monospace,monospace=
">    &quot;--dns-script cmd : Run cmd as user defined dns configuration sc=
ript\n&quot;</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Add the `|disable` here</p></li></ul></li></ul><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail">change 838</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/838?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifbe4ffb44d3bfcaa50adb38cacb=
3436fcdc71b10 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 838 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 07 Mar 2025 10:37:11=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--ZYqyua73YjQ=--


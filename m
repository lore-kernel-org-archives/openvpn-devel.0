From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 20 Jan 2025 12:36:50 +0000
In-Reply-To: <gerrit.1737375148000.Ia4095518d5e4447992a2974e0d7a159d79ba6b6f@...2715...>
References: <gerrit.1737375148000.Ia4095518d5e4447992a2974e0d7a159d79ba6b6f@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <7b05a8c9197fd25ffe4c9bfa92f16d96896fa301-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sT7JCysUvSk="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement
 override-user
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

--sT7JCysUvSk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/872?usp=3Demail )

Change subject: Implement override-user
......................................................................


Patch Set 1: Code-Review-1

(16 comments)

Patchset:

PS1:
Documentation review


File Changes.rst:

http://gerrit.openvpn.net/c/openvpn/+/872/comment/ccc7ee92_27cbfac3 :
PS1, Line 41:     client use certificates and multi-factor authentication.
"clients"


File doc/man-sections/server-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/872/comment/2cd1859d_57eca9b5 :
PS1, Line 673: --override-username
At the wrong place in the document alphabetically


http://gerrit.openvpn.net/c/openvpn/+/872/comment/b9a8d3a6_1619c847 :
PS1, Line 674:   Sets the username of a connection the specified username. =
 This username
"to the"


http://gerrit.openvpn.net/c/openvpn/+/872/comment/e61d54e2_2420a045 :
PS1, Line 675:   will also be used by the by ``--auth-gen-token``. However,=
 the overridden
Superfluous words "by the"?


http://gerrit.openvpn.net/c/openvpn/+/872/comment/4c901590_e34fb4e7 :
PS1, Line 677:   ``--client-config-dir`` and the ``--auth-user-pass-verify`=
` script have
This is confusing. Maybe: "after --client-config-dir has been read and the =
--client-connect and --auth-user-pass-verify scripts have been run."


http://gerrit.openvpn.net/c/openvpn/+/872/comment/a2d45f6f_d858b939 :
PS1, Line 680:   Also ``username-as-common-name`` will use the client provi=
ded username
--username-as-common-name for consistency


http://gerrit.openvpn.net/c/openvpn/+/872/comment/9a5ed281_33dadded :
PS1, Line 682:   ``--override-username`` option if  the option ``username-a=
s-common-name``
superfluous space


http://gerrit.openvpn.net/c/openvpn/+/872/comment/38f9af62_3921cd00 :
PS1, Line 686:   the the ``--auth-gen-token`` option. It will also be pushe=
d to the client
duplicated "the"


http://gerrit.openvpn.net/c/openvpn/+/872/comment/3b589338_48d21540 :
PS1, Line 687:   using ``--auth-token-user``.
We should add a cross-reference to documentation for --auth-token-user


File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/872/comment/4e08bcdb_c5d535f5 :
PS1, Line 2670:  * @param mi
Either document it or remove stub-comment.


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/872/comment/b78b8ba7_6bcff71d :
PS1, Line 7850:     else if (streq(p[0], "override-username") && p[1] && !p=
[2])
New option should be added to usage information.


http://gerrit.openvpn.net/c/openvpn/+/872/comment/5d357a53_801e96ab :
PS1, Line 7859:              * set another username might serious problems =
*/
missing word "cause"?


File src/openvpn/ssl_common.h:

http://gerrit.openvpn.net/c/openvpn/+/872/comment/77deffca_cb68f2dd :
PS1, Line 630:      * authentication */
"unless overridden by override-user"


http://gerrit.openvpn.net/c/openvpn/+/872/comment/8fe0507f_ef4f018d :
PS1, Line 633:     /** The username that client initial used before being o=
verrriden by
"initially"


http://gerrit.openvpn.net/c/openvpn/+/872/comment/47888316_35ac5086 :
PS1, Line 634:      * by override-user */
duplicated "by"



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/872?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia4095518d5e4447992a2974e0d7a159d79ba6b6f
Gerrit-Change-Number: 872
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Mon, 20 Jan 2025 12:36:50 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--sT7JCysUvSk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/872?usp=3Demail">Vi=
ew Change</a></p><p>16 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/872?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Documentation review</p></li></ul></li><li s=
tyle=3D"margin: 0; padding: 0;"><p>File Changes.rst:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/872/comment/ccc7ee92_27cbfac3">Patch Set #1, Line 41:</a> <code style=3D=
"font-family:monospace,monospace">    client use certificates and multi-fac=
tor authentication.</code></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">&quot;clients&quot;</p></li></ul></li><li style=3D"margin: 0;=
 padding: 0;"><p>File doc/man-sections/server-options.rst:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/872/comment/2cd1859d_57eca9b5">Patch Set #1, Line 673:</a> <code s=
tyle=3D"font-family:monospace,monospace">--override-username</code></p><p s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">At the wrong place i=
n the document alphabetically</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/872/comment/b9a8d3a6_1619c847">Patch Set #1, Line 674:</a> =
<code style=3D"font-family:monospace,monospace">  Sets the username of a co=
nnection the specified username.  This username</code></p><p style=3D"white=
-space: pre-wrap; word-wrap: break-word;">&quot;to the&quot;</p></li><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/872/comment/e61d54e2_2420a04=
5">Patch Set #1, Line 675:</a> <code style=3D"font-family:monospace,monospa=
ce">  will also be used by the by ``--auth-gen-token``. However, the overri=
dden</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">S=
uperfluous words &quot;by the&quot;?</p></li><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/872/comment/4c901590_e34fb4e7">Patch Set #1, Line 67=
7:</a> <code style=3D"font-family:monospace,monospace">  ``--client-config-=
dir`` and the ``--auth-user-pass-verify`` script have</code></p><p style=3D=
"white-space: pre-wrap; word-wrap: break-word;">This is confusing. Maybe: &=
quot;after --client-config-dir has been read and the --client-connect and -=
-auth-user-pass-verify scripts have been run.&quot;</p></li><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/872/comment/a2d45f6f_d858b939">Patch =
Set #1, Line 680:</a> <code style=3D"font-family:monospace,monospace">  Als=
o ``username-as-common-name`` will use the client provided username</code><=
/p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">--username-as=
-common-name for consistency</p></li><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/872/comment/9a5ed281_33dadded">Patch Set #1, Line 682:</a> <=
code style=3D"font-family:monospace,monospace">  ``--override-username`` op=
tion if  the option ``username-as-common-name``</code></p><p style=3D"white=
-space: pre-wrap; word-wrap: break-word;">superfluous space</p></li><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/872/comment/38f9af62_3921cd00=
">Patch Set #1, Line 686:</a> <code style=3D"font-family:monospace,monospac=
e">  the the ``--auth-gen-token`` option. It will also be pushed to the cli=
ent</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">du=
plicated &quot;the&quot;</p></li><li style=3D"margin: 0; padding: 0 0 0 16p=
x;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/872/comment/3b589338_48d21540">Patch Set #1, Line 687:</a> <code=
 style=3D"font-family:monospace,monospace">  using ``--auth-token-user``.</=
code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">We shou=
ld add a cross-reference to documentation for --auth-token-user</p></li></u=
l></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi.c:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/872/comment/4e08bcdb_c5d535f5">Patch Set #1, Line 26=
70:</a> <code style=3D"font-family:monospace,monospace"> * @param mi</code>=
</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Either docum=
ent it or remove stub-comment.</p></li></ul></li><li style=3D"margin: 0; pa=
dding: 0;"><p>File src/openvpn/options.c:</p><ul style=3D"list-style: none;=
 padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/872/comm=
ent/b78b8ba7_6bcff71d">Patch Set #1, Line 7850:</a> <code style=3D"font-fam=
ily:monospace,monospace">    else if (streq(p[0], &quot;override-username&q=
uot;) &amp;&amp; p[1] &amp;&amp; !p[2])</code></p><p style=3D"white-space: =
pre-wrap; word-wrap: break-word;">New option should be added to usage infor=
mation.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/872/co=
mment/5d357a53_801e96ab">Patch Set #1, Line 7859:</a> <code style=3D"font-f=
amily:monospace,monospace">             * set another username might seriou=
s problems */</code></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">missing word &quot;cause&quot;?</p></li></ul></li><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/ssl_common.h:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/872/comment/77deffca_cb68f2dd">Patch Set #1, Line 630:</a> <code style=
=3D"font-family:monospace,monospace">     * authentication */</code></p><p =
style=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;unless overri=
dden by override-user&quot;</p></li><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/872/comment/8fe0507f_ef4f018d">Patch Set #1, Line 633:</a> <c=
ode style=3D"font-family:monospace,monospace">    /** The username that cli=
ent initial used before being overrriden by</code></p><p style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">&quot;initially&quot;</p></li><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/872/comment/47888316_35ac5086=
">Patch Set #1, Line 634:</a> <code style=3D"font-family:monospace,monospac=
e">     * by override-user */</code></p><p style=3D"white-space: pre-wrap; =
word-wrap: break-word;">duplicated &quot;by&quot;</p></li></ul></li></ul><p=
>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/872?usp=3D=
email">change 872</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div it=
emscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/872?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia4095518d5e4447992a2974e0d7=
a159d79ba6b6f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 872 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 20 Jan 2025 12:36:50=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--sT7JCysUvSk=--


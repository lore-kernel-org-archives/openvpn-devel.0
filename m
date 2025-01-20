From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 20 Jan 2025 15:24:43 +0000
In-Reply-To: <gerrit.1737375148000.Ia4095518d5e4447992a2974e0d7a159d79ba6b6f@...2715...>
References: <gerrit.1737375148000.Ia4095518d5e4447992a2974e0d7a159d79ba6b6f@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <9c2bbab790dc49c74e6869919a937c4c17d081d8-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uK3tBb6w4nM="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement
 override-username
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

--uK3tBb6w4nM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/872?usp=3Demail )

Change subject: Implement override-username
......................................................................


Patch Set 2:

(16 comments)

File Changes.rst:

http://gerrit.openvpn.net/c/openvpn/+/872/comment/21228070_1f46d719 :
PS1, Line 41:     client use certificates and multi-factor authentication.
> "clients"
Done


File doc/man-sections/server-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/872/comment/06e9abaf_d78465ff :
PS1, Line 673: --override-username
> At the wrong place in the document alphabetically
Done


http://gerrit.openvpn.net/c/openvpn/+/872/comment/7c534346_cab10b4d :
PS1, Line 674:   Sets the username of a connection the specified username. =
 This username
> "to the"
Done


http://gerrit.openvpn.net/c/openvpn/+/872/comment/a75a4873_d2d04eb7 :
PS1, Line 675:   will also be used by the by ``--auth-gen-token``. However,=
 the overridden
> Superfluous words "by the"?
Done


http://gerrit.openvpn.net/c/openvpn/+/872/comment/4ad0be1f_637c94bf :
PS1, Line 677:   ``--client-config-dir`` and the ``--auth-user-pass-verify`=
` script have
> This is confusing. [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/872/comment/c9dae5be_bda55455 :
PS1, Line 680:   Also ``username-as-common-name`` will use the client provi=
ded username
> --username-as-common-name for consistency
Done


http://gerrit.openvpn.net/c/openvpn/+/872/comment/0affce0e_affb761d :
PS1, Line 682:   ``--override-username`` option if  the option ``username-a=
s-common-name``
> superfluous space
Done


http://gerrit.openvpn.net/c/openvpn/+/872/comment/ccb79877_4bb98f83 :
PS1, Line 686:   the the ``--auth-gen-token`` option. It will also be pushe=
d to the client
> duplicated "the"
Done


http://gerrit.openvpn.net/c/openvpn/+/872/comment/67d2ea38_226d164b :
PS1, Line 687:   using ``--auth-token-user``.
> We should add a cross-reference to documentation for --auth-token-user
Done


File doc/man-sections/server-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/872/comment/d9a3829a_99fd02a5 :
PS2, Line 427:   ``--override-username`` option if  the option ``--username=
-as-common-name``
Still superfluous space after "if"


File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/872/comment/cd8915c7_899bfa2a :
PS1, Line 2670:  * @param mi
> Either document it or remove stub-comment.
Done


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/872/comment/e20f62db_76f7ebd8 :
PS1, Line 7850:     else if (streq(p[0], "override-username") && p[1] && !p=
[2])
> New option should be added to usage information.
Done


http://gerrit.openvpn.net/c/openvpn/+/872/comment/2240b114_582b0419 :
PS1, Line 7859:              * set another username might serious problems =
*/
> missing word "cause"?
Done


File src/openvpn/ssl_common.h:

http://gerrit.openvpn.net/c/openvpn/+/872/comment/c09f832b_cfa6e127 :
PS1, Line 630:      * authentication */
> "unless overridden by override-user"
Done


http://gerrit.openvpn.net/c/openvpn/+/872/comment/f35c8085_0b38db04 :
PS1, Line 633:     /** The username that client initial used before being o=
verrriden by
> "initially"
Done


http://gerrit.openvpn.net/c/openvpn/+/872/comment/56ae7bc5_5d6fe748 :
PS1, Line 634:      * by override-user */
> duplicated "by"
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/872?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia4095518d5e4447992a2974e0d7a159d79ba6b6f
Gerrit-Change-Number: 872
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Mon, 20 Jan 2025 15:24:43 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--uK3tBb6w4nM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/872?usp=3Demail">View C=
hange</a></p><p>16 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File Changes.rst:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/872/comment/21228070_1f46d719">Patch Set #1, Line 41:</a> <code st=
yle=3D"font-family:monospace,monospace">    client use certificates and mul=
ti-factor authentication.</code></p><p><blockquote style=3D"border-left: 1p=
x solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;clients&quot;</blockq=
uote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sectio=
ns/server-options.rst:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/872/comment/06e9abaf_d78465=
ff">Patch Set #1, Line 673:</a> <code style=3D"font-family:monospace,monosp=
ace">--override-username</code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">At the wrong place in the do=
cument alphabetically</blockquote></p><p style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/872/comment/7c534346_cab10b4d">Patch Set #1, Line 674:</a> <co=
de style=3D"font-family:monospace,monospace">  Sets the username of a conne=
ction the specified username.  This username</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;to=
 the&quot;</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/872/comment/a75a4873_d2d04eb7">Patch Set #1, Line 675:</a> <code style=3D=
"font-family:monospace,monospace">  will also be used by the by ``--auth-ge=
n-token``. However, the overridden</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Superfluous words =
&quot;by the&quot;?</blockquote></p><p style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16p=
x;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/872/comment/4ad0be1f_637c94bf">Patch Set #1, Line 677:</a> <code=
 style=3D"font-family:monospace,monospace">  ``--client-config-dir`` and th=
e ``--auth-user-pass-verify`` script have</code></p><p><blockquote style=3D=
"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This is con=
fusing. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16p=
x;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/872/comment/c9dae5be_bda55455">Patch Set #1, Line 680:</a> <code=
 style=3D"font-family:monospace,monospace">  Also ``username-as-common-name=
`` will use the client provided username</code></p><p><blockquote style=3D"=
border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">--username-a=
s-common-name for consistency</blockquote></p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/872/comment/0affce0e_affb761d">Patch Set #1, Line 682:=
</a> <code style=3D"font-family:monospace,monospace">  ``--override-usernam=
e`` option if  the option ``username-as-common-name``</code></p><p><blockqu=
ote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
>superfluous space</blockquote></p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/872/comment/ccb79877_4bb98f83">Patch Set #1, Line 686:</a> <code =
style=3D"font-family:monospace,monospace">  the the ``--auth-gen-token`` op=
tion. It will also be pushed to the client</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">duplicat=
ed &quot;the&quot;</blockquote></p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/872/comment/67d2ea38_226d164b">Patch Set #1, Line 687:</a> <code =
style=3D"font-family:monospace,monospace">  using ``--auth-token-user``.</c=
ode></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;">We should add a cross-reference to documentation for --=
auth-token-user</blockquote></p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"=
><p>File doc/man-sections/server-options.rst:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/872/=
comment/d9a3829a_99fd02a5">Patch Set #2, Line 427:</a> <code style=3D"font-=
family:monospace,monospace">  ``--override-username`` option if  the option=
 ``--username-as-common-name``</code></p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Still superfluous space after &quot;if&quot;</p></=
li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi=
.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/872/comment/cd8915c7_899bfa2a">Patch Set #1, L=
ine 2670:</a> <code style=3D"font-family:monospace,monospace"> * @param mi<=
/code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px=
 0; padding: 0 10px;">Either document it or remove stub-comment.</blockquot=
e></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></=
li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/optio=
ns.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/872/comment/e20f62db_76f7ebd8">Patch Set #1,=
 Line 7850:</a> <code style=3D"font-family:monospace,monospace">    else if=
 (streq(p[0], &quot;override-username&quot;) &amp;&amp; p[1] &amp;&amp; !p[=
2])</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: =
10px 0; padding: 0 10px;">New option should be added to usage information.<=
/blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/872/comme=
nt/2240b114_582b0419">Patch Set #1, Line 7859:</a> <code style=3D"font-fami=
ly:monospace,monospace">             * set another username might serious p=
roblems */</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; m=
argin: 10px 0; padding: 0 10px;">missing word &quot;cause&quot;?</blockquot=
e></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></=
li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_c=
ommon.h:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/872/comment/c09f832b_cfa6e127">Patch Set =
#1, Line 630:</a> <code style=3D"font-family:monospace,monospace">     * au=
thentication */</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">&quot;unless overridden by override-u=
ser&quot;</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/872/comment/f35c8085_0b38db04">Patch Set #1, Line 633:</a> <code style=3D"=
font-family:monospace,monospace">    /** The username that client initial u=
sed before being overrriden by</code></p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;initially&quot;<=
/blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/872/comme=
nt/56ae7bc5_5d6fe748">Patch Set #1, Line 634:</a> <code style=3D"font-famil=
y:monospace,monospace">     * by override-user */</code></p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">dup=
licated &quot;by&quot;</blockquote></p><p style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/872?usp=3Demail">change 872</a>.=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/872?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia4095518d5e4447992a2974e0d7=
a159d79ba6b6f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 872 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 20 Jan 2025 15:24:43=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--uK3tBb6w4nM=--


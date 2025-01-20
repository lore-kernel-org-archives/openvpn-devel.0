From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 20 Jan 2025 15:29:00 +0000
In-Reply-To: <gerrit.1737375148000.Ia4095518d5e4447992a2974e0d7a159d79ba6b6f@...2715...>
References: <gerrit.1737375148000.Ia4095518d5e4447992a2974e0d7a159d79ba6b6f@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <148d42b1459eb90c2b746bc99c4414ec5a2e92c5-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="t22OOaODwZk="; charset=UTF-8
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
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--t22OOaODwZk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/872?usp=3Demail )

Change subject: Implement override-username
......................................................................


Patch Set 2:

(15 comments)

File Changes.rst:

http://gerrit.openvpn.net/c/openvpn/+/872/comment/02e764b7_6304b3bf :
PS1, Line 41:     client use certificates and multi-factor authentication.
> "clients"
Acknowledged


File doc/man-sections/server-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/872/comment/334a1a85_26710d09 :
PS1, Line 673: --override-username
> At the wrong place in the document alphabetically
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/872/comment/89fc0d0a_8affe908 :
PS1, Line 674:   Sets the username of a connection the specified username. =
 This username
> "to the"
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/872/comment/4ce38eba_2c5c594a :
PS1, Line 675:   will also be used by the by ``--auth-gen-token``. However,=
 the overridden
> Superfluous words "by the"?
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/872/comment/1118b7e1_d4a82479 :
PS1, Line 677:   ``--client-config-dir`` and the ``--auth-user-pass-verify`=
` script have
> This is confusing. [=E2=80=A6]
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/872/comment/61c5f531_68d4138a :
PS1, Line 680:   Also ``username-as-common-name`` will use the client provi=
ded username
> --username-as-common-name for consistency
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/872/comment/eccbce07_e521f35e :
PS1, Line 682:   ``--override-username`` option if  the option ``username-a=
s-common-name``
> superfluous space
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/872/comment/4fcc7d05_ea20ea4c :
PS1, Line 686:   the the ``--auth-gen-token`` option. It will also be pushe=
d to the client
> duplicated "the"
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/872/comment/f664c9a3_27d05978 :
PS1, Line 687:   using ``--auth-token-user``.
> We should add a cross-reference to documentation for --auth-token-user
Acknowledged


File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/872/comment/cb7d16f1_b397a081 :
PS1, Line 2670:  * @param mi
> Either document it or remove stub-comment.
Acknowledged


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/872/comment/a5d879a8_b2f803e4 :
PS1, Line 7850:     else if (streq(p[0], "override-username") && p[1] && !p=
[2])
> New option should be added to usage information.
I am not sure about it. This is an option that is only allow in per client =
specific files but since --disable is documented there, so I will do it for=
 consistency.


http://gerrit.openvpn.net/c/openvpn/+/872/comment/8bcfd0ed_260b2f18 :
PS1, Line 7859:              * set another username might serious problems =
*/
> missing word "cause"?
Acknowledged


File src/openvpn/ssl_common.h:

http://gerrit.openvpn.net/c/openvpn/+/872/comment/8970872f_44928eba :
PS1, Line 630:      * authentication */
> "unless overridden by override-user"
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/872/comment/d732026a_e80583da :
PS1, Line 633:     /** The username that client initial used before being o=
verrriden by
> "initially"
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/872/comment/40f0c46d_fedba44c :
PS1, Line 634:      * by override-user */
> duplicated "by"
Acknowledged



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
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 20 Jan 2025 15:29:00 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--t22OOaODwZk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/872?usp=3Demail">View C=
hange</a></p><p>15 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File Changes.rst:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/872/comment/02e764b7_6304b3bf">Patch Set #1, Line 41:</a> <code st=
yle=3D"font-family:monospace,monospace">    client use certificates and mul=
ti-factor authentication.</code></p><p><blockquote style=3D"border-left: 1p=
x solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;clients&quot;</blockq=
uote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowl=
edged</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File doc/ma=
n-sections/server-options.rst:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/872/comment/334a1a8=
5_26710d09">Patch Set #1, Line 673:</a> <code style=3D"font-family:monospac=
e,monospace">--override-username</code></p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">At the wrong place i=
n the document alphabetically</blockquote></p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Acknowledged</p></li><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/872/comment/89fc0d0a_8affe908">Patch Set #1, L=
ine 674:</a> <code style=3D"font-family:monospace,monospace">  Sets the use=
rname of a connection the specified username.  This username</code></p><p><=
blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0=
 10px;">&quot;to the&quot;</blockquote></p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Acknowledged</p></li><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/872/comment/4ce38eba_2c5c594a">Patch Set #1, Line=
 675:</a> <code style=3D"font-family:monospace,monospace">  will also be us=
ed by the by ``--auth-gen-token``. However, the overridden</code></p><p><bl=
ockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 1=
0px;">Superfluous words &quot;by the&quot;?</blockquote></p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/872/comment/1118b7e1_d4a82479">=
Patch Set #1, Line 677:</a> <code style=3D"font-family:monospace,monospace"=
>  ``--client-config-dir`` and the ``--auth-user-pass-verify`` script have<=
/code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px=
 0; padding: 0 10px;">This is confusing. [=E2=80=A6]</blockquote></p><p sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/872/comment/61c5f531_68=
d4138a">Patch Set #1, Line 680:</a> <code style=3D"font-family:monospace,mo=
nospace">  Also ``username-as-common-name`` will use the client provided us=
ername</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">--username-as-common-name for consistency</blo=
ckquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Ackn=
owledged</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/872/c=
omment/eccbce07_e521f35e">Patch Set #1, Line 682:</a> <code style=3D"font-f=
amily:monospace,monospace">  ``--override-username`` option if  the option =
``username-as-common-name``</code></p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;">superfluous space</blockq=
uote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowl=
edged</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/872/comm=
ent/4fcc7d05_ea20ea4c">Patch Set #1, Line 686:</a> <code style=3D"font-fami=
ly:monospace,monospace">  the the ``--auth-gen-token`` option. It will also=
 be pushed to the client</code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">duplicated &quot;the&quot;</=
blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">A=
cknowledged</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/8=
72/comment/f664c9a3_27d05978">Patch Set #1, Line 687:</a> <code style=3D"fo=
nt-family:monospace,monospace">  using ``--auth-token-user``.</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">We should add a cross-reference to documentation for --auth-token-=
user</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Acknowledged</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p=
>File src/openvpn/multi.c:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/872/comment/cb7d16f1_b3=
97a081">Patch Set #1, Line 2670:</a> <code style=3D"font-family:monospace,m=
onospace"> * @param mi</code></p><p><blockquote style=3D"border-left: 1px s=
olid #aaa; margin: 10px 0; padding: 0 10px;">Either document it or remove s=
tub-comment.</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Acknowledged</p></li></ul></li><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/options.c:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/872/comment/a=
5d879a8_b2f803e4">Patch Set #1, Line 7850:</a> <code style=3D"font-family:m=
onospace,monospace">    else if (streq(p[0], &quot;override-username&quot;)=
 &amp;&amp; p[1] &amp;&amp; !p[2])</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">New option should =
be added to usage information.</blockquote></p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">I am not sure about it. This is an option th=
at is only allow in per client specific files but since --disable is docume=
nted there, so I will do it for consistency.</p></li><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/872/comment/8bcfd0ed_260b2f18">Patch Set #1,=
 Line 7859:</a> <code style=3D"font-family:monospace,monospace">           =
  * set another username might serious problems */</code></p><p><blockquote=
 style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">mi=
ssing word &quot;cause&quot;?</blockquote></p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Acknowledged</p></li></ul></li><li style=3D"m=
argin: 0; padding: 0;"><p>File src/openvpn/ssl_common.h:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/872/comment/8970872f_44928eba">Patch Set #1, Line 630:</a> <code sty=
le=3D"font-family:monospace,monospace">     * authentication */</code></p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">&quot;unless overridden by override-user&quot;</blockquote></p><=
p style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p><=
/li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/872/comment/d73202=
6a_e80583da">Patch Set #1, Line 633:</a> <code style=3D"font-family:monospa=
ce,monospace">    /** The username that client initial used before being ov=
errriden by</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; =
margin: 10px 0; padding: 0 10px;">&quot;initially&quot;</blockquote></p><p =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></l=
i><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/872/comment/40f0c46d=
_fedba44c">Patch Set #1, Line 634:</a> <code style=3D"font-family:monospace=
,monospace">     * by override-user */</code></p><p><blockquote style=3D"bo=
rder-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">duplicated &qu=
ot;by&quot;</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">Acknowledged</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/872?usp=3Demail">change 872</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/872?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 20 Jan 2025 15:29:00=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--t22OOaODwZk=--


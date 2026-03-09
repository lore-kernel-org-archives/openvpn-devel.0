From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 9 Mar 2026 13:10:53 +0000
In-Reply-To: <gerrit.1725894771000.Iae04ad8715e40dfc76475c2c5b9a766c9604efc9@...2715...>
References: <gerrit.1725894771000.Iae04ad8715e40dfc76475c2c5b9a766c9604efc9@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726...
Message-ID: <62e27b41e2072502651f06b166003a105df0cc6c-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pXzCdJma2Tc="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: options: add IPv4
 CIDR parsing for relevant directives
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf_lici <ralf@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--pXzCdJma2Tc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici.

flichtenheld has posted comments on this change by ralf_lici. ( http://gerr=
it.openvpn.net/c/openvpn/+/739?usp=3Demail )

Change subject: options: add IPv4 CIDR parsing for relevant directives
......................................................................


Patch Set 9: Code-Review-1

(5 comments)

File doc/man-sections/server-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/739/comment/6c774407_c41b8c34?usp=3De=
mail :
PS9, Line 309:   view.
I would find it a bit easier to read if this was more explicit. Maybe add s=
omething like "So the server will actually push ``ifconfig alias remote/net=
mask`` to the client"?


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/739/comment/35d57942_8451aec7?usp=3De=
mail :
PS9, Line 7288:         const int lev =3D M_WARN;
Please fix to msglvl_t


http://gerrit.openvpn.net/c/openvpn/+/739/comment/9c9d016a_9cface99?usp=3De=
mail :
PS9, Line 7688:         remote_netmask =3D getaddr(GETADDR_HOST_ORDER | GET=
ADDR_RESOLVE, ifconfig_push_parms[2], 0,
A bit absurd that we need to parse netmask here again if we generated it be=
fore. But probably not worth trying to optimize that away.


File src/openvpn/options_util.c:

http://gerrit.openvpn.net/c/openvpn/+/739/comment/8d1749e3_5a891d4c?usp=3De=
mail :
PS9, Line 232:      * socket_util.c dependencies into options_util unit-tes=
t targets. */
This feels like a weak justification to duplicate code.


File tests/unit_tests/openvpn/test_options_parse.c:

http://gerrit.openvpn.net/c/openvpn/+/739/comment/ab0e93b7_3d53fbba?usp=3De=
mail :
PS9, Line 330: test_convert_ipv4_cidr_parms_coverage(void **state)
This does not feel like it provides actual "coverage". The examples are all=
 too similar. To get coverage you should test a bigger variety of "bits" (m=
aybe throw a "0" and a "32" in there at least?) and more interesting varian=
ts of input parameters (even if they are not currently realistic). E.g. use=
 minimal and maximal values for network_idx and max_idx.

Also include the case where the network parameter is a DNS name



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iae04ad8715e40dfc76475c2c5b9a766c9604efc9
Gerrit-Change-Number: 739
Gerrit-PatchSet: 9
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-Comment-Date: Mon, 09 Mar 2026 13:10:53 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--pXzCdJma2Tc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici. </p>
<p>Patch set 9:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail">Vi=
ew Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/server-op=
tions.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/739/comment/6c774407_c41b8c34?usp=3Dema=
il">Patch Set #9, Line 309:</a> <code style=3D"font-family:monospace,monosp=
ace">  view.</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;">I would find it a bit easier to read if this was mo=
re explicit. Maybe add something like &quot;So the server will actually pus=
h ``ifconfig alias remote/netmask`` to the client&quot;?</p></li></ul></li>=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/739/comment/35d57942_8451aec7?usp=3Demail">Patch Set #9, =
Line 7288:</a> <code style=3D"font-family:monospace,monospace">        cons=
t int lev =3D M_WARN;</code></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Please fix to msglvl_t</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/739/comment/9c9d016a_9cface99?u=
sp=3Demail">Patch Set #9, Line 7688:</a> <code style=3D"font-family:monospa=
ce,monospace">        remote_netmask =3D getaddr(GETADDR_HOST_ORDER | GETAD=
DR_RESOLVE, ifconfig_push_parms[2], 0,</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">A bit absurd that we nee=
d to parse netmask here again if we generated it before. But probably not w=
orth trying to optimize that away.</p></li></ul></li><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/options_util.c:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/739/comment/8d1749e3_5a891d4c?usp=3Demail">Patch Set #9, Line 232:</a> <co=
de style=3D"font-family:monospace,monospace">     * socket_util.c dependenc=
ies into options_util unit-test targets. */</code></p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">This feels like a we=
ak justification to duplicate code.</p></li></ul></li><li style=3D"margin: =
0; padding: 0;"><p>File tests/unit_tests/openvpn/test_options_parse.c:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/739/comment/ab0e93b7_3d53fbba?usp=3Demail">Patch Set #=
9, Line 330:</a> <code style=3D"font-family:monospace,monospace">test_conve=
rt_ipv4_cidr_parms_coverage(void **state)</code></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">This does not feel lik=
e it provides actual &quot;coverage&quot;. The examples are all too similar=
. To get coverage you should test a bigger variety of &quot;bits&quot; (may=
be throw a &quot;0&quot; and a &quot;32&quot; in there at least?) and more =
interesting variants of input parameters (even if they are not currently re=
alistic). E.g. use minimal and maximal values for network_idx and max_idx.<=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">Also include the case where the network parameter is a DNS name</p></li=
></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/739?usp=3Demail">change 739</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3De=
mail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/739?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iae04ad8715e40dfc76475c2c5b9=
a766c9604efc9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 739 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 09 Mar 2026 13:10:53=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--pXzCdJma2Tc=--


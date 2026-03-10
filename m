From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Tue, 10 Mar 2026 09:53:10 +0000
In-Reply-To: <gerrit.1725894771000.Iae04ad8715e40dfc76475c2c5b9a766c9604efc9@...2715...>
References: <gerrit.1725894771000.Iae04ad8715e40dfc76475c2c5b9a766c9604efc9@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <624da500f4edcf1e8369be5d87ed8f0ec0a54c5e-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+xtCcyPGueU="; charset=UTF-8
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
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+xtCcyPGueU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

ralf_lici has posted comments on this change by ralf_lici. ( http://gerrit.=
openvpn.net/c/openvpn/+/739?usp=3Demail )

Change subject: options: add IPv4 CIDR parsing for relevant directives
......................................................................


Patch Set 9:

(5 comments)

File doc/man-sections/server-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/739/comment/93ccbb1c_e6347e78?usp=3De=
mail :
PS9, Line 309:   view.
> I would find it a bit easier to read if this was more explicit. [=E2=80=
=A6]
Acknowledged


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/739/comment/bc6ae7da_894ede5f?usp=3De=
mail :
PS9, Line 7288:         const int lev =3D M_WARN;
> Please fix to msglvl_t
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/739/comment/25bbf8a6_50aad5ce?usp=3De=
mail :
PS9, Line 7688:         remote_netmask =3D getaddr(GETADDR_HOST_ORDER | GET=
ADDR_RESOLVE, ifconfig_push_parms[2], 0,
> A bit absurd that we need to parse netmask here again if we generated it =
before. [=E2=80=A6]
I agree. The main issue is that IPv4 options in options.c do not all conver=
t at the same stage: some paths keep parameters as strings until later cons=
umers, while others parse to binary earlier.
A dual-helper design (string + binary outputs) is possible, but it would ei=
ther duplicate per-option handling or require a broader parsing abstraction.
For this change, the scope is limited to translating CIDR-form IPv4 paramet=
er strings into the existing legacy string form, without altering downstrea=
m option processing.


File src/openvpn/options_util.c:

http://gerrit.openvpn.net/c/openvpn/+/739/comment/eb44c41a_68747e58?usp=3De=
mail :
PS9, Line 232:      * socket_util.c dependencies into options_util unit-tes=
t targets. */
> This feels like a weak justification to duplicate code.
Just to make sure I understood this point correctly: do you prefer that I s=
witch to print_in_addr_t() (and pull in socket_util dependencies), or that =
I keep the local conversion and only tighten/remove the justification comme=
nt?
I tried the former locally: switching to print_in_addr_t() made options_par=
se_testdriver, push_update_msg_testdriver, and misc_testdriver fail to link=
 unless socket_util.c is also linked. Once socket_util.c is linked, additio=
nal transitive symbols are required (setenv_*, siginfo_static/signal_reset,=
 management_*), so this becomes a broader test/build refactor.
That's why for this patch I kept the conversion self-contained in options_u=
til.c.


File tests/unit_tests/openvpn/test_options_parse.c:

http://gerrit.openvpn.net/c/openvpn/+/739/comment/306d8e15_e3a09146?usp=3De=
mail :
PS9, Line 330: test_convert_ipv4_cidr_parms_coverage(void **state)
> This does not feel like it provides actual "coverage". The examples are a=
ll too similar. [=E2=80=A6]
Acknowledged



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
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 10 Mar 2026 09:53:10 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>

--+xtCcyPGueU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail">View C=
hange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/server-option=
s.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/739/comment/93ccbb1c_e6347e78?usp=3Demail">=
Patch Set #9, Line 309:</a> <code style=3D"font-family:monospace,monospace"=
>  view.</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; mar=
gin: 10px 0; padding: 0 10px;">I would find it a bit easier to read if this=
 was more explicit. [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li></u=
l></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/739/comment/bc6ae7da_894ede5f?usp=3Demail">Patch S=
et #9, Line 7288:</a> <code style=3D"font-family:monospace,monospace">     =
   const int lev =3D M_WARN;</code></p><p><blockquote style=3D"border-left:=
 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Please fix to msglvl_t</=
blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Acknowledged</p></li><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/739/comment/25bbf8a6_50aad5ce?usp=3Demail">Patch Set #9, Lin=
e 7688:</a> <code style=3D"font-family:monospace,monospace">        remote_=
netmask =3D getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, ifconfig_push_par=
ms[2], 0,</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;">A bit absurd that we need to parse netmask =
here again if we generated it before. [=E2=80=A6]</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I agree=
. The main issue is that IPv4 options in options.c do not all convert at th=
e same stage: some paths keep parameters as strings until later consumers, =
while others parse to binary earlier.<br>A dual-helper design (string + bin=
ary outputs) is possible, but it would either duplicate per-option handling=
 or require a broader parsing abstraction.<br>For this change, the scope is=
 limited to translating CIDR-form IPv4 parameter strings into the existing =
legacy string form, without altering downstream option processing.</p></li>=
</ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options_=
util.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/739/comment/eb44c41a_68747e58?usp=3Demail"=
>Patch Set #9, Line 232:</a> <code style=3D"font-family:monospace,monospace=
">     * socket_util.c dependencies into options_util unit-test targets. */=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">This feels like a weak justification to duplicate co=
de.</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Just to make sure I understood this point correctly: d=
o you prefer that I switch to print_in_addr_t() (and pull in socket_util de=
pendencies), or that I keep the local conversion and only tighten/remove th=
e justification comment?<br>I tried the former locally: switching to print_=
in_addr_t() made options_parse_testdriver, push_update_msg_testdriver, and =
misc_testdriver fail to link unless socket_util.c is also linked. Once sock=
et_util.c is linked, additional transitive symbols are required (setenv_*, =
siginfo_static/signal_reset, management_*), so this becomes a broader test/=
build refactor.<br>That&#39;s why for this patch I kept the conversion self=
-contained in options_util.c.</p></li></ul></li><li style=3D"margin: 0; pad=
ding: 0;"><p>File tests/unit_tests/openvpn/test_options_parse.c:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/739/comment/306d8e15_e3a09146?usp=3Demail">Patch Set #9, Lin=
e 330:</a> <code style=3D"font-family:monospace,monospace">test_convert_ipv=
4_cidr_parms_coverage(void **state)</code></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This does not fee=
l like it provides actual &quot;coverage&quot;. The examples are all too si=
milar. [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Acknowledged</p></li></ul></li></ul><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739?usp=3De=
mail">change 739</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 10 Mar 2026 09:53:10=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>

</body></html>=

--+xtCcyPGueU=--


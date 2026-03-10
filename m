From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 10 Mar 2026 10:28:42 +0000
In-Reply-To: <gerrit.1725894771000.Iae04ad8715e40dfc76475c2c5b9a766c9604efc9@...2715...>
References: <gerrit.1725894771000.Iae04ad8715e40dfc76475c2c5b9a766c9604efc9@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726...
Message-ID: <c09597f0e9b592ef89681d275ff1fa072928cec5-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vmSk6tFRtB4="; charset=UTF-8
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

--vmSk6tFRtB4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici.

flichtenheld has posted comments on this change by ralf_lici. ( http://gerr=
it.openvpn.net/c/openvpn/+/739?usp=3Demail )

Change subject: options: add IPv4 CIDR parsing for relevant directives
......................................................................


Patch Set 9:

(2 comments)

File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/739/comment/c0e57a84_9a30f6b2?usp=3De=
mail :
PS9, Line 7688:         remote_netmask =3D getaddr(GETADDR_HOST_ORDER | GET=
ADDR_RESOLVE, ifconfig_push_parms[2], 0,
> I agree. The main issue is that IPv4 options in options. [=E2=80=A6]
Acknowledged


File src/openvpn/options_util.c:

http://gerrit.openvpn.net/c/openvpn/+/739/comment/dc618575_003b428a?usp=3De=
mail :
PS9, Line 232:      * socket_util.c dependencies into options_util unit-tes=
t targets. */
> Just to make sure I understood this point correctly: do you prefer that I=
 switch to print_in_addr_t( [=E2=80=A6]
Okay, to be clear: My opinion is that this code should not be duplicated. I=
 think it is complicated enough that we should avoid this.

The UT changes are probably not actually a problem. The list of dependencie=
s of test_socket is also reasonably small so I can't imagine this will be a=
 complicated addition to test_options.

If that turns out to be wrong we could also look into whether moving the co=
de to options_util would be simpler. There is no strict reason why it needs=
 to be in socket_util.



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
Gerrit-Comment-Date: Tue, 10 Mar 2026 10:28:42 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Comment-In-Reply-To: ralf_lici <ralf@...2726...>

--vmSk6tFRtB4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/739/comment/c0e57a84_9a30f6b2?usp=3Demail">Patch Set #9, =
Line 7688:</a> <code style=3D"font-family:monospace,monospace">        remo=
te_netmask =3D getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, ifconfig_push_=
parms[2], 0,</code></p><p><blockquote style=3D"border-left: 1px solid #aaa;=
 margin: 10px 0; padding: 0 10px;">I agree. The main issue is that IPv4 opt=
ions in options. [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li></ul></l=
i><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options_util.c:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/739/comment/dc618575_003b428a?usp=3Demail">Patch S=
et #9, Line 232:</a> <code style=3D"font-family:monospace,monospace">     *=
 socket_util.c dependencies into options_util unit-test targets. */</code><=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">Just to make sure I understood this point correctly: do you =
prefer that I switch to print_in_addr_t( [=E2=80=A6]</blockquote></p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Okay,=
 to be clear: My opinion is that this code should not be duplicated. I thin=
k it is complicated enough that we should avoid this.</p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">The UT changes ar=
e probably not actually a problem. The list of dependencies of test_socket =
is also reasonably small so I can&#39;t imagine this will be a complicated =
addition to test_options.</p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">If that turns out to be wrong we could also l=
ook into whether moving the code to options_util would be simpler. There is=
 no strict reason why it needs to be in socket_util.</p></li></ul></li></ul=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739?usp=
=3Demail">change 739</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings<=
/a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div ite=
mscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 10 Mar 2026 10:28:42=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: ralf_lici &lt;ralf@...2788...=
6...&gt; </div>

</body></html>=

--vmSk6tFRtB4=--


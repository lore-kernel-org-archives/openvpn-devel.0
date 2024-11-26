From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 26 Nov 2024 17:08:51 +0000
In-Reply-To: <gerrit.1732634928000.I1a22724f28c5cd47f6df178b49f44087d7c2b6fd@...2715...>
References: <gerrit.1732634928000.I1a22724f28c5cd47f6df178b49f44087d7c2b6fd@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., alex@...2837...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e9ad7e14bea6bb63aff6b52703d16cc47b933e9b-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gebqq+3XOSY="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Haiku: Add calls to
 manage routing table
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: kallisti5 <alex@...2837...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gebqq+3XOSY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: kallisti5, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/688?usp=3Demail )

Change subject: Haiku: Add calls to manage routing table
......................................................................


Patch Set 3: Code-Review-1

(7 comments)

File src/openvpn/route.c:

http://gerrit.openvpn.net/c/openvpn/+/688/comment/cb24a5fc_d8a53a2e :
PS3, Line 3940:     sockfd =3D socket(AF_INET, SOCK_DGRAM, 0);
Can be merged with the previous line?


http://gerrit.openvpn.net/c/openvpn/+/688/comment/e8a07f51_932f4e4e :
PS3, Line 3942:         msg(M_INFO, "%s: Error opening socket for AF_INET",=
 __func__);
M_ERRNO?


http://gerrit.openvpn.net/c/openvpn/+/688/comment/4b71cd90_2cc12dc0 :
PS3, Line 3949:         msg(M_INFO, "%s: Error getting routing table size",=
 __func__);
M_ERRNO?


http://gerrit.openvpn.net/c/openvpn/+/688/comment/cdfe37bd_7ed2e6c0 :
PS3, Line 3958: N
Use `check_malloc_return`.


http://gerrit.openvpn.net/c/openvpn/+/688/comment/2837f36b_f5691068 :
PS3, Line 3976:             strcpy(rgi->iface, interface->ifr_name);
Should probably use `strcpynt`


http://gerrit.openvpn.net/c/openvpn/+/688/comment/259f47d5_648923cf :
PS3, Line 3979:         int32 addressSize =3D 0;
no CamelCase please.


http://gerrit.openvpn.net/c/openvpn/+/688/comment/dfdc0992_8f8edb22 :
PS3, Line 3990: }
This seems to leak memory from the malloc?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/688?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1a22724f28c5cd47f6df178b49f44087d7c2b6fd
Gerrit-Change-Number: 688
Gerrit-PatchSet: 3
Gerrit-Owner: kallisti5 <alex@...2837...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: kallisti5 <alex@...2837...>
Gerrit-Comment-Date: Tue, 26 Nov 2024 17:08:51 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--gebqq+3XOSY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: kallisti5, plaisthos. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/688?usp=3Demail">Vi=
ew Change</a></p><p>7 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/route.c:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/688/comment/cb24a5fc_d8a53a2e">Patch Set #3, Line 3940:=
</a> <code style=3D"font-family:monospace,monospace">    sockfd =3D socket(=
AF_INET, SOCK_DGRAM, 0);</code></p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Can be merged with the previous line?</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/688/comment/e8a07f51_932f4e4e">=
Patch Set #3, Line 3942:</a> <code style=3D"font-family:monospace,monospace=
">        msg(M_INFO, &quot;%s: Error opening socket for AF_INET&quot;, __f=
unc__);</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;=
">M_ERRNO?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/6=
88/comment/4b71cd90_2cc12dc0">Patch Set #3, Line 3949:</a> <code style=3D"f=
ont-family:monospace,monospace">        msg(M_INFO, &quot;%s: Error getting=
 routing table size&quot;, __func__);</code></p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">M_ERRNO?</p></li><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/688/comment/cdfe37bd_7ed2e6c0">Patch Set #3, Lin=
e 3958:</a> <code style=3D"font-family:monospace,monospace">N</code></p><p =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Use `check_malloc_r=
eturn`.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/688/co=
mment/2837f36b_f5691068">Patch Set #3, Line 3976:</a> <code style=3D"font-f=
amily:monospace,monospace">            strcpy(rgi-&gt;iface, interface-&gt;=
ifr_name);</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Should probably use `strcpynt`</p></li><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/688/comment/259f47d5_648923cf">Patch Set #3, Line 397=
9:</a> <code style=3D"font-family:monospace,monospace">        int32 addres=
sSize =3D 0;</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-=
word;">no CamelCase please.</p></li><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/688/comment/dfdc0992_8f8edb22">Patch Set #3, Line 3990:</a> <=
code style=3D"font-family:monospace,monospace">}</code></p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">This seems to leak memory from t=
he malloc?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/688?usp=3Demail">change 688</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/688?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1a22724f28c5cd47f6df178b49f=
44087d7c2b6fd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 688 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: kallisti5 &lt;alex@...2837...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: kallisti5 &lt;alex@...2839...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 26 Nov 2024 17:08:51=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--gebqq+3XOSY=--


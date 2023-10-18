From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 18 Oct 2023 10:42:44 +0000
In-Reply-To: <gerrit.1697562354000.I143ca14c27c0c378b5e6b4184e80890d2c0e225e@...2715...>
References: <gerrit.1697562354000.I143ca14c27c0c378b5e6b4184e80890d2c0e225e@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., max@...2606...
Message-ID: <f0b37f9f31373c8322590047f7a673304808d250-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="x0w/HsXuDdg="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add compatibility
 functions for mbedtls 2.X.Y
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: MaxF <max@...2606...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--x0w/HsXuDdg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/371?usp=3Demail )

Change subject: Add compatibility functions for mbedtls 2.X.Y
......................................................................


Patch Set 2:

(1 comment)

Patchset:

PS2:
I tried compiling against 2.28.5 and got this error:


ssl_mbedtls.c: In function =E2=80=98external_pkcs1_sign=E2=80=99:
ssl_mbedtls.c:607:16: error: =E2=80=98MBEDTLS_RSA_BAD_INPUT_DATA=E2=80=99 u=
ndeclared (first use in this function); did you mean =E2=80=98MBEDTLS_ERR_R=
SA_BAD_INPUT_DATA=E2=80=99?
  607 |         return MBEDTLS_RSA_BAD_INPUT_DATA;
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~
      |                MBEDTLS_ERR_RSA_BAD_INPUT_DATA



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/371?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I143ca14c27c0c378b5e6b4184e80890d2c0e225e
Gerrit-Change-Number: 371
Gerrit-PatchSet: 2
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Wed, 18 Oct 2023 10:42:44 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--x0w/HsXuDdg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: MaxF, flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/371?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/3=
71?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">I tried compiling against 2.28.5 and got this erro=
r:</p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><br>ssl_mbedtls.c: In function =E2=80=98external_pkcs1_sign=E2=80=99:<br=
>ssl_mbedtls.c:607:16: error: =E2=80=98MBEDTLS_RSA_BAD_INPUT_DATA=E2=80=99 =
undeclared (first use in this function); did you mean =E2=80=98MBEDTLS_ERR_=
RSA_BAD_INPUT_DATA=E2=80=99?<br>  607 |         return MBEDTLS_RSA_BAD_INPU=
T_DATA;<br>      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~<br>      |    =
            MBEDTLS_ERR_RSA_BAD_INPUT_DATA</pre></li></ul></li></ul><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/371?usp=3Demail=
">change 371</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsco=
pe itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/371?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I143ca14c27c0c378b5e6b4184e8=
0890d2c0e225e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 371 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 18 Oct 2023 10:42:44=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--x0w/HsXuDdg=--


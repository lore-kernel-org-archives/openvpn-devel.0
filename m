From: "MaxF (Code Review)" <gerrit@...515...>
Date: Fri, 28 Nov 2025 12:59:22 +0000
In-Reply-To: <gerrit.1764327114000.Ia4afabcb6006dc9304a4c09f824d9c7c2d4d64ad@...2715...>
References: <gerrit.1764327114000.Ia4afabcb6006dc9304a4c09f824d9c7c2d4d64ad@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a9664e0fea5fe5b1ef72915be1e44b75f193c0d1-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ftITbflrXq8="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Drop Mbed TLS 2.X
 compatibility
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ftITbflrXq8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

MaxF has posted comments on this change by MaxF. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/1412?usp=3Demail )

Change subject: Drop Mbed TLS 2.X compatibility
......................................................................


Patch Set 2:

(3 comments)

Patchset:

PS1:
> configure.ac needs more work. Presumably there should be a CMakeLists. [=
=E2=80=A6]
CMake doesn't check the version. I think the approach is, if you have the w=
rong version, the build will just fail. It does a bunch of feature detectio=
n which I have now removed though.


File configure.ac:

http://gerrit.openvpn.net/c/openvpn/+/1412/comment/e31ce4eb_9de17423?usp=3D=
email :
PS1, Line 998: 			[mbedtls >=3D 2.0.0 mbedx509 >=3D 2.0.0 mbedcrypto >=3D 2=
.0.0],
> Needs to be updated as well
Done


http://gerrit.openvpn.net/c/openvpn/+/1412/comment/c2576736_b01015cf?usp=3D=
email :
PS1, Line 1036: 	if test "x$ac_cv_func_mbedtls_ssl_conf_export_keys_ext_cb"=
 !=3D xyes; then
> Now that we have the stricter version check, can we get rid of these addi=
tional tests?
Thanks for pointing that out! In version 3, we always have the export_keys_=
cb version, this let me remove even more code!



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1412?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia4afabcb6006dc9304a4c09f824d9c7c2d4d64ad
Gerrit-Change-Number: 1412
Gerrit-PatchSet: 2
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Fri, 28 Nov 2025 12:59:22 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>

--ftITbflrXq8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1412?usp=3Demail">View =
Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1412?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">con=
figure.ac needs more work. Presumably there should be a CMakeLists. [=E2=80=
=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">CMake doesn&#39;t check the version. I think the appr=
oach is, if you have the wrong version, the build will just fail. It does a=
 bunch of feature detection which I have now removed though.</p></li></ul><=
/li><li style=3D"margin: 0; padding: 0;"><p>File configure.ac:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1412/comment/e31ce4eb_9de17423?usp=3Demail">Patch Set #1, Line=
 998:</a> <code style=3D"font-family:monospace,monospace">			[mbedtls &gt;=
=3D 2.0.0 mbedx509 &gt;=3D 2.0.0 mbedcrypto &gt;=3D 2.0.0],</code></p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">Needs to be updated as well</blockquote></p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1412/comment/c2576736_b01015cf?=
usp=3Demail">Patch Set #1, Line 1036:</a> <code style=3D"font-family:monosp=
ace,monospace">	if test &quot;x$ac_cv_func_mbedtls_ssl_conf_export_keys_ext=
_cb&quot; !=3D xyes; then</code></p><p><blockquote style=3D"border-left: 1p=
x solid #aaa; margin: 10px 0; padding: 0 10px;">Now that we have the strict=
er version check, can we get rid of these additional tests?</blockquote></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Thanks for pointing that out! In version 3, we always have the export_key=
s_cb version, this let me remove even more code!</p></li></ul></li></ul><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1412?usp=3D=
email">change 1412</a>. To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1412?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia4afabcb6006dc9304a4c09f824=
d9c7c2d4d64ad </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1412 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 28 Nov 2025 12:59:22=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>

</body></html>=

--ftITbflrXq8=--


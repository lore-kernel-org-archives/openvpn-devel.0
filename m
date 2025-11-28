From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 28 Nov 2025 11:03:13 +0000
In-Reply-To: <gerrit.1764327114000.Ia4afabcb6006dc9304a4c09f824d9c7c2d4d64ad@...2715...>
References: <gerrit.1764327114000.Ia4afabcb6006dc9304a4c09f824d9c7c2d4d64ad@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, max@...2606...
Message-ID: <67fb579f56ef101375d845c248d1f4e9f5335b66-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="97DDDHVQ4Co="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Drop Mbed TLS 2.X
 compatibility
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: MaxF <max@...2606...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--97DDDHVQ4Co=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, plaisthos.

flichtenheld has posted comments on this change by MaxF. ( http://gerrit.op=
envpn.net/c/openvpn/+/1412?usp=3Demail )

Change subject: Drop Mbed TLS 2.X compatibility
......................................................................


Patch Set 1: Code-Review-2

(3 comments)

Patchset:

PS1:
configure.ac needs more work. Presumably there should be a CMakeLists.txt p=
atch as well?


File configure.ac:

http://gerrit.openvpn.net/c/openvpn/+/1412/comment/eeaca2b9_aa9059f4?usp=3D=
email :
PS1, Line 998: 			[mbedtls >=3D 2.0.0 mbedx509 >=3D 2.0.0 mbedcrypto >=3D 2=
.0.0],
Needs to be updated as well


http://gerrit.openvpn.net/c/openvpn/+/1412/comment/247cb35b_86dd2af0?usp=3D=
email :
PS1, Line 1036: 	if test "x$ac_cv_func_mbedtls_ssl_conf_export_keys_ext_cb"=
 !=3D xyes; then
Now that we have the stricter version check, can we get rid of these additi=
onal tests?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1412?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia4afabcb6006dc9304a4c09f824d9c7c2d4d64ad
Gerrit-Change-Number: 1412
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Fri, 28 Nov 2025 11:03:13 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--97DDDHVQ4Co=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1412?usp=3Demail">V=
iew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1412?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">configure.=
ac needs more work. Presumably there should be a CMakeLists.txt patch as we=
ll?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File configur=
e.ac:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/1412/comment/eeaca2b9_aa9059f4?usp=3Demail">=
Patch Set #1, Line 998:</a> <code style=3D"font-family:monospace,monospace"=
>			[mbedtls &gt;=3D 2.0.0 mbedx509 &gt;=3D 2.0.0 mbedcrypto &gt;=3D 2.0.0]=
,</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Needs to be updated as well</p></li><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1412/comment/247cb35b_86dd2af0?usp=3Demail">Patc=
h Set #1, Line 1036:</a> <code style=3D"font-family:monospace,monospace">	i=
f test &quot;x$ac_cv_func_mbedtls_ssl_conf_export_keys_ext_cb&quot; !=3D xy=
es; then</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Now that we have the stricter version check, can we get=
 rid of these additional tests?</p></li></ul></li></ul><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/1412?usp=3Demail">change 141=
2</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1412?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia4afabcb6006dc9304a4c09f824=
d9c7c2d4d64ad </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1412 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 28 Nov 2025 11:03:13=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--97DDDHVQ4Co=--


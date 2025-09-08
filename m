From: "mandree (Code Review)" <gerrit@...515...>
Date: Mon, 8 Sep 2025 18:15:43 +0000
In-Reply-To: <gerrit.1757337482000.I327ecc9a85dd906517c28e71fe500883bfa028a4@...2715...>
References: <gerrit.1757337482000.I327ecc9a85dd906517c28e71fe500883bfa028a4@...2715...>
Reply-To: matthias.andree@...68..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <47c1ef9a4e5497dd1e03c42fd32d65fb5979c9e1-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HSPxDIRVxss="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Switch test_ssl
 certificate from RSA 2048 to secp384r1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--HSPxDIRVxss=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

mandree has posted comments on this change. ( http://gerrit.openvpn.net/c/o=
penvpn/+/1172?usp=3Demail )

Change subject: Switch test_ssl certificate from RSA 2048 to secp384r1
......................................................................


Patch Set 2: Code-Review+1

(1 comment)

Patchset:

PS2:
On my FreeBSD 14.3-RELEASE-p2 amd64, with OpenSSL 3.5 installed from ports,
the self-test suite, in particular ssl_testdriver, now passes with openssl.=
cnf
raising the ciphersuite to SECLEVEL=3D3 or SECLEVEL=3D4, but SECLEVEL=3D5 s=
till bombs out
with "ee key too small". So: ACK because it's an improvement.

Not sure if the purpose of the test is "test that our own TLS stuff works",
or by contrast "test that the system's default OpenSSL setting works".
  In the former case, it might be suitable to ship an openssl.cnf for the t=
est
that gets us a defined environment, or maybe run the test twice once with s=
ystem
default settings and once with an override to see if _todays_ zealous SECLE=
VEL is it.

Of course the operating system or OpenSSL distro might kill our favorite ci=
pher altogether, in which case we're dead unless we override - but then the=
 isolated
test case bears no relevance for practical applicability of its results.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1172?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I327ecc9a85dd906517c28e71fe500883bfa028a4
Gerrit-Change-Number: 1172
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: mandree <matthias.andree@...68...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 08 Sep 2025 18:15:43 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--HSPxDIRVxss=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1172?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1172?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">On my FreeBSD 14.3-RELEASE-p2 amd64, with Op=
enSSL 3.5 installed from ports,<br>the self-test suite, in particular ssl_t=
estdriver, now passes with openssl.cnf<br>raising the ciphersuite to SECLEV=
EL=3D3 or SECLEVEL=3D4, but SECLEVEL=3D5 still bombs out<br>with &quot;ee k=
ey too small&quot;. So: ACK because it&#39;s an improvement.</p><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">Not sure if t=
he purpose of the test is &quot;test that our own TLS stuff works&quot;,<br=
>or by contrast &quot;test that the system&#39;s default OpenSSL setting wo=
rks&quot;.<br>  In the former case, it might be suitable to ship an openssl=
.cnf for the test<br>that gets us a defined environment, or maybe run the t=
est twice once with system<br>default settings and once with an override to=
 see if _todays_ zealous SECLEVEL is it.</pre><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Of course the operating system or OpenSSL dis=
tro might kill our favorite cipher altogether, in which case we&#39;re dead=
 unless we override - but then the isolated<br>test case bears no relevance=
 for practical applicability of its results.</p></li></ul></li></ul><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1172?usp=3Demai=
l">change 1172</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1172?usp=3Demail"/><meta itemp=
rop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I327ecc9a85dd906517c28e71fe5=
00883bfa028a4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1172 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: mandree &lt;matthias.andree@...220...=
..68...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 08 Sep 2025 18:15:43=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--HSPxDIRVxss=--


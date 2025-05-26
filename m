From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 26 May 2025 21:07:40 +0000
In-Reply-To: <gerrit.1748268615000.I80a14b77fcc2fabf51af9f2d5ea0c36362cccb91@...2715...>
References: <gerrit.1748268615000.I80a14b77fcc2fabf51af9f2d5ea0c36362cccb91@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <81d1c34c9eb9f28080fcf1bacd3c6d2a2c3dc728-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zBt3m8YuuCc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Changes.rst: Collect, fix,
 and improve entries for 2.7 release
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--zBt3m8YuuCc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1032?usp=3Demail )

Change subject: Changes.rst: Collect, fix, and improve entries for 2.7 rele=
ase
......................................................................


Patch Set 1:

(3 comments)

Patchset:

PS1:
went through "git log", found a few things that I found noteworthy.  Too ti=
red for good tests right now.


File Changes.rst:

http://gerrit.openvpn.net/c/openvpn/+/1032/comment/1c2da85a_e3e58cd5 :
PS1, Line 42:
- Windows adapters (tap-windows6 or win-dco) are now created on demand

- windows automatic service now runs as fully unprivileged service user

- more detailed printing of negotiated TLS encryption/signing parameters, i=
ncluding post-quantum crypto (if the TLS library supports it) (5b7a1bc3)

- improve IPv6 handling and logging around `--port-share`

- support for the Haiku OS

- support loading `--key` and `--cert` from OpenSSL 3 provider URIs (3512e8=
d3)

- OpenVPN on Windows will now use WFP firewalling to implement `block-local=
`, ensuring full protection against TunnelCrack style attacks using rogue D=
HCP servers

- cmake build support on Windows (is that new in 2.7?)


http://gerrit.openvpn.net/c/openvpn/+/1032/comment/c256a799_54742242 :
PS1, Line 165: Overview of changes in 2.6
- Windows build version is now logged and send to server in IV_PLAT_VER var=
iable

- `redirect-gateway` now uses actual IPv4 route to VPN server, not just "de=
fault route".  Can be queried with `--show-gateway v4addr`. (9df51cf56 +3)

- support for the new `--dns` syntax is advertised to OpenVPN servers with =
the `IV_PROTO_DNS_OPTION_V2` flag value in `IV_PROTO`



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1032?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I80a14b77fcc2fabf51af9f2d5ea0c36362cccb91
Gerrit-Change-Number: 1032
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 26 May 2025 21:07:40 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--zBt3m8YuuCc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1032?usp=3Demail">View =
Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1032?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">went through &quot;git log&quot;, found a few t=
hings that I found noteworthy.  Too tired for good tests right now.</p></li=
></ul></li><li style=3D"margin: 0; padding: 0;"><p>File Changes.rst:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1032/comment/1c2da85a_e3e58cd5">Patch Set #1, Line 42:</=
a> <code style=3D"font-family:monospace,monospace"></code></p><ul><li>Windo=
ws adapters (tap-windows6 or win-dco) are now created on demand</li></ul><u=
l><li>windows automatic service now runs as fully unprivileged service user=
</li></ul><ul><li>more detailed printing of negotiated TLS encryption/signi=
ng parameters, including post-quantum crypto (if the TLS library supports i=
t) (5b7a1bc3)</li></ul><ul><li>improve IPv6 handling and logging around `--=
port-share`</li></ul><ul><li>support for the Haiku OS</li></ul><ul><li>supp=
ort loading `--key` and `--cert` from OpenSSL 3 provider URIs (3512e8d3)</l=
i></ul><ul><li>OpenVPN on Windows will now use WFP firewalling to implement=
 `block-local`, ensuring full protection against TunnelCrack style attacks =
using rogue DHCP servers</li></ul><ul><li>cmake build support on Windows (i=
s that new in 2.7?)</li></ul></li><li style=3D"margin: 0; padding: 0 0 0 16=
px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1032/comment/c256a799_54742242">Patch Set #1, Line 165:</a> <co=
de style=3D"font-family:monospace,monospace">Overview of changes in 2.6</co=
de></p><ul><li>Windows build version is now logged and send to server in IV=
_PLAT_VER variable</li></ul><ul><li>`redirect-gateway` now uses actual IPv4=
 route to VPN server, not just &quot;default route&quot;.  Can be queried w=
ith `--show-gateway v4addr`. (9df51cf56 +3)</li></ul><ul><li>support for th=
e new `--dns` syntax is advertised to OpenVPN servers with the `IV_PROTO_DN=
S_OPTION_V2` flag value in `IV_PROTO`</li></ul></li></ul></li></ul><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1032?usp=3Demail=
">change 1032</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1032?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I80a14b77fcc2fabf51af9f2d5ea=
0c36362cccb91 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1032 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 26 May 2025 21:07:40=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--zBt3m8YuuCc=--


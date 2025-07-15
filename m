From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 15 Jul 2025 09:28:34 +0000
In-Reply-To: <gerrit.1752062243000.I0f325800ebeb20bd5ef3ff78e5c5fcf0f6f74efd@...2715...>
References: <gerrit.1752062243000.I0f325800ebeb20bd5ef3ff78e5c5fcf0f6f74efd@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <7101a9d1073c52c9bbdd674d1ae4b35595b00c7c-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kwtX6Le/3xg="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Cleanup/simplify
 mbed TLS related define from autoconf
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--kwtX6Le/3xg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/1081?usp=3Demail )

Change subject: Cleanup/simplify mbed TLS related define from autoconf
......................................................................


Patch Set 7: Code-Review-2

(1 comment)

File configure.ac:

http://gerrit.openvpn.net/c/openvpn/+/1081/comment/00ff5884_aeb7bbcd :
PS7, Line 1041: 	AC_CHECK_HEADER(psa/crypto.h)
Needs to be AC_CHECK_HEADERS, otherwise HAVE_MBEDTLS_PSA_CRYPTO_H is never =
defined.

But this passed everywhere. So does this mean this whole check is useless?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1081?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0f325800ebeb20bd5ef3ff78e5c5fcf0f6f74efd
Gerrit-Change-Number: 1081
Gerrit-PatchSet: 7
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Tue, 15 Jul 2025 09:28:34 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--kwtX6Le/3xg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 7:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1081?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File configure.ac:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1081/comment/00ff5884_aeb7bbcd">Patch Set #7, Line 1041:</a> <=
code style=3D"font-family:monospace,monospace">	AC_CHECK_HEADER(psa/crypto.=
h)</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Nee=
ds to be AC_CHECK_HEADERS, otherwise HAVE_MBEDTLS_PSA_CRYPTO_H is never def=
ined.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">But thi=
s passed everywhere. So does this mean this whole check is useless?</p></li=
></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1081?usp=3Demail">change 1081</a>. To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">sett=
ings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1081?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0f325800ebeb20bd5ef3ff78e5c=
5fcf0f6f74efd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1081 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 15 Jul 2025 09:28:34=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--kwtX6Le/3xg=--


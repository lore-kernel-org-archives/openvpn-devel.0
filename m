From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 18 Oct 2023 10:45:38 +0000
In-Reply-To: <gerrit.1697562354000.I445a93e84dc54b865b757038d22318ac427fce96@...2715...>
References: <gerrit.1697562354000.I445a93e84dc54b865b757038d22318ac427fce96@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., max@...2606...
Message-ID: <6c864e5bf597a11489904bb4c7d48b5487b52086-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5VFDAA/nT2M="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add support for
 mbedtls 3.X.Y
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

--5VFDAA/nT2M=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/370?usp=3Demail )

Change subject: Add support for mbedtls 3.X.Y
......................................................................


Patch Set 1:

(1 comment)

Patchset:

PS1:
This fails currently in make check for me with 3.5.0:


2023-10-18 10:44:16 OpenVPN 2.7_git [git:mbed3/ef7e9ab6f8de88a0+] x86_64-pc=
-linux-gnu [SSL (mbed TLS)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] [DCO] b=
uilt on Oct 18 2023
2023-10-18 10:44:16 library versions: mbed TLS 3.5.0, LZO 2.10
2023-10-18 10:44:16 DCO version: N/A
2023-10-18 10:44:16 OpenVPN 2.7_git [git:mbed3/ef7e9ab6f8de88a0+] x86_64-pc=
-linux-gnu [SSL (mbed TLS)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] [DCO] b=
uilt on Oct 18 2023
2023-10-18 10:44:16 Entering OpenVPN crypto self-test mode.
2023-10-18 10:44:16 TESTING ENCRYPT/DECRYPT of packet length=3D1
2023-10-18 10:44:16 cipher_ctx_final:706: CIPHER - Bad input parameters
2023-10-18 10:44:16 Assertion failed at ../../../openvpn-git/src/openvpn/cr=
ypto.c:239 (cipher_ctx_final(ctx->cipher, BEND(&work), &outlen))
2023-10-18 10:44:16 Exiting due to fatal error
Testing cipher AES-256-CBC...  FAIL (RC=3D1)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/370?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I445a93e84dc54b865b757038d22318ac427fce96
Gerrit-Change-Number: 370
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Wed, 18 Oct 2023 10:45:38 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--5VFDAA/nT2M=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: MaxF. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/370?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/3=
70?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">This fails currently in make check for me with 3.5=
.0:</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;"><br>2023-=
10-18 10:44:16 OpenVPN 2.7_git [git:mbed3/ef7e9ab6f8de88a0+] x86_64-pc-linu=
x-gnu [SSL (mbed TLS)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] [DCO] built =
on Oct 18 2023<br>2023-10-18 10:44:16 library versions: mbed TLS 3.5.0, LZO=
 2.10<br>2023-10-18 10:44:16 DCO version: N/A<br>2023-10-18 10:44:16 OpenVP=
N 2.7_git [git:mbed3/ef7e9ab6f8de88a0+] x86_64-pc-linux-gnu [SSL (mbed TLS)=
] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] [DCO] built on Oct 18 2023<br>202=
3-10-18 10:44:16 Entering OpenVPN crypto self-test mode.<br>2023-10-18 10:4=
4:16 TESTING ENCRYPT/DECRYPT of packet length=3D1<br>2023-10-18 10:44:16 ci=
pher_ctx_final:706: CIPHER - Bad input parameters<br>2023-10-18 10:44:16 As=
sertion failed at ../../../openvpn-git/src/openvpn/crypto.c:239 (cipher_ctx=
_final(ctx-&gt;cipher, BEND(&amp;work), &amp;outlen))<br>2023-10-18 10:44:1=
6 Exiting due to fatal error<br>Testing cipher AES-256-CBC...  FAIL (RC=3D1=
)</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/370?usp=3Demail">change 370</a>. To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setting=
s">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
370?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I445a93e84dc54b865b757038d22=
318ac427fce96 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 370 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 18 Oct 2023 10:45:38=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--5VFDAA/nT2M=--


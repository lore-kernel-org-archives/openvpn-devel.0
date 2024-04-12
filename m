From: "syzzer (Code Review)" <gerrit@...515...>
Date: Fri, 12 Apr 2024 20:01:02 +0000
In-Reply-To: <gerrit.1706186293000.I00821d75342daf3f813b829812d648fe298bea81@...2715...>
References: <gerrit.1706186293000.I00821d75342daf3f813b829812d648fe298bea81@...2715...>
Reply-To: steffan@...1856..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b20330df24cace162b4238bc830ef619ab73314a-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7PonoMt/cVc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement support
 for AEAD tag at the end
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

--7PonoMt/cVc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

syzzer has posted comments on this change. ( http://gerrit.openvpn.net/c/op=
envpn/+/506?usp=3Demail )

Change subject: Implement support for AEAD tag at the end
......................................................................


Patch Set 4: Code-Review-1

(5 comments)

Patchset:

PS4:
I have always supported to place the tag at the end. It's easier to manage =
in hardware, is common practice and has no security impact.

The only real reservation I have is whether this should be combined with ot=
her protocol changes to prevent an explosion of possible wire formats. For =
example with a longer on-the-wire IV. Combining these would results in 2 po=
ssible AEAD wire formats, instead of 4. (Or 8, if there are plans for a lon=
ger peer-id, but not sure if that was just a typo in v1 or actually planned=
).

(And then there are a few nits, see comments.)


File src/openvpn/crypto.c:

http://gerrit.openvpn.net/c/openvpn/+/506/comment/6e399d5e_d094230c :
PS1, Line 426:     uint8_t *tag_ptr =3D NULL;
Not sure if the current static analyzers are smart enough to detect that th=
ese (non-const) variables are not used inside the error_exit label, but the=
y used to complain about jumping over an initialization. (What CRYPTO_ERROR=
 above does.)


http://gerrit.openvpn.net/c/openvpn/+/506/comment/281413d5_d34e727f :
PS1, Line 463:     ASSERT(buf_inc_len(&work, outlen));
Good to add a newline to visually separate the decryption from the authenti=
cation, but the buf_inc_len belongs to the decryption bit, right? Not the a=
uthentication bit.


File src/openvpn/ssl.h:

http://gerrit.openvpn.net/c/openvpn/+/506/comment/9b25b8a6_547ed983 :
PS1, Line 111: #define IV_PROTO_DATA_V3        (1<<10)
This means that this commit can only go in together with commits for a larg=
er peer id and larger IV, right?


File tests/unit_tests/openvpn/test_ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/506/comment/05d64456_0a9f2c26 :
PS4, Line 272: run_data_channel_with_cipher_end(const char *cipher)
s/end/tag_end/ ? (Or even tag_at_end)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/506?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I00821d75342daf3f813b829812d648fe298bea81
Gerrit-Change-Number: 506
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: syzzer <steffan@...1856...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Fri, 12 Apr 2024 20:01:02 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--7PonoMt/cVc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 4:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/506?usp=3Demail">Vi=
ew Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/506?tab=3Dcomments">Patch Set #4:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">I have always supported to place the tag at t=
he end. It&#39;s easier to manage in hardware, is common practice and has n=
o security impact.</p><p style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">The only real reservation I have is whether this should be combined w=
ith other protocol changes to prevent an explosion of possible wire formats=
. For example with a longer on-the-wire IV. Combining these would results i=
n 2 possible AEAD wire formats, instead of 4. (Or 8, if there are plans for=
 a longer peer-id, but not sure if that was just a typo in v1 or actually p=
lanned).</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">(And=
 then there are a few nits, see comments.)</p></li></ul></li><li style=3D"m=
argin: 0; padding: 0;"><p>File src/openvpn/crypto.c:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/506/comment/6e399d5e_d094230c">Patch Set #1, Line 426:</a> <code style=
=3D"font-family:monospace,monospace">    uint8_t *tag_ptr =3D NULL;</code><=
/p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Not sure if t=
he current static analyzers are smart enough to detect that these (non-cons=
t) variables are not used inside the error_exit label, but they used to com=
plain about jumping over an initialization. (What CRYPTO_ERROR above does.)=
</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/506/comment/2=
81413d5_d34e727f">Patch Set #1, Line 463:</a> <code style=3D"font-family:mo=
nospace,monospace">    ASSERT(buf_inc_len(&amp;work, outlen));</code></p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Good to add a newl=
ine to visually separate the decryption from the authentication, but the bu=
f_inc_len belongs to the decryption bit, right? Not the authentication bit.=
</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn=
/ssl.h:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/506/comment/9b25b8a6_547ed983">Patch Set #=
1, Line 111:</a> <code style=3D"font-family:monospace,monospace">#define IV=
_PROTO_DATA_V3        (1&lt;&lt;10)</code></p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">This means that this commit can only go in to=
gether with commits for a larger peer id and larger IV, right?</p></li></ul=
></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn=
/test_ssl.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/506/comment/05d64456_0a9f2c26">Patch =
Set #4, Line 272:</a> <code style=3D"font-family:monospace,monospace">run_d=
ata_channel_with_cipher_end(const char *cipher)</code></p><p style=3D"white=
-space: pre-wrap; word-wrap: break-word;">s/end/tag_end/ ? (Or even tag_at_=
end)</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/506?usp=3Demail">change 506</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/506?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I00821d75342daf3f813b829812d=
648fe298bea81 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 506 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: syzzer &lt;steffan@...1856...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 12 Apr 2024 20:01:02=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--7PonoMt/cVc=--


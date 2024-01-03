From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 3 Jan 2024 14:40:16 +0000
In-Reply-To: <gerrit.1701971374000.Ie5aa643ab6190262f7c8b9e614bedb398e85859b@...2715...>
References: <gerrit.1701971374000.Ie5aa643ab6190262f7c8b9e614bedb398e85859b@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <8b2f0582df29fadaa6e2fee3da5c4cf7a9973d30-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6BPfpQS2cdY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Use mingw compile
 definition also to unit tests
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6BPfpQS2cdY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/469?usp=3Demail )

Change subject: Use mingw compile definition also to unit tests
......................................................................


Patch Set 3:

(2 comments)

File CMakeLists.txt:

http://gerrit.openvpn.net/c/openvpn/+/469/comment/b683acf6_b1411977 :
PS3, Line 293:         target_compile_options(${target} PRIVATE -municode -=
UUNICODE)
> combining -municode with -UUNICODE and main(void) just means the -municod=
e has no effect at all. [=E2=80=A6]
I updated the patch to only use the same defines but not the -municode. Aft=
er looking up -U that it undefines UNICODE I am not really sure anymore why=
 we use that for the normal mingw build.


http://gerrit.openvpn.net/c/openvpn/+/469/comment/5b8769bf_b8607c4b :
PS3, Line 666:             target_compile_definitions(${test_name} PRIVATE =
-Dmain=3Dwmain)
> Yeah, just don't use -municode in the first place.
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/469?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie5aa643ab6190262f7c8b9e614bedb398e85859b
Gerrit-Change-Number: 469
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 03 Jan 2024 14:40:16 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--6BPfpQS2cdY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/469?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File CMakeLists.txt:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/469/comment/b683acf6_b1411977">Patch Set #3, Line 293:</a> <co=
de style=3D"font-family:monospace,monospace">        target_compile_options=
(${target} PRIVATE -municode -UUNICODE)</code></p><p><blockquote style=3D"b=
order-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">combining -mu=
nicode with -UUNICODE and main(void) just means the -municode has no effect=
 at all. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">I updated the patch to only use the same defines but n=
ot the -municode. After looking up -U that it undefines UNICODE I am not re=
ally sure anymore why we use that for the normal mingw build.</p></li><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/469/comment/5b8769bf_b8607c=
4b">Patch Set #3, Line 666:</a> <code style=3D"font-family:monospace,monosp=
ace">            target_compile_definitions(${test_name} PRIVATE -Dmain=3Dw=
main)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin=
: 10px 0; padding: 0 10px;">Yeah, just don&#39;t use -municode in the first=
 place.</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/469?usp=3Demail">change 469</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/469?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie5aa643ab6190262f7c8b9e614b=
edb398e85859b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 469 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 03 Jan 2024 14:40:16=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--6BPfpQS2cdY=--


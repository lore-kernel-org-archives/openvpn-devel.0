From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 23 Jan 2026 13:33:28 +0000
In-Reply-To: <gerrit.1765571645000.Ib251d546d993b96ed3bd8cb9111bcc627cdb0fae@...2715...>
References: <gerrit.1765571645000.Ib251d546d993b96ed3bd8cb9111bcc627cdb0fae@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., steffan@...1856..., max@...2606...
Message-ID: <7d3ca09c70a16e6b79ed66f91f1bab23f4c0eb1a-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nqLoFZ/euZg="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Add support for
 Mbed TLS 4
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: MaxF <max@...2606...>
Cc: flichtenheld <frank@...2641...>, syzzer <steffan@...1856...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nqLoFZ/euZg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, syzzer.

plaisthos has posted comments on this change by MaxF. ( http://gerrit.openv=
pn.net/c/openvpn/+/1441?usp=3Demail )

Change subject: Add support for Mbed TLS 4
......................................................................


Patch Set 7: Code-Review+2

(2 comments)

File src/openvpn/crypto_mbedtls.c:

http://gerrit.openvpn.net/c/openvpn/+/1441/comment/32a319ea_8293f4ed?usp=3D=
email :
PS7, Line 611:     { "SHA256", PSA_ALG_SHA_256 },
We probably want to a few more of the common algorithms here in a follow up=
 commit or in the next version of this commit. At least SHA384 and SHA512 a=
re pretty common and SHA224 wouldn't hurt either.

#define PSA_ALG_SHA3_224                        ((psa_algorithm_t) 0x020000=
10)
/** SHA3-256 */
#define PSA_ALG_SHA3_256                        ((psa_algorithm_t) 0x020000=
11)
/** SHA3-384 */
#define PSA_ALG_SHA3_384                        ((psa_algorithm_t) 0x020000=
12)
/** SHA3-512 */
#define PSA_ALG_SHA3_512                        ((psa_algorithm_t) 0x020000=
13)

seem also good candidates to already add here to future proof it a bit.


File src/openvpn/ssl_mbedtls.c:

http://gerrit.openvpn.net/c/openvpn/+/1441/comment/3877c185_ffe25e3e?usp=3D=
email :
PS7, Line 362:     { "X25519", MBEDTLS_SSL_IANA_TLS_GROUP_X25519 },
MBEDTLS_SSL_IANA_TLS_GROUP_X448 should also be added here I think.

Also secp521r1. For the european context in goverment stuff, often the brai=
n pool curves are also used, so I am surprised they are missing here.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1441?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib251d546d993b96ed3bd8cb9111bcc627cdb0fae
Gerrit-Change-Number: 1441
Gerrit-PatchSet: 7
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: syzzer <steffan@...1856...>
Gerrit-Attention: syzzer <steffan@...1856...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Fri, 23 Jan 2026 13:33:28 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--nqLoFZ/euZg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, syzzer. </p>
<p>Patch set 7:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1441?usp=3Demail">V=
iew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto_mbedtl=
s.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/1441/comment/32a319ea_8293f4ed?usp=3Demail">P=
atch Set #7, Line 611:</a> <code style=3D"font-family:monospace,monospace">=
    { &quot;SHA256&quot;, PSA_ALG_SHA_256 },</code></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">We probably want to=
 a few more of the common algorithms here in a follow up commit or in the n=
ext version of this commit. At least SHA384 and SHA512 are pretty common an=
d SHA224 wouldn&#39;t hurt either.</p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">#define PSA_ALG_SHA3_224            =
            ((psa_algorithm_t) 0x02000010)<br>/** SHA3-256 */<br>#define PS=
A_ALG_SHA3_256                        ((psa_algorithm_t) 0x02000011)<br>/**=
 SHA3-384 */<br>#define PSA_ALG_SHA3_384                        ((psa_algor=
ithm_t) 0x02000012)<br>/** SHA3-512 */<br>#define PSA_ALG_SHA3_512         =
               ((psa_algorithm_t) 0x02000013)</p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">seem also good candidate=
s to already add here to future proof it a bit.</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_mbedtls.c:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1441/comment/3877c185_ffe25e3e?usp=3Demail">Patch Set #7, Line=
 362:</a> <code style=3D"font-family:monospace,monospace">    { &quot;X2551=
9&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_X25519 },</code></p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">MBEDTLS_SSL_IANA_T=
LS_GROUP_X448 should also be added here I think.</p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Also secp521r1. For th=
e european context in goverment stuff, often the brain pool curves are also=
 used, so I am surprised they are missing here.</p></li></ul></li></ul><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1441?usp=3De=
mail">change 1441</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1441?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib251d546d993b96ed3bd8cb9111=
bcc627cdb0fae </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1441 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: syzzer &lt;steffan@...1856...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: syzzer &lt;steffan@...2115...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 23 Jan 2026 13:33:28=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--nqLoFZ/euZg=--


From: "MaxF (Code Review)" <gerrit@...515...>
Date: Mon, 15 Dec 2025 16:42:18 +0000
In-Reply-To: <gerrit.1765571645000.Ib251d546d993b96ed3bd8cb9111bcc627cdb0fae@...2715...>
References: <gerrit.1765571645000.Ib251d546d993b96ed3bd8cb9111bcc627cdb0fae@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, steffan@...1856...
Message-ID: <975886739af658761eb882b5f4a46a5d569bd3b2-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uCrGnMETwPI="; charset=UTF-8
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
Cc: syzzer <steffan@...1856...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--uCrGnMETwPI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, syzzer.

MaxF has posted comments on this change by MaxF. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/1441?usp=3Demail )

Change subject: Add support for Mbed TLS 4
......................................................................


Patch Set 3:

(3 comments)

File src/openvpn/crypto_mbedtls.c:

http://gerrit.openvpn.net/c/openvpn/+/1441/comment/31ee5c24_5c1a094c?usp=3D=
email :
PS3, Line 88: /* TODO: Complete the table. */
> Consider copying the table from the private mbedtls header file, might sa=
ve you some work. [=E2=80=A6]
I looked at it and I'm not sure how much it helps. The new PSA_KEY_TYPE and=
 PSA_ALG magic numbers don't seem to be in that table. I also don't know if=
 legacy crypto defines like MBEDTLS_AES_C are externally visible.


http://gerrit.openvpn.net/c/openvpn/+/1441/comment/26d91568_0d8c32b2?usp=3D=
email :
PS3, Line 204:     return (int)cipher_info->key_bytes;
> key_bytes is already int, right?
Right


http://gerrit.openvpn.net/c/openvpn/+/1441/comment/50b21610_ae2e0509?usp=3D=
email :
PS3, Line 299:     /* TODO: Log warning on errors? */
> We can't handle the error here. If this errors out, looks to me like we a=
re in an invalid state. [=E2=80=A6]
I added ASSERTs to this and similar functions.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1441?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib251d546d993b96ed3bd8cb9111bcc627cdb0fae
Gerrit-Change-Number: 1441
Gerrit-PatchSet: 3
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: syzzer <steffan@...1856...>
Gerrit-Attention: syzzer <steffan@...1856...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Mon, 15 Dec 2025 16:42:18 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: syzzer <steffan@...1856...>

--uCrGnMETwPI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, syzzer. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1441?usp=3Demail">View =
Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto_mbedtls.c:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/1441/comment/31ee5c24_5c1a094c?usp=3Demail">Patch=
 Set #3, Line 88:</a> <code style=3D"font-family:monospace,monospace">/* TO=
DO: Complete the table. */</code></p><p><blockquote style=3D"border-left: 1=
px solid #aaa; margin: 10px 0; padding: 0 10px;">Consider copying the table=
 from the private mbedtls header file, might save you some work. [=E2=80=A6=
]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">I looked at it and I&#39;m not sure how much it helps. T=
he new PSA_KEY_TYPE and PSA_ALG magic numbers don&#39;t seem to be in that =
table. I also don&#39;t know if legacy crypto defines like MBEDTLS_AES_C ar=
e externally visible.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1441/comment/26d91568_0d8c32b2?usp=3Demail">Patch Set #3, Line 204:=
</a> <code style=3D"font-family:monospace,monospace">    return (int)cipher=
_info-&gt;key_bytes;</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">key_bytes is already int, right?=
</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Right</p></li><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1441/comment/50b21610_ae2e0509?usp=3Demail">Patch Set #3, Line 29=
9:</a> <code style=3D"font-family:monospace,monospace">    /* TODO: Log war=
ning on errors? */</code></p><p><blockquote style=3D"border-left: 1px solid=
 #aaa; margin: 10px 0; padding: 0 10px;">We can&#39;t handle the error here=
. If this errors out, looks to me like we are in an invalid state. [=E2=80=
=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">I added ASSERTs to this and similar functions.</p></l=
i></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1441?usp=3Demail">change 1441</a>. To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1441?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib251d546d993b96ed3bd8cb9111=
bcc627cdb0fae </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1441 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: syzzer &lt;steffan@...1856...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: syzzer &lt;steffan@...2115...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 15 Dec 2025 16:42:18=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: syzzer &lt;steffan@...1852...=
6...&gt; </div>

</body></html>=

--uCrGnMETwPI=--


From: "syzzer (Code Review)" <gerrit@...515...>
Date: Mon, 15 Dec 2025 16:00:39 +0000
In-Reply-To: <gerrit.1765571645000.Ib251d546d993b96ed3bd8cb9111bcc627cdb0fae@...2715...>
References: <gerrit.1765571645000.Ib251d546d993b96ed3bd8cb9111bcc627cdb0fae@...2715...>
Reply-To: steffan@...1856..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, max@...2606...
Message-ID: <1d5a7750f5583926387befee0966826bc928a67f-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Vg3PLgeQXq4="; charset=UTF-8
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
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Vg3PLgeQXq4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, plaisthos.

syzzer has posted comments on this change by MaxF. ( http://gerrit.openvpn.=
net/c/openvpn/+/1441?usp=3Demail )

Change subject: Add support for Mbed TLS 4
......................................................................


Patch Set 3:

(5 comments)

Patchset:

PS3:
A few initials thoughts when glazing over part of the code.


File src/openvpn/crypto_mbedtls.c:

http://gerrit.openvpn.net/c/openvpn/+/1441/comment/ddbc1422_631be2a6?usp=3D=
email :
PS3, Line 88: /* TODO: Complete the table. */
Consider copying the table from the private mbedtls header file, might save=
 you some work. And complain with mbedtls that they broke a useful API...


http://gerrit.openvpn.net/c/openvpn/+/1441/comment/35ed3edf_fa15f561?usp=3D=
email :
PS3, Line 204:     return (int)cipher_info->key_bytes;
key_bytes is already int, right?


http://gerrit.openvpn.net/c/openvpn/+/1441/comment/eaf36ed8_1b9ab022?usp=3D=
email :
PS3, Line 292:     ALLOC_OBJ_CLEAR(ctx, cipher_ctx_t);
Good catch, adding the _CLEAR.


http://gerrit.openvpn.net/c/openvpn/+/1441/comment/b63901cc_f7bfd9e1?usp=3D=
email :
PS3, Line 299:     /* TODO: Log warning on errors? */
We can't handle the error here. If this errors out, looks to me like we are=
 in an invalid state. Consider ASSERT()'in out if it fails.



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
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Mon, 15 Dec 2025 16:00:39 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--Vg3PLgeQXq4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1441?usp=3Demail">View =
Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1441?tab=3Dcomments&amp;usp=3Demail">Patch Set #3:</a> </p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">A few initials=
 thoughts when glazing over part of the code.</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto_mbedtls.c:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1441/comment/ddbc1422_631be2a6?usp=3Demail">Patch Set #3, L=
ine 88:</a> <code style=3D"font-family:monospace,monospace">/* TODO: Comple=
te the table. */</code></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Consider copying the table from the private mbe=
dtls header file, might save you some work. And complain with mbedtls that =
they broke a useful API...</p></li><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1441/comment/35ed3edf_fa15f561?usp=3Demail">Patch Set #3, Line=
 204:</a> <code style=3D"font-family:monospace,monospace">    return (int)c=
ipher_info-&gt;key_bytes;</code></p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">key_bytes is already int, right?</p></=
li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1441/comment/eaf36e=
d8_1b9ab022?usp=3Demail">Patch Set #3, Line 292:</a> <code style=3D"font-fa=
mily:monospace,monospace">    ALLOC_OBJ_CLEAR(ctx, cipher_ctx_t);</code></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Good catch, adding the _CLEAR.</p></li><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1441/comment/b63901cc_f7bfd9e1?usp=3Demail">Patch Set #3=
, Line 299:</a> <code style=3D"font-family:monospace,monospace">    /* TODO=
: Log warning on errors? */</code></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">We can&#39;t handle the error here. =
If this errors out, looks to me like we are in an invalid state. Consider A=
SSERT()&#39;in out if it fails.</p></li></ul></li></ul><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/1441?usp=3Demail">change 144=
1</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1441?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 15 Dec 2025 16:00:39=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>=

--Vg3PLgeQXq4=--


From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 20 Nov 2024 19:56:59 +0000
In-Reply-To: <gerrit.1731290343000.I3a1c6561f4d9a69e2a441d49dff620b4258a1bcc@...2715...>
References: <gerrit.1731290343000.I3a1c6561f4d9a69e2a441d49dff620b4258a1bcc@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., max@...2606...
Message-ID: <75c1c258dac39b864977eb43f57ef620f15278a3-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qCSUov47g3U="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Implement HKDF
 expand function based on RFC 8446
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: MaxF <max@...2606...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qCSUov47g3U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/798?usp=3Demail )

Change subject: Implement HKDF expand function based on RFC 8446
......................................................................


Patch Set 4:

(5 comments)

Patchset:

PS4:
Thanks for the review.


File src/openvpn/crypto_epoch.h:

http://gerrit.openvpn.net/c/openvpn/+/798/comment/d8777d7c_f373c906 :
PS4, Line 32:  *  - salt is always assumed to be zero length (ie not suppor=
ted)
            :  *  - IKM (secret) is assumed to be always 32 bytes
> salt and IKM are arguments for HKDF-Extract, not HKDF-Expand.
You are right. I will remove those as they are not even parameters and we d=
on't use HDKF-Extract at all.


File src/openvpn/crypto_epoch.c:

http://gerrit.openvpn.net/c/openvpn/+/798/comment/496fe9e5_57694e82 :
PS4, Line 67:     hmac_ctx_cleanup(hmac_ctx);
            :     hmac_ctx_free(hmac_ctx);
> Not exactly about this commit itself, but looking at these functions, it'=
s not clear to me why we ne [=E2=80=A6]
mbed TLS needs both:

void
md_ctx_cleanup(mbedtls_md_context_t *ctx)
{
    mbedtls_md_free(ctx);
}


void
hmac_ctx_free(mbedtls_md_context_t *ctx)
{
    free(ctx);
}


They do different things and you need both otherwise you leave memory behin=
d.


http://gerrit.openvpn.net/c/openvpn/+/798/comment/38a2fb96_8e7628d3 :
PS4, Line 83:     }
> We could check label_len and context_len too: [=E2=80=A6]
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/798/comment/5ded05ce_c4d2d7a5 :
PS4, Line 86:     /* 2 byte for the outlen encoded as uint16, 5 bytes for "=
ovpn " */
            :     int hkdf_label_len =3D 2 + 5 + label_len + context_len;
            :     struct buffer hkdf_label =3D alloc_buf_gc(hkdf_label_len,=
 &gc);
            :
            :
            :     buf_write_u16(&hkdf_label, out_len);
            :     buf_write(&hkdf_label, "ovpn ", 5);
            :     buf_write(&hkdf_label, label, label_len);
            :     if (context_len > 0)
            :     {
            :         buf_write(&hkdf_label, context, context_len);
            :     }
> That's not exactly how this works. [=E2=80=A6]
Hm, I know what you are saying, at the same time, TLS 1.3 also doesn't add =
that extra byte for the context length:

https://datatracker.ietf.org/doc/html/rfc8446#section-7.1

I think the label and context is rather theorectical since we a) always hav=
e the same label and b) don't use context at all.

So I can just remove the possibility to use context from this function if t=
hat function if that makes things better. This was intended to do the same =
as TLS 1.3 just with "ovpn " instead of "tls13 "

I think what TLS RFC fails to mention and I also fail to mention is that yo=
u this label construction is a bit brittle in the sense that you have descr=
ibed, ie. you need to ensure that all the labels you are using this functio=
n with are not prefixes of each other.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/798?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3a1c6561f4d9a69e2a441d49dff620b4258a1bcc
Gerrit-Change-Number: 798
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Wed, 20 Nov 2024 19:56:59 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: MaxF <max@...2606...>
Gerrit-MessageType: comment

--qCSUov47g3U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: MaxF, flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/798?usp=3Demail">View C=
hange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
798?tab=3Dcomments">Patch Set #4:</a> </p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Thanks for the review.</p></li></ul></li><li styl=
e=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto_epoch.h:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/798/comment/d8777d7c_f373c906">Patch Set #4, Line 32:</a> </=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;"><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"> *  - salt is always assumed to be zero length (ie not supported=
)<br> *  - IKM (secret) is assumed to be always 32 bytes<br></pre></blockqu=
ote></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;">salt and IKM are arguments for HKDF-Extract, not HKDF-E=
xpand.</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-=
word;">You are right. I will remove those as they are not even parameters a=
nd we don&#39;t use HDKF-Extract at all.</p></li></ul></li><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/crypto_epoch.c:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/798/comment/496fe9e5_57694e82">Patch Set #4, Line 67:</a> </p><p><bl=
ockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 1=
0px;"><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">    hmac_ctx_cleanup(hmac_ctx);<br>    hmac_ctx_free(hmac_ctx);<br></pre=
></blockquote></p><p><blockquote style=3D"border-left: 1px solid #aaa; marg=
in: 10px 0; padding: 0 10px;">Not exactly about this commit itself, but loo=
king at these functions, it&#39;s not clear to me why we ne [=E2=80=A6]</bl=
ockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">mbe=
d TLS needs both:</p><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">void<br>md_ctx_cleanup(mbedtls_md_context_t *ctx)<br>{<br=
>    mbedtls_md_free(ctx);<br>}</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><br>void<br>hmac_ctx_free(mbedtls_md_cont=
ext_t *ctx)<br>{<br>    free(ctx);<br>}</pre><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;"><br>They do different things and you need both=
 otherwise you leave memory behind.</p></li><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/798/comment/38a2fb96_8e7628d3">Patch Set #4, Line 83:=
</a> <code style=3D"font-family:monospace,monospace">    }</code></p><p><bl=
ockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 1=
0px;">We could check label_len and context_len too: [=E2=80=A6]</blockquote=
></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledge=
d</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/798/comment/=
5ded05ce_c4d2d7a5">Patch Set #4, Line 86:</a> </p><p><blockquote style=3D"b=
order-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">    /* 2 byte fo=
r the outlen encoded as uint16, 5 bytes for &quot;ovpn &quot; */<br>    int=
 hkdf_label_len =3D 2 + 5 + label_len + context_len;<br>    struct buffer h=
kdf_label =3D alloc_buf_gc(hkdf_label_len, &amp;gc);<br><br><br>    buf_wri=
te_u16(&amp;hkdf_label, out_len);<br>    buf_write(&amp;hkdf_label, &quot;o=
vpn &quot;, 5);<br>    buf_write(&amp;hkdf_label, label, label_len);<br>   =
 if (context_len &gt; 0)<br>    {<br>        buf_write(&amp;hkdf_label, con=
text, context_len);<br>    }<br></pre></blockquote></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">That&#39=
;s not exactly how this works. [=E2=80=A6]</blockquote></p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Hm, I know what you are saying, =
at the same time, TLS 1.3 also doesn&#39;t add that extra byte for the cont=
ext length:</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">h=
ttps://datatracker.ietf.org/doc/html/rfc8446#section-7.1</p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">I think the label and context i=
s rather theorectical since we a) always have the same label and b) don&#39=
;t use context at all.</p><p style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">So I can just remove the possibility to use context from this fun=
ction if that function if that makes things better. This was intended to do=
 the same as TLS 1.3 just with &quot;ovpn &quot; instead of &quot;tls13 &qu=
ot;</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">I think w=
hat TLS RFC fails to mention and I also fail to mention is that you this la=
bel construction is a bit brittle in the sense that you have described, ie.=
 you need to ensure that all the labels you are using this function with ar=
e not prefixes of each other.</p></li></ul></li></ul><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/798?usp=3Demail">change 798</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/798?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3a1c6561f4d9a69e2a441d49dff=
620b4258a1bcc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 798 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 20 Nov 2024 19:56:59=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: MaxF &lt;max@...2606...&g=
t; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--qCSUov47g3U=--


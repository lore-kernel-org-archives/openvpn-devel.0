From: "MaxF (Code Review)" <gerrit@...515...>
Date: Wed, 20 Nov 2024 16:48:24 +0000
In-Reply-To: <gerrit.1731290343000.I3a1c6561f4d9a69e2a441d49dff620b4258a1bcc@...2715...>
References: <gerrit.1731290343000.I3a1c6561f4d9a69e2a441d49dff620b4258a1bcc@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4e09c14977bb69df482262d57813d7a0412f4652-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YmFy/BVmmFA="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YmFy/BVmmFA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

MaxF has posted comments on this change. ( http://gerrit.openvpn.net/c/open=
vpn/+/798?usp=3Demail )

Change subject: Implement HKDF expand function based on RFC 8446
......................................................................


Patch Set 4: Code-Review-2

(5 comments)

Patchset:

PS4:
The implementation of HKDF-Expand is correct, but the implementation of HKD=
F-Expand-Label is slightly wrong in a way that causes different (label, con=
text) pairs to produce identical keys (in a predictable way).

Another thing: Are there any plans to actually use the context argument?


File src/openvpn/crypto_epoch.h:

http://gerrit.openvpn.net/c/openvpn/+/798/comment/152f282d_bc633665 :
PS4, Line 32:  *  - salt is always assumed to be zero length (ie not suppor=
ted)
            :  *  - IKM (secret) is assumed to be always 32 bytes
salt and IKM are arguments for HKDF-Extract, not HKDF-Expand.


File src/openvpn/crypto_epoch.c:

http://gerrit.openvpn.net/c/openvpn/+/798/comment/006aedfa_6f857acd :
PS4, Line 67:     hmac_ctx_cleanup(hmac_ctx);
            :     hmac_ctx_free(hmac_ctx);
Not exactly about this commit itself, but looking at these functions, it's =
not clear to me why we need both. The doc comments for both say "free the H=
MAC context".


http://gerrit.openvpn.net/c/openvpn/+/798/comment/ea9a9a5f_e4e2916c :
PS4, Line 83:     }
We could check label_len and context_len too:
* label_len <=3D 250 (because the total length including prefix must be <=
=3D 255)
* context_len <=3D 255


http://gerrit.openvpn.net/c/openvpn/+/798/comment/b32d3125_e4ee1228 :
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
That's not exactly how this works. When an RFC specifies a variable-length =
array, it has to be prefixed with a fixed-size length field. In this case, =
the maximum length for label and context is 255 each, so the length fields =
are 1 byte. See RFC 1832.

That means hkdf_label_len =3D 2 + 1 + 5 + label_len + 1 + context_len.

The label needs to be prefixed with label_len + 5 (the prefix is counted), =
the context is prefixed with context_len.

Otherwise, the inputs would be ambiguous: label =3D "abcdef", context =3D "=
" and label =3D "abc", context =3D "def" would give the same result.



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
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 20 Nov 2024 16:48:24 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--YmFy/BVmmFA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 4:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/798?usp=3Demail">Vi=
ew Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/798?tab=3Dcomments">Patch Set #4:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">The implementation of HKDF-Expand is correct,=
 but the implementation of HKDF-Expand-Label is slightly wrong in a way tha=
t causes different (label, context) pairs to produce identical keys (in a p=
redictable way).</p><p style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">Another thing: Are there any plans to actually use the context argument=
?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvp=
n/crypto_epoch.h:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/798/comment/152f282d_bc633665">=
Patch Set #4, Line 32:</a> </p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;"><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"> *  - salt is always assumed to be =
zero length (ie not supported)<br> *  - IKM (secret) is assumed to be alway=
s 32 bytes<br></pre></blockquote></p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">salt and IKM are arguments for HKDF-Extract, not HKDF-=
Expand.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/=
openvpn/crypto_epoch.c:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/798/comment/006aedfa_6f857=
acd">Patch Set #4, Line 67:</a> </p><p><blockquote style=3D"border-left: 1p=
x solid #aaa; margin: 10px 0; padding: 0 10px;"><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">    hmac_ctx_cleanup(hmac_ctx)=
;<br>    hmac_ctx_free(hmac_ctx);<br></pre></blockquote></p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Not exactly about this commit i=
tself, but looking at these functions, it&#39;s not clear to me why we need=
 both. The doc comments for both say &quot;free the HMAC context&quot;.</p>=
</li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/798/comment/ea9a9=
a5f_e4e2916c">Patch Set #4, Line 83:</a> <code style=3D"font-family:monospa=
ce,monospace">    }</code></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">We could check label_len and context_len too:</p><ul><li>labe=
l_len &lt;=3D 250 (because the total length including prefix must be &lt;=
=3D 255)</li><li>context_len &lt;=3D 255</li></ul></li><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/798/comment/b32d3125_e4ee1228">Patch Set #=
4, Line 86:</a> </p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;"><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">    /* 2 byte for the outlen encoded as uint16=
, 5 bytes for &quot;ovpn &quot; */<br>    int hkdf_label_len =3D 2 + 5 + la=
bel_len + context_len;<br>    struct buffer hkdf_label =3D alloc_buf_gc(hkd=
f_label_len, &amp;gc);<br><br><br>    buf_write_u16(&amp;hkdf_label, out_le=
n);<br>    buf_write(&amp;hkdf_label, &quot;ovpn &quot;, 5);<br>    buf_wri=
te(&amp;hkdf_label, label, label_len);<br>    if (context_len &gt; 0)<br>  =
  {<br>        buf_write(&amp;hkdf_label, context, context_len);<br>    }<b=
r></pre></blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">That&#39;s not exactly how this works. When an RFC specifies a var=
iable-length array, it has to be prefixed with a fixed-size length field. I=
n this case, the maximum length for label and context is 255 each, so the l=
ength fields are 1 byte. See RFC 1832.</p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">That means hkdf_label_len =3D 2 + 1 + 5 + label_l=
en + 1 + context_len.</p><p style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">The label needs to be prefixed with label_len + 5 (the prefix is c=
ounted), the context is prefixed with context_len.</p><p style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Otherwise, the inputs would be ambigu=
ous: label =3D &quot;abcdef&quot;, context =3D &quot;&quot; and label =3D &=
quot;abc&quot;, context =3D &quot;def&quot; would give the same result.</p>=
</li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/798?usp=3Demail">change 798</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">se=
ttings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/798?u=
sp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 20 Nov 2024 16:48:24=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--YmFy/BVmmFA=--


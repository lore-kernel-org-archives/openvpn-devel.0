From: "MaxF (Code Review)" <gerrit@...515...>
Date: Wed, 20 Nov 2024 21:28:48 +0000
In-Reply-To: <gerrit.1731290343000.I3a1c6561f4d9a69e2a441d49dff620b4258a1bcc@...2715...>
References: <gerrit.1731290343000.I3a1c6561f4d9a69e2a441d49dff620b4258a1bcc@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0a1ec4991ef92c812b75b2e4de699265939232e7-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7C0hTuPcp00="; charset=UTF-8
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

--7C0hTuPcp00=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

MaxF has posted comments on this change. ( http://gerrit.openvpn.net/c/open=
vpn/+/798?usp=3Demail )

Change subject: Implement HKDF expand function based on RFC 8446
......................................................................


Patch Set 4:

(1 comment)

File src/openvpn/crypto_epoch.c:

http://gerrit.openvpn.net/c/openvpn/+/798/comment/66b3a85e_5d30ac1a :
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
> Hm, I know what you are saying, at the same time, TLS 1. [=E2=80=A6]
TLS 1.3 does use length fields here, it's implied by the "opaque label<7..2=
55>" notation.

You can look at the implementations in OpenSSL or mbed TLS. For example, se=
e ssl_tls13_hkdf_encode_label() in https://github.com/Mbed-TLS/mbedtls/blob=
/development/library/ssl_tls13_keys.c

Removing the context argument and otherwise leaving the function as-is is f=
ine.



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
Gerrit-Comment-Date: Wed, 20 Nov 2024 21:28:48 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Comment-In-Reply-To: MaxF <max@...2606...>
Gerrit-MessageType: comment

--7C0hTuPcp00=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/798?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto_epoch.c:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/798/comment/66b3a85e_5d30ac1a">Patch Set #4, Line 86:=
</a> </p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;"><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">    /* 2 byte for the outlen encoded as uint16, 5 bytes f=
or &quot;ovpn &quot; */<br>    int hkdf_label_len =3D 2 + 5 + label_len + c=
ontext_len;<br>    struct buffer hkdf_label =3D alloc_buf_gc(hkdf_label_len=
, &amp;gc);<br><br><br>    buf_write_u16(&amp;hkdf_label, out_len);<br>    =
buf_write(&amp;hkdf_label, &quot;ovpn &quot;, 5);<br>    buf_write(&amp;hkd=
f_label, label, label_len);<br>    if (context_len &gt; 0)<br>    {<br>    =
    buf_write(&amp;hkdf_label, context, context_len);<br>    }<br></pre></b=
lockquote></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: =
10px 0; padding: 0 10px;">Hm, I know what you are saying, at the same time,=
 TLS 1. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word=
-wrap: break-word;">TLS 1.3 does use length fields here, it&#39;s implied b=
y the &quot;opaque label&lt;7..255&gt;&quot; notation.</p><p style=3D"white=
-space: pre-wrap; word-wrap: break-word;">You can look at the implementatio=
ns in OpenSSL or mbed TLS. For example, see ssl_tls13_hkdf_encode_label() i=
n https://github.com/Mbed-TLS/mbedtls/blob/development/library/ssl_tls13_ke=
ys.c</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Removing=
 the context argument and otherwise leaving the function as-is is fine.</p>=
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
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 20 Nov 2024 21:28:48=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: MaxF &lt;max@...2606...&g=
t; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--7C0hTuPcp00=--


From: "MaxF (Code Review)" <gerrit@...515...>
Date: Sat, 23 Nov 2024 00:00:15 +0000
In-Reply-To: <gerrit.1731290343000.I3a1c6561f4d9a69e2a441d49dff620b4258a1bcc@...2715...>
References: <gerrit.1731290343000.I3a1c6561f4d9a69e2a441d49dff620b4258a1bcc@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <9c0818170654bbcd878b4faceb360545fa6aeb08-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/4f72QFVhlk="; charset=UTF-8
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

--/4f72QFVhlk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

MaxF has posted comments on this change. ( http://gerrit.openvpn.net/c/open=
vpn/+/798?usp=3Demail )

Change subject: Implement HKDF expand function based on RFC 8446
......................................................................


Patch Set 5: -Code-Review

(5 comments)

Patchset:

PS5:
The ovpn_expand_label() function looks good to me now. I have some nitpicks=
 but it should work correctly. Also, I really like that you added a test to=
 see that it produces the same result as OpenSSL!


File src/openvpn/crypto_epoch.c:

http://gerrit.openvpn.net/c/openvpn/+/798/comment/4f1de082_54f44df5 :
PS4, Line 67:     hmac_ctx_cleanup(hmac_ctx);
            :     hmac_ctx_free(hmac_ctx);
> mbed TLS needs both: [=E2=80=A6]
Makes sense!


http://gerrit.openvpn.net/c/openvpn/+/798/comment/a592ddf7_ad5c9cd2 :
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
> Yeah, you are right. [=E2=80=A6]
I agree, it's a good idea to keep it close to the TLS standard. Also makes =
it easier if someone else is going to review it in the future.

The current implementation looks good to me!


File src/openvpn/crypto_epoch.c:

http://gerrit.openvpn.net/c/openvpn/+/798/comment/2574664f_9fe72c38 :
PS5, Line 89:     int hkdf_label_len =3D 2 + 5 + 1 + label_len + 1 + contex=
t_len;
            :     struct buffer hkdf_label =3D alloc_buf_gc(hkdf_label_len,=
 &gc);
            :
            :     const uint8_t *label_prefix =3D (const uint8_t *) ("ovpn =
");
            :     int prefix_len =3D 5;
You could move the prefix_len declaration up and replace the "5" in hkdf_la=
bel_len with it.


http://gerrit.openvpn.net/c/openvpn/+/798/comment/effb4ac6_eb381832 :
PS5, Line 101:     if (context_len > 0)
             :     {
             :         buf_write(&hkdf_label, context, context_len);
             :     }
Why do we need this check? buf_write() doesn't do anything if context_len i=
s 0 right?

(And if it's needed, why is it not needed for label?)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/798?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3a1c6561f4d9a69e2a441d49dff620b4258a1bcc
Gerrit-Change-Number: 798
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Sat, 23 Nov 2024 00:00:15 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Comment-In-Reply-To: MaxF <max@...2606...>
Gerrit-MessageType: comment

--/4f72QFVhlk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 5:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ddd;">-Code-Review</span></p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/798?usp=3Demail">View Ch=
ange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/7=
98?tab=3Dcomments">Patch Set #5:</a> </p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">The ovpn_expand_label() function looks good to me =
now. I have some nitpicks but it should work correctly. Also, I really like=
 that you added a test to see that it produces the same result as OpenSSL!<=
/p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/=
crypto_epoch.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/798/comment/4f1de082_54f44df5">Pa=
tch Set #4, Line 67:</a> </p><p><blockquote style=3D"border-left: 1px solid=
 #aaa; margin: 10px 0; padding: 0 10px;"><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">    hmac_ctx_cleanup(hmac_ctx);<br>  =
  hmac_ctx_free(hmac_ctx);<br></pre></blockquote></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">mbed TLS=
 needs both: [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Makes sense!</p></li><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/798/comment/a592ddf7_ad5c9cd2">Patch Set #4, Line 8=
6:</a> </p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;"><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">    /* 2 byte for the outlen encoded as uint16, 5 bytes=
 for &quot;ovpn &quot; */<br>    int hkdf_label_len =3D 2 + 5 + label_len +=
 context_len;<br>    struct buffer hkdf_label =3D alloc_buf_gc(hkdf_label_l=
en, &amp;gc);<br><br><br>    buf_write_u16(&amp;hkdf_label, out_len);<br>  =
  buf_write(&amp;hkdf_label, &quot;ovpn &quot;, 5);<br>    buf_write(&amp;h=
kdf_label, label, label_len);<br>    if (context_len &gt; 0)<br>    {<br>  =
      buf_write(&amp;hkdf_label, context, context_len);<br>    }<br></pre><=
/blockquote></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin=
: 10px 0; padding: 0 10px;">Yeah, you are right. [=E2=80=A6]</blockquote></=
p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">I agree, it&#3=
9;s a good idea to keep it close to the TLS standard. Also makes it easier =
if someone else is going to review it in the future.</p><p style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">The current implementation looks go=
od to me!</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File sr=
c/openvpn/crypto_epoch.c:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/798/comment/2574664f_9fe=
72c38">Patch Set #5, Line 89:</a> </p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;"><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">    int hkdf_label_len =3D 2=
 + 5 + 1 + label_len + 1 + context_len;<br>    struct buffer hkdf_label =3D=
 alloc_buf_gc(hkdf_label_len, &amp;gc);<br><br>    const uint8_t *label_pre=
fix =3D (const uint8_t *) (&quot;ovpn &quot;);<br>    int prefix_len =3D 5;=
<br></pre></blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">You could move the prefix_len declaration up and replace the &qu=
ot;5&quot; in hkdf_label_len with it.</p></li><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/798/comment/effb4ac6_eb381832">Patch Set #5, Line 1=
01:</a> </p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10=
px 0; padding: 0 10px;"><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">    if (context_len &gt; 0)<br>    {<br>        buf_wr=
ite(&amp;hkdf_label, context, context_len);<br>    }<br></pre></blockquote>=
</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Why do we ne=
ed this check? buf_write() doesn&#39;t do anything if context_len is 0 righ=
t?</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">(And if it=
&#39;s needed, why is it not needed for label?)</p></li></ul></li></ul><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/798?usp=3Dem=
ail">change 798</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/798?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3a1c6561f4d9a69e2a441d49dff=
620b4258a1bcc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 798 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 23 Nov 2024 00:00:15=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: MaxF &lt;max@...2606...&g=
t; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--/4f72QFVhlk=--


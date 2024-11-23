From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Sat, 23 Nov 2024 21:04:00 +0000
In-Reply-To: <gerrit.1731290343000.I3a1c6561f4d9a69e2a441d49dff620b4258a1bcc@...2715...>
References: <gerrit.1731290343000.I3a1c6561f4d9a69e2a441d49dff620b4258a1bcc@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., max@...2606...
Message-ID: <2d40e3d74531cb410220e679cfbd529cf6f9674a-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0m2gt25QJRs="; charset=UTF-8
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

--0m2gt25QJRs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/798?usp=3Demail )

Change subject: Implement HKDF expand function based on RFC 8446
......................................................................


Patch Set 6:

(3 comments)

File src/openvpn/crypto_epoch.h:

http://gerrit.openvpn.net/c/openvpn/+/798/comment/4094583d_be1b5fbb :
PS4, Line 32:  *  - salt is always assumed to be zero length (ie not suppor=
ted)
            :  *  - IKM (secret) is assumed to be always 32 bytes
> You are right. [=E2=80=A6]
Done


File src/openvpn/crypto_epoch.c:

http://gerrit.openvpn.net/c/openvpn/+/798/comment/3d0b791f_15e4f6e5 :
PS5, Line 89:     int hkdf_label_len =3D 2 + 5 + 1 + label_len + 1 + contex=
t_len;
            :     struct buffer hkdf_label =3D alloc_buf_gc(hkdf_label_len,=
 &gc);
            :
            :     const uint8_t *label_prefix =3D (const uint8_t *) ("ovpn =
");
            :     int prefix_len =3D 5;
> You could move the prefix_len declaration up and replace the "5" in hkdf_=
label_len with it.
Done


http://gerrit.openvpn.net/c/openvpn/+/798/comment/0f194e22_472a8009 :
PS5, Line 101:     if (context_len > 0)
             :     {
             :         buf_write(&hkdf_label, context, context_len);
             :     }
> Why do we need this check? buf_write() doesn't do anything if context_len=
 is 0 right? [=E2=80=A6]
label is supposed to always at least 1 character. I added a check for that.

buf_write will still call memcpy with a 0 and at least according to C stand=
ard the pointer must still be valid so I wanted to be safe.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/798?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3a1c6561f4d9a69e2a441d49dff620b4258a1bcc
Gerrit-Change-Number: 798
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Sat, 23 Nov 2024 21:04:00 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Comment-In-Reply-To: MaxF <max@...2606...>
Gerrit-MessageType: comment

--0m2gt25QJRs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: MaxF, flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/798?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto_epoch.h:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/798/comment/4094583d_be1b5fbb">Patch Set #4, Line 32=
:</a> </p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px=
 0; padding: 0 10px;"><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"> *  - salt is always assumed to be zero length (ie not s=
upported)<br> *  - IKM (secret) is assumed to be always 32 bytes<br></pre><=
/blockquote></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin=
: 10px 0; padding: 0 10px;">You are right. [=E2=80=A6]</blockquote></p><p s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></=
li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto_epoch.c:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/798/comment/3d0b791f_15e4f6e5">Patch Set #5, Line=
 89:</a> </p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 1=
0px 0; padding: 0 10px;"><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">    int hkdf_label_len =3D 2 + 5 + 1 + label_len + 1 =
+ context_len;<br>    struct buffer hkdf_label =3D alloc_buf_gc(hkdf_label_=
len, &amp;gc);<br><br>    const uint8_t *label_prefix =3D (const uint8_t *)=
 (&quot;ovpn &quot;);<br>    int prefix_len =3D 5;<br></pre></blockquote></=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;">You could move the prefix_len declaration up and replace the =
&quot;5&quot; in hkdf_label_len with it.</blockquote></p><p style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/798/comment/0f194e22_472a8009">Patch Set #5=
, Line 101:</a> </p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;"><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">    if (context_len &gt; 0)<br>    {<br>      =
  buf_write(&amp;hkdf_label, context, context_len);<br>    }<br></pre></blo=
ckquote></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10=
px 0; padding: 0 10px;">Why do we need this check? buf_write() doesn&#39;t =
do anything if context_len is 0 right? [=E2=80=A6]</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">label is supposed to alw=
ays at least 1 character. I added a check for that.</p><p style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">buf_write will still call memcpy wit=
h a 0 and at least according to C standard the pointer must still be valid =
so I wanted to be safe.</p></li></ul></li></ul><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/798?usp=3Demail">change 798</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/798?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3a1c6561f4d9a69e2a441d49dff=
620b4258a1bcc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 798 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 23 Nov 2024 21:04:00=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: MaxF &lt;max@...2606...&g=
t; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--0m2gt25QJRs=--


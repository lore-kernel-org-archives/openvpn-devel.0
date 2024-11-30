From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Sat, 30 Nov 2024 12:41:23 +0000
In-Reply-To: <gerrit.1731290343000.I4a981c5a70717e2276d89bf83a06c7fdbe6712d7@...2715...>
References: <gerrit.1731290343000.I4a981c5a70717e2276d89bf83a06c7fdbe6712d7@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <b1e1bfef0e8ab7f214a0536f45cb0d4bbd37be1f-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7afyTe14qzI="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change API of
 init_key_ctx to use struct key_paramters
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--7afyTe14qzI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/801?usp=3Demail )

Change subject: Change API of init_key_ctx to use struct key_paramters
......................................................................


Patch Set 5:

(6 comments)

Patchset:

PS5:
thanks for the review


File src/openvpn/crypto.h:

http://gerrit.openvpn.net/c/openvpn/+/801/comment/8d53de3a_4d1c5e54 :
PS5, Line 158: /** internal structure similar to struct key that hold key i=
nformation
> "holds"
Done


File src/openvpn/crypto.c:

http://gerrit.openvpn.net/c/openvpn/+/801/comment/ce856d23_fcfbd114 :
PS5, Line 902: ,
> Needs update
Done


http://gerrit.openvpn.net/c/openvpn/+/801/comment/a387265a_62cbf33e :
PS5, Line 915: impl_iv_len
> Change to `ASSERT(impl_iv_len <=3D key->hmac_size);` to keep consistency
Done


http://gerrit.openvpn.net/c/openvpn/+/801/comment/0fbf3998_33a8a7fa :
PS5, Line 1128:     key_params->cipher_size =3D MAX_HMAC_KEY_LENGTH;
> `MAX_CIPHER_KEY_LENGTH`
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/801/comment/e070181c_273bb98a :
PS5, Line 1129: MAX_CIPHER_KEY_LENGTH
> `MAX_HMAC_KEY_LENGTH`
Acknowledged



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/801?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4a981c5a70717e2276d89bf83a06c7fdbe6712d7
Gerrit-Change-Number: 801
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Sat, 30 Nov 2024 12:41:23 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--7afyTe14qzI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/801?usp=3Demail">View C=
hange</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
801?tab=3Dcomments">Patch Set #5:</a> </p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">thanks for the review</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto.h:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/801/comment/8d53de3a_4d1c5e54">Patch Set #5, Line 158:</a> <code st=
yle=3D"font-family:monospace,monospace">/** internal structure similar to s=
truct key that hold key information</code></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;holds&quot;=
</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/op=
envpn/crypto.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/801/comment/ce856d23_fcfbd114">Pa=
tch Set #5, Line 902:</a> <code style=3D"font-family:monospace,monospace">,=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">Needs update</blockquote></p><p style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/801/comment/a387265a_62cbf33e">Patch Set #5, Lin=
e 915:</a> <code style=3D"font-family:monospace,monospace">impl_iv_len</cod=
e></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; =
padding: 0 10px;">Change to `ASSERT(impl_iv_len &lt;=3D key-&gt;hmac_size);=
` to keep consistency</blockquote></p><p style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/801/comment/0fbf3998_33a8a7fa">Patch Set #5, Line 1128:</a> <c=
ode style=3D"font-family:monospace,monospace">    key_params-&gt;cipher_siz=
e =3D MAX_HMAC_KEY_LENGTH;</code></p><p><blockquote style=3D"border-left: 1=
px solid #aaa; margin: 10px 0; padding: 0 10px;">`MAX_CIPHER_KEY_LENGTH`</b=
lockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Ac=
knowledged</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/8=
01/comment/e070181c_273bb98a">Patch Set #5, Line 1129:</a> <code style=3D"f=
ont-family:monospace,monospace">MAX_CIPHER_KEY_LENGTH</code></p><p><blockqu=
ote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
>`MAX_HMAC_KEY_LENGTH`</blockquote></p><p style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">Acknowledged</p></li></ul></li></ul><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/801?usp=3Demail">change =
801</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/801?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4a981c5a70717e2276d89bf83a0=
6c7fdbe6712d7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 801 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 30 Nov 2024 12:41:23=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--7afyTe14qzI=--


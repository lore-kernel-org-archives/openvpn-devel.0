From: "ordex (Code Review)" <gerrit@...515...>
Date: Tue, 12 Nov 2024 08:26:21 +0000
In-Reply-To: <gerrit.1731290343000.I74216d776d3e0a8dc987ec7b1671c8e8dcccdbd6@...2715...>
References: <gerrit.1731290343000.I74216d776d3e0a8dc987ec7b1671c8e8dcccdbd6@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <0a187d4df9f8d832aef1ef71a2925be2d0ef7ee6-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4KyaiGyJq6M="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Use XOR instead of
 concatenation for calculation of IV from implicit IV
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: cron2 <gert@...1296...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--4KyaiGyJq6M=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

ordex has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/797?usp=3Demail )

Change subject: Use XOR instead of concatenation for calculation of  IV fro=
m implicit IV
......................................................................


Patch Set 2:

(5 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/797/comment/b59359cf_8e31314e :
PS2, Line 12: IV generation code later.
Question: what is the advantage or XOR'ing the IV with the packet ID? And w=
hy is the implicit IV growing from 32bits to 64?


File src/openvpn/crypto.h:

http://gerrit.openvpn.net/c/openvpn/+/797/comment/c99a7cfb_275919d0 :
PS2, Line 168:     size_t implicit_iv_len;     /**< The length of implicit_=
iv */
why is the len being removed? What is the underlying assumption allowing us=
 to drop the len?

My wild wild guess: implicit IV len =3D=3D packet ID size. Is that correct?


http://gerrit.openvpn.net/c/openvpn/+/797/comment/a758a11d_0ceb58dd :
PS2, Line 173:     uint8_t implicit_iv[OPENVPN_MAX_IV_LENGTH];
I believe I understand the comment above, but I have troubles combining it =
with OPENVPN_MAX_IV_LENGTH that is 128 bits with OpenSSL.
Does it mean we actually only fill part of the array when using AEAD (i.e. =
32 bits)?
Is this going to change with the new format and become 64 bits?
Is the rest of the array therefore unused?

Maybe this is explained somewhere else, but this comment alone leaves me wi=
th these open questions.


File src/openvpn/crypto.c:

http://gerrit.openvpn.net/c/openvpn/+/797/comment/ae81c136_3aaad761 :
PS2, Line 102:          * XOR of packet and implicit IV */
This comment doesn't fully compile. Are you saying that "implicit part =3D =
packet id XOR implcit iv"? If that's the case, I'll rephrase it a bit, like:

"Remainder of IV is the result of packet id XOR'd with impliciti IV (the re=
sult is expected to be unique per session)."

Or something along those lines.


http://gerrit.openvpn.net/c/openvpn/+/797/comment/f435a313_33ac03a7 :
PS2, Line 445:          * XOR of packet counter and implicit IV */
same comment as before



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/797?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I74216d776d3e0a8dc987ec7b1671c8e8dcccdbd6
Gerrit-Change-Number: 797
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 12 Nov 2024 08:26:21 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--4KyaiGyJq6M=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/797?usp=3Demail">View C=
hange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/797/comment/b59359cf_8e31314e">Patch Set #2, Line 12:</a> <code style=
=3D"font-family:monospace,monospace">IV generation code later.</code></p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Question: what is =
the advantage or XOR&#39;ing the IV with the packet ID? And why is the impl=
icit IV growing from 32bits to 64?</p></li></ul></li><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/crypto.h:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/797/c=
omment/c99a7cfb_275919d0">Patch Set #2, Line 168:</a> <code style=3D"font-f=
amily:monospace,monospace">    size_t implicit_iv_len;     /**&lt; The leng=
th of implicit_iv */</code></p><p style=3D"white-space: pre-wrap; word-wrap=
: break-word;">why is the len being removed? What is the underlying assumpt=
ion allowing us to drop the len?</p><p style=3D"white-space: pre-wrap; word=
-wrap: break-word;">My wild wild guess: implicit IV len =3D=3D packet ID si=
ze. Is that correct?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/797/comment/a758a11d_0ceb58dd">Patch Set #2, Line 173:</a> <code sty=
le=3D"font-family:monospace,monospace">    uint8_t implicit_iv[OPENVPN_MAX_=
IV_LENGTH];</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">I believe I understand the comment above, but I have troubles combini=
ng it with OPENVPN_MAX_IV_LENGTH that is 128 bits with OpenSSL.<br>Does it =
mean we actually only fill part of the array when using AEAD (i.e. 32 bits)=
?<br>Is this going to change with the new format and become 64 bits?<br>Is =
the rest of the array therefore unused?</p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Maybe this is explained somewhere else, but this=
 comment alone leaves me with these open questions.</p></li></ul></li><li s=
tyle=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto.c:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/797/comment/ae81c136_3aaad761">Patch Set #2, Line 102:</a> <co=
de style=3D"font-family:monospace,monospace">         * XOR of packet and i=
mplicit IV */</code></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">This comment doesn&#39;t fully compile. Are you saying that &quot;i=
mplicit part =3D packet id XOR implcit iv&quot;? If that&#39;s the case, I&=
#39;ll rephrase it a bit, like:</p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">&quot;Remainder of IV is the result of packet id XOR&#39=
;d with impliciti IV (the result is expected to be unique per session).&quo=
t;</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Or somethi=
ng along those lines.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/797/comment/f435a313_33ac03a7">Patch Set #2, Line 445:</a> <code st=
yle=3D"font-family:monospace,monospace">         * XOR of packet counter an=
d implicit IV */</code></p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">same comment as before</p></li></ul></li></ul><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/797?usp=3Demail">change 79=
7</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/797?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I74216d776d3e0a8dc987ec7b167=
1c8e8dcccdbd6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 797 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 12 Nov 2024 08:26:21=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--4KyaiGyJq6M=--


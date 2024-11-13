From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 13 Nov 2024 12:49:21 +0000
In-Reply-To: <gerrit.1731290343000.I74216d776d3e0a8dc987ec7b1671c8e8dcccdbd6@...2715...>
References: <gerrit.1731290343000.I74216d776d3e0a8dc987ec7b1671c8e8dcccdbd6@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296..., a@...2181...
Message-ID: <e24e981c263e89091125cc6911f8d758061eee0d-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oB3Na14Q+Os="; charset=UTF-8
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
Cc: cron2 <gert@...1296...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--oB3Na14Q+Os=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, ordex.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/797?usp=3Demail )

Change subject: Use XOR instead of concatenation for calculation of  IV fro=
m implicit IV
......................................................................


Patch Set 2:

(9 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/797/comment/59bcb58e_1dd37b5e :
PS2, Line 12: IV generation code later.
> Question: what is the advantage or XOR'ing the IV with the packet ID? And=
 why is the implicit IV gro [=E2=80=A6]
The implicit IV is growing from 64 bit to 96 bits. The whole IV is 96 bits =
and with Data v2 we use 32 bit packet id || implicit_iv to form the IV.


File src/openvpn/crypto.h:

http://gerrit.openvpn.net/c/openvpn/+/797/comment/141bbf3c_5381bd8d :
PS2, Line 168:     size_t implicit_iv_len;     /**< The length of implicit_=
iv */
> why is the len being removed? What is the underlying assumption allowing =
us to drop the len? [=E2=80=A6]
The underlying assumption is that implicit IV is always xored to generate t=
he IV. So implicit IV len is always the same length as the length of the IV.


http://gerrit.openvpn.net/c/openvpn/+/797/comment/cc89468e_4b046e53 :
PS2, Line 173:     uint8_t implicit_iv[OPENVPN_MAX_IV_LENGTH];
> I believe I understand the comment above, but I have troubles combining i=
t with OPENVPN_MAX_IV_LENGT [=E2=80=A6]
Yes, we only fill as many bytes as the size of the IV of the cipher we are =
using.


File src/openvpn/crypto.c:

http://gerrit.openvpn.net/c/openvpn/+/797/comment/d33cecd7_d179dad1 :
PS2, Line 102:          * XOR of packet and implicit IV */
> This comment doesn't fully compile. [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/797/comment/23e39761_6d3a4ea0 :
PS2, Line 445:          * XOR of packet counter and implicit IV */
> same comment as before
Done


File src/openvpn/dco_freebsd.c:

http://gerrit.openvpn.net/c/openvpn/+/797/comment/dc522f44_9fe63698 :
PS2, Line 398:         /* FreeBSD uses the contact operation, need to skip =
the first 4 null
> concat?
Acknowledged


File src/openvpn/dco_linux.c:

http://gerrit.openvpn.net/c/openvpn/+/797/comment/e2a5f44c_31248b37 :
PS2, Line 588:         /* First 4 zero bytes as the kernel does concat inst=
ead of XOR */
> "skip" first 4 zero bytes?
Done


http://gerrit.openvpn.net/c/openvpn/+/797/comment/a7e16baf_72713641 :
PS2, Line 599:         /* First 4 zero bytes as the kernel does concat inst=
ead of XOR */
> as above
Done


File src/openvpn/dco_win.c:

http://gerrit.openvpn.net/c/openvpn/+/797/comment/9c728a26_c4af20b0 :
PS2, Line 317:     /* First 4 zero bytes as ovpn-dco-win does concat instea=
d of XOR */
> same comment as for Linux DCO, but no +4 here?  confusing
Yeah looks that I only tested windows. Since all of them directly get the k=
eys from the key2 structure, the patch does not interact with that. Will re=
move it from all platforms in the fixed version.



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
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Wed, 13 Nov 2024 12:49:21 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Comment-In-Reply-To: ordex <a@...2181...>
Gerrit-MessageType: comment

--oB3Na14Q+Os=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, ordex. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/797?usp=3Demail">View C=
hange</a></p><p>9 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/797/comment/59bcb58e_1dd37b5e">Patch Set #2, Line 12:</a> <code style=
=3D"font-family:monospace,monospace">IV generation code later.</code></p><p=
><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding:=
 0 10px;">Question: what is the advantage or XOR&#39;ing the IV with the pa=
cket ID? And why is the implicit IV gro [=E2=80=A6]</blockquote></p><p styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">The implicit IV is grow=
ing from 64 bit to 96 bits. The whole IV is 96 bits and with Data v2 we use=
 32 bit packet id || implicit_iv to form the IV.</p></li></ul></li><li styl=
e=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto.h:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/797/comment/141bbf3c_5381bd8d">Patch Set #2, Line 168:</a> <code s=
tyle=3D"font-family:monospace,monospace">    size_t implicit_iv_len;     /*=
*&lt; The length of implicit_iv */</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">why is the len bei=
ng removed? What is the underlying assumption allowing us to drop the len? =
[=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">The underlying assumption is that implicit IV is always xored t=
o generate the IV. So implicit IV len is always the same length as the leng=
th of the IV.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
797/comment/cc89468e_4b046e53">Patch Set #2, Line 173:</a> <code style=3D"f=
ont-family:monospace,monospace">    uint8_t implicit_iv[OPENVPN_MAX_IV_LENG=
TH];</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;">I believe I understand the comment above, but I =
have troubles combining it with OPENVPN_MAX_IV_LENGT [=E2=80=A6]</blockquot=
e></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Yes, we on=
ly fill as many bytes as the size of the IV of the cipher we are using.</p>=
</li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/cry=
pto.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/797/comment/d33cecd7_d179dad1">Patch Set #2=
, Line 102:</a> <code style=3D"font-family:monospace,monospace">         * =
XOR of packet and implicit IV */</code></p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This comment doesn&#=
39;t fully compile. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/797/comment/23e39761_6d3a4ea0">Patch Set #2, Line 44=
5:</a> <code style=3D"font-family:monospace,monospace">         * XOR of pa=
cket counter and implicit IV */</code></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">same comment as befor=
e</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/o=
penvpn/dco_freebsd.c:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/797/comment/dc522f44_9fe6369=
8">Patch Set #2, Line 398:</a> <code style=3D"font-family:monospace,monospa=
ce">        /* FreeBSD uses the contact operation, need to skip the first 4=
 null</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin=
: 10px 0; padding: 0 10px;">concat?</blockquote></p><p style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Acknowledged</p></li></ul></li><li styl=
e=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco_linux.c:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/797/comment/e2a5f44c_31248b37">Patch Set #2, Line 588:</a> <co=
de style=3D"font-family:monospace,monospace">        /* First 4 zero bytes =
as the kernel does concat instead of XOR */</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;sk=
ip&quot; first 4 zero bytes?</blockquote></p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/797/comment/a7e16baf_72713641">Patch Set #2, Line 599:<=
/a> <code style=3D"font-family:monospace,monospace">        /* First 4 zero=
 bytes as the kernel does concat instead of XOR */</code></p><p><blockquote=
 style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">as=
 above</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File =
src/openvpn/dco_win.c:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/797/comment/9c728a26_c4af20=
b0">Patch Set #2, Line 317:</a> <code style=3D"font-family:monospace,monosp=
ace">    /* First 4 zero bytes as ovpn-dco-win does concat instead of XOR *=
/</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10=
px 0; padding: 0 10px;">same comment as for Linux DCO, but no +4 here?  con=
fusing</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Yeah looks that I only tested windows. Since all of them directly ge=
t the keys from the key2 structure, the patch does not interact with that. =
Will remove it from all platforms in the fixed version.</p></li></ul></li><=
/ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/797?=
usp=3Demail">change 797</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/797?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 13 Nov 2024 12:49:21=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;a@...2181...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--oB3Na14Q+Os=--


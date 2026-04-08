From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 8 Apr 2026 02:07:43 +0000
In-Reply-To: <gerrit.1775475846000.I055c64ca8b23066e70eea7d7deddfb14f5354c5f@...2715...>
References: <gerrit.1775475846000.I055c64ca8b23066e70eea7d7deddfb14f5354c5f@...2715...>
Reply-To: arne-openvpn@...1227..., selva.nair@...277...,
 luca.boccassi@...277..., openvpn-devel@lists.sourceforge.net
Message-ID: <672d2ede8a4c03e93da1d35092fca59877616499-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6bwFlXztKS0="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add new helpers to
 handle key exchange (S_SENT_KEY/S_START) with larg...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Bluca <luca.boccassi@...277...>
Cc: selvanair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6bwFlXztKS0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Bluca, selvanair.

plaisthos has posted comments on this change by Bluca. ( http://gerrit.open=
vpn.net/c/openvpn/+/1622?usp=3Demail )

Change subject: Add new helpers to handle key exchange (S_SENT_KEY/S_START)=
 with large passwords
......................................................................


Patch Set 2: Code-Review-1

(5 comments)

Patchset:

PS2:
I still do not agree with the approach as such but here are additional some=
 comments on the patch itself.


File src/openvpn/common.h:

http://gerrit.openvpn.net/c/openvpn/+/1622/comment/a14781fe_894ca37b?usp=3D=
email :
PS2, Line 76:  * than the default TLS channel size (e.g. with ENABLE_PKCS11=
),
So an OpenVPN compiled without --enable-pkcs11 gets a buffer of 2048 + 2 * =
128? That feels a bit odd.


File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1622/comment/a7bf99f1_be645d0f?usp=3D=
email :
PS2, Line 919:     }
there are other reasons why a handshake can fail at this point. Printing a =
message that suggest that probably password is at fault can be misleading.


http://gerrit.openvpn.net/c/openvpn/+/1622/comment/ffbce5ce_262ab2e5?usp=3D=
email :
PS2, Line 2645:  * when long passwords/tokens are used.
So this method will basically greedily read as many TLS records as there ar=
e currently on the wire. This will make future improvements a lot harder wh=
ere there are server/clients out there that basically ignore the framing an=
d consider anything that is sent in the same batch to be part of the key me=
thod.

Even the original Microsoft patch does not do that. It still uses only one =
TLS record (max 16kB) for key2 method.

The correct approach here would be to try to read a whole TLS record (16 kB=
) and take whatever the SSL_read gives you as the key2 method and not doing=
 multiple smaller reads that break the assumption of TLS record framing tha=
t OpenVPN (currently) uses.

I am surprised that this did not already cause problems for you when the se=
rver sends push reply immediately after its key2 write and this is being pu=
t into the key packet. But maybe you never got such unlucky timing.


http://gerrit.openvpn.net/c/openvpn/+/1622/comment/9a4c89e5_f09f9549?usp=3D=
email :
PS2, Line 2940:             BLEN(&ks->key_method_send_buf) > TLS_CHANNEL_BU=
F_SIZE;
This can also be triggered by other methods like setting multiple setenv UV=
_xx with push-peerinfo in the configuration and then the user will get the =
error message iwth the long password above.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1622?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I055c64ca8b23066e70eea7d7deddfb14f5354c5f
Gerrit-Change-Number: 1622
Gerrit-PatchSet: 2
Gerrit-Owner: Bluca <luca.boccassi@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: selvanair <selva.nair@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: Bluca <luca.boccassi@...277...>
Gerrit-Attention: selvanair <selva.nair@...277...>
Gerrit-Comment-Date: Wed, 08 Apr 2026 02:07:43 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--6bwFlXztKS0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Bluca, selvanair. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1622?usp=3Demail">V=
iew Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1622?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I still do=
 not agree with the approach as such but here are additional some comments =
on the patch itself.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"=
><p>File src/openvpn/common.h:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1622/comment/a14781=
fe_894ca37b?usp=3Demail">Patch Set #2, Line 76:</a> <code style=3D"font-fam=
ily:monospace,monospace"> * than the default TLS channel size (e.g. with EN=
ABLE_PKCS11),</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">So an OpenVPN compiled without --enable-pkcs11 get=
s a buffer of 2048 + 2 * 128? That feels a bit odd.</p></li></ul></li><li s=
tyle=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl.c:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1622/comment/a7bf99f1_be645d0f?usp=3Demail">Patch Set #2, Line 919=
:</a> <code style=3D"font-family:monospace,monospace">    }</code></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">ther=
e are other reasons why a handshake can fail at this point. Printing a mess=
age that suggest that probably password is at fault can be misleading.</p><=
/li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1622/comment/ffbce=
5ce_262ab2e5?usp=3Demail">Patch Set #2, Line 2645:</a> <code style=3D"font-=
family:monospace,monospace"> * when long passwords/tokens are used.</code><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">So this method will basically greedily read as many TLS records as ther=
e are currently on the wire. This will make future improvements a lot harde=
r where there are server/clients out there that basically ignore the framin=
g and consider anything that is sent in the same batch to be part of the ke=
y method.</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Even the original Microsoft patch does not do that. It still =
uses only one TLS record (max 16kB) for key2 method. </p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">The correct appro=
ach here would be to try to read a whole TLS record (16 kB) and take whatev=
er the SSL_read gives you as the key2 method and not doing multiple smaller=
 reads that break the assumption of TLS record framing that OpenVPN (curren=
tly) uses.</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">I am surprised that this did not already cause problems for =
you when the server sends push reply immediately after its key2 write and t=
his is being put into the key packet. But maybe you never got such unlucky =
timing.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1622/c=
omment/9a4c89e5_f09f9549?usp=3Demail">Patch Set #2, Line 2940:</a> <code st=
yle=3D"font-family:monospace,monospace">            BLEN(&amp;ks-&gt;key_me=
thod_send_buf) &gt; TLS_CHANNEL_BUF_SIZE;</code></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">This can also be trigg=
ered by other methods like setting multiple setenv UV_xx with push-peerinfo=
 in the configuration and then the user will get the error message iwth the=
 long password above.</p></li></ul></li></ul><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1622?usp=3Demail">change 1622</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1622?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I055c64ca8b23066e70eea7d7ded=
dfb14f5354c5f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1622 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Bluca &lt;luca.boccassi@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: selvanair &lt;selva.nair@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Bluca &lt;luca.boccassi@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: selvanair &lt;selva.nair@...493...=
277...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 08 Apr 2026 02:07:43=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--6bwFlXztKS0=--


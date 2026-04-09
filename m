From: "Bluca (Code Review)" <gerrit@...515...>
Date: Thu, 9 Apr 2026 01:10:30 +0000
In-Reply-To: <gerrit.1775475846000.I055c64ca8b23066e70eea7d7deddfb14f5354c5f@...2715...>
References: <gerrit.1775475846000.I055c64ca8b23066e70eea7d7deddfb14f5354c5f@...2715...>
Reply-To: luca.boccassi@...277..., arne-openvpn@...1227...,
 selva.nair@...277..., openvpn-devel@lists.sourceforge.net
Message-ID: <343a2b74de1bfa9bc73a5c5a966ee220add18e6c-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GnfhbWrfxH4="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: ssl: use TLS
 record-sized buffers for key method 2 exchange
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, selvanair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--GnfhbWrfxH4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, selvanair.

Bluca has posted comments on this change by Bluca. ( http://gerrit.openvpn.=
net/c/openvpn/+/1622?usp=3Demail )

Change subject: ssl: use TLS record-sized buffers for key method 2 exchange
......................................................................


Patch Set 2:

(5 comments)

Patchset:

PS1:
> > With a pre-a7f80d402f server there was no helpful message with a patche=
d client, so I've now added it.
>
> And while you consider that behaviour completely acceptable and the probl=
em that your patch introduces, I really don't like adding another obscure w=
ay an OpenVPN connection can fail. While it might be a not be a big deal fo=
r you, you also do not need to debug and support OpenVPN.

But the problem is not introduced by this patch, it's always been there, an=
d the logs above intended to show exactly this.
The intent of this change is that it doesn't make it any better or any wors=
e - it simply stays the same: if the server doesn't support it, you get a c=
lear error message from the client saying so.


PS1:
> There are multiple way that I can see that are better suited to solve the=
 problem of supporting longer username/passwords in OpenVPN. They would hav=
e many advantages over the approach that you are trying to force in here. T=
hey would have only the one downside of not working with the Azure OpenVPN =
implementation.

Well, that one downside is the one thing I am motivated by...

> I understand that this is frustrating for you but maybe you should compla=
in to Microsoft instead.

Even if there was anybody to complain to (might as well try to complain to =
a brick wall), using tokens for auth is not going to go away. There are way=
 too many real world security disasters because passwords get exfiltrated o=
r phished and then used to gain permanent access to intranets. JIT single-u=
se tokens are not going anywhere, regardless of any complaint one might mak=
e, and they don't fit in the current hardcoded buffer.


File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1622/comment/7ddd6405_e59c67df?usp=3D=
email :
PS2, Line 919:     }
> there are other reasons why a handshake can fail at this point. [=E2=80=
=A6]
Reworded a bit to make it into a suggestion rather than a statement, can fu=
rther reword it if needed


http://gerrit.openvpn.net/c/openvpn/+/1622/comment/cc5a8238_93462793?usp=3D=
email :
PS2, Line 2645:  * when long passwords/tokens are used.
> So this method will basically greedily read as many TLS records as there =
are currently on the wire. [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/1622/comment/0a3fd2a0_be58e8fd?usp=3D=
email :
PS2, Line 2940:             BLEN(&ks->key_method_send_buf) > TLS_CHANNEL_BU=
F_SIZE;
> This can also be triggered by other methods like setting multiple setenv =
UV_xx with push-peerinfo in [=E2=80=A6]
Doesn't push_peer_info() hardcode a limit of 512 * 3, which is lower than 2=
048 anyway? Could you please share a config that would reproduce this issue?



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
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: selvanair <selva.nair@...277...>
Gerrit-Comment-Date: Thu, 09 Apr 2026 01:10:30 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Comment-In-Reply-To: Bluca <luca.boccassi@...277...>

--GnfhbWrfxH4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, selvanair. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1622?usp=3Demail">View =
Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1622?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><blockquote cla=
ss=3D"blocks" style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;"><blockquote class=3D"blocks" style=3D"border-left: 1px solid #aa=
a; margin: 10px 0; padding: 0 10px;"><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">With a pre-a7f80d402f server there wa=
s no helpful message with a patched client, so I&#39;ve now added it.</p></=
blockquote><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">And while you consider that behaviour completely acceptable and=
 the problem that your patch introduces, I really don&#39;t like adding ano=
ther obscure way an OpenVPN connection can fail. While it might be a not be=
 a big deal for you, you also do not need to debug and support OpenVPN.</p>=
</blockquote><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">But the problem is not introduced by this patch, it&#39;s alw=
ays been there, and the logs above intended to show exactly this.<br>The in=
tent of this change is that it doesn&#39;t make it any better or any worse =
- it simply stays the same: if the server doesn&#39;t support it, you get a=
 clear error message from the client saying so.</p></li><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1622?tab=3Dcomments&amp;usp=3Demail">Patc=
h Set #1:</a> </p><blockquote class=3D"blocks" style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;"><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">There are multiple way that I =
can see that are better suited to solve the problem of supporting longer us=
ername/passwords in OpenVPN. They would have many advantages over the appro=
ach that you are trying to force in here. They would have only the one down=
side of not working with the Azure OpenVPN implementation.</p></blockquote>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Well, that one downside is the one thing I am motivated by...</p><blockquo=
te class=3D"blocks" style=3D"border-left: 1px solid #aaa; margin: 10px 0; p=
adding: 0 10px;"><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">I understand that this is frustrating for you but maybe y=
ou should complain to Microsoft instead.</p></blockquote><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">Even if there was=
 anybody to complain to (might as well try to complain to a brick wall), us=
ing tokens for auth is not going to go away. There are way too many real wo=
rld security disasters because passwords get exfiltrated or phished and the=
n used to gain permanent access to intranets. JIT single-use tokens are not=
 going anywhere, regardless of any complaint one might make, and they don&#=
39;t fit in the current hardcoded buffer.</p></li></ul></li><li style=3D"ma=
rgin: 0; padding: 0;"><p>File src/openvpn/ssl.c:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
622/comment/7ddd6405_e59c67df?usp=3Demail">Patch Set #2, Line 919:</a> <cod=
e style=3D"font-family:monospace,monospace">    }</code></p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">the=
re are other reasons why a handshake can fail at this point. [=E2=80=A6]</b=
lockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Reworded a bit to make it into a suggestion rather than a st=
atement, can further reword it if needed</p></li><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1622/comment/cc5a8238_93462793?usp=3Demail">Patc=
h Set #2, Line 2645:</a> <code style=3D"font-family:monospace,monospace"> *=
 when long passwords/tokens are used.</code></p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">So this method =
will basically greedily read as many TLS records as there are currently on =
the wire. [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/1622/comment/0a3fd2a0_be58e8fd?usp=3Demail">P=
atch Set #2, Line 2940:</a> <code style=3D"font-family:monospace,monospace"=
>            BLEN(&amp;ks-&gt;key_method_send_buf) &gt; TLS_CHANNEL_BUF_SIZ=
E;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 1=
0px 0; padding: 0 10px;">This can also be triggered by other methods like s=
etting multiple setenv UV_xx with push-peerinfo in [=E2=80=A6]</blockquote>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Doesn&#39;t push_peer_info() hardcode a limit of 512 * 3, which is low=
er than 2048 anyway? Could you please share a config that would reproduce t=
his issue?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/1622?usp=3Demail">change 1622</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http:=
//schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1622?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: selvanair &lt;selva.nair@...493...=
277...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 09 Apr 2026 01:10:30=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: Bluca &lt;luca.boccassi@...220...=
..277...&gt; </div>

</body></html>=

--GnfhbWrfxH4=--


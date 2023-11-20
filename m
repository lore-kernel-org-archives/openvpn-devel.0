From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 20 Nov 2023 13:02:18 +0000
In-Reply-To: <gerrit.1700479678000.I0ad48915004ddee587e97c8ed190ba8ee989e48d@...2715...>
References: <gerrit.1700479678000.I0ad48915004ddee587e97c8ed190ba8ee989e48d@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <cfcb63acedfe6625ab9db44bf4cb3ba6c38e4360-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0981VBosiUo="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Allow the TLS
 session to send out TLS alerts
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0981VBosiUo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/449?usp=3Demail )

Change subject: Allow the TLS session to send out TLS alerts
......................................................................


Patch Set 1:

(8 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/449/comment/e66f6133_04b1cc5d :
PS1, Line 20: Sending out alerts  is a slight compromise in security as ale=
rts give
> superfluous space
Done


http://gerrit.openvpn.net/c/openvpn/+/449/comment/d04c679a_cc1ae3ed :
PS1, Line 22: out. But since all other consumers TLS implementation are alr=
eady doing this
> "consumer TLS implementations"
Done


http://gerrit.openvpn.net/c/openvpn/+/449/comment/8660b029_d3b05646 :
PS1, Line 23: and TLS implementation (nowadays) are very careful not to lea=
k (sensitive)
> "implementations"
Done


File Changes.rst:

http://gerrit.openvpn.net/c/openvpn/+/449/comment/9f072ad8_eab0e86f :
PS1, Line 6:     OpenVPN 2.7 will send out TLS alerts to peer informing the=
m if the TLS
> "peers"
Done


http://gerrit.openvpn.net/c/openvpn/+/449/comment/568b8456_4669a9a3 :
PS1, Line 10:     a timeout when the server just stop responding completely.
> "stops"
Done


File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/449/comment/a39b7fdf_e1dbd71f :
PS1, Line 2846:  * Shut down an SSL session, so an SSL close notify is sent=
 if there no other
> "there is"
Done


http://gerrit.openvpn.net/c/openvpn/+/449/comment/8e57006f_630e475d :
PS1, Line 2851: do_ssl_shutdown(struct key_state *ks)
> Why do we need an empty function? Was this supposed to call key_state_ssl=
_shutdown?
Yes. That is accidentally leftover code from an earlier version. I decided =
on the key_state_ssl_shutdown name as that aligns more with similar functio=
ns in existing code


File src/openvpn/ssl_backend.h:

http://gerrit.openvpn.net/c/openvpn/+/449/comment/6cfd1f28_022bf406 :
PS1, Line 376:  * a shutdown altert.
> alert
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/449?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0ad48915004ddee587e97c8ed190ba8ee989e48d
Gerrit-Change-Number: 449
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 20 Nov 2023 13:02:18 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--0981VBosiUo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/449?usp=3Demail">View C=
hange</a></p><p>8 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/449/comment/e66f6133_04b1cc5d">Patch Set #1, Line 20:</a> <code style=
=3D"font-family:monospace,monospace">Sending out alerts  is a slight compro=
mise in security as alerts give</code></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">superfluous space</bl=
ockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Don=
e</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/449/comment/=
d04c679a_cc1ae3ed">Patch Set #1, Line 22:</a> <code style=3D"font-family:mo=
nospace,monospace">out. But since all other consumers TLS implementation ar=
e already doing this</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">&quot;consumer TLS implementatio=
ns&quot;</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
449/comment/8660b029_d3b05646">Patch Set #1, Line 23:</a> <code style=3D"fo=
nt-family:monospace,monospace">and TLS implementation (nowadays) are very c=
areful not to leak (sensitive)</code></p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;implementations&=
quot;</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File C=
hanges.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/449/comment/9f072ad8_eab0e86f">Patch S=
et #1, Line 6:</a> <code style=3D"font-family:monospace,monospace">    Open=
VPN 2.7 will send out TLS alerts to peer informing them if the TLS</code></=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;">&quot;peers&quot;</blockquote></p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/449/comment/568b8456_4669a9a3">Patch Set #1, Line 10=
:</a> <code style=3D"font-family:monospace,monospace">    a timeout when th=
e server just stop responding completely.</code></p><p><blockquote style=3D=
"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;stops=
&quot;</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File =
src/openvpn/ssl.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/449/comment/a39b7fdf_e1dbd71f">=
Patch Set #1, Line 2846:</a> <code style=3D"font-family:monospace,monospace=
"> * Shut down an SSL session, so an SSL close notify is sent if there no o=
ther</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;">&quot;there is&quot;</blockquote></p><p style=3D=
"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/449/comment/8e57006f_630e475d">Patch=
 Set #1, Line 2851:</a> <code style=3D"font-family:monospace,monospace">do_=
ssl_shutdown(struct key_state *ks)</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Why do we need an =
empty function? Was this supposed to call key_state_ssl_shutdown?</blockquo=
te></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Yes. That=
 is accidentally leftover code from an earlier version. I decided on the ke=
y_state_ssl_shutdown name as that aligns more with similar functions in exi=
sting code</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File s=
rc/openvpn/ssl_backend.h:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/449/comment/6cfd1f28_022=
bf406">Patch Set #1, Line 376:</a> <code style=3D"font-family:monospace,mon=
ospace"> * a shutdown altert.</code></p><p><blockquote style=3D"border-left=
: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">alert</blockquote></p><=
p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul=
></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/449?usp=3Demail">change 449</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/449?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0ad48915004ddee587e97c8ed19=
0ba8ee989e48d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 449 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 20 Nov 2023 13:02:18=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--0981VBosiUo=--


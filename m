From: "MaxF (Code Review)" <gerrit@...515...>
Date: Sat, 28 Dec 2024 17:34:37 +0000
In-Reply-To: <gerrit.1731290343000.Id7d6a576ca8c9560cb2dfae82fc62175820e9b80@...2715...>
References: <gerrit.1731290343000.Id7d6a576ca8c9560cb2dfae82fc62175820e9b80@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1e7b2126341ea0b79ab486dc15cf56792a7492a3-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/vA0t64NZ9Y="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Implement methods to
 generate and manage OpenVPN Epoch keys
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

--/vA0t64NZ9Y=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

MaxF has posted comments on this change. ( http://gerrit.openvpn.net/c/open=
vpn/+/804?usp=3Demail )

Change subject: Implement methods to generate and manage OpenVPN Epoch keys
......................................................................


Patch Set 9:

(12 comments)

Patchset:

PS9:
Reviewed until crypto_epoch.h, will continue later


File src/openvpn/crypto.h:

http://gerrit.openvpn.net/c/openvpn/+/804/comment/a432af93_97a33d7a :
PS9, Line 175: /** the epoch of the key is if it was generated as epoch dat=
a key material */
I think you mean: The epoch of the key, if it was generated as epoch data k=
ey material.

(Implying, it's undefined if this is a different kind of key?)


http://gerrit.openvpn.net/c/openvpn/+/804/comment/735a8e52_5784bd7e :
PS9, Line 223: is
this?


http://gerrit.openvpn.net/c/openvpn/+/804/comment/a6671a3f_87bca2ec :
PS9, Line 315: key
keys


http://gerrit.openvpn.net/c/openvpn/+/804/comment/5f52e18e_e35d296c :
PS9, Line 316: to switch also sending key
to also switch the sending key?


http://gerrit.openvpn.net/c/openvpn/+/804/comment/68672759_37e827d3 :
PS9, Line 324: switch
switched?


http://gerrit.openvpn.net/c/openvpn/+/804/comment/7c80d6b3_104e8e59 :
PS9, Line 524: @param epoch Epoch read from packet or 0 when epoch is not u=
sed.
That's not an argument of the function.


File src/openvpn/crypto_epoch.h:

http://gerrit.openvpn.net/c/openvpn/+/804/comment/ced0bc22_010e9c3f :
PS9, Line 72: * @param epoch_key     Epoch key to be used
            :  * @param key          Destination for the generated data key
wrong order compared to the function.


http://gerrit.openvpn.net/c/openvpn/+/804/comment/cb952e40_38a4c3a6 :
PS9, Line 91: using
uses


http://gerrit.openvpn.net/c/openvpn/+/804/comment/480f9270_6b023e63 :
PS9, Line 96: a
for the receive key?


http://gerrit.openvpn.net/c/openvpn/+/804/comment/3dba7c21_2b0cdd56 :
PS9, Line 103: send_epoch_keyt
send_epoch_key


http://gerrit.openvpn.net/c/openvpn/+/804/comment/44263987_947e608e :
PS9, Line 118: * @param e1_send    The E1 send epoch key derived by TLS-EKM
             :  * @param e1_recv    The E1 receive epoch key derived by TLS=
-EKM
incomplete parameters



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/804?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id7d6a576ca8c9560cb2dfae82fc62175820e9b80
Gerrit-Change-Number: 804
Gerrit-PatchSet: 9
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: MaxF <max@...2606...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Sat, 28 Dec 2024 17:34:37 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--/vA0t64NZ9Y=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/804?usp=3Demail">View C=
hange</a></p><p>12 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/804?tab=3Dcomments">Patch Set #9:</a> </p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Reviewed until crypto_epoch.h, will continue lat=
er</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openv=
pn/crypto.h:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/804/comment/a432af93_97a33d7a">Patch =
Set #9, Line 175:</a> <code style=3D"font-family:monospace,monospace">/** t=
he epoch of the key is if it was generated as epoch data key material */</c=
ode></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">I think =
you mean: The epoch of the key, if it was generated as epoch data key mater=
ial.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">(Implyin=
g, it&#39;s undefined if this is a different kind of key?)</p></li><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/804/comment/735a8e52_5784bd7e"=
>Patch Set #9, Line 223:</a> <code style=3D"font-family:monospace,monospace=
">is</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">t=
his?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/804/comme=
nt/a6671a3f_87bca2ec">Patch Set #9, Line 315:</a> <code style=3D"font-famil=
y:monospace,monospace">key</code></p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">keys</p></li><li style=3D"margin: 0; padding: 0 0 0 16=
px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/804/comment/5f52e18e_e35d296c">Patch Set #9, Line 316:</a> <cod=
e style=3D"font-family:monospace,monospace">to switch also sending key</cod=
e></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">to also sw=
itch the sending key?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/804/comment/68672759_37e827d3">Patch Set #9, Line 324:</a> <code st=
yle=3D"font-family:monospace,monospace">switch</code></p><p style=3D"white-=
space: pre-wrap; word-wrap: break-word;">switched?</p></li><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/804/comment/7c80d6b3_104e8e59">Patch S=
et #9, Line 524:</a> <code style=3D"font-family:monospace,monospace">@param=
 epoch Epoch read from packet or 0 when epoch is not used.</code></p><p sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">That&#39;s not an argu=
ment of the function.</p></li></ul></li><li style=3D"margin: 0; padding: 0;=
"><p>File src/openvpn/crypto_epoch.h:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/804/comment/=
ced0bc22_010e9c3f">Patch Set #9, Line 72:</a> </p><p><blockquote style=3D"b=
order-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">* @param epoch_k=
ey     Epoch key to be used<br> * @param key          Destination for the g=
enerated data key<br></pre></blockquote></p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">wrong order compared to the function.</p></li><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/804/comment/cb952e40_38=
a4c3a6">Patch Set #9, Line 91:</a> <code style=3D"font-family:monospace,mon=
ospace">using</code></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">uses</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/8=
04/comment/480f9270_6b023e63">Patch Set #9, Line 96:</a> <code style=3D"fon=
t-family:monospace,monospace">a</code></p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">for the receive key?</p></li><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/804/comment/3dba7c21_2b0cdd56">Patch Set #=
9, Line 103:</a> <code style=3D"font-family:monospace,monospace">send_epoch=
_keyt</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
send_epoch_key</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/804/comment/44263987_947e608e">Patch Set #9, Line 118:</a> </p><p><blockqu=
ote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">* =
@param e1_send    The E1 send epoch key derived by TLS-EKM<br> * @param e1_=
recv    The E1 receive epoch key derived by TLS-EKM<br></pre></blockquote><=
/p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">incomplete pa=
rameters</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/804?usp=3Demail">change 804</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/804?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id7d6a576ca8c9560cb2dfae82fc=
62175820e9b80 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 804 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: MaxF &lt;max@...2606...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 28 Dec 2024 17:34:37=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--/vA0t64NZ9Y=--


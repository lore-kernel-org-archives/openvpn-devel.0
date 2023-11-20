From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 20 Nov 2023 11:55:56 +0000
In-Reply-To: <gerrit.1700479678000.I0ad48915004ddee587e97c8ed190ba8ee989e48d@...2715...>
References: <gerrit.1700479678000.I0ad48915004ddee587e97c8ed190ba8ee989e48d@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <8f5e47aa3d3ce87a5567f7f965ad46ea16601d05-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="U/GvYIS5+ds="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--U/GvYIS5+ds=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/449?usp=3Demail )

Change subject: Allow the TLS session to send out TLS alerts
......................................................................


Patch Set 1: Code-Review-2

(9 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/449/comment/ce9fb57d_f01b1b19 :
PS1, Line 20: Sending out alerts  is a slight compromise in security as ale=
rts give
superfluous space


http://gerrit.openvpn.net/c/openvpn/+/449/comment/8bf6026e_889913be :
PS1, Line 22: out. But since all other consumers TLS implementation are alr=
eady doing this
"consumer TLS implementations"


http://gerrit.openvpn.net/c/openvpn/+/449/comment/a80886c0_b6d5627c :
PS1, Line 23: and TLS implementation (nowadays) are very careful not to lea=
k (sensitive)
"implementations"


Patchset:

PS1:
Can't judge the state machine patch really. But the doubts about the shutdo=
wn function makes this a NAK either way.


File Changes.rst:

http://gerrit.openvpn.net/c/openvpn/+/449/comment/9c3faa2e_d4fd7ba3 :
PS1, Line 6:     OpenVPN 2.7 will send out TLS alerts to peer informing the=
m if the TLS
"peers"


http://gerrit.openvpn.net/c/openvpn/+/449/comment/fd295cc6_2def6a9b :
PS1, Line 10:     a timeout when the server just stop responding completely.
"stops"


File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/449/comment/38284760_a524bebe :
PS1, Line 2846:  * Shut down an SSL session, so an SSL close notify is sent=
 if there no other
"there is"


http://gerrit.openvpn.net/c/openvpn/+/449/comment/8e4b3e48_338f6a18 :
PS1, Line 2851: do_ssl_shutdown(struct key_state *ks)
Why do we need an empty function? Was this supposed to call key_state_ssl_s=
hutdown?


File src/openvpn/ssl_backend.h:

http://gerrit.openvpn.net/c/openvpn/+/449/comment/fa6d4de4_e2eda72e :
PS1, Line 376:  * a shutdown altert.
alert



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
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Mon, 20 Nov 2023 11:55:56 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--U/GvYIS5+ds=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/449?usp=3Demail">Vi=
ew Change</a></p><p>9 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/449/comment/ce9fb57d_f01b1b19">Patch Set #1, Line 20:</a> <code s=
tyle=3D"font-family:monospace,monospace">Sending out alerts  is a slight co=
mpromise in security as alerts give</code></p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">superfluous space</p></li><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/449/comment/8bf6026e_889913be">Patch Set =
#1, Line 22:</a> <code style=3D"font-family:monospace,monospace">out. But s=
ince all other consumers TLS implementation are already doing this</code></=
p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;consumer=
 TLS implementations&quot;</p></li><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/449/comment/a80886c0_b6d5627c">Patch Set #1, Line 23:</a> <cod=
e style=3D"font-family:monospace,monospace">and TLS implementation (nowaday=
s) are very careful not to leak (sensitive)</code></p><p style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">&quot;implementations&quot;</p></li><=
/ul></li><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/449?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Can&#39;t judge the state machine patch =
really. But the doubts about the shutdown function makes this a NAK either =
way.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File Changes=
.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/449/comment/9c3faa2e_d4fd7ba3">Patch Set #1,=
 Line 6:</a> <code style=3D"font-family:monospace,monospace">    OpenVPN 2.=
7 will send out TLS alerts to peer informing them if the TLS</code></p><p s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;peers&quot;</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/449/comment/fd29=
5cc6_2def6a9b">Patch Set #1, Line 10:</a> <code style=3D"font-family:monosp=
ace,monospace">    a timeout when the server just stop responding completel=
y.</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">&qu=
ot;stops&quot;</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Fi=
le src/openvpn/ssl.c:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/449/comment/38284760_a524beb=
e">Patch Set #1, Line 2846:</a> <code style=3D"font-family:monospace,monosp=
ace"> * Shut down an SSL session, so an SSL close notify is sent if there n=
o other</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;=
">&quot;there is&quot;</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/449/comment/8e4b3e48_338f6a18">Patch Set #1, Line 2851:</a> <code =
style=3D"font-family:monospace,monospace">do_ssl_shutdown(struct key_state =
*ks)</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">W=
hy do we need an empty function? Was this supposed to call key_state_ssl_sh=
utdown?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/=
openvpn/ssl_backend.h:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/449/comment/fa6d4de4_e2eda7=
2e">Patch Set #1, Line 376:</a> <code style=3D"font-family:monospace,monosp=
ace"> * a shutdown altert.</code></p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">alert</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/449?usp=3Demail">change 449</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/449?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 20 Nov 2023 11:55:56=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--U/GvYIS5+ds=--


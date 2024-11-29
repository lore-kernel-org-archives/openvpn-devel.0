From: "MaxF (Code Review)" <gerrit@...515...>
Date: Fri, 29 Nov 2024 14:05:53 +0000
In-Reply-To: <gerrit.1731290343000.I057f007577f10c6ac917ee4620ee3d2559187dc7@...2715...>
References: <gerrit.1731290343000.I057f007577f10c6ac917ee4620ee3d2559187dc7@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <359453f81cc339baf4cd71b5d5df0aee3a5ee1e3-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5aluGiHa1XU="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Trigger
 renegotiation of data key if getting close to the AEAD usage ...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, cron2 <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5aluGiHa1XU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

MaxF has posted comments on this change. ( http://gerrit.openvpn.net/c/open=
vpn/+/796?usp=3Demail )

Change subject: Trigger renegotiation of data key if getting close to the A=
EAD usage limit
......................................................................


Patch Set 7: Code-Review-1

(3 comments)

Patchset:

PS7:
The limit matches the one in the RFC for p =3D 2^57.

I have some nitpicks about comments.

And one question: The RFC also specifies a limit for message integrity. If =
v is the number of failed decryptions for the current key and L is the maxi=
mum number of blocks per message, we must make sure that v <=3D min(2^64, (=
p * 2^127) / (L + 1)). Are we going to check that too?


File src/openvpn/crypto.h:

http://gerrit.openvpn.net/c/openvpn/+/796/comment/cb71ff95_59bc6586 :
PS7, Line 169:     /** Counter for the number of plaintext encrypted using =
this cipher
             :      * in number of 128 bit blocks (only used for AEAD ciphe=
rs) */
This looks a bit garbled. Maybe "Counter for the number of 128-bit plaintex=
t blocks encrypted with the current key"?


File src/openvpn/crypto.c:

http://gerrit.openvpn.net/c/openvpn/+/796/comment/ab160cf8_a5e88f45 :
PS7, Line 347: q <=3D (p^(1/2) * 2^(129/2) - 1) / (L + 1)
We're not doing anything with this inequality. This one is for the case whe=
re we don't count the individual blocks but just have an upper bound of L o=
n the number of blocks per message.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I057f007577f10c6ac917ee4620ee3d2559187dc7
Gerrit-Change-Number: 796
Gerrit-PatchSet: 7
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Fri, 29 Nov 2024 14:05:53 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--5aluGiHa1XU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p>Patch set 7:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail">Vi=
ew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/796?tab=3Dcomments">Patch Set #7:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">The limit matches the one in the RFC for p =
=3D 2^57.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">I h=
ave some nitpicks about comments.</p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">And one question: The RFC also specifies a limit for m=
essage integrity. If v is the number of failed decryptions for the current =
key and L is the maximum number of blocks per message, we must make sure th=
at v &lt;=3D min(2^64, (p * 2^127) / (L + 1)). Are we going to check that t=
oo?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/open=
vpn/crypto.h:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/796/comment/cb71ff95_59bc6586">Patch=
 Set #7, Line 169:</a> </p><p><blockquote style=3D"border-left: 1px solid #=
aaa; margin: 10px 0; padding: 0 10px;"><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">    /** Counter for the number of plain=
text encrypted using this cipher<br>     * in number of 128 bit blocks (onl=
y used for AEAD ciphers) */<br></pre></blockquote></p><p style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">This looks a bit garbled. Maybe &quot=
;Counter for the number of 128-bit plaintext blocks encrypted with the curr=
ent key&quot;?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Fi=
le src/openvpn/crypto.c:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/796/comment/ab160cf8_a5e8=
8f45">Patch Set #7, Line 347:</a> <code style=3D"font-family:monospace,mono=
space">q &lt;=3D (p^(1/2) * 2^(129/2) - 1) / (L + 1)</code></p><p style=3D"=
white-space: pre-wrap; word-wrap: break-word;">We&#39;re not doing anything=
 with this inequality. This one is for the case where we don&#39;t count th=
e individual blocks but just have an upper bound of L on the number of bloc=
ks per message.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail">change 796</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/796?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I057f007577f10c6ac917ee4620e=
e3d2559187dc7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 796 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 29 Nov 2024 14:05:53=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--5aluGiHa1XU=--


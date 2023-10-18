From: "MaxF (Code Review)" <gerrit@...515...>
Date: Wed, 18 Oct 2023 12:14:53 +0000
In-Reply-To: <gerrit.1697562354000.I445a93e84dc54b865b757038d22318ac427fce96@...2715...>
References: <gerrit.1697562354000.I445a93e84dc54b865b757038d22318ac427fce96@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0a2e235153f224a7edaec3f01160abb8b1a2fe88-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pdI/491v6Pg="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add support for
 mbedtls 3.X.Y
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--pdI/491v6Pg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

MaxF has posted comments on this change. ( http://gerrit.openvpn.net/c/open=
vpn/+/370?usp=3Demail )

Change subject: Add support for mbedtls 3.X.Y
......................................................................


Patch Set 1:

(2 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/370/comment/dd9f6001_8850e081 :
PS1, Line 28: This commit breaks compatibility for mbed TLS version 2.x.y. A
> That makes me unhappy. [=E2=80=A6]
Would you prefer to put the two commits together into one?

I don't think reordering them makes sense, you'd just end up with a file fu=
ll of unused functions.


File src/openvpn/crypto_mbedtls.c:

http://gerrit.openvpn.net/c/openvpn/+/370/comment/c741b867_3336d64e :
PS1, Line 174:         if (info && name
> why is the cipher_kt_insecure check missing here?
By accident. Thanks for catching this!



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/370?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I445a93e84dc54b865b757038d22318ac427fce96
Gerrit-Change-Number: 370
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 18 Oct 2023 12:14:53 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--pdI/491v6Pg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/370?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/370/comment/dd9f6001_8850e081">Patch Set #1, Line 28:</a> <code style=
=3D"font-family:monospace,monospace">This commit breaks compatibility for m=
bed TLS version 2.x.y. A</code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">That makes me unhappy. [=E2=
=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Would you prefer to put the two commits together into one?</p><p st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">I don&#39;t think reo=
rdering them makes sense, you&#39;d just end up with a file full of unused =
functions.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File s=
rc/openvpn/crypto_mbedtls.c:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/370/comment/c741b867_=
3336d64e">Patch Set #1, Line 174:</a> <code style=3D"font-family:monospace,=
monospace">        if (info &amp;&amp; name</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">why is t=
he cipher_kt_insecure check missing here?</blockquote></p><p style=3D"white=
-space: pre-wrap; word-wrap: break-word;">By accident. Thanks for catching =
this!</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/370?usp=3Demail">change 370</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/370?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I445a93e84dc54b865b757038d22=
318ac427fce96 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 370 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 18 Oct 2023 12:14:53=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--pdI/491v6Pg=--


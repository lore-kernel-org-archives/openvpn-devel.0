From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 22 Mar 2024 18:07:25 +0000
In-Reply-To: <gerrit.1711123201000.Ia73d53002f4ba2658af18c17cce1b68f79de5781@...2715...>
References: <gerrit.1711123201000.Ia73d53002f4ba2658af18c17cce1b68f79de5781@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <d0625c8a40cad93e7daf64e831b63d1c54a3670d-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Y6rCvGwRJoc="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Add bracket in
 fingerprint message and do not warn about missing veri...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Y6rCvGwRJoc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/546?usp=3Demail )

Change subject: Add bracket in fingerprint message and do not warn about mi=
ssing verification
......................................................................


Patch Set 1:

(1 comment)

File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/546/comment/715e408c_54ef637b :
PS1, Line 3598:         && !(o->verify_hash_depth =3D=3D0 && o->verify_hash=
))
> why only with verify_hash_depth =3D=3D 0? --verify-hash should not count?
verify-hash does only verify the hash on a CA/intermediate CA, so it is an =
more a restriction to --ca rather than actually checking if the peer is usi=
ng a proper certificate.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/546?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia73d53002f4ba2658af18c17cce1b68f79de5781
Gerrit-Change-Number: 546
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Fri, 22 Mar 2024 18:07:25 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--Y6rCvGwRJoc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/546?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init.c:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/546/comment/715e408c_54ef637b">Patch Set #1, Line 3598:</a> <=
code style=3D"font-family:monospace,monospace">        &amp;&amp; !(o-&gt;v=
erify_hash_depth =3D=3D0 &amp;&amp; o-&gt;verify_hash))</code></p><p><block=
quote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px=
;">why only with verify_hash_depth =3D=3D 0? --verify-hash should not count=
?</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;=
">verify-hash does only verify the hash on a CA/intermediate CA, so it is a=
n more a restriction to --ca rather than actually checking if the peer is u=
sing a proper certificate.</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/546?usp=3Demail">change 546</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/546?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia73d53002f4ba2658af18c17cce=
1b68f79de5781 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 546 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 22 Mar 2024 18:07:25=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--Y6rCvGwRJoc=--


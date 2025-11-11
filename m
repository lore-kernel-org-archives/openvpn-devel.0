From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 11 Nov 2025 14:28:12 +0000
In-Reply-To: <gerrit.1761324750000.I34584f695ddca3b3e1f2bbcb4380ac91b09c1c8d@...2715...>
References: <gerrit.1761324750000.I34584f695ddca3b3e1f2bbcb4380ac91b09c1c8d@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <fd1a8b9ab43e98f12e42e200ab509729556c08ad-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CZrCRjYMBLg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: Fix conversion
 warning in tls_prepend_opcode_v1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CZrCRjYMBLg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change by flichtenheld. ( http://g=
errit.openvpn.net/c/openvpn/+/1298?usp=3Demail )

Change subject: ssl: Fix conversion warning in tls_prepend_opcode_v1
......................................................................


Patch Set 4:

(1 comment)

File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1298/comment/63437cc2_76f424ff?usp=3D=
email :
PS3, Line 3985:     ASSERT(ks->key_id <=3D 1 << P_OPCODE_SHIFT);
> Can we add brackets here? I find this a bit hard to read since the order =
of <=3D and << is not so supe [=E2=80=A6]
That would be redundant with `P_KEY_ID_MASK` I guess, so how about just usi=
ng that? Changed to that for now. But definitely right about the off-by-one.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1298?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I34584f695ddca3b3e1f2bbcb4380ac91b09c1c8d
Gerrit-Change-Number: 1298
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Tue, 11 Nov 2025 14:28:12 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>

--CZrCRjYMBLg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1298?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl.c:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1298/comment/63437cc2_76f424ff?usp=3Demail">Patch Set #3, Lin=
e 3985:</a> <code style=3D"font-family:monospace,monospace">    ASSERT(ks-&=
gt;key_id &lt;=3D 1 &lt;&lt; P_OPCODE_SHIFT);</code></p><p><blockquote styl=
e=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Can we =
add brackets here? I find this a bit hard to read since the order of &lt;=
=3D and &lt;&lt; is not so supe [=E2=80=A6]</blockquote></p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">That would be =
redundant with `P_KEY_ID_MASK` I guess, so how about just using that? Chang=
ed to that for now. But definitely right about the off-by-one.</p></li></ul=
></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1298?usp=3Demail">change 1298</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demai=
l">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1298?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I34584f695ddca3b3e1f2bbcb438=
0ac91b09c1c8d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1298 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 11 Nov 2025 14:28:12=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>

</body></html>=

--CZrCRjYMBLg=--


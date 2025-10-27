From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 27 Oct 2025 11:48:33 +0000
In-Reply-To: <gerrit.1761488400000.I0579d18c784e2ac16973d5553992c28f281a0900@...2715...>
References: <gerrit.1761488400000.I0579d18c784e2ac16973d5553992c28f281a0900@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, max@...2606...
Message-ID: <6327ad1234a4e31bf038e0b81cc28b69194c7ff6-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4xh0RARP4QI="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add option to check
 tls-crypt-v2 key timestamps
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: MaxF <max@...2606...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--4xh0RARP4QI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, plaisthos.

flichtenheld has posted comments on this change by MaxF. ( http://gerrit.op=
envpn.net/c/openvpn/+/1304?usp=3Demail )

Change subject: Add option to check tls-crypt-v2 key timestamps
......................................................................


Patch Set 3: -Code-Review

Copied votes on follow-up patch sets have been updated:
* Copied Code-Review vote has been removed from patch set 4 (was Code-Revie=
w-2) since the new Code-Review=3D0 vote is not copyable (copy condition: "c=
hangekind:NO_CHANGE OR changekind:TRIVIAL_REBASE OR is:MIN").

(1 comment)

File src/openvpn/tls_crypt.c:

http://gerrit.openvpn.net/c/openvpn/+/1304/comment/f76fba9a_587eaa9c?usp=3D=
email :
PS2, Line 679:         return tls_crypt_v2_check_client_key_age(ctx, opt->t=
ls_crypt_v2_max_age);
> That was bad, thanks for catching that! Should be fixed now.
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1304?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0579d18c784e2ac16973d5553992c28f281a0900
Gerrit-Change-Number: 1304
Gerrit-PatchSet: 3
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Mon, 27 Oct 2025 11:48:33 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Comment-In-Reply-To: MaxF <max@...2606...>

--4xh0RARP4QI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, plaisthos. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ddd;">-Code-Review</span></p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1304?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/tls_crypt.c:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1304/comment/f76fba9a_587eaa9c?usp=3Demail">Patch Set #2=
, Line 679:</a> <code style=3D"font-family:monospace,monospace">        ret=
urn tls_crypt_v2_check_client_key_age(ctx, opt-&gt;tls_crypt_v2_max_age);</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">That was bad, thanks for catching that! Should be fixe=
d now.</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1304?usp=3Demail">change 1304</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1304?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0579d18c784e2ac16973d555399=
2c28f281a0900 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1304 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 27 Oct 2025 11:48:33=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: MaxF &lt;max@...2606...&g=
t; </div>

</body></html>=

--4xh0RARP4QI=--


From: "MaxF (Code Review)" <gerrit@...515...>
Date: Thu, 29 Jan 2026 15:43:14 +0000
In-Reply-To: <gerrit.1769619521000.I740991f22b728fe2f5a48bc18d5ca4b62f56f399@...2715...>
References: <gerrit.1769619521000.I740991f22b728fe2f5a48bc18d5ca4b62f56f399@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <3a7c3d0821bb3b5414541de60f05e94edec36d48-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tO5UekW4ocE="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Mbed TLS 4: Add more
 algorithms
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--tO5UekW4ocE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

MaxF has posted comments on this change by MaxF. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/1500?usp=3Demail )

Change subject: Mbed TLS 4: Add more algorithms
......................................................................


Patch Set 3:

(1 comment)

File src/openvpn/ssl_mbedtls.c:

http://gerrit.openvpn.net/c/openvpn/+/1500/comment/226baf37_e5dc0946?usp=3D=
email :
PS2, Line 370: /* Curve25519. */
> Any reason to not include Curve448?
Forgetfulness



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1500?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I740991f22b728fe2f5a48bc18d5ca4b62f56f399
Gerrit-Change-Number: 1500
Gerrit-PatchSet: 3
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Thu, 29 Jan 2026 15:43:14 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>

--tO5UekW4ocE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1500?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_mbedtls.c:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1500/comment/226baf37_e5dc0946?usp=3Demail">Patch Set=
 #2, Line 370:</a> <code style=3D"font-family:monospace,monospace">/* Curve=
25519. */</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;">Any reason to not include Curve448?</blockq=
uote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Forgetfulness</p></li></ul></li></ul><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1500?usp=3Demail">change 1500</a>. T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope item=
type=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1500?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I740991f22b728fe2f5a48bc18d5=
ca4b62f56f399 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1500 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 29 Jan 2026 15:43:14=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>

</body></html>=

--tO5UekW4ocE=--


From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 21 Jan 2026 13:04:01 +0000
In-Reply-To: <gerrit.1765571645000.Ib251d546d993b96ed3bd8cb9111bcc627cdb0fae@...2715...>
References: <gerrit.1765571645000.Ib251d546d993b96ed3bd8cb9111bcc627cdb0fae@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., steffan@...1856..., max@...2606...
Message-ID: <40c664ed5069a73a6c1601798c2ff0bcc6e7ace8-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="j8UaAF4UHk4="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Add support for
 Mbed TLS 4
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: MaxF <max@...2606...>
Cc: flichtenheld <frank@...2641...>, syzzer <steffan@...1856...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--j8UaAF4UHk4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, syzzer.

plaisthos has posted comments on this change by MaxF. ( http://gerrit.openv=
pn.net/c/openvpn/+/1441?usp=3Demail )

Change subject: Add support for Mbed TLS 4
......................................................................


Patch Set 5:

(1 comment)

File src/openvpn/ssl_mbedtls.c:

http://gerrit.openvpn.net/c/openvpn/+/1441/comment/46ea0c7e_a2445a5e?usp=3D=
email :
PS5, Line 610: {
/Users/arne/oss/openvpn-git/src/openvpn/ssl_mbedtls.c:609:1: error: unused =
function 'external_pkcs1_sign' [-Werror,-Wunused-function]
  609 | external_pkcs1_sign(void *ctx_voidptr, int (*f_rng)(void *, unsigne=
d char *, size_t), void *p_rng,

  And I do not see this function being used anywhere. Please double check t=
his with Werror.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1441?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib251d546d993b96ed3bd8cb9111bcc627cdb0fae
Gerrit-Change-Number: 1441
Gerrit-PatchSet: 5
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: syzzer <steffan@...1856...>
Gerrit-Attention: syzzer <steffan@...1856...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Wed, 21 Jan 2026 13:04:01 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--j8UaAF4UHk4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, syzzer. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1441?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_mbedtls.c:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1441/comment/46ea0c7e_a2445a5e?usp=3Demail">Patch Set=
 #5, Line 610:</a> <code style=3D"font-family:monospace,monospace">{</code>=
</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">/Users/arne/oss/openvpn-git/src/openvpn/ssl_mbedtls.c:609=
:1: error: unused function &#39;external_pkcs1_sign&#39; [-Werror,-Wunused-=
function]<br>  609 | external_pkcs1_sign(void *ctx_voidptr, int (*f_rng)(vo=
id *, unsigned char *, size_t), void *p_rng,<br>  <br>  And I do not see th=
is function being used anywhere. Please double check this with Werror.</pre=
></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1441?usp=3Demail">change 1441</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?=
usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1441?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib251d546d993b96ed3bd8cb9111=
bcc627cdb0fae </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1441 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: syzzer &lt;steffan@...1856...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: syzzer &lt;steffan@...2115...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 21 Jan 2026 13:04:01=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>=

--j8UaAF4UHk4=--


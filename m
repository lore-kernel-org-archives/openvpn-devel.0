From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 17 Mar 2026 14:43:54 +0000
In-Reply-To: <gerrit.1773754326000.I74841d3611c62d3c59fc839bc73a0c83ce025262@...2715...>
References: <gerrit.1773754326000.I74841d3611c62d3c59fc839bc73a0c83ce025262@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <d3c38c00f820b67455661ab55d1e3a76a44117fe-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="R2exZ4ZbSPg="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Do not support
 tls_ctx_set_cert_profile on AWS-LC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--R2exZ4ZbSPg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change by plaisthos. ( http://gerrit.=
openvpn.net/c/openvpn/+/1579?usp=3Demail )

Change subject: Do not support tls_ctx_set_cert_profile on AWS-LC
......................................................................


Patch Set 2:

(1 comment)

File src/openvpn/ssl_openssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1579/comment/6b0d32e7_d6754350?usp=3D=
email :
PS1, Line 553:             "WARNING: OpenSSL 1.1.0, aws-lc and LibreSSL do =
not support "
> Should we update this to say LibreSSL 3.5. [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1579?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I74841d3611c62d3c59fc839bc73a0c83ce025262
Gerrit-Change-Number: 1579
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 17 Mar 2026 14:43:54 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>

--R2exZ4ZbSPg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1579?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_openssl.c:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1579/comment/6b0d32e7_d6754350?usp=3Demail">Patch Set=
 #1, Line 553:</a> <code style=3D"font-family:monospace,monospace">        =
    &quot;WARNING: OpenSSL 1.1.0, aws-lc and LibreSSL do not support &quot;=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">Should we update this to say LibreSSL 3.5. [=E2=80=
=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1579?usp=3Demail">change 1579</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1579?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I74841d3611c62d3c59fc839bc73=
a0c83ce025262 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1579 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 17 Mar 2026 14:43:54=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>

</body></html>=

--R2exZ4ZbSPg=--


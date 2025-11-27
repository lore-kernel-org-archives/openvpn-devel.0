From: "ordex (Code Review)" <gerrit@...515...>
Date: Thu, 27 Nov 2025 10:01:44 +0000
In-Reply-To: <gerrit.1763838359000.I1e9c7eee06bf5f2e8aed8cd2523684539294ac8b@...2715...>
References: <gerrit.1763838359000.I1e9c7eee06bf5f2e8aed8cd2523684539294ac8b@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <1d6c938d13d56aeac13cfcb1f87e10798998779c-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kwlXwA8kdE8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]:
 extract_x509_field_ssl(): verify that X509_NAME is not NULL.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--kwlXwA8kdE8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

ordex has posted comments on this change by cron2. ( http://gerrit.openvpn.=
net/c/openvpn/+/1388?usp=3Demail )

Change subject: extract_x509_field_ssl(): verify that X509_NAME is not NULL.
......................................................................


Patch Set 1: Code-Review-1

(1 comment)

File src/openvpn/ssl_verify_openssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1388/comment/d4be6f27_e032b011?usp=3D=
email :
PS1, Line 206:     if (x509 =3D=3D NULL)
we normally assume parameters are valid and don't do NULL checks right at t=
he beginning of the function body.

therefore we should check the return value of `X509_get_subject_name()` bef=
ore calling `extract_x509_field_ssl()` in `backend_x509_get_username()`



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1388?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1e9c7eee06bf5f2e8aed8cd2523684539294ac8b
Gerrit-Change-Number: 1388
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Comment-Date: Thu, 27 Nov 2025 10:01:44 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--kwlXwA8kdE8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1388?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_verify_ope=
nssl.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1388/comment/d4be6f27_e032b011?usp=3Demail=
">Patch Set #1, Line 206:</a> <code style=3D"font-family:monospace,monospac=
e">    if (x509 =3D=3D NULL)</code></p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">we normally assume parameters are v=
alid and don&#39;t do NULL checks right at the beginning of the function bo=
dy.</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">therefore we should check the return value of `X509_get_subject_nam=
e()` before calling `extract_x509_field_ssl()` in `backend_x509_get_usernam=
e()`</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1388?usp=3Demail">change 1388</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1388?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1e9c7eee06bf5f2e8aed8cd2523=
684539294ac8b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1388 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 27 Nov 2025 10:01:44=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--kwlXwA8kdE8=--


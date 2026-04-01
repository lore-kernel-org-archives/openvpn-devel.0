From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 1 Apr 2026 10:34:38 +0000
In-Reply-To: <gerrit.1774974242000.I6c2eda0e5bbb3a70b404f821e25ded81f0f5ddd5@...2715...>
References: <gerrit.1774974242000.I6c2eda0e5bbb3a70b404f821e25ded81f0f5ddd5@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <1140488e3ea1af942fce40fdd43e13e997eb8c21-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="84+ocA3LKck="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: OpenSSL 4.0: Use
 X509_check_certificate_times instead of X509_cmp_time
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

--84+ocA3LKck=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change by plaisthos. ( http://gerr=
it.openvpn.net/c/openvpn/+/1595?usp=3Demail )

Change subject: OpenSSL 4.0: Use X509_check_certificate_times instead of X5=
09_cmp_time
......................................................................


Patch Set 2: Code-Review-1

(2 comments)

File src/openvpn/ssl_openssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1595/comment/ce3d6801_f2791ace?usp=3D=
email :
PS2, Line 691:         msg(D_TLS_DEBUG_MED, "Failed to initialise certifica=
te verification parameters.");
Shouldn't we return from the function here?


http://gerrit.openvpn.net/c/openvpn/+/1595/comment/ed877e20_2571c8e7?usp=3D=
email :
PS2, Line 708:     if (ret =3D=3D X509_V_ERR_ERROR_IN_CERT_NOT_AFTER_FIELD)
error, not ret



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1595?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6c2eda0e5bbb3a70b404f821e25ded81f0f5ddd5
Gerrit-Change-Number: 1595
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Wed, 01 Apr 2026 10:34:38 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--84+ocA3LKck=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1595?usp=3Demail">V=
iew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_openssl.c=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1595/comment/ce3d6801_f2791ace?usp=3Demail">Patc=
h Set #2, Line 691:</a> <code style=3D"font-family:monospace,monospace">   =
     msg(D_TLS_DEBUG_MED, &quot;Failed to initialise certificate verificati=
on parameters.&quot;);</code></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Shouldn&#39;t we return from the function=
 here?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1595/co=
mment/ed877e20_2571c8e7?usp=3Demail">Patch Set #2, Line 708:</a> <code styl=
e=3D"font-family:monospace,monospace">    if (ret =3D=3D X509_V_ERR_ERROR_I=
N_CERT_NOT_AFTER_FIELD)</code></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">error, not ret</p></li></ul></li></ul><p=
>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1595?usp=
=3Demail">change 1595</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1595?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6c2eda0e5bbb3a70b404f821e25=
ded81f0f5ddd5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1595 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 01 Apr 2026 10:34:38=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--84+ocA3LKck=--


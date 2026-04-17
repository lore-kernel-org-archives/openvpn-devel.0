From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 17 Apr 2026 16:46:29 +0000
In-Reply-To: <gerrit.1774974242000.I6c2eda0e5bbb3a70b404f821e25ded81f0f5ddd5@...2715...>
References: <gerrit.1774974242000.I6c2eda0e5bbb3a70b404f821e25ded81f0f5ddd5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., matthias.andree@...68...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7338b9ef8baddde63dba2f100286d39eeb37ba0e-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="61BNxc4ooEI="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: OpenSSL 4.0: Use
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
Cc: mandree <matthias.andree@...68...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--61BNxc4ooEI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mandree, plaisthos.

cron2 has posted comments on this change by plaisthos. ( http://gerrit.open=
vpn.net/c/openvpn/+/1595?usp=3Demail )

Change subject: OpenSSL 4.0: Use X509_check_certificate_times instead of X5=
09_cmp_time
......................................................................


Patch Set 5:

(3 comments)

Patchset:

PS5:
After some quick discussion we didn't feel like doing another round - the A=
PI documentation says "these 4 error codes are possible" and it's hard to i=
magine anything else (a generic "EWEIRDFAILURE" can always be signalled as =
one of the two "cannot read <time> from cert" errors).  So we progress here=
, for now.


File src/openvpn/ssl_openssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1595/comment/4abd9506_936c6580?usp=3D=
email :
PS3, Line 688:     if (error =3D=3D X509_V_ERR_ERROR_IN_CERT_NOT_BEFORE_FIE=
LD)
> Not sure whether that is bikeshedding, but should we maybe use a case sta=
tement here? Looks more app [=E2=80=A6]
Done


File src/openvpn/ssl_openssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1595/comment/60f7cadb_7d8a7424?usp=3D=
email :
PS5, Line 724:     }
> The followup question to Frank's is whether there should be a default bra=
nch decoding other error va [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1595?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6c2eda0e5bbb3a70b404f821e25ded81f0f5ddd5
Gerrit-Change-Number: 1595
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: mandree <matthias.andree@...68...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mandree <matthias.andree@...68...>
Gerrit-Comment-Date: Fri, 17 Apr 2026 16:46:29 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Comment-In-Reply-To: mandree <matthias.andree@...68...>

--61BNxc4ooEI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, mandree, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1595?usp=3Demail">View =
Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1595?tab=3Dcomments&amp;usp=3Demail">Patch Set #5:</a> </p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">After some qui=
ck discussion we didn&#39;t feel like doing another round - the API documen=
tation says &quot;these 4 error codes are possible&quot; and it&#39;s hard =
to imagine anything else (a generic &quot;EWEIRDFAILURE&quot; can always be=
 signalled as one of the two &quot;cannot read &lt;time&gt; from cert&quot;=
 errors).  So we progress here, for now.</p></li></ul></li><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/ssl_openssl.c:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1595/comment/4abd9506_936c6580?usp=3Demail">Patch Set #3, Line 688:</=
a> <code style=3D"font-family:monospace,monospace">    if (error =3D=3D X50=
9_V_ERR_ERROR_IN_CERT_NOT_BEFORE_FIELD)</code></p><p><blockquote style=3D"b=
order-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Not sure whet=
her that is bikeshedding, but should we maybe use a case statement here? Lo=
oks more app [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_openssl.c:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1595/comment/60f7cadb_7d8a7424?usp=3Demail">Patch Set #5, Line=
 724:</a> <code style=3D"font-family:monospace,monospace">    }</code></p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">The followup question to Frank&#39;s is whether there should be =
a default branch decoding other error va [=E2=80=A6]</blockquote></p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done<=
/p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1595?usp=3Demail">change 1595</a>. To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setting=
s?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.or=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1595?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6c2eda0e5bbb3a70b404f821e25=
ded81f0f5ddd5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1595 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: mandree &lt;matthias.andree@...2908...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mandree &lt;matthias.andree@=
...68...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 17 Apr 2026 16:46:29=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: mandree &lt;matthias.andr=
ee@...68...&gt; </div>

</body></html>=

--61BNxc4ooEI=--


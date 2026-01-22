From: "MaxF (Code Review)" <gerrit@...515...>
Date: Thu, 22 Jan 2026 17:47:18 +0000
In-Reply-To: <gerrit.1765571645000.Ib251d546d993b96ed3bd8cb9111bcc627cdb0fae@...2715...>
References: <gerrit.1765571645000.Ib251d546d993b96ed3bd8cb9111bcc627cdb0fae@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., steffan@...1856...
Message-ID: <1dda46e8c134bcfd70441adaa49aca6022f89e60-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CmwGMhFitS8="; charset=UTF-8
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
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, syzzer <steffan@...1856...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CmwGMhFitS8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, syzzer.

MaxF has posted comments on this change by MaxF. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/1441?usp=3Demail )

Change subject: Add support for Mbed TLS 4
......................................................................


Patch Set 7:

(3 comments)

Patchset:

PS5:
> There is something wrong with connecting to an OpenSSL based OpeNVPN, e.g=
. against community VPN: [=E2=80=A6]
After looking around a bit, I found that this error code isn't exactly an e=
rror, but it's meant to tell the application "there's a new session ticket,=
 if you want to do anything with that" (see e.g. https://github.com/Mbed-TL=
S/mbedtls/issues/8749).

In 3.6 it used to be the case that you had to opt in to that by calling mbe=
dtls_ssl_conf_tls13_enable_signal_new_session_tickets but that function see=
ms to be gone. Disabling session tickets altogether with mbedtls_ssl_conf_s=
ession_tickets doesn't seem to do anything in TLS 1.3 either. I did a git g=
rep on the mbedtls source, it doesn't seem to be checked at all in ssl_tls1=
3.c.

So ultimately I decided to just treat this error code like WANT_READ or WAN=
T_WRITE and keep running. With that change, I can connect an openvpn-mbedtl=
s client to an openssl server, and ignoring the error doesn't seem to cause=
 any problems.


Patchset:

PS6:
Fixed connecting an mbedtls client to an openssl server. Also updated READM=
E.mbedtls.


File src/openvpn/ssl_mbedtls.c:

http://gerrit.openvpn.net/c/openvpn/+/1441/comment/9eb67876_ce448f68?usp=3D=
email :
PS5, Line 610: {
> /Users/arne/oss/openvpn-git/src/openvpn/ssl_mbedtls. [=E2=80=A6]
Fixed. The unused function is ifdefd out now.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1441?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib251d546d993b96ed3bd8cb9111bcc627cdb0fae
Gerrit-Change-Number: 1441
Gerrit-PatchSet: 7
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: syzzer <steffan@...1856...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: syzzer <steffan@...1856...>
Gerrit-Comment-Date: Thu, 22 Jan 2026 17:47:18 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>

--CmwGMhFitS8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, syzzer. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1441?usp=3Demail">View =
Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1441?tab=3Dcomments&amp;usp=3Demail">Patch Set #5:</a> </p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">The=
re is something wrong with connecting to an OpenSSL based OpeNVPN, e.g. aga=
inst community VPN: [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">After looking around a b=
it, I found that this error code isn&#39;t exactly an error, but it&#39;s m=
eant to tell the application &quot;there&#39;s a new session ticket, if you=
 want to do anything with that&quot; (see e.g. https://github.com/Mbed-TLS/=
mbedtls/issues/8749).</p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">In 3.6 it used to be the case that you had to opt=
 in to that by calling mbedtls_ssl_conf_tls13_enable_signal_new_session_tic=
kets but that function seems to be gone. Disabling session tickets altogeth=
er with mbedtls_ssl_conf_session_tickets doesn&#39;t seem to do anything in=
 TLS 1.3 either. I did a git grep on the mbedtls source, it doesn&#39;t see=
m to be checked at all in ssl_tls13.c.</p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">So ultimately I decided to just =
treat this error code like WANT_READ or WANT_WRITE and keep running. With t=
hat change, I can connect an openvpn-mbedtls client to an openssl server, a=
nd ignoring the error doesn&#39;t seem to cause any problems.</p></li></ul>=
</li><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1441?tab=3Dcomments&amp;usp=3Demail">Patch Set #6:</a> </p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Fixed conn=
ecting an mbedtls client to an openssl server. Also updated README.mbedtls.=
</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn=
/ssl_mbedtls.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1441/comment/9eb67876_ce448f68?us=
p=3Demail">Patch Set #5, Line 610:</a> <code style=3D"font-family:monospace=
,monospace">{</code></p><p><blockquote style=3D"border-left: 1px solid #aaa=
; margin: 10px 0; padding: 0 10px;">/Users/arne/oss/openvpn-git/src/openvpn=
/ssl_mbedtls. [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Fixed. The unused function is if=
defd out now.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1441?usp=3Demail">change 1441</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1441?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib251d546d993b96ed3bd8cb9111=
bcc627cdb0fae </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1441 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: syzzer &lt;steffan@...2115...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 22 Jan 2026 17:47:18=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>

</body></html>=

--CmwGMhFitS8=--


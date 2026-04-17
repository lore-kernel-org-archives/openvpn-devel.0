From: "mandree (Code Review)" <gerrit@...515...>
Date: Fri, 17 Apr 2026 10:58:52 +0000
In-Reply-To: <gerrit.1774974242000.I6c2eda0e5bbb3a70b404f821e25ded81f0f5ddd5@...2715...>
References: <gerrit.1774974242000.I6c2eda0e5bbb3a70b404f821e25ded81f0f5ddd5@...2715...>
Reply-To: matthias.andree@...68..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d5af46d4a4f3d3215d8f781f7c5764bcf5658bf5-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="r1YgNDt3QKw="; charset=UTF-8
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
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--r1YgNDt3QKw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

mandree has posted comments on this change by plaisthos. ( http://gerrit.op=
envpn.net/c/openvpn/+/1595?usp=3Demail )

Change subject: OpenSSL 4.0: Use X509_check_certificate_times instead of X5=
09_cmp_time
......................................................................


Patch Set 5:

(2 comments)

Patchset:

PS5:
So we're using a switch to decode a subset of errors - certainly the most l=
ikely ones, but should there be a fallback path for all other errors to rep=
ort them?


File src/openvpn/ssl_openssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1595/comment/ec8212fc_9969e4dd?usp=3D=
email :
PS5, Line 724:     }
The followup question to Frank's is whether there should be a default branc=
h decoding other error values in a generic way and report them.



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
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: mandree <matthias.andree@...68...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Fri, 17 Apr 2026 10:58:52 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--r1YgNDt3QKw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1595?usp=3Demail">View =
Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1595?tab=3Dcomments&amp;usp=3Demail">Patch Set #5:</a> </p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">So we&#39;re u=
sing a switch to decode a subset of errors - certainly the most likely ones=
, but should there be a fallback path for all other errors to report them?<=
/p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/=
ssl_openssl.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1595/comment/ec8212fc_9969e4dd?us=
p=3Demail">Patch Set #5, Line 724:</a> <code style=3D"font-family:monospace=
,monospace">    }</code></p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">The followup question to Frank&#39;s is whethe=
r there should be a default branch decoding other error values in a generic=
 way and report them.</p></li></ul></li></ul><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1595?usp=3Demail">change 1595</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1595?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6c2eda0e5bbb3a70b404f821e25=
ded81f0f5ddd5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1595 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: mandree &lt;matthias.andree@...2908...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 17 Apr 2026 10:58:52=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>=

--r1YgNDt3QKw=--


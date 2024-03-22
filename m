From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 22 Mar 2024 18:39:44 +0000
In-Reply-To: <gerrit.1711123146000.I3c6fd36eb9daee9244d6dc6d9f22de1c5cf9d039@...2715...>
References: <gerrit.1711123146000.I3c6fd36eb9daee9244d6dc6d9f22de1c5cf9d039@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <6fe4585d3fcaa3541f8c88e4d7c8b3fe41760bc3-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bLKMaAufqHA="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Use snprintf
 instead of sprintf for get_ssl_library_version
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--bLKMaAufqHA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/545?usp=3Demail )

Change subject: Use snprintf instead of sprintf for get_ssl_library_version
......................................................................


Patch Set 1:

(1 comment)

File src/openvpn/ssl_mbedtls.c:

http://gerrit.openvpn.net/c/openvpn/+/545/comment/7c92da42_95f3de4f :
PS1, Line 1617:     snprintf(mbedtls_version, sizeof(mbedtls_version), "mbe=
d TLS %d.%d.%d",
> Do we want to use openvpn_snprintf here?
I think we probably want to get rid of openvpn_snprintf instead. I will pre=
pare a patch to remove it and add unit tests to check if it behaves correct=
ly according to https://en.cppreference.com/w/c/io/snprintf it actually gua=
rantees the behaviour that we expect.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/545?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3c6fd36eb9daee9244d6dc6d9f22de1c5cf9d039
Gerrit-Change-Number: 545
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Fri, 22 Mar 2024 18:39:44 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--bLKMaAufqHA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/545?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_mbedtls.c:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/545/comment/7c92da42_95f3de4f">Patch Set #1, Line 1617=
:</a> <code style=3D"font-family:monospace,monospace">    snprintf(mbedtls_=
version, sizeof(mbedtls_version), &quot;mbed TLS %d.%d.%d&quot;,</code></p>=
<p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddin=
g: 0 10px;">Do we want to use openvpn_snprintf here?</blockquote></p><p sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">I think we probably wa=
nt to get rid of openvpn_snprintf instead. I will prepare a patch to remove=
 it and add unit tests to check if it behaves correctly according to https:=
//en.cppreference.com/w/c/io/snprintf it actually guarantees the behaviour =
that we expect.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/545?usp=3Demail">change 545</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/545?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3c6fd36eb9daee9244d6dc6d9f2=
2de1c5cf9d039 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 545 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 22 Mar 2024 18:39:44=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--bLKMaAufqHA=--


From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 26 Mar 2025 12:54:25 +0000
In-Reply-To: <gerrit.1742992852000.I8bbb6ffdac7d0029dbf3c13e62c11b61813c15ef@...2715...>
References: <gerrit.1742992852000.I8bbb6ffdac7d0029dbf3c13e62c11b61813c15ef@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <5210acce423207fccf23e69050f9ba8b9f20912c-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gZ53jvUIuL4="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix compatibility
 with mbedTLS 2.28.10+ and 3.6.3+
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gZ53jvUIuL4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/918?usp=3Demail )

Change subject: Fix compatibility with mbedTLS 2.28.10+ and 3.6.3+
......................................................................


Patch Set 1:

(1 comment)

File src/openvpn/ssl_mbedtls.c:

http://gerrit.openvpn.net/c/openvpn/+/918/comment/f233a8d9_03afa70d :
PS1, Line 1249:     /* Tell mbedTLS that we generally do not care about the=
 hostname */
That sounds a bit broken. I would rather say Tell mbed TLS that we do not n=
eed the library to verify the hostname as we do the verification in our own=
 callback using mbedtls_ssl_conf_verify if requested by options.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/918?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8bbb6ffdac7d0029dbf3c13e62c11b61813c15ef
Gerrit-Change-Number: 918
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 26 Mar 2025 12:54:25 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--gZ53jvUIuL4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/918?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_mbedtls.c:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/918/comment/f233a8d9_03afa70d">Patch Set #1, Line 1249=
:</a> <code style=3D"font-family:monospace,monospace">    /* Tell mbedTLS t=
hat we generally do not care about the hostname */</code></p><p style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">That sounds a bit broken. I wo=
uld rather say Tell mbed TLS that we do not need the library to verify the =
hostname as we do the verification in our own callback using mbedtls_ssl_co=
nf_verify if requested by options.</p></li></ul></li></ul><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/918?usp=3Demail">change 9=
18</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/918?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8bbb6ffdac7d0029dbf3c13e62c=
11b61813c15ef </div>
<div style=3D"display:none"> Gerrit-Change-Number: 918 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 26 Mar 2025 12:54:25=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--gZ53jvUIuL4=--


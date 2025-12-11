From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 11 Dec 2025 12:02:38 +0000
In-Reply-To: <gerrit.1765381324000.I21251a42f94fa1d9de083d2acd95b887658c5760@...2715...>
References: <gerrit.1765381324000.I21251a42f94fa1d9de083d2acd95b887658c5760@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <b1a0204a89710b3b74c50e8993c8aecc3aa2a011-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lJpLXL8Qh14="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change ssl_ctx in
 struct tls_options to be a pointer
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

--lJpLXL8Qh14=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change by plaisthos. ( http://gerr=
it.openvpn.net/c/openvpn/+/1431?usp=3Demail )

Change subject: Change ssl_ctx in struct tls_options to be a pointer
......................................................................


Patch Set 4: Code-Review-1

(5 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/1431/comment/7420438b_56404671?usp=3D=
email :
PS4, Line 16: and also the CRL being reload multiple times.
"reloaded"


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/1431/comment/4b726ecf_b6b6dad8?usp=3D=
email :
PS4, Line 3129:          * SSL context. */
Please leave `*/` on its own line for consistency


File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1431/comment/a249f13e_f414aad5?usp=3D=
email :
PS4, Line 878:      * all instances sharing the same context
Please add missing "."


File src/openvpn/ssl_common.h:

http://gerrit.openvpn.net/c/openvpn/+/1431/comment/6d9492a9_d331710c?usp=3D=
email :
PS4, Line 308:     /* our master TLS context from which all SSL objects der=
ived,
"are derived"?


http://gerrit.openvpn.net/c/openvpn/+/1431/comment/beee4aac_f65ec234?usp=3D=
email :
PS4, Line 309:      * this context is shared between all instances so point
"points to"?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1431?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I21251a42f94fa1d9de083d2acd95b887658c5760
Gerrit-Change-Number: 1431
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Thu, 11 Dec 2025 12:02:38 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--lJpLXL8Qh14=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>Patch set 4:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1431?usp=3Demail">V=
iew Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1431/comment/7420438b_56404671?usp=3Demail">Patch Set #4, Line=
 16:</a> <code style=3D"font-family:monospace,monospace">and also the CRL b=
eing reload multiple times.</code></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">&quot;reloaded&quot;</p></li></ul></=
li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init.c:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1431/comment/4b726ecf_b6b6dad8?usp=3Demail">Patch Set #4,=
 Line 3129:</a> <code style=3D"font-family:monospace,monospace">         * =
SSL context. */</code></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Please leave `*/` on its own line for consistenc=
y</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvp=
n/ssl.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1431/comment/a249f13e_f414aad5?usp=3Demai=
l">Patch Set #4, Line 878:</a> <code style=3D"font-family:monospace,monospa=
ce">     * all instances sharing the same context</code></p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Please add mis=
sing &quot;.&quot;</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><=
p>File src/openvpn/ssl_common.h:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1431/comment/6d94=
92a9_d331710c?usp=3Demail">Patch Set #4, Line 308:</a> <code style=3D"font-=
family:monospace,monospace">    /* our master TLS context from which all SS=
L objects derived,</code></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">&quot;are derived&quot;?</p></li><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1431/comment/beee4aac_f65ec234?us=
p=3Demail">Patch Set #4, Line 309:</a> <code style=3D"font-family:monospace=
,monospace">     * this context is shared between all instances so point</c=
ode></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">&quot;points to&quot;?</p></li></ul></li></ul><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/1431?usp=3Demail">change 143=
1</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1431?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I21251a42f94fa1d9de083d2acd9=
5b887658c5760 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1431 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 11 Dec 2025 12:02:38=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--lJpLXL8Qh14=--


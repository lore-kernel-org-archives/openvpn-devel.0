From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 12 Mar 2026 11:35:24 +0000
In-Reply-To: <gerrit.1773251317000.Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c@...2715...>
References: <gerrit.1773251317000.Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <28229b9ba65914fb72b692c87da2725c29c228e3-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2XYEmhGMVA4="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change hash values
 in our hash map from uint32_t to uint64_t
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

--2XYEmhGMVA4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change by plaisthos. ( http://gerr=
it.openvpn.net/c/openvpn/+/1570?usp=3Demail )

Change subject: Change hash values in our hash map from uint32_t to uint64_t
......................................................................


Patch Set 2:

(1 comment)

File tests/unit_tests/openvpn/test_misc.c:

http://gerrit.openvpn.net/c/openvpn/+/1570/comment/e9ce02ce_c816e1a1?usp=3D=
email :
PS2, Line 176:     struct hash *hash =3D hash_init(10000, (uint32_t)get_ran=
dom(), word_hash_function, word_compare_function);
get_random already returns uint32_t, so this is a meaningless cast.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1570?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c
Gerrit-Change-Number: 1570
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Thu, 12 Mar 2026 11:35:24 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--2XYEmhGMVA4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1570?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_=
misc.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1570/comment/e9ce02ce_c816e1a1?usp=3Demail=
">Patch Set #2, Line 176:</a> <code style=3D"font-family:monospace,monospac=
e">    struct hash *hash =3D hash_init(10000, (uint32_t)get_random(), word_=
hash_function, word_compare_function);</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">get_random already retur=
ns uint32_t, so this is a meaningless cast.</p></li></ul></li></ul><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1570?usp=3Demail=
">change 1570</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1570?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib8140107f98164d2a2e1768a6d8=
ac65016cd7f7c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1570 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 12 Mar 2026 11:35:24=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>=

--2XYEmhGMVA4=--


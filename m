From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 26 Feb 2026 13:39:42 +0000
In-Reply-To: <gerrit.1770986118000.I8b0d1cad7062856abcc40c4e16ec93b45295bbd3@...2715...>
References: <gerrit.1770986118000.I8b0d1cad7062856abcc40c4e16ec93b45295bbd3@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5fa74736976396f3472554888e9cfa932add9d9e-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7WRN4FIo1g4="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add support for user
 defined network namespace
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--7WRN4FIo1g4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

its_Giaan has posted comments on this change by its_Giaan. ( http://gerrit.=
openvpn.net/c/openvpn/+/1521?usp=3Demail )

Change subject: Add support for user defined network namespace
......................................................................


Patch Set 3:

(3 comments)

File src/openvpn/networking_sitnl.c:

http://gerrit.openvpn.net/c/openvpn/+/1521/comment/122e5461_ae4d3b5a?usp=3D=
email :
PS1, Line 841:         goto err;
> This changes it from effectively `M_FATAL | M_ERRNO` to `M_INFO | M_ERRNO=
`. [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/05bd4cdb_f0807205?usp=3D=
email :
PS1, Line 848:         goto err;
> M_ERRNO?
Done


File src/openvpn/networking_sitnl.c:

http://gerrit.openvpn.net/c/openvpn/+/1521/comment/a653993b_b8776da3?usp=3D=
email :
PS2, Line 206:             msg(M_ERRNO, "%s: Network namespace %s does not =
exist\n", __func__, path);
> Hmm, why did you change `M_WARN` to `M_ERRNO`? That means the same as `M_=
INFO | M_ERRNO` AFAICT. [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1521?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8b0d1cad7062856abcc40c4e16ec93b45295bbd3
Gerrit-Change-Number: 1521
Gerrit-PatchSet: 3
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Thu, 26 Feb 2026 13:39:42 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: its_Giaan <gianmarco@...2726...>
Comment-In-Reply-To: flichtenheld <frank@...2641...>

--7WRN4FIo1g4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521?usp=3Demail">View =
Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/networking_sitnl.=
c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1521/comment/122e5461_ae4d3b5a?usp=3Demail">Pat=
ch Set #1, Line 841:</a> <code style=3D"font-family:monospace,monospace">  =
      goto err;</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">This changes it from effectively `M_F=
ATAL | M_ERRNO` to `M_INFO | M_ERRNO`. [=E2=80=A6]</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/comment/05b=
d4cdb_f0807205?usp=3Demail">Patch Set #1, Line 848:</a> <code style=3D"font=
-family:monospace,monospace">        goto err;</code></p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">M_ERRN=
O?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding:=
 0;"><p>File src/openvpn/networking_sitnl.c:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/=
comment/a653993b_b8776da3?usp=3Demail">Patch Set #2, Line 206:</a> <code st=
yle=3D"font-family:monospace,monospace">            msg(M_ERRNO, &quot;%s: =
Network namespace %s does not exist\n&quot;, __func__, path);</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">Hmm, why did you change `M_WARN` to `M_ERRNO`? That means the same=
 as `M_INFO | M_ERRNO` AFAICT. [=E2=80=A6]</blockquote></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></=
ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1521?usp=3Demail">change 1521</a>. To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Dem=
ail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1521?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8b0d1cad7062856abcc40c4e16e=
c93b45295bbd3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1521 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 26 Feb 2026 13:39:42=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: its_Giaan &lt;gianmarco@...220...=
..2726...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>

</body></html>=

--7WRN4FIo1g4=--


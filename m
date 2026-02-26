From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 26 Feb 2026 11:37:24 +0000
In-Reply-To: <gerrit.1770986118000.I8b0d1cad7062856abcc40c4e16ec93b45295bbd3@...2715...>
References: <gerrit.1770986118000.I8b0d1cad7062856abcc40c4e16ec93b45295bbd3@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net
Message-ID: <a75a01b6ba67e9d881aa540d9b246d7a905e7245-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wGcfiKB/RjI="; charset=UTF-8
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
To: its_Giaan <gianmarco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--wGcfiKB/RjI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos.

flichtenheld has posted comments on this change by its_Giaan. ( http://gerr=
it.openvpn.net/c/openvpn/+/1521?usp=3Demail )

Change subject: Add support for user defined network namespace
......................................................................


Patch Set 2: Code-Review-2

(6 comments)

File src/openvpn/networking_sitnl.h:

http://gerrit.openvpn.net/c/openvpn/+/1521/comment/bb1d8a23_20125c14?usp=3D=
email :
PS1, Line 98: int openvpn_if_nametoindex(const char *ifname, int netnsid);
> I'm not thrilled by the idea of having a function that does too much stuf=
f so I only moved the call  [=E2=80=A6]
Done


File src/openvpn/networking_sitnl.c:

http://gerrit.openvpn.net/c/openvpn/+/1521/comment/6558e3ae_b6c53a15?usp=3D=
email :
PS1, Line 841:         goto err;
> M_ERRNO?
This changes it from effectively `M_FATAL | M_ERRNO` to `M_INFO | M_ERRNO`.=
 That feels like a big change. If you want the error to be fatal, then just=
 remove the code after the msg() call. If you do not want it to be fatal, t=
hen use `M_WARN | M_ERRNO`. `M_INFO` feels wrong.


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/6bd42df7_ac3131a1?usp=3D=
email :
PS1, Line 1002: err:
> SITNL_ADDATTR() requires a label
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/623af649_3ec0329e?usp=3D=
email :
PS1, Line 1124: err:
> SITNL_ADDATTR() requires a label
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/3c69f209_c727ee44?usp=3D=
email :
PS1, Line 1903:         return netnsid;
> Addressed in http://gerrit.openvpn. [=E2=80=A6]
Done


File src/openvpn/networking_sitnl.c:

http://gerrit.openvpn.net/c/openvpn/+/1521/comment/8758f6bd_4e04d658?usp=3D=
email :
PS2, Line 206:             msg(M_ERRNO, "%s: Network namespace %s does not =
exist\n", __func__, path);
Hmm, why did you change `M_WARN` to `M_ERRNO`? That means the same as `M_IN=
FO | M_ERRNO` AFAICT. So I would have expected you to retain the `M_WARN`. =
`M_ERRNO` is not a level but an additional flag that ensures that strerr ou=
tput is appended.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1521?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8b0d1cad7062856abcc40c4e16ec93b45295bbd3
Gerrit-Change-Number: 1521
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Comment-Date: Thu, 26 Feb 2026 11:37:24 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: its_Giaan <gianmarco@...2726...>
Comment-In-Reply-To: flichtenheld <frank@...2641...>

--wGcfiKB/RjI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: its_Giaan, plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521?usp=3Demail">V=
iew Change</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/networking_si=
tnl.h:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1521/comment/bb1d8a23_20125c14?usp=3Demail"=
>Patch Set #1, Line 98:</a> <code style=3D"font-family:monospace,monospace"=
>int openvpn_if_nametoindex(const char *ifname, int netnsid);</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">I&#39;m not thrilled by the idea of having a function that does to=
o much stuff so I only moved the call  [=E2=80=A6]</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ne=
tworking_sitnl.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/comment/6558e3ae_b6c53a15?=
usp=3Demail">Patch Set #1, Line 841:</a> <code style=3D"font-family:monospa=
ce,monospace">        goto err;</code></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">M_ERRNO?</blockquote>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">This changes it from effectively `M_FATAL | M_ERRNO` to `M_INFO | M_ER=
RNO`. That feels like a big change. If you want the error to be fatal, then=
 just remove the code after the msg() call. If you do not want it to be fat=
al, then use `M_WARN | M_ERRNO`. `M_INFO` feels wrong.</p></li><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/comment/6bd42df7_ac3131a1?us=
p=3Demail">Patch Set #1, Line 1002:</a> <code style=3D"font-family:monospac=
e,monospace">err:</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">SITNL_ADDATTR() requires a label</b=
lockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Acknowledged</p></li><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1521/comment/623af649_3ec0329e?usp=3Demail">Patch Set #1, Lin=
e 1124:</a> <code style=3D"font-family:monospace,monospace">err:</code></p>=
<p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddin=
g: 0 10px;">SITNL_ADDATTR() requires a label</blockquote></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged<=
/p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/comment/3=
c69f209_c727ee44?usp=3Demail">Patch Set #1, Line 1903:</a> <code style=3D"f=
ont-family:monospace,monospace">        return netnsid;</code></p><p><block=
quote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px=
;">Addressed in http://gerrit.openvpn. [=E2=80=A6]</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ne=
tworking_sitnl.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/comment/8758f6bd_4e04d658?=
usp=3Demail">Patch Set #2, Line 206:</a> <code style=3D"font-family:monospa=
ce,monospace">            msg(M_ERRNO, &quot;%s: Network namespace %s does =
not exist\n&quot;, __func__, path);</code></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Hmm, why did you change `M_W=
ARN` to `M_ERRNO`? That means the same as `M_INFO | M_ERRNO` AFAICT. So I w=
ould have expected you to retain the `M_WARN`. `M_ERRNO` is not a level but=
 an additional flag that ensures that strerr output is appended.</p></li></=
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
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 26 Feb 2026 11:37:24=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: its_Giaan &lt;gianmarco@...220...=
..2726...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>

</body></html>=

--wGcfiKB/RjI=--


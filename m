From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 17 Mar 2026 11:34:37 +0000
In-Reply-To: <gerrit.1770986118000.I8b0d1cad7062856abcc40c4e16ec93b45295bbd3@...2715...>
References: <gerrit.1770986118000.I8b0d1cad7062856abcc40c4e16ec93b45295bbd3@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net
Message-ID: <8c4077fdd5ab95548386fc6b498582b7161e778a-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9mxI7tjzqv8="; charset=UTF-8
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

--9mxI7tjzqv8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos.

flichtenheld has posted comments on this change by its_Giaan. ( http://gerr=
it.openvpn.net/c/openvpn/+/1521?usp=3Demail )

Change subject: Add support for user defined network namespace
......................................................................


Patch Set 3: Code-Review-1

(4 comments)

File src/openvpn/networking_sitnl.c:

http://gerrit.openvpn.net/c/openvpn/+/1521/comment/57e35eeb_25accb45?usp=3D=
email :
PS3, Line 638:     SITNL_ADDATTR(&req.n, sizeof(req), IFLA_TARGET_NETNSID, =
&netnsid, 4);
Yes, sizeof(int) =3D=3D 4, but do we need to hard-code this here?

This issue is all over the code, only noting the first instance I found.


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/cc6d4520_806e8ed9?usp=3D=
email :
PS3, Line 1172:     netns_restore(orig);
Why do we skip the restore on error?


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/6b59d92f_2d13ab27?usp=3D=
email :
PS3, Line 1347:         msg(M_WARN, "%s: cannot get ifindex for %s: %s", __=
func__, np(iface), strerror(errno));
Please switch to M_ERRNO as well


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/1521/comment/8524456a_c0f153f1?usp=3D=
email :
PS3, Line 6461:         msg(M_WARN, "NOTE: --netns is supported only on Lin=
ux when SITNL is built-in");
I think "when SITNL support is enabled" would sound better



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
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Comment-Date: Tue, 17 Mar 2026 11:34:37 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--9mxI7tjzqv8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: its_Giaan, plaisthos. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521?usp=3Demail">V=
iew Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/networking_si=
tnl.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1521/comment/57e35eeb_25accb45?usp=3Demail"=
>Patch Set #3, Line 638:</a> <code style=3D"font-family:monospace,monospace=
">    SITNL_ADDATTR(&amp;req.n, sizeof(req), IFLA_TARGET_NETNSID, &amp;netn=
sid, 4);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Yes, sizeof(int) =3D=3D 4, but do we need to hard-code =
this here?</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">This issue is all over the code, only noting the first insta=
nce I found.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
521/comment/cc6d4520_806e8ed9?usp=3Demail">Patch Set #3, Line 1172:</a> <co=
de style=3D"font-family:monospace,monospace">    netns_restore(orig);</code=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Why do we skip the restore on error?</p></li><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1521/comment/6b59d92f_2d13ab27?usp=3Demail">Pa=
tch Set #3, Line 1347:</a> <code style=3D"font-family:monospace,monospace">=
        msg(M_WARN, &quot;%s: cannot get ifindex for %s: %s&quot;, __func__=
, np(iface), strerror(errno));</code></p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Please switch to M_ERRNO as well<=
/p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/=
options.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1521/comment/8524456a_c0f153f1?usp=3Dem=
ail">Patch Set #3, Line 6461:</a> <code style=3D"font-family:monospace,mono=
space">        msg(M_WARN, &quot;NOTE: --netns is supported only on Linux w=
hen SITNL is built-in&quot;);</code></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">I think &quot;when SITNL support i=
s enabled&quot; would sound better</p></li></ul></li></ul><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521?usp=3Demail">change =
1521</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 17 Mar 2026 11:34:37=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--9mxI7tjzqv8=--


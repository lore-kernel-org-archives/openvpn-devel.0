From: "kallisti5 (Code Review)" <gerrit@...515...>
Date: Tue, 26 Nov 2024 18:56:02 +0000
In-Reply-To: <gerrit.1732634928000.I1a22724f28c5cd47f6df178b49f44087d7c2b6fd@...2715...>
References: <gerrit.1732634928000.I1a22724f28c5cd47f6df178b49f44087d7c2b6fd@...2715...>
Reply-To: alex@...2837..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ce818feab7ba369ee8c9bdc6863aa4f7080e8cd1-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KGm9i7l6lbA="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Haiku: Add calls to
 manage routing table
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--KGm9i7l6lbA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

kallisti5 has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/688?usp=3Demail )

Change subject: Haiku: Add calls to manage routing table
......................................................................


Patch Set 5:

(8 comments)

Patchset:

PS5:
Changes 99% done.  One remaining.  strncpy? Not sure what strcpynt is.


File src/openvpn/route.c:

http://gerrit.openvpn.net/c/openvpn/+/688/comment/b11d677f_d33d20c9 :
PS3, Line 3940:     sockfd =3D socket(AF_INET, SOCK_DGRAM, 0);
> Can be merged with the previous line?
Done


http://gerrit.openvpn.net/c/openvpn/+/688/comment/ad7dfc0e_82230690 :
PS3, Line 3942:         msg(M_INFO, "%s: Error opening socket for AF_INET",=
 __func__);
> M_ERRNO?
Done


http://gerrit.openvpn.net/c/openvpn/+/688/comment/edd8c58c_a5545f1a :
PS3, Line 3949:         msg(M_INFO, "%s: Error getting routing table size",=
 __func__);
> M_ERRNO?
Done


http://gerrit.openvpn.net/c/openvpn/+/688/comment/15117370_186fb3a1 :
PS3, Line 3958: N
> Use `check_malloc_return`.
Done


http://gerrit.openvpn.net/c/openvpn/+/688/comment/c99a0ee5_6001d640 :
PS3, Line 3976:             strcpy(rgi->iface, interface->ifr_name);
> Should probably use `strcpynt`
strncpy?


http://gerrit.openvpn.net/c/openvpn/+/688/comment/a9cb3152_0855c379 :
PS3, Line 3979:         int32 addressSize =3D 0;
> no CamelCase please.
Done


http://gerrit.openvpn.net/c/openvpn/+/688/comment/3a9f5015_6ae45d40 :
PS3, Line 3990: }
> This seems to leak memory from the malloc?
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/688?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1a22724f28c5cd47f6df178b49f44087d7c2b6fd
Gerrit-Change-Number: 688
Gerrit-PatchSet: 5
Gerrit-Owner: kallisti5 <alex@...2837...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 26 Nov 2024 18:56:02 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--KGm9i7l6lbA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/688?usp=3Demail">View C=
hange</a></p><p>8 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
688?tab=3Dcomments">Patch Set #5:</a> </p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Changes 99% done.  One remaining.  strncpy? Not s=
ure what strcpynt is.</p></li></ul></li><li style=3D"margin: 0; padding: 0;=
"><p>File src/openvpn/route.c:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/688/comment/b11d677=
f_d33d20c9">Patch Set #3, Line 3940:</a> <code style=3D"font-family:monospa=
ce,monospace">    sockfd =3D socket(AF_INET, SOCK_DGRAM, 0);</code></p><p><=
blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0=
 10px;">Can be merged with the previous line?</blockquote></p><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/688/comment/ad7dfc0e_82230690">Patch S=
et #3, Line 3942:</a> <code style=3D"font-family:monospace,monospace">     =
   msg(M_INFO, &quot;%s: Error opening socket for AF_INET&quot;, __func__);=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">M_ERRNO?</blockquote></p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/688/comment/edd8c58c_a5545f1a">Patch Set #3, Line 39=
49:</a> <code style=3D"font-family:monospace,monospace">        msg(M_INFO,=
 &quot;%s: Error getting routing table size&quot;, __func__);</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">M_ERRNO?</blockquote></p><p style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/688/comment/15117370_186fb3a1">Patch Set #3, Line 3958:</a> <code =
style=3D"font-family:monospace,monospace">N</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Use `che=
ck_malloc_return`.</blockquote></p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/688/comment/c99a0ee5_6001d640">Patch Set #3, Line 3976:</a> <code=
 style=3D"font-family:monospace,monospace">            strcpy(rgi-&gt;iface=
, interface-&gt;ifr_name);</code></p><p><blockquote style=3D"border-left: 1=
px solid #aaa; margin: 10px 0; padding: 0 10px;">Should probably use `strcp=
ynt`</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">strncpy?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
688/comment/a9cb3152_0855c379">Patch Set #3, Line 3979:</a> <code style=3D"=
font-family:monospace,monospace">        int32 addressSize =3D 0;</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">no CamelCase please.</blockquote></p><p style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/688/comment/3a9f5015_6ae45d40">Patch Set #3, Line =
3990:</a> <code style=3D"font-family:monospace,monospace">}</code></p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">This seems to leak memory from the malloc?</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><=
/ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/688?=
usp=3Demail">change 688</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/688?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1a22724f28c5cd47f6df178b49f=
44087d7c2b6fd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 688 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: kallisti5 &lt;alex@...2837...&gt=
; </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 26 Nov 2024 18:56:02=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--KGm9i7l6lbA=--


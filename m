From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 26 Feb 2026 09:48:44 +0000
In-Reply-To: <gerrit.1770986118000.I8b0d1cad7062856abcc40c4e16ec93b45295bbd3@...2715...>
References: <gerrit.1770986118000.I8b0d1cad7062856abcc40c4e16ec93b45295bbd3@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <dd3d1acdbcc6f53d369a9394af42e1d8267c2b99-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3UZOiNOlBNI="; charset=UTF-8
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

--3UZOiNOlBNI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

its_Giaan has posted comments on this change by its_Giaan. ( http://gerrit.=
openvpn.net/c/openvpn/+/1521?usp=3Demail )

Change subject: Add support for user defined network namespace
......................................................................


Patch Set 2:

(24 comments)

File src/openvpn/dco.c:

http://gerrit.openvpn.net/c/openvpn/+/1521/comment/896aa530_aee37115?usp=3D=
email :
PS1, Line 394:         msg(msglevel, "Note: --netns not supported by ovpn-d=
co, disabling data channel offload.");
> `ovpn` ? Or just "DCO"?
Done


File src/openvpn/networking_sitnl.h:

http://gerrit.openvpn.net/c/openvpn/+/1521/comment/54e1d744_317f8b7a?usp=3D=
email :
PS1, Line 52:  *              NETNS_RUN_DIR, e.g. /var/run/netns/<name>).
> Doxygen says `networking_sitnl. [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/dcdf2078_aa274ea0?usp=3D=
email :
PS1, Line 98: int openvpn_if_nametoindex(const char *ifname, int netnsid);
> This is ALWAYS called with `get_or_create_netnsid_sitnl`, so just move al=
l of that code inside and c [=E2=80=A6]
I'm not thrilled by the idea of having a function that does too much stuff =
so I only moved the call to get_or_create_netnsid_sitnl() inside.


File src/openvpn/networking_sitnl.c:

http://gerrit.openvpn.net/c/openvpn/+/1521/comment/fa0f2215_3cf98d28?usp=3D=
email :
PS1, Line 74: #define NETNS_RUN_DIR  "/var/run/netns"
> Wouldn't `/run` be a better value here? `/var/run` is just a symlink nowa=
days AFAIK
indeed


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/f4d47f64_4f660ee1?usp=3D=
email :
PS1, Line 206:             msg(M_WARN, "%s: Network namespace %s does not e=
xist\n", __func__, path);
> M_ERRNO?
Done


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/c43227fc_0359781b?usp=3D=
email :
PS1, Line 239:         msg(M_WARN, "%s: Cannot open original network namesp=
ace\n", __func__);
> M_ERRNO?
Done


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/67a2f3a1_46be9598?usp=3D=
email :
PS1, Line 247:         msg(M_WARN, "%s: Cannot open network namespace \"%s\=
"\n", __func__, name);
> M_ERRNO
Done


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/be497947_bd26b285?usp=3D=
email :
PS1, Line 254:         msg(M_WARN, "%s: setting the network namespace \"%s\=
" failed\n", __func__, name);
> M_ERRNO
Done


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/4c35413c_6640d246?usp=3D=
email :
PS1, Line 272:         msg(M_WARN, "%s: Cannot restore original network nam=
espace\n", __func__);
> M_ERRNO
Done


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/742c386b_4519cc6f?usp=3D=
email :
PS1, Line 635:         goto err;
> just use return
Done


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/22e23784_c162668b?usp=3D=
email :
PS1, Line 841:         goto err;
> M_ERR is fatal
M_ERRNO?


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/8a284417_909fc242?usp=3D=
email :
PS1, Line 848:         goto err;
> M_ERR is fatal
M_ERRNO?


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/d3926303_567f83d5?usp=3D=
email :
PS1, Line 914:     if (netns)
> These 4 lines (counting the netns assignment) are copied often enough tha=
t they should be moved to a [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/88485286_b7b56c97?usp=3D=
email :
PS1, Line 928:         msg(M_WARN, "%s: rtnl: cannot get ifindex for %s: %s=
", __func__, iface, strerror(errno));
> Should use M_ERRNO instead of manually using strerror
Done


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/f5ac3d5e_ae177443?usp=3D=
email :
PS1, Line 950:     ret =3D sitnl_send(&req.n, 0, 0, NULL, NULL);
> Just declare ret here. C has moved on...
Done


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/18e6b8dd_66e39679?usp=3D=
email :
PS1, Line 953:         goto err;
> Just use return
Done


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/9305239d_8149d39f?usp=3D=
email :
PS1, Line 955:     if (orig >=3D 0)
> Also move to function or macro
Done


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/43479fdf_4052fd95?usp=3D=
email :
PS1, Line 1002: err:
> Unused label?
SITNL_ADDATTR() requires a label


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/164779a4_0a0706ba?usp=3D=
email :
PS1, Line 1019:
> spurious empty line
Done


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/034b03f7_9d56a11c?usp=3D=
email :
PS1, Line 1064:
> spurious empty line
Done


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/c991facb_65fb1024?usp=3D=
email :
PS1, Line 1124: err:
> Unused label
SITNL_ADDATTR() requires a label


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/9da49ebb_0c7cdb54?usp=3D=
email :
PS1, Line 1833:         goto err;
> WHAT?
Whoops


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/a803d839_9934efff?usp=3D=
email :
PS1, Line 1881:         goto err;
> lol
Done


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/1521/comment/2b61fd19_da804455?usp=3D=
email :
PS1, Line 6476: #if defined(TARGET_LINUX)
> The documentation says it is a no-op on non-Linux, but as you implemented=
 it is an error I think?
indeed



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
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Thu, 26 Feb 2026 09:48:44 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>

--3UZOiNOlBNI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521?usp=3Demail">View =
Change</a></p><p>24 comments:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco.c:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1521/comment/896aa530_aee37115?usp=3Demail">Patch Set #1, L=
ine 394:</a> <code style=3D"font-family:monospace,monospace">        msg(ms=
glevel, &quot;Note: --netns not supported by ovpn-dco, disabling data chann=
el offload.&quot;);</code></p><p><blockquote style=3D"border-left: 1px soli=
d #aaa; margin: 10px 0; padding: 0 10px;">`ovpn` ? Or just &quot;DCO&quot;?=
</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0=
;"><p>File src/openvpn/networking_sitnl.h:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/co=
mment/54e1d744_317f8b7a?usp=3Demail">Patch Set #1, Line 52:</a> <code style=
=3D"font-family:monospace,monospace"> *              NETNS_RUN_DIR, e.g. /v=
ar/run/netns/&lt;name&gt;).</code></p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;">Doxygen says `networking_=
sitnl. [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1521/comment/dcdf2078_aa274ea0?usp=3Demail">Patc=
h Set #1, Line 98:</a> <code style=3D"font-family:monospace,monospace">int =
openvpn_if_nametoindex(const char *ifname, int netnsid);</code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">This is ALWAYS called with `get_or_create_netnsid_sitnl`, so just move =
all of that code inside and c [=E2=80=A6]</blockquote></p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">I&#39;m not thri=
lled by the idea of having a function that does too much stuff so I only mo=
ved the call to get_or_create_netnsid_sitnl() inside.</p></li></ul></li><li=
 style=3D"margin: 0; padding: 0;"><p>File src/openvpn/networking_sitnl.c:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1521/comment/fa0f2215_3cf98d28?usp=3Demail">Patch S=
et #1, Line 74:</a> <code style=3D"font-family:monospace,monospace">#define=
 NETNS_RUN_DIR  &quot;/var/run/netns&quot;</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Wouldn&#=
39;t `/run` be a better value here? `/var/run` is just a symlink nowadays A=
FAIK</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">indeed</p></li><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1521/comment/f4d47f64_4f660ee1?usp=3Demail">Patch Set #1, Li=
ne 206:</a> <code style=3D"font-family:monospace,monospace">            msg=
(M_WARN, &quot;%s: Network namespace %s does not exist\n&quot;, __func__, p=
ath);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin=
: 10px 0; padding: 0 10px;">M_ERRNO?</blockquote></p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/comment/c43227fc_0359781b=
?usp=3Demail">Patch Set #1, Line 239:</a> <code style=3D"font-family:monosp=
ace,monospace">        msg(M_WARN, &quot;%s: Cannot open original network n=
amespace\n&quot;, __func__);</code></p><p><blockquote style=3D"border-left:=
 1px solid #aaa; margin: 10px 0; padding: 0 10px;">M_ERRNO?</blockquote></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/co=
mment/67a2f3a1_46be9598?usp=3Demail">Patch Set #1, Line 247:</a> <code styl=
e=3D"font-family:monospace,monospace">        msg(M_WARN, &quot;%s: Cannot =
open network namespace \&quot;%s\&quot;\n&quot;, __func__, name);</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">M_ERRNO</blockquote></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1521/comment/be497947_bd26b285?usp=3Demail">Pa=
tch Set #1, Line 254:</a> <code style=3D"font-family:monospace,monospace"> =
       msg(M_WARN, &quot;%s: setting the network namespace \&quot;%s\&quot;=
 failed\n&quot;, __func__, name);</code></p><p><blockquote style=3D"border-=
left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">M_ERRNO</blockquote=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
521/comment/4c35413c_6640d246?usp=3Demail">Patch Set #1, Line 272:</a> <cod=
e style=3D"font-family:monospace,monospace">        msg(M_WARN, &quot;%s: C=
annot restore original network namespace\n&quot;, __func__);</code></p><p><=
blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0=
 10px;">M_ERRNO</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1521/comment/742c386b_4519cc6f?usp=3Demail">Patch S=
et #1, Line 635:</a> <code style=3D"font-family:monospace,monospace">      =
  goto err;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; =
margin: 10px 0; padding: 0 10px;">just use return</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/comment/22e=
23784_c162668b?usp=3Demail">Patch Set #1, Line 841:</a> <code style=3D"font=
-family:monospace,monospace">        goto err;</code></p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">M_ERR =
is fatal</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">M_ERRNO?</p></li><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1521/comment/8a284417_909fc242?usp=3Demail">Patch Set =
#1, Line 848:</a> <code style=3D"font-family:monospace,monospace">        g=
oto err;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; mar=
gin: 10px 0; padding: 0 10px;">M_ERR is fatal</blockquote></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">M_ERRNO?</p>=
</li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/comment/d392=
6303_567f83d5?usp=3Demail">Patch Set #1, Line 914:</a> <code style=3D"font-=
family:monospace,monospace">    if (netns)</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">These 4 =
lines (counting the netns assignment) are copied often enough that they sho=
uld be moved to a [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1521/comment/88485286_b7b56c97?usp=3D=
email">Patch Set #1, Line 928:</a> <code style=3D"font-family:monospace,mon=
ospace">        msg(M_WARN, &quot;%s: rtnl: cannot get ifindex for %s: %s&q=
uot;, __func__, iface, strerror(errno));</code></p><p><blockquote style=3D"=
border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Should use M=
_ERRNO instead of manually using strerror</blockquote></p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/comment/f5ac3d5e_ae1=
77443?usp=3Demail">Patch Set #1, Line 950:</a> <code style=3D"font-family:m=
onospace,monospace">    ret =3D sitnl_send(&amp;req.n, 0, 0, NULL, NULL);</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">Just declare ret here. C has moved on...</blockquote><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/=
comment/18e6b8dd_66e39679?usp=3Demail">Patch Set #1, Line 953:</a> <code st=
yle=3D"font-family:monospace,monospace">        goto err;</code></p><p><blo=
ckquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10=
px;">Just use return</blockquote></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1521/comment/9305239d_8149d39f?usp=3Demail">Pa=
tch Set #1, Line 955:</a> <code style=3D"font-family:monospace,monospace"> =
   if (orig &gt;=3D 0)</code></p><p><blockquote style=3D"border-left: 1px s=
olid #aaa; margin: 10px 0; padding: 0 10px;">Also move to function or macro=
</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1521/comment/43479fdf_4052fd95?usp=3Demail">Patch Set #1, Line 100=
2:</a> <code style=3D"font-family:monospace,monospace">err:</code></p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">Unused label?</blockquote></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">SITNL_ADDATTR() requires a label</p><=
/li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/comment/16477=
9a4_0a0706ba?usp=3Demail">Patch Set #1, Line 1019:</a> <code style=3D"font-=
family:monospace,monospace"></code></p><p><blockquote style=3D"border-left:=
 1px solid #aaa; margin: 10px 0; padding: 0 10px;">spurious empty line</blo=
ckquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1521/comment/034b03f7_9d56a11c?usp=3Demail">Patch Set #1, Line 1064:</a=
> <code style=3D"font-family:monospace,monospace"></code></p><p><blockquote=
 style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">sp=
urious empty line</blockquote></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/1521/comment/c991facb_65fb1024?usp=3Demail">Patch=
 Set #1, Line 1124:</a> <code style=3D"font-family:monospace,monospace">err=
:</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10=
px 0; padding: 0 10px;">Unused label</blockquote></p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">SITNL_ADDATTR() requi=
res a label</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
521/comment/9da49ebb_0c7cdb54?usp=3Demail">Patch Set #1, Line 1833:</a> <co=
de style=3D"font-family:monospace,monospace">        goto err;</code></p><p=
><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding:=
 0 10px;">WHAT?</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Whoops</p></li><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/1521/comment/a803d839_9934efff?usp=3Demail">Patch=
 Set #1, Line 1881:</a> <code style=3D"font-family:monospace,monospace">   =
     goto err;</code></p><p><blockquote style=3D"border-left: 1px solid #aa=
a; margin: 10px 0; padding: 0 10px;">lol</blockquote></p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul=
></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1521/comment/2b61fd19_da804455?usp=3Demail">Patch S=
et #1, Line 6476:</a> <code style=3D"font-family:monospace,monospace">#if d=
efined(TARGET_LINUX)</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">The documentation says it is a n=
o-op on non-Linux, but as you implemented it is an error I think?</blockquo=
te></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">indeed</p></li></ul></li></ul><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/1521?usp=3Demail">change 1521</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1521?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 26 Feb 2026 09:48:44=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>

</body></html>=

--3UZOiNOlBNI=--


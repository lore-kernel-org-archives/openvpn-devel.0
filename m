From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 16 Feb 2026 12:10:39 +0000
In-Reply-To: <gerrit.1770986118000.I8b0d1cad7062856abcc40c4e16ec93b45295bbd3@...2715...>
References: <gerrit.1770986118000.I8b0d1cad7062856abcc40c4e16ec93b45295bbd3@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net
Message-ID: <27618e66e3b42fee5dcff84d729fb42784440ef6-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/LRwqUKqjZ8="; charset=UTF-8
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

--/LRwqUKqjZ8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos.

flichtenheld has posted comments on this change by its_Giaan. ( http://gerr=
it.openvpn.net/c/openvpn/+/1521?usp=3Demail )

Change subject: Add support for user defined network namespace
......................................................................


Patch Set 1: Code-Review-2

(26 comments)

Patchset:

PS1:
I stopped reviewing at some point. Enough to fix for now


File src/openvpn/dco.c:

http://gerrit.openvpn.net/c/openvpn/+/1521/comment/f5b745f0_c74ba00a?usp=3D=
email :
PS1, Line 394:         msg(msglevel, "Note: --netns not supported by ovpn-d=
co, disabling data channel offload.");
`ovpn` ? Or just "DCO"?


File src/openvpn/networking_sitnl.h:

http://gerrit.openvpn.net/c/openvpn/+/1521/comment/fa0e61b1_09e3ce72?usp=3D=
email :
PS1, Line 52:  *              NETNS_RUN_DIR, e.g. /var/run/netns/<name>).
Doxygen says `networking_sitnl.h:52: warning: Unsupported xml/html tag <nam=
e> found`


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/1e561559_8521c63f?usp=3D=
email :
PS1, Line 98: int openvpn_if_nametoindex(const char *ifname, int netnsid);
This is ALWAYS called with `get_or_create_netnsid_sitnl`, so just move all =
of that code inside and change the signature.


File src/openvpn/networking_sitnl.c:

http://gerrit.openvpn.net/c/openvpn/+/1521/comment/97ff67c1_781261b5?usp=3D=
email :
PS1, Line 74: #define NETNS_RUN_DIR  "/var/run/netns"
Wouldn't `/run` be a better value here? `/var/run` is just a symlink nowada=
ys AFAIK


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/289f0216_601a33c5?usp=3D=
email :
PS1, Line 206:             msg(M_WARN, "%s: Network namespace %s does not e=
xist\n", __func__, path);
M_ERRNO?


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/d1511ce1_4a61a209?usp=3D=
email :
PS1, Line 239:         msg(M_WARN, "%s: Cannot open original network namesp=
ace\n", __func__);
M_ERRNO?


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/db2ee770_077ea5de?usp=3D=
email :
PS1, Line 247:         msg(M_WARN, "%s: Cannot open network namespace \"%s\=
"\n", __func__, name);
M_ERRNO


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/60e6c6bb_45c54b89?usp=3D=
email :
PS1, Line 254:         msg(M_WARN, "%s: setting the network namespace \"%s\=
" failed\n", __func__, name);
M_ERRNO


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/5e711262_50c89506?usp=3D=
email :
PS1, Line 272:         msg(M_WARN, "%s: Cannot restore original network nam=
espace\n", __func__);
M_ERRNO


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/15d5672a_5f164ecd?usp=3D=
email :
PS1, Line 635:         goto err;
just use return


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/e3edca05_87e906c4?usp=3D=
email :
PS1, Line 841:         goto err;
M_ERR is fatal


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/5ed22de4_b4c7950e?usp=3D=
email :
PS1, Line 848:         goto err;
M_ERR is fatal


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/7cb5d904_f6b98d2c?usp=3D=
email :
PS1, Line 914:     if (netns)
These 4 lines (counting the netns assignment) are copied often enough that =
they should be moved to a function or macro.


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/48e4eb65_4e5b7e66?usp=3D=
email :
PS1, Line 928:         msg(M_WARN, "%s: rtnl: cannot get ifindex for %s: %s=
", __func__, iface, strerror(errno));
Should use M_ERRNO instead of manually using strerror


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/e1d31283_33bdeb60?usp=3D=
email :
PS1, Line 950:     ret =3D sitnl_send(&req.n, 0, 0, NULL, NULL);
Just declare ret here. C has moved on...


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/f52dde96_e5b369fd?usp=3D=
email :
PS1, Line 953:         goto err;
Just use return


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/e4633213_a3d2a888?usp=3D=
email :
PS1, Line 955:     if (orig >=3D 0)
Also move to function or macro


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/3706333e_7b657959?usp=3D=
email :
PS1, Line 1002: err:
Unused label?


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/a2a79f77_a7e3716c?usp=3D=
email :
PS1, Line 1019:
spurious empty line


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/99000be3_9e6be45b?usp=3D=
email :
PS1, Line 1064:
spurious empty line


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/7c543e33_d1045522?usp=3D=
email :
PS1, Line 1124: err:
Unused label


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/a9d4fe8c_8da527ff?usp=3D=
email :
PS1, Line 1833:         goto err;
WHAT?


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/57c51c0b_69ab4bb4?usp=3D=
email :
PS1, Line 1881:         goto err;
lol


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/09b54618_34113780?usp=3D=
email :
PS1, Line 1903:         return netnsid;
Hmm, why does clang-format not fix this?


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/1521/comment/cbd845cd_a862dec9?usp=3D=
email :
PS1, Line 6476: #if defined(TARGET_LINUX)
The documentation says it is a no-op on non-Linux, but as you implemented i=
t is an error I think?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1521?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8b0d1cad7062856abcc40c4e16ec93b45295bbd3
Gerrit-Change-Number: 1521
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Comment-Date: Mon, 16 Feb 2026 12:10:39 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--/LRwqUKqjZ8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: its_Giaan, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521?usp=3Demail">V=
iew Change</a></p><p>26 comments:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1521?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I stopp=
ed reviewing at some point. Enough to fix for now</p></li></ul></li><li sty=
le=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco.c:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1521/comment/f5b745f0_c74ba00a?usp=3Demail">Patch Set #1, Line 394:<=
/a> <code style=3D"font-family:monospace,monospace">        msg(msglevel, &=
quot;Note: --netns not supported by ovpn-dco, disabling data channel offloa=
d.&quot;);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">`ovpn` ? Or just &quot;DCO&quot;?</p></li></ul></li><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/networking_sitnl.h:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/1521/comment/fa0e61b1_09e3ce72?usp=3Demail">Patch=
 Set #1, Line 52:</a> <code style=3D"font-family:monospace,monospace"> *   =
           NETNS_RUN_DIR, e.g. /var/run/netns/&lt;name&gt;).</code></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Dox=
ygen says `networking_sitnl.h:52: warning: Unsupported xml/html tag &lt;nam=
e&gt; found`</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
521/comment/1e561559_8521c63f?usp=3Demail">Patch Set #1, Line 98:</a> <code=
 style=3D"font-family:monospace,monospace">int openvpn_if_nametoindex(const=
 char *ifname, int netnsid);</code></p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">This is ALWAYS called with `get_or_=
create_netnsid_sitnl`, so just move all of that code inside and change the =
signature.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File s=
rc/openvpn/networking_sitnl.c:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/comment/97ff67=
c1_781261b5?usp=3Demail">Patch Set #1, Line 74:</a> <code style=3D"font-fam=
ily:monospace,monospace">#define NETNS_RUN_DIR  &quot;/var/run/netns&quot;<=
/code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Wouldn&#39;t `/run` be a better value here? `/var/run` is just a=
 symlink nowadays AFAIK</p></li><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1521/comment/289f0216_601a33c5?usp=3Demail">Patch Set #1, Line 20=
6:</a> <code style=3D"font-family:monospace,monospace">            msg(M_WA=
RN, &quot;%s: Network namespace %s does not exist\n&quot;, __func__, path);=
</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">M_ERRNO?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1521/comment/d1511ce1_4a61a209?usp=3Demail">Patch Set #1, Line 239:<=
/a> <code style=3D"font-family:monospace,monospace">        msg(M_WARN, &qu=
ot;%s: Cannot open original network namespace\n&quot;, __func__);</code></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">M_ERRNO?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
521/comment/db2ee770_077ea5de?usp=3Demail">Patch Set #1, Line 247:</a> <cod=
e style=3D"font-family:monospace,monospace">        msg(M_WARN, &quot;%s: C=
annot open network namespace \&quot;%s\&quot;\n&quot;, __func__, name);</co=
de></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">M_ERRNO</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1521/comment/60e6c6bb_45c54b89?usp=3Demail">Patch Set #1, Line 254:</a> <=
code style=3D"font-family:monospace,monospace">        msg(M_WARN, &quot;%s=
: setting the network namespace \&quot;%s\&quot; failed\n&quot;, __func__, =
name);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">M_ERRNO</p></li><li style=3D"margin: 0; padding: 0 0 0 16=
px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1521/comment/5e711262_50c89506?usp=3Demail">Patch Set #1, Line =
272:</a> <code style=3D"font-family:monospace,monospace">        msg(M_WARN=
, &quot;%s: Cannot restore original network namespace\n&quot;, __func__);</=
code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">M_ERRNO</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1521/comment/15d5672a_5f164ecd?usp=3Demail">Patch Set #1, Line 635:</a>=
 <code style=3D"font-family:monospace,monospace">        goto err;</code></=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">just use return</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1521/comment/e3edca05_87e906c4?usp=3Demail">Patch Set #1, Line 841:</a=
> <code style=3D"font-family:monospace,monospace">        goto err;</code><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">M_ERR is fatal</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1521/comment/5ed22de4_b4c7950e?usp=3Demail">Patch Set #1, Line 848:</a=
> <code style=3D"font-family:monospace,monospace">        goto err;</code><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">M_ERR is fatal</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1521/comment/7cb5d904_f6b98d2c?usp=3Demail">Patch Set #1, Line 914:</a=
> <code style=3D"font-family:monospace,monospace">    if (netns)</code></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>These 4 lines (counting the netns assignment) are copied often enough that=
 they should be moved to a function or macro.</p></li><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1521/comment/48e4eb65_4e5b7e66?usp=3Demail"=
>Patch Set #1, Line 928:</a> <code style=3D"font-family:monospace,monospace=
">        msg(M_WARN, &quot;%s: rtnl: cannot get ifindex for %s: %s&quot;, =
__func__, iface, strerror(errno));</code></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Should use M_ERRNO instead of=
 manually using strerror</p></li><li style=3D"margin: 0; padding: 0 0 0 16p=
x;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1521/comment/e1d31283_33bdeb60?usp=3Demail">Patch Set #1, Line 9=
50:</a> <code style=3D"font-family:monospace,monospace">    ret =3D sitnl_s=
end(&amp;req.n, 0, 0, NULL, NULL);</code></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Just declare ret here. C has =
moved on...</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
521/comment/f52dde96_e5b369fd?usp=3Demail">Patch Set #1, Line 953:</a> <cod=
e style=3D"font-family:monospace,monospace">        goto err;</code></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Ju=
st use return</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1521/comment/e4633213_a3d2a888?usp=3Demail">Patch Set #1, Line 955:</a> <co=
de style=3D"font-family:monospace,monospace">    if (orig &gt;=3D 0)</code>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Also move to function or macro</p></li><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1521/comment/3706333e_7b657959?usp=3Demail">Patch Set=
 #1, Line 1002:</a> <code style=3D"font-family:monospace,monospace">err:</c=
ode></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">Unused label?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1521/comment/a2a79f77_a7e3716c?usp=3Demail">Patch Set #1, Line 101=
9:</a> <code style=3D"font-family:monospace,monospace"></code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">spuriou=
s empty line</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
521/comment/99000be3_9e6be45b?usp=3Demail">Patch Set #1, Line 1064:</a> <co=
de style=3D"font-family:monospace,monospace"></code></p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">spurious empty lin=
e</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/comment=
/7c543e33_d1045522?usp=3Demail">Patch Set #1, Line 1124:</a> <code style=3D=
"font-family:monospace,monospace">err:</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Unused label</p></li><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/comment/a9d4fe8c_8da=
527ff?usp=3Demail">Patch Set #1, Line 1833:</a> <code style=3D"font-family:=
monospace,monospace">        goto err;</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">WHAT?</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/comment/57c51c0b_69ab4bb4?=
usp=3Demail">Patch Set #1, Line 1881:</a> <code style=3D"font-family:monosp=
ace,monospace">        goto err;</code></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">lol</p></li><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1521/comment/09b54618_34113780?usp=3Demai=
l">Patch Set #1, Line 1903:</a> <code style=3D"font-family:monospace,monosp=
ace">        return netnsid;</code></p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Hmm, why does clang-format not fix =
this?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/op=
envpn/options.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/comment/cbd845cd_a862dec9?=
usp=3Demail">Patch Set #1, Line 6476:</a> <code style=3D"font-family:monosp=
ace,monospace">#if defined(TARGET_LINUX)</code></p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">The documentation says =
it is a no-op on non-Linux, but as you implemented it is an error I think?<=
/p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1521?usp=3Demail">change 1521</a>. To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setting=
s?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.or=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1521?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8b0d1cad7062856abcc40c4e16e=
c93b45295bbd3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1521 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 16 Feb 2026 12:10:39=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--/LRwqUKqjZ8=--


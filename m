From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 18 Mar 2026 10:21:01 +0000
In-Reply-To: <gerrit.1770986118000.I8b0d1cad7062856abcc40c4e16ec93b45295bbd3@...2715...>
References: <gerrit.1770986118000.I8b0d1cad7062856abcc40c4e16ec93b45295bbd3@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net
Message-ID: <a1c9bb3add8636959503a0a7d7cef5622cdbeafb-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="K64APB8GIuQ="; charset=UTF-8
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

--K64APB8GIuQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos.

flichtenheld has posted comments on this change by its_Giaan. ( http://gerr=
it.openvpn.net/c/openvpn/+/1521?usp=3Demail )

Change subject: Add support for user defined network namespace
......................................................................


Patch Set 4: Code-Review-1

(13 comments)

File src/openvpn/networking_sitnl.c:

http://gerrit.openvpn.net/c/openvpn/+/1521/comment/4314739e_2d4bc1d9?usp=3D=
email :
PS4, Line 771:     if (ret < 0)
Redundant code.


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/bdeed08b_be6f179c?usp=3D=
email :
PS4, Line 819:     if (ret < 0)
redundant code


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/dd19d5b9_09ff231b?usp=3D=
email :
PS4, Line 1137:         netns_restore(orig);
instead just move the code around so the switch happens after the check


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/efa59517_408ec8ff?usp=3D=
email :
PS4, Line 1169:     if (ret < 0)
redundant code


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/eb0d21db_0305708b?usp=3D=
email :
PS4, Line 1211:     netns_restore(orig);
restore needs to be after err:


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/c1f79458_0f7d935d?usp=3D=
email :
PS4, Line 1247:     netns_restore(orig);
restore needs to be after err:


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/dcedc153_51d7fe41?usp=3D=
email :
PS4, Line 1283:             netns_restore(orig);
move the netns_switch to after the parameter checks


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/37b3e127_ecd5e4c8?usp=3D=
email :
PS4, Line 1321:         netns_restore(orig);
needs to be after err:


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/2da76258_bc75db17?usp=3D=
email :
PS4, Line 1416:             netns_restore(orig);
move switch to after parameter check


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/37f50a5e_1a48206b?usp=3D=
email :
PS4, Line 1464:     netns_restore(orig);
after err:


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/20b0928d_d826d6f3?usp=3D=
email :
PS4, Line 1952:         netns_restore(orig);
restore before switch


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/a4d99beb_485b5051?usp=3D=
email :
PS4, Line 1969:     if (ret < 0)
redundant code


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/1521/comment/6eeabe14_8951b5a9?usp=3D=
email :
PS4, Line 6468:         msg(M_WARN, "NOTE: --netns is supported only on Lin=
ux when compiled with SITNL");
I would go for "SITNL support"



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1521?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8b0d1cad7062856abcc40c4e16ec93b45295bbd3
Gerrit-Change-Number: 1521
Gerrit-PatchSet: 4
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Comment-Date: Wed, 18 Mar 2026 10:21:01 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--K64APB8GIuQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: its_Giaan, plaisthos. </p>
<p>Patch set 4:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521?usp=3Demail">V=
iew Change</a></p><p>13 comments:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/networking_s=
itnl.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1521/comment/4314739e_2d4bc1d9?usp=3Demail=
">Patch Set #4, Line 771:</a> <code style=3D"font-family:monospace,monospac=
e">    if (ret &lt; 0)</code></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Redundant code.</p></li><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1521/comment/bdeed08b_be6f179c?usp=3Dem=
ail">Patch Set #4, Line 819:</a> <code style=3D"font-family:monospace,monos=
pace">    if (ret &lt; 0)</code></p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">redundant code</p></li><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1521/comment/dd19d5b9_09ff231b?usp=3D=
email">Patch Set #4, Line 1137:</a> <code style=3D"font-family:monospace,mo=
nospace">        netns_restore(orig);</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">instead just move the co=
de around so the switch happens after the check</p></li><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1521/comment/efa59517_408ec8ff?usp=3Demai=
l">Patch Set #4, Line 1169:</a> <code style=3D"font-family:monospace,monosp=
ace">    if (ret &lt; 0)</code></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">redundant code</p></li><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1521/comment/eb0d21db_0305708b?usp=3De=
mail">Patch Set #4, Line 1211:</a> <code style=3D"font-family:monospace,mon=
ospace">    netns_restore(orig);</code></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">restore needs to be after err:<=
/p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/comment/c=
1f79458_0f7d935d?usp=3Demail">Patch Set #4, Line 1247:</a> <code style=3D"f=
ont-family:monospace,monospace">    netns_restore(orig);</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">restore=
 needs to be after err:</p></li><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1521/comment/dcedc153_51d7fe41?usp=3Demail">Patch Set #4, Line 12=
83:</a> <code style=3D"font-family:monospace,monospace">            netns_r=
estore(orig);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">move the netns_switch to after the parameter check=
s</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/comment=
/37b3e127_ecd5e4c8?usp=3Demail">Patch Set #4, Line 1321:</a> <code style=3D=
"font-family:monospace,monospace">        netns_restore(orig);</code></p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">n=
eeds to be after err:</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1521/comment/2da76258_bc75db17?usp=3Demail">Patch Set #4, Line 1416=
:</a> <code style=3D"font-family:monospace,monospace">            netns_res=
tore(orig);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">move switch to after parameter check</p></li><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/comment/37f50a5e_1a48206=
b?usp=3Demail">Patch Set #4, Line 1464:</a> <code style=3D"font-family:mono=
space,monospace">    netns_restore(orig);</code></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">after err:</p></li><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/comment/20b0928d_d82=
6d6f3?usp=3Demail">Patch Set #4, Line 1952:</a> <code style=3D"font-family:=
monospace,monospace">        netns_restore(orig);</code></p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">restore before=
 switch</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/c=
omment/a4d99beb_485b5051?usp=3Demail">Patch Set #4, Line 1969:</a> <code st=
yle=3D"font-family:monospace,monospace">    if (ret &lt; 0)</code></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">redu=
ndant code</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File s=
rc/openvpn/options.c:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/comment/6eeabe14_8951b5=
a9?usp=3Demail">Patch Set #4, Line 6468:</a> <code style=3D"font-family:mon=
ospace,monospace">        msg(M_WARN, &quot;NOTE: --netns is supported only=
 on Linux when compiled with SITNL&quot;);</code></p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">I would go for &quot;=
SITNL support&quot;</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1521?usp=3Demail">change 1521</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1521?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8b0d1cad7062856abcc40c4e16e=
c93b45295bbd3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1521 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 18 Mar 2026 10:21:01=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--K64APB8GIuQ=--


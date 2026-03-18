From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Wed, 18 Mar 2026 16:15:32 +0000
In-Reply-To: <gerrit.1770986118000.I8b0d1cad7062856abcc40c4e16ec93b45295bbd3@...2715...>
References: <gerrit.1770986118000.I8b0d1cad7062856abcc40c4e16ec93b45295bbd3@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <fe429870541ea2bc7dff5d0d0e8ebe3f241fc86b-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hFzYMLHkcFs="; charset=UTF-8
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

--hFzYMLHkcFs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

its_Giaan has posted comments on this change by its_Giaan. ( http://gerrit.=
openvpn.net/c/openvpn/+/1521?usp=3Demail )

Change subject: Add support for user defined network namespace
......................................................................


Patch Set 5:

(12 comments)

File src/openvpn/networking_sitnl.c:

http://gerrit.openvpn.net/c/openvpn/+/1521/comment/167513fa_e7d6d350?usp=3D=
email :
PS4, Line 771:     if (ret < 0)
> Redundant code.
Done


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/7eddcf9c_aaa945e8?usp=3D=
email :
PS4, Line 819:     if (ret < 0)
> redundant code
Done


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/537e9aad_7a6ad766?usp=3D=
email :
PS4, Line 1137:         netns_restore(orig);
> instead just move the code around so the switch happens after the check
Done


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/f7070273_3fab86e7?usp=3D=
email :
PS4, Line 1169:     if (ret < 0)
> redundant code
Done


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/670cfaf3_d7b151a8?usp=3D=
email :
PS4, Line 1211:     netns_restore(orig);
> restore needs to be after err:
Done


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/cb3e6ac1_b795495f?usp=3D=
email :
PS4, Line 1247:     netns_restore(orig);
> restore needs to be after err:
Done


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/1ae478b0_27bb0047?usp=3D=
email :
PS4, Line 1283:             netns_restore(orig);
> move the netns_switch to after the parameter checks
Done


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/0535a454_21dfab59?usp=3D=
email :
PS4, Line 1321:         netns_restore(orig);
> needs to be after err:
Done


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/114af87d_61ddd36d?usp=3D=
email :
PS4, Line 1416:             netns_restore(orig);
> move switch to after parameter check
Done


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/c68c9df0_09f15400?usp=3D=
email :
PS4, Line 1464:     netns_restore(orig);
> after err:
Done


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/c933e7c7_5cf78d92?usp=3D=
email :
PS4, Line 1952:         netns_restore(orig);
> restore before switch
Done


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/21b10505_c0d56d20?usp=3D=
email :
PS4, Line 1969:     if (ret < 0)
> redundant code
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
Gerrit-PatchSet: 5
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 18 Mar 2026 16:15:32 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>

--hFzYMLHkcFs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521?usp=3Demail">View =
Change</a></p><p>12 comments:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/networking_sitnl=
.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1521/comment/167513fa_e7d6d350?usp=3Demail">Pa=
tch Set #4, Line 771:</a> <code style=3D"font-family:monospace,monospace"> =
   if (ret &lt; 0)</code></p><p><blockquote style=3D"border-left: 1px solid=
 #aaa; margin: 10px 0; padding: 0 10px;">Redundant code.</blockquote></p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">D=
one</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/comme=
nt/7eddcf9c_aaa945e8?usp=3Demail">Patch Set #4, Line 819:</a> <code style=
=3D"font-family:monospace,monospace">    if (ret &lt; 0)</code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">redundant code</blockquote></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1521/comment/537e9aad_7a6ad766?usp=3Demail">Patc=
h Set #4, Line 1137:</a> <code style=3D"font-family:monospace,monospace">  =
      netns_restore(orig);</code></p><p><blockquote style=3D"border-left: 1=
px solid #aaa; margin: 10px 0; padding: 0 10px;">instead just move the code=
 around so the switch happens after the check</blockquote></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/comment/f7070273=
_3fab86e7?usp=3Demail">Patch Set #4, Line 1169:</a> <code style=3D"font-fam=
ily:monospace,monospace">    if (ret &lt; 0)</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">redundan=
t code</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1521/comment/670cfaf3_d7b151a8?usp=3Demail">Patch Set #4, Li=
ne 1211:</a> <code style=3D"font-family:monospace,monospace">    netns_rest=
ore(orig);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; m=
argin: 10px 0; padding: 0 10px;">restore needs to be after err:</blockquote=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
521/comment/cb3e6ac1_b795495f?usp=3Demail">Patch Set #4, Line 1247:</a> <co=
de style=3D"font-family:monospace,monospace">    netns_restore(orig);</code=
></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; p=
adding: 0 10px;">restore needs to be after err:</blockquote></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></=
li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/comment/1ae478=
b0_27bb0047?usp=3Demail">Patch Set #4, Line 1283:</a> <code style=3D"font-f=
amily:monospace,monospace">            netns_restore(orig);</code></p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">move the netns_switch to after the parameter checks</blockquote></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/com=
ment/0535a454_21dfab59?usp=3Demail">Patch Set #4, Line 1321:</a> <code styl=
e=3D"font-family:monospace,monospace">        netns_restore(orig);</code></=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;">needs to be after err:</blockquote></p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/comment/114af87d_61ddd36d=
?usp=3Demail">Patch Set #4, Line 1416:</a> <code style=3D"font-family:monos=
pace,monospace">            netns_restore(orig);</code></p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">move=
 switch to after parameter check</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/comment/c68c9df0_09f15400?=
usp=3Demail">Patch Set #4, Line 1464:</a> <code style=3D"font-family:monosp=
ace,monospace">    netns_restore(orig);</code></p><p><blockquote style=3D"b=
order-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">after err:</b=
lockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1521/comment/c933e7c7_5cf78d92?usp=3Demail">Patch Set #4, Line 1952:<=
/a> <code style=3D"font-family:monospace,monospace">        netns_restore(o=
rig);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin=
: 10px 0; padding: 0 10px;">restore before switch</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521/comment/21b=
10505_c0d56d20?usp=3Demail">Patch Set #4, Line 1969:</a> <code style=3D"fon=
t-family:monospace,monospace">    if (ret &lt; 0)</code></p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">red=
undant code</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521?usp=3Demail">change 1=
521</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8b0d1cad7062856abcc40c4e16e=
c93b45295bbd3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1521 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 18 Mar 2026 16:15:32=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>

</body></html>=

--hFzYMLHkcFs=--


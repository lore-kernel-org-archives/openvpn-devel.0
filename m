From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 7 Oct 2025 15:50:10 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@...2715...>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@...2715...>
Reply-To: arne-openvpn@...1227..., gianmarco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <334f152f34aa95ea6819e4a33b0196f499fa7dfa-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ydUF9gFuEWM="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multipeer: introduce
 asymmetric peer-id
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ydUF9gFuEWM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, its_Giaan.

plaisthos has posted comments on this change by its_Giaan. ( http://gerrit.=
openvpn.net/c/openvpn/+/1089?usp=3Demail )

Change subject: multipeer: introduce asymmetric peer-id
......................................................................


Patch Set 4: Code-Review-2

(8 comments)

Patchset:

PS4:
The part that picks the "peer-id" pushed and parsed options.c that sets pee=
r-id on receiving peer-id

    if (found & OPT_P_PEER_ID)
    {
        msg(D_PUSH_DEBUG, "OPTIONS IMPORT: peer-id set");
        c->c2.tls_multi->use_peer_id =3D true;
        c->c2.tls_multi->tx_peer_id =3D c->options.peer_id;
    }


should probably also be adjusted to set both rx and tx as peer-id as pushed=
 option should set both.


File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1089/comment/7b89f526_1248648b?usp=3D=
email :
PS4, Line 1179:     ret->rx_peer_id =3D MAX_PEER_ID;
Add comment here that we also use the rx peer id to identify DCO clients as=
 this has become now a important distinction.


http://gerrit.openvpn.net/c/openvpn/+/1089/comment/18e30fd6_0e66350f?usp=3D=
email :
PS4, Line 1982:         }
This is still not guarded by DCO capability. With the current version we st=
ill always indicate to the peer that we are always asymmetric peer ID capab=
le even if the underlying DCO module is not able to use a different peer ID=
 for TX.


http://gerrit.openvpn.net/c/openvpn/+/1089/comment/3fb67b50_b42dfeaf?usp=3D=
email :
PS4, Line 2165:     if (multi->rx_peer_id =3D=3D MAX_PEER_ID && session->op=
t->mode !=3D MODE_SERVER)
This feel be a very hacky place to set the multi rx peer id. I think there =
is a better place to do that.


File src/openvpn/ssl_ncp.c:

http://gerrit.openvpn.net/c/openvpn/+/1089/comment/c5df3a60_53fab78f?usp=3D=
email :
PS4, Line 425:     if (tx_peer_id)
This also need to take DCO capability into account.


http://gerrit.openvpn.net/c/openvpn/+/1089/comment/1a14b321_0b6cf1e1?usp=3D=
email :
PS4, Line 450:         if (multi->use_peer_id)
I think this parts needs to be skipped if we are using/negotiated asymmetri=
c peer-id as it would overwrite both rx and tx ids with the EKM generated o=
nes. Probably move the if (tx_peer_id) above and have this as else path wit=
h a comment that asymmetric peer id trumps EKM


File src/openvpn/ssl_util.h:

http://gerrit.openvpn.net/c/openvpn/+/1089/comment/17f8e5bb_aeb5d80c?usp=3D=
email :
PS4, Line 56: uint32_t extract_asymmetric_peer_id(const char *peer_info);
Add doxygen please


File src/openvpn/ssl_util.c:

http://gerrit.openvpn.net/c/openvpn/+/1089/comment/aa5446c4_405e7c5e?usp=3D=
email :
PS4, Line 90:     return 0;
0 is a valid peer id. So I would rather have -1 (and int32_t as return type=
) or MAX_PEER_ID, MAX_UINT value or similar as not defined.

In fact the first client that typically connects to a p2mp server is assign=
ed value 0.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Change-Number: 1089
Gerrit-PatchSet: 4
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 07 Oct 2025 15:50:10 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--ydUF9gFuEWM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, its_Giaan. </p>
<p>Patch set 4:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail">V=
iew Change</a></p><p>8 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1089?tab=3Dcomments&amp;usp=3Demail">Patch Set #4:</a> </p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">The part t=
hat picks the &quot;peer-id&quot; pushed and parsed options.c that sets pee=
r-id on receiving peer-id</p><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">    if (found &amp; OPT_P_PEER_I=
D)<br>    {<br>        msg(D_PUSH_DEBUG, &quot;OPTIONS IMPORT: peer-id set&=
quot;);<br>        c-&gt;c2.tls_multi-&gt;use_peer_id =3D true;<br>        =
c-&gt;c2.tls_multi-&gt;tx_peer_id =3D c-&gt;options.peer_id;<br>    }<br>  =
  </pre><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">should probably also be adjusted to set both rx and tx as peer-id =
as pushed option should set both.</p></li></ul></li><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/ssl.c:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1089/comm=
ent/7b89f526_1248648b?usp=3Demail">Patch Set #4, Line 1179:</a> <code style=
=3D"font-family:monospace,monospace">    ret-&gt;rx_peer_id =3D MAX_PEER_ID=
;</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Add comment here that we also use the rx peer id to identify D=
CO clients as this has become now a important distinction.</p></li><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1089/comment/18e30fd6_0e66350f=
?usp=3Demail">Patch Set #4, Line 1982:</a> <code style=3D"font-family:monos=
pace,monospace">        }</code></p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">This is still not guarded by DCO capab=
ility. With the current version we still always indicate to the peer that w=
e are always asymmetric peer ID capable even if the underlying DCO module i=
s not able to use a different peer ID for TX.</p></li><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1089/comment/3fb67b50_b42dfeaf?usp=3Demail"=
>Patch Set #4, Line 2165:</a> <code style=3D"font-family:monospace,monospac=
e">    if (multi-&gt;rx_peer_id =3D=3D MAX_PEER_ID &amp;&amp; session-&gt;o=
pt-&gt;mode !=3D MODE_SERVER)</code></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">This feel be a very hacky place to=
 set the multi rx peer id. I think there is a better place to do that.</p><=
/li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_=
ncp.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1089/comment/c5df3a60_53fab78f?usp=3Demail"=
>Patch Set #4, Line 425:</a> <code style=3D"font-family:monospace,monospace=
">    if (tx_peer_id)</code></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">This also need to take DCO capability into=
 account.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1089=
/comment/1a14b321_0b6cf1e1?usp=3Demail">Patch Set #4, Line 450:</a> <code s=
tyle=3D"font-family:monospace,monospace">        if (multi-&gt;use_peer_id)=
</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">I think this parts needs to be skipped if we are using/negotiat=
ed asymmetric peer-id as it would overwrite both rx and tx ids with the EKM=
 generated ones. Probably move the if (tx_peer_id) above and have this as e=
lse path with a comment that asymmetric peer id trumps EKM</p></li></ul></l=
i><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_util.h:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1089/comment/17f8e5bb_aeb5d80c?usp=3Demail">Patch Set =
#4, Line 56:</a> <code style=3D"font-family:monospace,monospace">uint32_t e=
xtract_asymmetric_peer_id(const char *peer_info);</code></p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Add doxygen pl=
ease</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/ope=
nvpn/ssl_util.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1089/comment/aa5446c4_405e7c5e?=
usp=3Demail">Patch Set #4, Line 90:</a> <code style=3D"font-family:monospac=
e,monospace">    return 0;</code></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">0 is a valid peer id. So I would rath=
er have -1 (and int32_t as return type) or MAX_PEER_ID, MAX_UINT value or s=
imilar as not defined.</p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">In fact the first client that typically connects=
 to a p2mp server is assigned value 0.</p></li></ul></li></ul><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail">cha=
nge 1089</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3ba=
b3f2dff639bf9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1089 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 07 Oct 2025 15:50:10=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--ydUF9gFuEWM=--


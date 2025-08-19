From: "MaxF (Code Review)" <gerrit@...515...>
Date: Tue, 19 Aug 2025 13:59:56 +0000
In-Reply-To: <gerrit.1750855087000.I6752dcd5aff3e5cea2b439366479e86751a1c403@...2715...>
References: <gerrit.1750855087000.I6752dcd5aff3e5cea2b439366479e86751a1c403@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c08c780b1cb577b794cbc387c206d52ba3cc7266-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fkMw9l7N/Aw="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Check message
 id/acked ids too when doing sessionid cookie checks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--fkMw9l7N/Aw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

MaxF has posted comments on this change. ( http://gerrit.openvpn.net/c/open=
vpn/+/1067?usp=3Demail )

Change subject: Check message id/acked ids too when doing sessionid cookie =
checks
......................................................................


Patch Set 6: Code-Review+2

(2 comments)

File src/openvpn/mudp.c:

http://gerrit.openvpn.net/c/openvpn/+/1067/comment/a89a1941_de7cae02 :
PS5, Line 163:             msg(D_MULTI_MEDIUM, "Packet (%s) with invalid or=
 missing SID from %s",
             :                 packet_opcode_name(op), peer);
> This debug message may now be incorrect. The packet might have a valid SI=
D, but a wrong packet ID.
Done


File src/openvpn/ssl_pkt.c:

http://gerrit.openvpn.net/c/openvpn/+/1067/comment/333f0fff_e4904c7d :
PS5, Line 518:     /* Check if the packet ID of the packet or ACKED packet =
 is <=3D 1 */
             :     for (int i =3D 0; i < ack.len; i++)
             :     {
             :         /* This packet ACKs a packet that has a higher packe=
t id than the
             :          * ones expected in the three-way handshake, conside=
r it as invalid
             :          * for the session */
             :         if (ack.packet_id[i] > 1)
             :         {
             :             return false;
             :         }
             :     }
             :
             :     if (!pkt_is_ack)
             :     {
             :         packet_id_type message_id;
             :         /* Extract the packet ID from the packet */
             :         if (!reliable_ack_read_packet_id(&buf, &message_id))
             :         {
             :             return false;
             :         }
             :
             :         /* similar check. Anything larger than 1 is not cons=
idered part of the
             :          * three-way handshake */
             :         if (message_id > 1)
             :         {
             :             return false;
             :         }
             :     }
> Maybe nitpicky, but this seems like scope creep for this function. [=E2=
=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1067?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6752dcd5aff3e5cea2b439366479e86751a1c403
Gerrit-Change-Number: 1067
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 19 Aug 2025 13:59:56 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: MaxF <max@...2606...>
Gerrit-MessageType: comment

--fkMw9l7N/Aw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 6:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1067?usp=3Demail">V=
iew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mudp.c:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1067/comment/a89a1941_de7cae02">Patch Set #5, Line 163:=
</a> </p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;"><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">            msg(D_MULTI_MEDIUM, &quot;Packet (%s) with in=
valid or missing SID from %s&quot;,<br>                packet_opcode_name(o=
p), peer);<br></pre></blockquote></p><p><blockquote style=3D"border-left: 1=
px solid #aaa; margin: 10px 0; padding: 0 10px;">This debug message may now=
 be incorrect. The packet might have a valid SID, but a wrong packet ID.</b=
lockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Do=
ne</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openv=
pn/ssl_pkt.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1067/comment/333f0fff_e4904c7d">Patc=
h Set #5, Line 518:</a> </p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;"><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">    /* Check if the packet ID of the p=
acket or ACKED packet  is &lt;=3D 1 */<br>    for (int i =3D 0; i &lt; ack.=
len; i++)<br>    {<br>        /* This packet ACKs a packet that has a highe=
r packet id than the<br>         * ones expected in the three-way handshake=
, consider it as invalid<br>         * for the session */<br>        if (ac=
k.packet_id[i] &gt; 1)<br>        {<br>            return false;<br>       =
 }<br>    }<br><br>    if (!pkt_is_ack)<br>    {<br>        packet_id_type =
message_id;<br>        /* Extract the packet ID from the packet */<br>     =
   if (!reliable_ack_read_packet_id(&amp;buf, &amp;message_id))<br>        =
{<br>            return false;<br>        }<br><br>        /* similar check=
. Anything larger than 1 is not considered part of the<br>         * three-=
way handshake */<br>        if (message_id &gt; 1)<br>        {<br>        =
    return false;<br>        }<br>    }<br></pre></blockquote></p><p><block=
quote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px=
;">Maybe nitpicky, but this seems like scope creep for this function. [=E2=
=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1067?usp=3Demail">change 1067</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1067?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6752dcd5aff3e5cea2b43936647=
9e86751a1c403 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1067 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 19 Aug 2025 13:59:56=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: MaxF &lt;max@...2606...&g=
t; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--fkMw9l7N/Aw=--


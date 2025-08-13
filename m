From: "MaxF (Code Review)" <gerrit@...515...>
Date: Wed, 13 Aug 2025 14:01:34 +0000
In-Reply-To: <gerrit.1750855087000.I6752dcd5aff3e5cea2b439366479e86751a1c403@...2715...>
References: <gerrit.1750855087000.I6752dcd5aff3e5cea2b439366479e86751a1c403@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f79bc885c6d314dc115040ea42dbd9c504f14284-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3m0ef8MM+ts="; charset=UTF-8
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

--3m0ef8MM+ts=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

MaxF has posted comments on this change. ( http://gerrit.openvpn.net/c/open=
vpn/+/1067?usp=3Demail )

Change subject: Check message id/acked ids too when doing sessionid cookie =
checks
......................................................................


Patch Set 5:

(3 comments)

Patchset:

PS5:
The change makes sense to me, just some small nitpicks. If you strongly pre=
fer doing it this way, I'm willing to approve.


File src/openvpn/mudp.c:

http://gerrit.openvpn.net/c/openvpn/+/1067/comment/b8f6989e_8a8a01d2 :
PS5, Line 163:             msg(D_MULTI_MEDIUM, "Packet (%s) with invalid or=
 missing SID from %s",
             :                 packet_opcode_name(op), peer);
This debug message may now be incorrect. The packet might have a valid SID,=
 but a wrong packet ID.


File src/openvpn/ssl_pkt.c:

http://gerrit.openvpn.net/c/openvpn/+/1067/comment/3d6e4bec_68a33598 :
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
Maybe nitpicky, but this seems like scope creep for this function. Now chec=
k_session_id_hmac() does more than checking the hmac. I'd prefer to extract=
 this check to its own function, or rename this one.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1067?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6752dcd5aff3e5cea2b439366479e86751a1c403
Gerrit-Change-Number: 1067
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: MaxF <max@...2606...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 13 Aug 2025 14:01:34 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--3m0ef8MM+ts=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1067?usp=3Demail">View =
Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1067?tab=3Dcomments">Patch Set #5:</a> </p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">The change makes sense to me, just some small n=
itpicks. If you strongly prefer doing it this way, I&#39;m willing to appro=
ve.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/open=
vpn/mudp.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1067/comment/b8f6989e_8a8a01d2">Patch =
Set #5, Line 163:</a> </p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;"><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">            msg(D_MULTI_MEDIUM, &quot;Pa=
cket (%s) with invalid or missing SID from %s&quot;,<br>                pac=
ket_opcode_name(op), peer);<br></pre></blockquote></p><p style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">This debug message may now be incorre=
ct. The packet might have a valid SID, but a wrong packet ID.</p></li></ul>=
</li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_pkt.c:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1067/comment/3d6e4bec_68a33598">Patch Set #5, Line 5=
18:</a> </p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10=
px 0; padding: 0 10px;"><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">    /* Check if the packet ID of the packet or ACKED p=
acket  is &lt;=3D 1 */<br>    for (int i =3D 0; i &lt; ack.len; i++)<br>   =
 {<br>        /* This packet ACKs a packet that has a higher packet id than=
 the<br>         * ones expected in the three-way handshake, consider it as=
 invalid<br>         * for the session */<br>        if (ack.packet_id[i] &=
gt; 1)<br>        {<br>            return false;<br>        }<br>    }<br><=
br>    if (!pkt_is_ack)<br>    {<br>        packet_id_type message_id;<br> =
       /* Extract the packet ID from the packet */<br>        if (!reliable=
_ack_read_packet_id(&amp;buf, &amp;message_id))<br>        {<br>           =
 return false;<br>        }<br><br>        /* similar check. Anything large=
r than 1 is not considered part of the<br>         * three-way handshake */=
<br>        if (message_id &gt; 1)<br>        {<br>            return false=
;<br>        }<br>    }<br></pre></blockquote></p><p style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Maybe nitpicky, but this seems like scope=
 creep for this function. Now check_session_id_hmac() does more than checki=
ng the hmac. I&#39;d prefer to extract this check to its own function, or r=
ename this one.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/1067?usp=3Demail">change 1067</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1067?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6752dcd5aff3e5cea2b43936647=
9e86751a1c403 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1067 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: MaxF &lt;max@...2606...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 13 Aug 2025 14:01:34=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--3m0ef8MM+ts=--


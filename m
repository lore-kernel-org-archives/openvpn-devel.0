From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 21 Nov 2025 21:03:37 +0000
In-Reply-To: <gerrit.1762862118000.I6a5110a0583b8b33496b06d9c27c1084df38e842@...2715...>
References: <gerrit.1762862118000.I6a5110a0583b8b33496b06d9c27c1084df38e842@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <148b738f0fdb8f0aedf7c03834044f9897edda8f-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jvtxzL5d7vg="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi-socket: do not
 return tuntap flags on server-side
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--jvtxzL5d7vg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos.

cron2 has posted comments on this change by its_Giaan. ( http://gerrit.open=
vpn.net/c/openvpn/+/1364?usp=3Demail )

Change subject: multi-socket: do not return tuntap flags on server-side
......................................................................


Patch Set 2:

(1 comment)

Patchset:

PS2:
IRC notes...

```
18:10 <@cron2> okay
18:10 <@cron2> - drop the #ifdef MULTI_DEBUG_EVENT_LOOP (completely)
18:10 <@cron2> - add the comment :-)
18:10 <@cron2> - drop FILE_CLOSED, plus explain in the commit message
18:10 <@cron2> - drop the new msg() again, because, too excessive
18:11 <@cron2> and someone needs to explain get_io_flags_dowork_udp() to me
18:11 <@cron2> why is it called "udp" and the comment says "for TCP & UDP
               sockets"?
18:13 <@cron2> and why does it say "Wait for I/O events" when all it does (=
does
               it?) is set up the flags for events we want to see?
18:14 < Giaan> probably a copy paste from it=C2=B4s ancestor (io_wait())
18:15 <@cron2> should TUN_WRITE then also be removed from get_io_flags_udp(=
)?
18:15 < Giaan> no
18:15 < Giaan> we need that for tun_set()
18:17 <@cron2> do I even dare to ask how tun_set() and get_io_flags_udp()=20
               relate, and why get_io_flags_udp() would deal with TUN_WRITE
               while get_io_flags_dowork_udp() does not?
18:17 < Giaan> ah indeed
18:17  * cron2 has to leave, and fetch the kids from sports... so will be b=
ack
          tomorrow and work on this...
18:17 < Giaan> it=C2=B4s related to the get_io_flags_dowork_udp()
18:18 <@cron2> (can we get rid of get_io_flags_dowork_udp()?)
18:18 <@cron2> just fold these two lines into the caller... this used to be
               much larger
18:18 < Giaan> yeah, and then all the udp sockets won=C2=B4t work :D
18:19 <@cron2> nah, keep the logic, but put it into get_io_flags_udp() inst=
ead
               of having an extra function for just one extra function call=
 + 1
               assignment :-)
18:19 <@cron2> anyway, will be back...
18:20 < Giaan> please dump all your concerns in gerrit so we won=C2=B4t for=
get :-)
```



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1364?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6a5110a0583b8b33496b06d9c27c1084df38e842
Gerrit-Change-Number: 1364
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Fri, 21 Nov 2025 21:03:37 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--jvtxzL5d7vg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, its_Giaan, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1364?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1364?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">IRC notes...</p=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">```<br>18:10 &lt;@cron2&gt; okay<br>18:10 &lt;@cron2&gt; - d=
rop the #ifdef MULTI_DEBUG_EVENT_LOOP (completely)<br>18:10 &lt;@cron2&gt; =
- add the comment :-)<br>18:10 &lt;@cron2&gt; - drop FILE_CLOSED, plus expl=
ain in the commit message<br>18:10 &lt;@cron2&gt; - drop the new msg() agai=
n, because, too excessive<br>18:11 &lt;@cron2&gt; and someone needs to expl=
ain get_io_flags_dowork_udp() to me<br>18:11 &lt;@cron2&gt; why is it calle=
d &quot;udp&quot; and the comment says &quot;for TCP &amp; UDP <br>        =
       sockets&quot;?<br>18:13 &lt;@cron2&gt; and why does it say &quot;Wai=
t for I/O events&quot; when all it does (does <br>               it?) is se=
t up the flags for events we want to see?<br>18:14 &lt; Giaan&gt; probably =
a copy paste from it=C2=B4s ancestor (io_wait())<br>18:15 &lt;@cron2&gt; sh=
ould TUN_WRITE then also be removed from get_io_flags_udp()?<br>18:15 &lt; =
Giaan&gt; no<br>18:15 &lt; Giaan&gt; we need that for tun_set()<br>18:17 &l=
t;@cron2&gt; do I even dare to ask how tun_set() and get_io_flags_udp() <br=
>               relate, and why get_io_flags_udp() would deal with TUN_WRIT=
E <br>               while get_io_flags_dowork_udp() does not?<br>18:17 &lt=
; Giaan&gt; ah indeed <br>18:17  * cron2 has to leave, and fetch the kids f=
rom sports... so will be back <br>          tomorrow and work on this...<br=
>18:17 &lt; Giaan&gt; it=C2=B4s related to the get_io_flags_dowork_udp()<br=
>18:18 &lt;@cron2&gt; (can we get rid of get_io_flags_dowork_udp()?)<br>18:=
18 &lt;@cron2&gt; just fold these two lines into the caller... this used to=
 be <br>               much larger<br>18:18 &lt; Giaan&gt; yeah, and then a=
ll the udp sockets won=C2=B4t work :D<br>18:19 &lt;@cron2&gt; nah, keep the=
 logic, but put it into get_io_flags_udp() instead <br>               of ha=
ving an extra function for just one extra function call + 1 <br>           =
    assignment :-)<br>18:19 &lt;@cron2&gt; anyway, will be back...<br>18:20=
 &lt; Giaan&gt; please dump all your concerns in gerrit so we won=C2=B4t fo=
rget :-)<br>```</pre></li></ul></li></ul><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1364?usp=3Demail">change 1364</a>. To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.o=
penvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1364?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6a5110a0583b8b33496b06d9c27=
c1084df38e842 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1364 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 21 Nov 2025 21:03:37=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>=

--jvtxzL5d7vg=--


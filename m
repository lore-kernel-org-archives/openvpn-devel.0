From: "mrbff (Code Review)" <gerrit@...515...>
Date: Tue, 14 Oct 2025 16:05:02 +0000
In-Reply-To: <gerrit.1759855064000.I07a8ddd9026eef64b6f5abde98702a9801616a5f@...2715...>
References: <gerrit.1759855064000.I07a8ddd9026eef64b6f5abde98702a9801616a5f@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726..., gert@...1296...
Message-ID: <12bb05d2ee14e18b5c32c5a7134914d95d1017bd-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0IkVHuUwGJQ="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: PUSH_UPDATE server:
 remove old IP(s) from vhash after sending a messa...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0IkVHuUwGJQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, ordex, plaisthos.

mrbff has posted comments on this change by mrbff. ( http://gerrit.openvpn.=
net/c/openvpn/+/1253?usp=3Demail )

Change subject: PUSH_UPDATE server: remove old IP(s) from vhash after sendi=
ng a message containing ifconfig(-ipv6)
......................................................................


Patch Set 6:

(2 comments)

File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/1253/comment/fc5a283e_68bf4b30?usp=3D=
email :
PS5, Line 4390:             mi->context.c2.push_ifconfig_local =3D htonl(ne=
w_addr.s_addr);
> something is weird here. [=E2=80=A6]
yes I printed bit by bit and they are the same and I don't understand why h=
tonl fixes things and I don't understand why (addr.s_addr =3D=3D htonl(add.=
s_addr)) statement is false.

uint32

2025-10-14 17:40:06 us=3D422285 MANAGEMENT: CMD 'push-update-cid 0 "ifconfi=
g 10.10.10.55 255.255.255.0"'
2025-10-14 17:40:06 us=3D422386 SENT CONTROL [client0]: 'PUSH_UPDATE,ifconf=
ig 10.10.10.55 255.255.255.0' (status=3D1)
2025-10-14 17:40:06 us=3D422409 MULTI: Unlearn: 10.10.10.2 -> client0/udp6:=
92.168.3.1:37467
2025-10-14 17:40:06 us=3D422422 MULTI: Learn: 10.10.10.55 -> client0/udp6:9=
2.168.3.1:37467


2025-10-14 17:40:06 us=3D422432 New IPv4 Address Analysis:
2025-10-14 17:40:06 us=3D422437   Original s_addr:     0x370a0a0a =3D 92340=
4810 =3D 00110111000010100000101000001010
2025-10-14 17:40:06 us=3D422442   ntohl(s_addr):       0x0a0a0a37 =3D 16843=
0135 =3D 00001010000010100000101000110111
2025-10-14 17:40:06 us=3D422448   htonl(s_addr):       0x0a0a0a37 =3D 16843=
0135 =3D 00001010000010100000101000110111
2025-10-14 17:40:06 us=3D422454   As IP address: 10.10.10.55

uint64

2025-10-14 17:49:28 us=3D407391 MANAGEMENT: CMD 'push-update-cid 0 "ifconfi=
g 10.10.10.55 255.255.255.0"'
2025-10-14 17:49:28 us=3D407531 SENT CONTROL [client0]: 'PUSH_UPDATE,ifconf=
ig 10.10.10.55 255.255.255.0' (status=3D1)
2025-10-14 17:49:28 us=3D407565 MULTI: Unlearn: 10.10.10.2 -> client0/udp6:=
92.168.3.1:37923
2025-10-14 17:49:28 us=3D407581 MULTI: Learn: 10.10.10.55 -> client0/udp6:9=
2.168.3.1:37923


2025-10-14 17:49:28 us=3D407592 New IPv4 Address Analysis:
2025-10-14 17:49:28 us=3D407600   Original s_addr:     0x370a0a0a =3D 92340=
4810 =3D 0000000000000000000000000000000000110111000010100000101000001010
2025-10-14 17:49:28 us=3D407606   ntohl(s_addr):       0x0a0a0a37 =3D 16843=
0135 =3D 0000000000000000000000000000000000001010000010100000101000110111
2025-10-14 17:49:28 us=3D407613   htonl(s_addr):       0x0a0a0a37 =3D 16843=
0135 =3D 0000000000000000000000000000000000001010000010100000101000110111
2025-10-14 17:49:28 us=3D407619   As IP address: 10.10.10.55


File src/openvpn/push_util.c:

http://gerrit.openvpn.net/c/openvpn/+/1253/comment/bd5cee56_ee31112f?usp=3D=
email :
PS6, Line 165:     o.ifconfig_local =3D canary;
> in other parts of the code we use having a bool named like `$option_defin=
ed` (in this case it would  [=E2=80=A6]
the canary is mostly to be less invasive as possible. I know it's a bit wei=
rd but it works well and minimizes the scope for this logic without having =
to touch other functions that are also used in other parts of the code in d=
ifferent logic. Adding ifconfig_local_defined to the options struct and mod=
ifying add_option() and remove_option(), just to handle -ifconfig(-ipv6) in=
 the server looks a little overkill to me.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1253?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I07a8ddd9026eef64b6f5abde98702a9801616a5f
Gerrit-Change-Number: 1253
Gerrit-PatchSet: 6
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <antonio@...2726...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Comment-Date: Tue, 14 Oct 2025 16:05:02 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: ordex <antonio@...2726...>

--0IkVHuUwGJQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, ordex, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1253?usp=3Demail">View =
Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi.c:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1253/comment/fc5a283e_68bf4b30?usp=3Demail">Patch Set #5, =
Line 4390:</a> <code style=3D"font-family:monospace,monospace">            =
mi-&gt;context.c2.push_ifconfig_local =3D htonl(new_addr.s_addr);</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">something is weird here. [=E2=80=A6]</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">yes I p=
rinted bit by bit and they are the same and I don&#39;t understand why hton=
l fixes things and I don&#39;t understand why (addr.s_addr =3D=3D htonl(add=
.s_addr)) statement is false.</p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">uint32</p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">2025-10-14 17:40:06 us=3D42228=
5 MANAGEMENT: CMD &#39;push-update-cid 0 &quot;ifconfig 10.10.10.55 255.255=
.255.0&quot;&#39;<br>2025-10-14 17:40:06 us=3D422386 SENT CONTROL [client0]=
: &#39;PUSH_UPDATE,ifconfig 10.10.10.55 255.255.255.0&#39; (status=3D1)<br>=
2025-10-14 17:40:06 us=3D422409 MULTI: Unlearn: 10.10.10.2 -&gt; client0/ud=
p6:92.168.3.1:37467<br>2025-10-14 17:40:06 us=3D422422 MULTI: Learn: 10.10.=
10.55 -&gt; client0/udp6:92.168.3.1:37467</p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;"><br>2025-10-14 17:40:06 us=3D=
422432 New IPv4 Address Analysis:<br>2025-10-14 17:40:06 us=3D422437   Orig=
inal s_addr:     0x370a0a0a =3D 923404810 =3D 00110111000010100000101000001=
010<br>2025-10-14 17:40:06 us=3D422442   ntohl(s_addr):       0x0a0a0a37 =
=3D 168430135 =3D 00001010000010100000101000110111<br>2025-10-14 17:40:06 u=
s=3D422448   htonl(s_addr):       0x0a0a0a37 =3D 168430135 =3D 000010100000=
10100000101000110111<br>2025-10-14 17:40:06 us=3D422454   As IP address: 10=
.10.10.55</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">uint64</p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">2025-10-14 17:49:28 us=3D407391 MANAGEMENT: CMD &#=
39;push-update-cid 0 &quot;ifconfig 10.10.10.55 255.255.255.0&quot;&#39;<br=
>2025-10-14 17:49:28 us=3D407531 SENT CONTROL [client0]: &#39;PUSH_UPDATE,i=
fconfig 10.10.10.55 255.255.255.0&#39; (status=3D1)<br>2025-10-14 17:49:28 =
us=3D407565 MULTI: Unlearn: 10.10.10.2 -&gt; client0/udp6:92.168.3.1:37923<=
br>2025-10-14 17:49:28 us=3D407581 MULTI: Learn: 10.10.10.55 -&gt; client0/=
udp6:92.168.3.1:37923</p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;"><br>2025-10-14 17:49:28 us=3D407592 New IPv4 Addr=
ess Analysis:<br>2025-10-14 17:49:28 us=3D407600   Original s_addr:     0x3=
70a0a0a =3D 923404810 =3D 0000000000000000000000000000000000110111000010100=
000101000001010<br>2025-10-14 17:49:28 us=3D407606   ntohl(s_addr):       0=
x0a0a0a37 =3D 168430135 =3D 00000000000000000000000000000000000010100000101=
00000101000110111<br>2025-10-14 17:49:28 us=3D407613   htonl(s_addr):      =
 0x0a0a0a37 =3D 168430135 =3D 000000000000000000000000000000000000101000001=
0100000101000110111<br>2025-10-14 17:49:28 us=3D407619   As IP address: 10.=
10.10.55</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src=
/openvpn/push_util.c:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/1253/comment/bd5cee56_ee3111=
2f?usp=3Demail">Patch Set #6, Line 165:</a> <code style=3D"font-family:mono=
space,monospace">    o.ifconfig_local =3D canary;</code></p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">in =
other parts of the code we use having a bool named like `$option_defined` (=
in this case it would  [=E2=80=A6]</blockquote></p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">the canary is mostly to=
 be less invasive as possible. I know it&#39;s a bit weird but it works wel=
l and minimizes the scope for this logic without having to touch other func=
tions that are also used in other parts of the code in different logic. Add=
ing ifconfig_local_defined to the options struct and modifying add_option()=
 and remove_option(), just to handle -ifconfig(-ipv6) in the server looks a=
 little overkill to me.</p></li></ul></li></ul><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1253?usp=3Demail">change 1253</a>. T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope item=
type=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1253?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I07a8ddd9026eef64b6f5abde987=
02a9801616a5f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1253 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@...2726...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 14 Oct 2025 16:05:02=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;antonio@...2787...=
...&gt; </div>

</body></html>=

--0IkVHuUwGJQ=--


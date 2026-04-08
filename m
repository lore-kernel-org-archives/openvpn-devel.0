From: "Bluca (Code Review)" <gerrit@...515...>
Date: Wed, 8 Apr 2026 00:54:40 +0000
In-Reply-To: <gerrit.1775475846000.I055c64ca8b23066e70eea7d7deddfb14f5354c5f@...2715...>
References: <gerrit.1775475846000.I055c64ca8b23066e70eea7d7deddfb14f5354c5f@...2715...>
Reply-To: luca.boccassi@...277..., arne-openvpn@...1227...,
 selva.nair@...277..., openvpn-devel@lists.sourceforge.net
Message-ID: <3b98c9bf5489fa5eb86a3cbcc498c722ac2020ee-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4aLHf00Djrc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add new helpers to
 handle key exchange (S_SENT_KEY/S_START) with larg...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, selvanair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--4aLHf00Djrc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, selvanair.

Bluca has posted comments on this change by Bluca. ( http://gerrit.openvpn.=
net/c/openvpn/+/1622?usp=3Demail )

Change subject: Add new helpers to handle key exchange (S_SENT_KEY/S_START)=
 with large passwords
......................................................................


Patch Set 2:

(2 comments)

Patchset:

PS1:
> But I get the feeling that you are not really interested in any solution =
that would actually improve on the OpenVPN protocol to implement longer use=
rname/password if it is not compatible with the approach that Microsoft has=
 decided to take.

Of course what I am after is making my use case work, otherwise what would =
be the point? I don't think there's anything wrong with wanting to fix thin=
gs that don't work, that's how open source contributions happen after all, =
everyone has their own itches to scratch, and mine is being able to ditch a=
ll proprietary software from my machine and still be able to do my job. It =
doesn't feel like it's a bad goal to have, no?

So if you have specific suggestions that can improve the situation in _both=
_ cases, I'd be happy to work on implementing them.


PS1:
> You might not care about compatibility, interoperability and behaviour of=
 modern clients with older servers and vice versa but we care and we have t=
ake that into account.

This is not true, and I must say being on the receiving end of such jibes i=
s really not motivating, as I've been testing these changes in various comb=
inations as explained in the commit message exactly because I don't want to=
 break anything.

But one thing is breaking backward compatibility, and something entirely di=
fferent is when something _never worked_ in the first place.

This is what happens when trying to use a long password with various combin=
ations of existing client/server pairings.

Pre-a7f80d402f client to pre-a7f80d402f server:

2026-04-08 00:53:44 us=3D768916 Attempting to establish TCP connection with=
 [AF_INET]127.0.0.1:11940
2026-04-08 00:53:44 us=3D769011 TCP connection established with [AF_INET]12=
7.0.0.1:11940
2026-04-08 00:53:44 us=3D769020 TCPv4_CLIENT link local: (not bound)
2026-04-08 00:53:44 us=3D769026 TCPv4_CLIENT link remote: [AF_INET]127.0.0.=
1:11940
2026-04-08 00:53:44 us=3D769450 TLS: Initial packet from [AF_INET]127.0.0.1=
:11940, sid=3D34dfa3d7 a78d4716
2026-04-08 00:53:44 us=3D769480 TLS Error: Key Method #2 write failed
2026-04-08 00:53:44 us=3D769486 TLS Error: TLS handshake failed
2026-04-08 00:53:44 us=3D769527 Fatal TLS error (check_tls_errors_co), rest=
arting
2026-04-08 00:53:44 us=3D769541 TCP/UDP: Closing socket
2026-04-08 00:53:44 us=3D769569 SIGUSR1[soft,tls-error] received, process r=
estarting
2026-04-08 00:53:44 us=3D769582 Restart pause, 1 second(s)

2.7 client (without this patch) to pre-a7f80d402f server:

2026-04-08 01:08:17 us=3D72026 Attempting to establish TCP connection with =
[AF_INET]127.0.0.1:11940
2026-04-08 01:08:17 us=3D72132 TCP connection established with [AF_INET]127=
.0.0.1:11940
2026-04-08 01:08:17 us=3D72141 TCPv4_CLIENT link local: (not bound)
2026-04-08 01:08:17 us=3D72147 TCPv4_CLIENT link remote: [AF_INET]127.0.0.1=
:11940
2026-04-08 01:08:17 us=3D72596 TLS: Initial packet from [AF_INET]127.0.0.1:=
11940, sid=3Ddd20ab34 e3af8d3c
2026-04-08 01:08:17 us=3D72627 TLS Error: Key Method #2 write failed
2026-04-08 01:08:17 us=3D72636 TLS Error: TLS handshake failed
2026-04-08 01:08:17 us=3D72702 Fatal TLS error (check_tls_errors_co), resta=
rting
2026-04-08 01:08:17 us=3D72721 TCP/UDP: Closing socket
2026-04-08 01:08:17 us=3D72753 SIGUSR1[soft,tls-error] received, process re=
starting
2026-04-08 01:08:17 us=3D72766 Restart pause, 2 second(s)

2.7 client (without this patch) to 2.7 server (without this patch):

2026-04-08 01:10:10 us=3D299468 Attempting to establish TCP connection with=
 [AF_INET]127.0.0.1:11940
2026-04-08 01:10:10 us=3D299563 TCP connection established with [AF_INET]12=
7.0.0.1:11940
2026-04-08 01:10:10 us=3D299574 TCPv4_CLIENT link local: (not bound)
2026-04-08 01:10:10 us=3D299581 TCPv4_CLIENT link remote: [AF_INET]127.0.0.=
1:11940
2026-04-08 01:10:10 us=3D299899 TLS: Initial packet from [AF_INET]127.0.0.1=
:11940, sid=3Def841a67 6d757318
2026-04-08 01:10:10 us=3D299912 TLS Error: Key Method #2 write failed
2026-04-08 01:10:10 us=3D299917 TLS Error: TLS handshake failed
2026-04-08 01:10:10 us=3D299967 Fatal TLS error (check_tls_errors_co), rest=
arting
2026-04-08 01:10:10 us=3D299989 TCP/UDP: Closing socket
2026-04-08 01:10:10 us=3D300016 SIGUSR1[soft,tls-error] received, process r=
estarting
2026-04-08 01:10:10 us=3D300026 Restart pause, 2 second(s)

pre-a7f80d402f client to 2.7 server (without this patch):

2026-04-08 01:11:56 us=3D44683 Attempting to establish TCP connection with =
[AF_INET]127.0.0.1:11940
2026-04-08 01:11:56 us=3D44820 TCP connection established with [AF_INET]127=
.0.0.1:11940
2026-04-08 01:11:56 us=3D44827 TCPv4_CLIENT link local: (not bound)
2026-04-08 01:11:56 us=3D44831 TCPv4_CLIENT link remote: [AF_INET]127.0.0.1=
:11940
2026-04-08 01:11:56 us=3D45442 TLS: Initial packet from [AF_INET]127.0.0.1:=
11940, sid=3D9f2bc992 ef68a461
2026-04-08 01:11:56 us=3D45469 TLS Error: Key Method #2 write failed
2026-04-08 01:11:56 us=3D45475 TLS Error: TLS handshake failed
2026-04-08 01:11:56 us=3D45522 Fatal TLS error (check_tls_errors_co), resta=
rting
2026-04-08 01:11:56 us=3D45537 TCP/UDP: Closing socket
2026-04-08 01:11:56 us=3D45572 SIGUSR1[soft,tls-error] received, process re=
starting
2026-04-08 01:11:56 us=3D45582 Restart pause, 1 second(s)


Basically the only difference is that the new version waits 2s instead of 1=
s. The message is exactly the same, an unspecified "key method" failure, th=
at doesn't really say the password is too long, and is entirely unhelpful t=
o a casual user. The error reporting from a7f80d402f doesn't trigger in any=
 combination.

Now here's how it looks with this patch, when connecting to a 2.7 server be=
fore this patch:

2026-04-08 01:34:55 us=3D526614 Attempting to establish TCP connection with=
 [AF_INET]127.0.0.1:11940
2026-04-08 01:34:55 us=3D526683 TCP connection established with [AF_INET]12=
7.0.0.1:11940
2026-04-08 01:34:55 us=3D526690 TCPv4_CLIENT link local: (not bound)
2026-04-08 01:34:55 us=3D526694 TCPv4_CLIENT link remote: [AF_INET]127.0.0.=
1:11940
2026-04-08 01:34:55 us=3D527014 TLS: Initial packet from [AF_INET]127.0.0.1=
:11940, sid=3Db3756543 a0f9575c
2026-04-08 01:34:55 us=3D527030 WARNING: this configuration may cache passw=
ords in memory -- use the auth-nocache option to prevent this
2026-04-08 01:34:55 us=3D527737 VERIFY OK: depth=3D1, CN=3DTest CA
2026-04-08 01:34:55 us=3D527836 VERIFY OK: depth=3D0, CN=3Dserver
2026-04-08 01:34:55 us=3D568575 Control Channel: TLSv1.3, cipher TLSv1.3 TL=
S_AES_256_GCM_SHA384, peer certificate: 256 bits ECprime256v1, signature: e=
cdsa-with-SHA256, peer signing digest/type: ecdsa_secp256r1_sha256 ECDSA, k=
ey agreement: X25519MLKEM768
2026-04-08 01:34:55 us=3D568624 [server] Peer Connection Initiated with [AF=
_INET]127.0.0.1:11940
2026-04-08 01:34:55 us=3D568639 TLS: move_session: dest=3DTM_ACTIVE src=3DT=
M_INITIAL reinit_src=3D1
2026-04-08 01:34:55 us=3D568717 TLS: tls_multi_process: initial untrusted s=
ession promoted to trusted
2026-04-08 01:34:55 us=3D569034 AUTH: Received control message: AUTH_FAILED=
,Username or password is too long. Maximum length is 128 bytes
2026-04-08 01:34:55 us=3D569150 TCP/UDP: Closing socket
2026-04-08 01:34:55 us=3D569194 SIGTERM[soft,auth-failure] received, proces=
s exiting

IE: the new error path reporting from a7f80d402f actually fires up, and rep=
orts a useful and actionable message to the user.

With a pre-a7f80d402f server there was no helpful message with a patched cl=
ient, so I've now added it.

So not only this patch doesn't break compatibility or make the UX worse, it=
 actually improves it in the error case.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1622?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I055c64ca8b23066e70eea7d7deddfb14f5354c5f
Gerrit-Change-Number: 1622
Gerrit-PatchSet: 2
Gerrit-Owner: Bluca <luca.boccassi@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: selvanair <selva.nair@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: selvanair <selva.nair@...277...>
Gerrit-Comment-Date: Wed, 08 Apr 2026 00:54:40 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Comment-In-Reply-To: Bluca <luca.boccassi@...277...>

--4aLHf00Djrc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, selvanair. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1622?usp=3Demail">View =
Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1622?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><blockquote cla=
ss=3D"blocks" style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;"><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">But I get the feeling that you are not really interested in any=
 solution that would actually improve on the OpenVPN protocol to implement =
longer username/password if it is not compatible with the approach that Mic=
rosoft has decided to take.</p></blockquote><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">Of course what I am after is m=
aking my use case work, otherwise what would be the point? I don&#39;t thin=
k there&#39;s anything wrong with wanting to fix things that don&#39;t work=
, that&#39;s how open source contributions happen after all, everyone has t=
heir own itches to scratch, and mine is being able to ditch all proprietary=
 software from my machine and still be able to do my job. It doesn&#39;t fe=
el like it&#39;s a bad goal to have, no?</p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">So if you have specific sugges=
tions that can improve the situation in _both_ cases, I&#39;d be happy to w=
ork on implementing them.</p></li><li style=3D"margin: 0; padding: 0 0 0 16=
px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1622?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><blo=
ckquote class=3D"blocks" style=3D"border-left: 1px solid #aaa; margin: 10px=
 0; padding: 0 10px;"><p class=3D"blocks" style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">You might not care about compatibility, interoperabi=
lity and behaviour of modern clients with older servers and vice versa but =
we care and we have take that into account.</p></blockquote><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This is not tr=
ue, and I must say being on the receiving end of such jibes is really not m=
otivating, as I&#39;ve been testing these changes in various combinations a=
s explained in the commit message exactly because I don&#39;t want to break=
 anything.</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">But one thing is breaking backward compatibility, and someth=
ing entirely different is when something _never worked_ in the first place.=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">This is what happens when trying to use a long password with various c=
ombinations of existing client/server pairings.</p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Pre-a7f80d402f client t=
o pre-a7f80d402f server:</p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">2026-04-08 00:53:44 us=3D768916 Attempting to =
establish TCP connection with [AF_INET]127.0.0.1:11940<br>2026-04-08 00:53:=
44 us=3D769011 TCP connection established with [AF_INET]127.0.0.1:11940<br>=
2026-04-08 00:53:44 us=3D769020 TCPv4_CLIENT link local: (not bound)<br>202=
6-04-08 00:53:44 us=3D769026 TCPv4_CLIENT link remote: [AF_INET]127.0.0.1:1=
1940<br>2026-04-08 00:53:44 us=3D769450 TLS: Initial packet from [AF_INET]1=
27.0.0.1:11940, sid=3D34dfa3d7 a78d4716<br>2026-04-08 00:53:44 us=3D769480 =
TLS Error: Key Method #2 write failed<br>2026-04-08 00:53:44 us=3D769486 TL=
S Error: TLS handshake failed<br>2026-04-08 00:53:44 us=3D769527 Fatal TLS =
error (check_tls_errors_co), restarting<br>2026-04-08 00:53:44 us=3D769541 =
TCP/UDP: Closing socket<br>2026-04-08 00:53:44 us=3D769569 SIGUSR1[soft,tls=
-error] received, process restarting<br>2026-04-08 00:53:44 us=3D769582 Res=
tart pause, 1 second(s)</p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">2.7 client (without this patch) to pre-a7f80d40=
2f server:</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">2026-04-08 01:08:17 us=3D72026 Attempting to establish TCP c=
onnection with [AF_INET]127.0.0.1:11940<br>2026-04-08 01:08:17 us=3D72132 T=
CP connection established with [AF_INET]127.0.0.1:11940<br>2026-04-08 01:08=
:17 us=3D72141 TCPv4_CLIENT link local: (not bound)<br>2026-04-08 01:08:17 =
us=3D72147 TCPv4_CLIENT link remote: [AF_INET]127.0.0.1:11940<br>2026-04-08=
 01:08:17 us=3D72596 TLS: Initial packet from [AF_INET]127.0.0.1:11940, sid=
=3Ddd20ab34 e3af8d3c<br>2026-04-08 01:08:17 us=3D72627 TLS Error: Key Metho=
d #2 write failed<br>2026-04-08 01:08:17 us=3D72636 TLS Error: TLS handshak=
e failed<br>2026-04-08 01:08:17 us=3D72702 Fatal TLS error (check_tls_error=
s_co), restarting<br>2026-04-08 01:08:17 us=3D72721 TCP/UDP: Closing socket=
<br>2026-04-08 01:08:17 us=3D72753 SIGUSR1[soft,tls-error] received, proces=
s restarting<br>2026-04-08 01:08:17 us=3D72766 Restart pause, 2 second(s)</=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">2.7 client (without this patch) to 2.7 server (without this patch):</p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
2026-04-08 01:10:10 us=3D299468 Attempting to establish TCP connection with=
 [AF_INET]127.0.0.1:11940<br>2026-04-08 01:10:10 us=3D299563 TCP connection=
 established with [AF_INET]127.0.0.1:11940<br>2026-04-08 01:10:10 us=3D2995=
74 TCPv4_CLIENT link local: (not bound)<br>2026-04-08 01:10:10 us=3D299581 =
TCPv4_CLIENT link remote: [AF_INET]127.0.0.1:11940<br>2026-04-08 01:10:10 u=
s=3D299899 TLS: Initial packet from [AF_INET]127.0.0.1:11940, sid=3Def841a6=
7 6d757318<br>2026-04-08 01:10:10 us=3D299912 TLS Error: Key Method #2 writ=
e failed<br>2026-04-08 01:10:10 us=3D299917 TLS Error: TLS handshake failed=
<br>2026-04-08 01:10:10 us=3D299967 Fatal TLS error (check_tls_errors_co), =
restarting<br>2026-04-08 01:10:10 us=3D299989 TCP/UDP: Closing socket<br>20=
26-04-08 01:10:10 us=3D300016 SIGUSR1[soft,tls-error] received, process res=
tarting<br>2026-04-08 01:10:10 us=3D300026 Restart pause, 2 second(s)</p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">p=
re-a7f80d402f client to 2.7 server (without this patch):</p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">2026-04-08 01:=
11:56 us=3D44683 Attempting to establish TCP connection with [AF_INET]127.0=
.0.1:11940<br>2026-04-08 01:11:56 us=3D44820 TCP connection established wit=
h [AF_INET]127.0.0.1:11940<br>2026-04-08 01:11:56 us=3D44827 TCPv4_CLIENT l=
ink local: (not bound)<br>2026-04-08 01:11:56 us=3D44831 TCPv4_CLIENT link =
remote: [AF_INET]127.0.0.1:11940<br>2026-04-08 01:11:56 us=3D45442 TLS: Ini=
tial packet from [AF_INET]127.0.0.1:11940, sid=3D9f2bc992 ef68a461<br>2026-=
04-08 01:11:56 us=3D45469 TLS Error: Key Method #2 write failed<br>2026-04-=
08 01:11:56 us=3D45475 TLS Error: TLS handshake failed<br>2026-04-08 01:11:=
56 us=3D45522 Fatal TLS error (check_tls_errors_co), restarting<br>2026-04-=
08 01:11:56 us=3D45537 TCP/UDP: Closing socket<br>2026-04-08 01:11:56 us=3D=
45572 SIGUSR1[soft,tls-error] received, process restarting<br>2026-04-08 01=
:11:56 us=3D45582 Restart pause, 1 second(s)</p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;"><br>Basically the only d=
ifference is that the new version waits 2s instead of 1s. The message is ex=
actly the same, an unspecified &quot;key method&quot; failure, that doesn&#=
39;t really say the password is too long, and is entirely unhelpful to a ca=
sual user. The error reporting from a7f80d402f doesn&#39;t trigger in any c=
ombination.</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Now here&#39;s how it looks with this patch, when connectin=
g to a 2.7 server before this patch:</p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">2026-04-08 01:34:55 us=3D526614 At=
tempting to establish TCP connection with [AF_INET]127.0.0.1:11940<br>2026-=
04-08 01:34:55 us=3D526683 TCP connection established with [AF_INET]127.0.0=
.1:11940<br>2026-04-08 01:34:55 us=3D526690 TCPv4_CLIENT link local: (not b=
ound)<br>2026-04-08 01:34:55 us=3D526694 TCPv4_CLIENT link remote: [AF_INET=
]127.0.0.1:11940<br>2026-04-08 01:34:55 us=3D527014 TLS: Initial packet fro=
m [AF_INET]127.0.0.1:11940, sid=3Db3756543 a0f9575c<br>2026-04-08 01:34:55 =
us=3D527030 WARNING: this configuration may cache passwords in memory -- us=
e the auth-nocache option to prevent this<br>2026-04-08 01:34:55 us=3D52773=
7 VERIFY OK: depth=3D1, CN=3DTest CA<br>2026-04-08 01:34:55 us=3D527836 VER=
IFY OK: depth=3D0, CN=3Dserver<br>2026-04-08 01:34:55 us=3D568575 Control C=
hannel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, peer certificate: 2=
56 bits ECprime256v1, signature: ecdsa-with-SHA256, peer signing digest/typ=
e: ecdsa_secp256r1_sha256 ECDSA, key agreement: X25519MLKEM768<br>2026-04-0=
8 01:34:55 us=3D568624 [server] Peer Connection Initiated with [AF_INET]127=
.0.0.1:11940<br>2026-04-08 01:34:55 us=3D568639 TLS: move_session: dest=3DT=
M_ACTIVE src=3DTM_INITIAL reinit_src=3D1<br>2026-04-08 01:34:55 us=3D568717=
 TLS: tls_multi_process: initial untrusted session promoted to trusted<br>2=
026-04-08 01:34:55 us=3D569034 AUTH: Received control message: AUTH_FAILED,=
Username or password is too long. Maximum length is 128 bytes<br>2026-04-08=
 01:34:55 us=3D569150 TCP/UDP: Closing socket<br>2026-04-08 01:34:55 us=3D5=
69194 SIGTERM[soft,auth-failure] received, process exiting</p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">IE: the new =
error path reporting from a7f80d402f actually fires up, and reports a usefu=
l and actionable message to the user.</p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">With a pre-a7f80d402f server ther=
e was no helpful message with a patched client, so I&#39;ve now added it.</=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">So not only this patch doesn&#39;t break compatibility or make the UX wo=
rse, it actually improves it in the error case.</p></li></ul></li></ul><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1622?usp=3De=
mail">change 1622</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1622?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I055c64ca8b23066e70eea7d7ded=
dfb14f5354c5f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1622 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Bluca &lt;luca.boccassi@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: selvanair &lt;selva.nair@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: selvanair &lt;selva.nair@...493...=
277...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 08 Apr 2026 00:54:40=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: Bluca &lt;luca.boccassi@...220...=
..277...&gt; </div>

</body></html>=

--4aLHf00Djrc=--


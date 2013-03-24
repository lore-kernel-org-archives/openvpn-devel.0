MIME-Version: 1.0
Date: Mon, 25 Mar 2013 00:35:12 +0100
Message-ID: <CAHQBeznzF4k-Bx_VSBwAwuy8FYKny3Zcf=6knJwZG8=W4kgVBg@...278...>
From: Eugene Rudoy <gene.devel@...277...>
Content-Type: multipart/alternative; boundary=bcaec5523b26c995c604d8b4232a
Subject: [Openvpn-devel] PolarSSL-1.2 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--bcaec5523b26c995c604d8b4232a
Content-Type: text/plain; charset=UTF-8

Dear openvpn-developers,

I'm wondering what is the best way to submit patches to the openvpn
project. The patch I (er13) added more than a month ago to this ticket
https://community.openvpn.net/openvpn/ticket/250 has been completely
ignored. Instead the patch submitted directly to this list has been
accepted and committed. It's not that my patch is better (btw. I'm not the
only author of it, my patch is based on MaxMuster's one), it just it seems
that you don't pay enough attention to your own bug-tracking system and
some of the patches submitted there simply get lost. I would appreciate it
if you could improve yourself in this regard so that the people investing
their time don't get disappointed ;-) Thanks!

To the PolarSSL-1.2 support itself: I must confess I didn't test it but I
believe the new implementation of verify_callback in ssl_verify_callback.c
is incorrect (
https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/ssl_verify_polarssl.c#L46).
It always returns 0. The error is signaled just by setting *flags to
non-zero value. The flags variable is then reused by PolarSSL for the next
certificate in the chain. So it might be that the incorrect certificate
chain won't get accepted but from reading the code it seems that non-zero
flags coupled with zero return value might result in spurious verify error
messages for other certificates in the chain. Please correct me if I'm
wrong.

Best,
Gene

--bcaec5523b26c995c604d8b4232a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<span style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:1=
3px;background-color:rgb(255,255,255)">Dear openvpn-developers,</span><div =
style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:13px;ba=
ckground-color:rgb(255,255,255)">
<br></div><div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;fo=
nt-size:13px;background-color:rgb(255,255,255)">I&#39;m wondering what is t=
he best way to submit patches to the openvpn project. The patch I (er13) ad=
ded more than a month ago to this ticket=C2=A0<a href=3D"https://community.=
openvpn.net/openvpn/ticket/250" target=3D"_blank" style=3D"color:rgb(17,85,=
204)">https://community.openvpn.net/openvpn/ticket/250</a>=C2=A0has been co=
mpletely ignored. Instead the patch submitted directly to this list has bee=
n accepted and committed. It&#39;s not that my patch is better (btw. I&#39;=
m not the only author of it, my patch is based on MaxMuster&#39;s one), it =
just it seems that you don&#39;t pay enough attention to your own bug-track=
ing system and some of the patches submitted there simply get lost. I would=
 appreciate it if you could improve yourself in this regard so that the peo=
ple investing their time don&#39;t get disappointed ;-) Thanks!</div>
<div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:13=
px;background-color:rgb(255,255,255)"><br></div><div style=3D"color:rgb(34,=
34,34);font-family:arial,sans-serif;font-size:13px;background-color:rgb(255=
,255,255)">
To the PolarSSL-1.2 support itself: I must confess I didn&#39;t test it but=
 I believe the new implementation of verify_callback in ssl_verify_callback=
.c is incorrect (<a href=3D"https://github.com/OpenVPN/openvpn/blob/master/=
src/openvpn/ssl_verify_polarssl.c#L46" target=3D"_blank" style=3D"color:rgb=
(17,85,204)">https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/ssl=
_verify_polarssl.c#L46</a>). It always returns 0. The error is signaled jus=
t by setting *flags to non-zero value. The flags variable is then reused by=
 PolarSSL for the next certificate in the chain. So it might be that the in=
correct certificate chain won&#39;t get accepted but from reading the code =
it seems that non-zero flags coupled with zero return value might result in=
 spurious verify error messages for other certificates in the chain. Please=
 correct me if I&#39;m wrong.</div>
<div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:13=
px;background-color:rgb(255,255,255)"><br></div><div style=3D"color:rgb(34,=
34,34);font-family:arial,sans-serif;font-size:13px;background-color:rgb(255=
,255,255)">
Best,</div><div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;f=
ont-size:13px;background-color:rgb(255,255,255)">Gene</div>

--bcaec5523b26c995c604d8b4232a--


MIME-Version: 1.0
References: <CAC8x_z10PT_ToTzVUKQENA5ZJgJ4EMvBJARphDR5_wdytA2JSw@...278...>
 <b7c9a1ac-3322-4eeb-befd-e19c7f72da6b@...1227...>
 <CAC8x_z3Fwf0r-BuvuOo+Vg0708fsaPGWjg-2pnY3xgM+e4QxDg@...278...>
 <Zzm_gUxTAmFZjm_h@...1296...>
 <CAC8x_z1OtkMeuRCHNOHfg-rcJ3Kcj2uHua3pzK5ZqKJDjPvBjQ@...278...>
 <ZzoQ7jXbImL56HL6@...1296...>
 <CAC8x_z2=DL=t2V5oN_hBMLbYcVMH78XqbTLguxFifjDco+zWyQ@...278...>
 <2dae1148-45d8-4f82-8b65-973b81a18645@...1227...>
 <CAC8x_z25-XQEyk0O34nKFMMj-mXNR2r+WbbaseX70mzzZKT+QA@...278...>
 <ZzrpT6DjykCOJwUB@...1296...>
 <CAC8x_z18gdgGfgSkH4w2hy5KJ8qkbTWXMyjNe592bLGe6ipzsA@...278...>
 <CAFHpkQEYLiq+QGA=gKk-f-3Bi33XWvsS8r5+UEd8GUdmjbE+Ng@...278...>
 <NiEAJIgS9m7ZfNEendx_-DgdcR9mgMT7fRzEQkUbVYLFCz0ypiEj0WQmBGFcUYYPjPds9DYHnsE9C8LCC3TJaA==@protonmail.internalid>
 <CAC8x_z25BWNsGfTbJTk2000D_DHN0tTWBUzSO7USzqwh0VSAGw@...278...>
 <8b4f437c.AW4AAFgn2E0AAAAAAAAAAauy6DYAAYCsnhYAAAAAABXTlQBnOxEf@...2677...>
 <CAC8x_z177Yprk0RnVqaqoLGize5tByiU4wsRvdqh2ovAtQ92nw@...278...>
 <CAFHpkQFFq9q2MAzzGutSb88fgSz7EbJDXH4z5hSG6xLavfnh+w@...278...>
 <CAC8x_z3d4ZjsMu5=8KKOoQMiObQ1Z19_u8Qgr1wsf7Au9ackSA@...278...>
 <CAC8x_z1Gt-mKE9PK59QSFGZJUC2F=YXJCX8mzsbQB_grKB=UrQ@...278...>
In-Reply-To: <CAC8x_z1Gt-mKE9PK59QSFGZJUC2F=YXJCX8mzsbQB_grKB=UrQ@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 19 Nov 2024 09:40:32 +0100
Message-ID: <CAFHpkQFwmWZRESJxOXWY=0E3SA+BeDTLqM2fnk_Ow=H=3fHc7g@...278...>
Content-Type: multipart/alternative; boundary="0000000000003093a306273ffd1a"
Subject: Re: [Openvpn-devel] Subject: Potential OpenVPN Vulnerability
 Report: Repeated TLS Handshake Failures Leading to Denial-of-Service
 Conditions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?16DXqteZINep15jXqNef?= <nsh531@...277...>
Cc: David Sommerseth <dazo+openvpn@...2108...>, =?UTF-8?B?15PXmdeV15XXl9eZINek15LXmdei15XXmdeV16o=?= <cve@...2832...>, Gert Doering <gert@...1296...>, Antonio Quartulli <antonio@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, SECURITY@...515...

--0000000000003093a306273ffd1a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I see "Access server" in logs.

which means that you are running OpenVPN Access Server (not a community
edition).

that product has dedicated support at OpenVPN Support Center
<https://support.openvpn.com/hc/en-us> (I hope you've purchased it).

=E2=80=AA=D0=BF=D0=BD, 18 =D0=BD=D0=BE=D1=8F=D0=B1. 2024=E2=80=AF=D0=B3. =
=D0=B2 15:21, =E2=80=AB=D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=D7=9F=E2=80=AC=
=E2=80=8E <nsh531@...277...>:=E2=80=AC

> server logs:
>
>
> 2024-11-18T22:07:43+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:07:43
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T22:07:49+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:07:49
> 165.154.42.209:42098 Connection reset, restarting [0]'
> 2024-11-18T22:07:49+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:07:49
> 165.154.42.209:42098 SIGUSR1[soft,connection-reset] received,
> client-instance restarting'
> 2024-11-18T22:07:52+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:07:52
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T22:07:52+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:07:52
> TCP connection established with [AF_INET]165.154.42.209:44954'
> 2024-11-18T22:07:52+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:07:52
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T22:07:52+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:07:52
> 165.154.42.209:44954 Non-OpenVPN client protocol detected'
> 2024-11-18T22:07:52+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:07:52
> 165.154.42.209:44954 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T22:07:54+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:07:54
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T22:07:54+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:07:54
> TCP connection established with [AF_INET]165.154.42.209:46014'
> 2024-11-18T22:07:54+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:07:54
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T22:07:54+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:07:54
> 165.154.42.209:46014 Non-OpenVPN client protocol detected'
> 2024-11-18T22:07:54+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:07:54
> 165.154.42.209:46014 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T22:07:54+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:07:54
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T22:07:54+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:07:54
> TCP connection established with [AF_INET]165.154.42.209:46248'
> 2024-11-18T22:07:54+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:07:54
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T22:07:54+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:07:54
> 165.154.42.209:46248 Non-OpenVPN client protocol detected'
> 2024-11-18T22:07:54+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:07:54
> 165.154.42.209:46248 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T22:08:03+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:03
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T22:08:03+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:03
> TCP connection established with [AF_INET]165.154.42.209:49206'
> 2024-11-18T22:08:03+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:03
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T22:08:04+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:04
> 165.154.42.209:49206 Non-OpenVPN client protocol detected'
> 2024-11-18T22:08:04+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:04
> 165.154.42.209:49206 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T22:08:04+1100 [stdout#info] [WEB] OUT:
> '2024-11-18T22:08:04+1100 [twisted.python.log#info] "127.0.0.1" - -
> [18/Nov/2024:11:08:04 +0000] "GET / HTTP/1.1" 200 1707 "-" "curl/7.29.0"'
> 2024-11-18T22:08:05+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:05
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T22:08:05+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:05
> TCP connection established with [AF_INET]165.154.42.209:50150'
> 2024-11-18T22:08:05+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:05
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T22:08:05+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:05
> 165.154.42.209:50150 Non-OpenVPN client protocol detected'
> 2024-11-18T22:08:05+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:05
> 165.154.42.209:50150 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T22:08:14+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:14
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T22:08:14+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:14
> TCP connection established with [AF_INET]165.154.42.209:54166'
> 2024-11-18T22:08:14+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:14
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T22:08:14+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:14
> 165.154.42.209:54166 Non-OpenVPN client protocol detected'
> 2024-11-18T22:08:14+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:14
> 165.154.42.209:54166 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T22:08:14+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:14
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T22:08:14+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:14
> TCP connection established with [AF_INET]165.154.42.209:54260'
> 2024-11-18T22:08:14+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:14
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T22:08:14+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:14
> 165.154.42.209:54260 Non-OpenVPN client protocol detected'
> 2024-11-18T22:08:14+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:14
> 165.154.42.209:54260 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T22:08:15+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:15
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T22:08:15+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:15
> TCP connection established with [AF_INET]165.154.42.209:54382'
> 2024-11-18T22:08:15+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:15
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T22:08:15+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:15
> 165.154.42.209:54382 Non-OpenVPN client protocol detected'
> 2024-11-18T22:08:15+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:15
> 165.154.42.209:54382 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T22:08:15+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:15
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T22:08:15+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:15
> TCP connection established with [AF_INET]165.154.42.209:54506'
> 2024-11-18T22:08:15+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:15
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T22:08:15+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:15
> 165.154.42.209:54506 Non-OpenVPN client protocol detected'
> 2024-11-18T22:08:15+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:15
> 165.154.42.209:54506 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T22:08:16+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:16
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T22:08:16+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:16
> TCP connection established with [AF_INET]165.154.42.209:54660'
> 2024-11-18T22:08:16+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:16
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T22:08:16+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:16
> 165.154.42.209:54660 Non-OpenVPN client protocol detected'
> 2024-11-18T22:08:16+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:16
> 165.154.42.209:54660 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T22:08:16+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:16
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T22:08:16+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:16
> TCP connection established with [AF_INET]165.154.42.209:54804'
> 2024-11-18T22:08:16+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:16
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T22:08:16+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:16
> 165.154.42.209:54804 Non-OpenVPN client protocol detected'
> 2024-11-18T22:08:16+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:16
> 165.154.42.209:54804 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T22:08:17+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:17
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T22:08:17+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:17
> TCP connection established with [AF_INET]165.154.42.209:54950'
> 2024-11-18T22:08:17+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:17
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T22:08:17+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:17
> 165.154.42.209:54950 Non-OpenVPN client protocol detected'
> 2024-11-18T22:08:17+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:17
> 165.154.42.209:54950 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T22:08:17+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:17
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T22:08:17+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:17
> TCP connection established with [AF_INET]165.154.42.209:55156'
> 2024-11-18T22:08:17+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:17
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T22:08:17+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:17
> 165.154.42.209:55156 Non-OpenVPN client protocol detected'
> 2024-11-18T22:08:17+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:17
> 165.154.42.209:55156 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T22:08:18+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:18
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T22:08:18+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:18
> TCP connection established with [AF_INET]165.154.42.209:55284'
> 2024-11-18T22:08:18+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:18
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T22:08:18+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:18
> 165.154.42.209:55284 Non-OpenVPN client protocol detected'
> 2024-11-18T22:08:18+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:18
> 165.154.42.209:55284 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T22:08:18+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:18
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T22:08:18+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:18
> TCP connection established with [AF_INET]165.154.42.209:55410'
> 2024-11-18T22:08:18+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:18
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T22:08:18+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:18
> 165.154.42.209:55410 Non-OpenVPN client protocol detected'
> 2024-11-18T22:08:18+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:18
> 165.154.42.209:55410 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T22:08:19+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:19
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T22:08:19+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:19
> TCP connection established with [AF_INET]165.154.42.209:55610'
> 2024-11-18T22:08:19+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:19
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T22:08:19+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:19
> 165.154.42.209:55610 Non-OpenVPN client protocol detected'
> 2024-11-18T22:08:19+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:08:19
> 165.154.42.209:55610 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T22:44:28+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:44:28
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T22:44:28+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:44:28
> TCP connection established with [AF_INET]79.110.62.21:35294'
> 2024-11-18T22:44:28+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:44:28
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T22:44:28+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:44:28
> 79.110.62.21:35294 Non-OpenVPN client protocol detected'
> 2024-11-18T22:44:28+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:44:28
> 79.110.62.21:35294 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T22:48:46+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:48:46
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T22:48:46+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:48:46
> TCP connection established with [AF_INET]94.156.177.228:51080'
> 2024-11-18T22:48:46+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:48:46
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T22:48:46+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:48:46
> 94.156.177.228:51080 Non-OpenVPN client protocol detected'
> 2024-11-18T22:48:46+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 11:48:46
> 94.156.177.228:51080 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T22:48:47+1100 [stdout#info] [WEB] OUT:
> '2024-11-18T22:48:47+1100 [twisted.python.log#info] "127.0.0.1" - -
> [18/Nov/2024:11:48:47 +0000] "GET /RDWeb/Pages/ HTTP/1.1" 200 1707 "-"
> "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like
> Gecko) Chrome/115.0.0.0 Safari/537.36 Edg/115.0.1901.203"'
> 2024-11-18T22:57:10+1100 [stdout#info] [WEB] OUT:
> '2024-11-18T22:57:10+1100 [twisted.python.log#info] "68.183.22.136" - -
> [18/Nov/2024:11:57:10 +0000] "GET / HTTP/1.0" 400 - "-" "-"'
> 2024-11-18T22:57:12+1100 [stdout#info] [WEB] OUT:
> '2024-11-18T22:57:12+1100 [twisted.python.log#info] "68.183.22.136" - -
> [18/Nov/2024:11:57:11 +0000] "OPTIONS / HTTP/1.0" 400 - "-" "-"'
> 2024-11-18T22:57:13+1100 [stdout#info] [WEB] OUT:
> '2024-11-18T22:57:13+1100 [twisted.python.log#info] "68.183.22.136" - -
> [18/Nov/2024:11:57:12 +0000] "OPTIONS / RTSP/1.0" 400 - "-" "-"'
> 2024-11-18T22:57:14+1100 [stdout#info] [WEB] OUT:
> '2024-11-18T22:57:14+1100 [twisted.python.log#info] "68.183.22.136" - -
> [18/Nov/2024:11:57:14 +0000] "GET /nice%20ports%2C/Tri%6Eity.txt%2ebak
> HTTP/1.0" 400 - "-" "-"'
> 2024-11-18T22:57:15+1100 [stdout#info] [WEB] OUT:
> '2024-11-18T22:57:15+1100 [twisted.python.log#info] "68.183.22.136" - -
> [18/Nov/2024:11:57:15 +0000] "OPTIONS sip:nm SIP/2.0" 400 - "-" "-"'
> 2024-11-18T23:03:10+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:10
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T23:03:10+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:10
> TCP connection established with [AF_INET]152.32.143.189:60324'
> 2024-11-18T23:03:10+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:10
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T23:03:12+1100 [stdout#info] [WEB] OUT:
> '2024-11-18T23:03:12+1100 [twisted.python.log#info] "147.185.132.123" - -
> [18/Nov/2024:12:03:11 +0000] "GET /admin HTTP/1.1" 302 240 "-" "Expanse, a
> Palo Alto Networks company, searches across the global IPv4 space multiple
> times per day to identify customers&#39; presences on the Internet. If you
> would like to be excluded from our scans, please send IP addresses/domains
> to: scaninfo@...2834..."'
> 2024-11-18T23:03:12+1100 [stdout#info] [WEB] OUT:
> '2024-11-18T23:03:12+1100 [twisted.python.log#info] "147.185.132.123" - -
> [18/Nov/2024:12:03:12 +0000] "GET /admin/ HTTP/1.1" 302 - "-" "Expanse, a
> Palo Alto Networks company, searches across the global IPv4 space multiple
> times per day to identify customers&#39; presences on the Internet. If you
> would like to be excluded from our scans, please send IP addresses/domains
> to: scaninfo@...2834..."'
> 2024-11-18T23:03:13+1100 [stdout#info] [WEB] OUT:
> '2024-11-18T23:03:13+1100 [stdout#info] No Cookie or mismatched cookie'
> 2024-11-18T23:03:13+1100 [stdout#info] [WEB] OUT:
> '2024-11-18T23:03:13+1100 [twisted.python.log#info] "147.185.132.123" - -
> [18/Nov/2024:12:03:12 +0000] "GET /admin/__session_start__ HTTP/1.1" 200
> 164 "-" "Expanse, a Palo Alto Networks company, searches across the global
> IPv4 space multiple times per day to identify customers&#39; presences on
> the Internet. If you would like to be excluded from our scans, please send
> IP addresses/domains to: scaninfo@...2834..."'
> 2024-11-18T23:03:16+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:16
> 152.32.143.189:60324 Connection reset, restarting [0]'
> 2024-11-18T23:03:16+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:16
> 152.32.143.189:60324 SIGUSR1[soft,connection-reset] received,
> client-instance restarting'
> 2024-11-18T23:03:18+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:18
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T23:03:18+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:18
> TCP connection established with [AF_INET]152.32.143.189:34528'
> 2024-11-18T23:03:18+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:18
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T23:03:18+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:18
> 152.32.143.189:34528 Non-OpenVPN client protocol detected'
> 2024-11-18T23:03:18+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:18
> 152.32.143.189:34528 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T23:03:21+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:21
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T23:03:21+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:21
> TCP connection established with [AF_INET]152.32.143.189:35864'
> 2024-11-18T23:03:21+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:21
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T23:03:21+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:21
> 152.32.143.189:35864 Non-OpenVPN client protocol detected'
> 2024-11-18T23:03:21+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:21
> 152.32.143.189:35864 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T23:03:22+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:22
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T23:03:22+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:22
> TCP connection established with [AF_INET]152.32.143.189:36138'
> 2024-11-18T23:03:22+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:22
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T23:03:22+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:22
> 152.32.143.189:36138 Non-OpenVPN client protocol detected'
> 2024-11-18T23:03:22+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:22
> 152.32.143.189:36138 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T23:03:30+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:30
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T23:03:30+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:30
> TCP connection established with [AF_INET]152.32.143.189:40176'
> 2024-11-18T23:03:30+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:30
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T23:03:31+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:31
> 152.32.143.189:40176 Non-OpenVPN client protocol detected'
> 2024-11-18T23:03:31+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:31
> 152.32.143.189:40176 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T23:03:31+1100 [stdout#info] [WEB] OUT:
> '2024-11-18T23:03:31+1100 [twisted.python.log#info] "127.0.0.1" - -
> [18/Nov/2024:12:03:30 +0000] "GET / HTTP/1.1" 200 1707 "-" "curl/7.29.0"'
> 2024-11-18T23:03:32+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:32
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T23:03:32+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:32
> TCP connection established with [AF_INET]152.32.143.189:41352'
> 2024-11-18T23:03:32+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:32
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T23:03:32+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:32
> 152.32.143.189:41352 Non-OpenVPN client protocol detected'
> 2024-11-18T23:03:32+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:32
> 152.32.143.189:41352 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T23:03:41+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:41
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T23:03:41+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:41
> TCP connection established with [AF_INET]152.32.143.189:46888'
> 2024-11-18T23:03:41+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:41
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T23:03:42+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:42
> 152.32.143.189:46888 Non-OpenVPN client protocol detected'
> 2024-11-18T23:03:42+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:42
> 152.32.143.189:46888 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T23:03:42+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:42
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T23:03:42+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:42
> TCP connection established with [AF_INET]152.32.143.189:47524'
> 2024-11-18T23:03:42+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:42
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T23:03:42+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:42
> 152.32.143.189:47524 Non-OpenVPN client protocol detected'
> 2024-11-18T23:03:42+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:42
> 152.32.143.189:47524 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T23:03:43+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:43
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T23:03:43+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:43
> TCP connection established with [AF_INET]152.32.143.189:48008'
> 2024-11-18T23:03:43+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:43
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T23:03:43+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:43
> 152.32.143.189:48008 Non-OpenVPN client protocol detected'
> 2024-11-18T23:03:43+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:43
> 152.32.143.189:48008 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T23:03:44+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:44
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T23:03:44+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:44
> TCP connection established with [AF_INET]152.32.143.189:48522'
> 2024-11-18T23:03:44+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:44
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T23:03:44+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:44
> 152.32.143.189:48522 Non-OpenVPN client protocol detected'
> 2024-11-18T23:03:44+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:44
> 152.32.143.189:48522 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T23:03:45+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:45
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T23:03:45+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:45
> TCP connection established with [AF_INET]152.32.143.189:49156'
> 2024-11-18T23:03:45+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:45
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T23:03:45+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:45
> 152.32.143.189:49156 Non-OpenVPN client protocol detected'
> 2024-11-18T23:03:45+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:45
> 152.32.143.189:49156 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T23:03:46+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:46
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T23:03:46+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:46
> TCP connection established with [AF_INET]152.32.143.189:49756'
> 2024-11-18T23:03:46+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:46
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T23:03:46+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:46
> 152.32.143.189:49756 Non-OpenVPN client protocol detected'
> 2024-11-18T23:03:46+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:46
> 152.32.143.189:49756 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T23:03:47+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:47
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T23:03:47+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:47
> TCP connection established with [AF_INET]152.32.143.189:50234'
> 2024-11-18T23:03:47+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:47
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T23:03:47+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:47
> 152.32.143.189:50234 Non-OpenVPN client protocol detected'
> 2024-11-18T23:03:47+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:47
> 152.32.143.189:50234 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T23:03:48+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:48
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T23:03:48+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:48
> TCP connection established with [AF_INET]152.32.143.189:51192'
> 2024-11-18T23:03:48+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:48
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T23:03:48+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:48
> 152.32.143.189:51192 Non-OpenVPN client protocol detected'
> 2024-11-18T23:03:48+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:48
> 152.32.143.189:51192 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T23:03:49+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:49
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T23:03:49+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:49
> TCP connection established with [AF_INET]152.32.143.189:51718'
> 2024-11-18T23:03:49+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:49
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T23:03:49+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:49
> 152.32.143.189:51718 Non-OpenVPN client protocol detected'
> 2024-11-18T23:03:49+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:49
> 152.32.143.189:51718 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T23:03:50+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:50
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T23:03:50+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:50
> TCP connection established with [AF_INET]152.32.143.189:52384'
> 2024-11-18T23:03:50+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:50
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T23:03:50+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:50
> 152.32.143.189:52384 Non-OpenVPN client protocol detected'
> 2024-11-18T23:03:50+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:50
> 152.32.143.189:52384 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T23:03:50+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:50
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T23:03:50+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:50
> TCP connection established with [AF_INET]152.32.143.189:52844'
> 2024-11-18T23:03:50+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:50
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T23:03:50+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:50
> 152.32.143.189:52844 Non-OpenVPN client protocol detected'
> 2024-11-18T23:03:50+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:03:50
> 152.32.143.189:52844 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T23:04:12+1100 [stdout#info] [WEB] OUT:
> "2024-11-18T23:04:12+1100 [-] expired session b'x5NuuX..."
> 2024-11-18T23:51:30+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:51:30
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T23:51:30+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:51:30
> TCP connection established with [AF_INET]185.242.226.117:34407'
> 2024-11-18T23:51:30+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:51:30
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T23:51:31+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:51:31
> 185.242.226.117:34407 Non-OpenVPN client protocol detected'
> 2024-11-18T23:51:31+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:51:31
> 185.242.226.117:34407 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T23:59:04+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:59:04
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T23:59:04+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:59:04
> TCP connection established with [AF_INET]165.154.36.105:42216'
> 2024-11-18T23:59:04+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:59:04
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T23:59:04+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:59:04
> 165.154.36.105:42216 Non-OpenVPN client protocol detected'
> 2024-11-18T23:59:04+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:59:04
> 165.154.36.105:42216 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T23:59:04+1100 [stdout#info] [WEB] OUT:
> '2024-11-18T23:59:04+1100 [twisted.python.log#info] "127.0.0.1" - -
> [18/Nov/2024:12:59:04 +0000] "GET / HTTP/1.1" 200 1707 "-" "Mozilla/5.0
> (Windows NT 7_1; Win64; x64) AppleWebKit/553.44 (KHTML, like Gecko)
> Chrome/90.0.2093 Safari/537.36"'
> 2024-11-18T23:59:04+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:59:04
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T23:59:04+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:59:04
> TCP connection established with [AF_INET]165.154.36.105:42430'
> 2024-11-18T23:59:04+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:59:04
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T23:59:04+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:59:04
> 165.154.36.105:42430 Non-OpenVPN client protocol detected'
> 2024-11-18T23:59:04+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:59:04
> 165.154.36.105:42430 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T23:59:05+1100 [stdout#info] [WEB] OUT:
> '2024-11-18T23:59:05+1100 [twisted.python.log#info] "127.0.0.1" - -
> [18/Nov/2024:12:59:04 +0000] "GET
> /static/standalone/client/media/favicon-dark/favicon-32x32.png HTTP/1.1"
> 200 734 "-" "Go-http-client/1.1"'
> 2024-11-18T23:59:05+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:59:05
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-18T23:59:05+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:59:05
> TCP connection established with [AF_INET]165.154.36.105:42530'
> 2024-11-18T23:59:05+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:59:05
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T23:59:05+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:59:05
> 165.154.36.105:42530 Note: OpenSSL hardware crypto engine functionality
> is not available'
> 2024-11-18T23:59:05+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:59:05
> 165.154.36.105:42530 TCP connection established with [AF_INET]
> 165.154.36.105:42528'
> 2024-11-18T23:59:05+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:59:05
> 165.154.36.105:42530 Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-18T23:59:05+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:59:05
> 165.154.36.105:42530 Non-OpenVPN client protocol detected'
> 2024-11-18T23:59:05+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:59:05
> 165.154.36.105:42530 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T23:59:05+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:59:05
> 165.154.36.105:42528 Non-OpenVPN client protocol detected'
> 2024-11-18T23:59:05+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 12:59:05
> 165.154.36.105:42528 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-18T23:59:05+1100 [stdout#info] [WEB] OUT:
> '2024-11-18T23:59:05+1100 [twisted.python.log#info] "127.0.0.1" - -
> [18/Nov/2024:12:59:05 +0000] "GET /sitemap.xml HTTP/1.1" 404 167 "-"
> "Go-http-client/1.1"'
> 2024-11-18T23:59:05+1100 [stdout#info] [WEB] OUT:
> '2024-11-18T23:59:05+1100 [twisted.python.log#info] "127.0.0.1" - -
> [18/Nov/2024:12:59:05 +0000] "GET /robots.txt HTTP/1.1" 200 26 "-"
> "Go-http-client/1.1"'
> 2024-11-19T00:05:55+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:05:55
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-19T00:05:55+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:05:55
> TCP connection established with [AF_INET]118.193.36.63:33848'
> 2024-11-19T00:05:55+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:05:55
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-19T00:05:55+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:05:55
> 118.193.36.63:33848 Non-OpenVPN client protocol detected'
> 2024-11-19T00:05:55+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:05:55
> 118.193.36.63:33848 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-19T00:05:55+1100 [stdout#info] [WEB] OUT:
> '2024-11-19T00:05:55+1100 [twisted.python.log#info] "127.0.0.1" - -
> [18/Nov/2024:13:05:55 +0000] "GET / HTTP/1.1" 200 1707 "-" "Mozilla/5.0
> (Windows NT 9_1_2; Win64; x64) AppleWebKit/594.54 (KHTML, like Gecko)
> Chrome/90.0.2915 Safari/537.36"'
> 2024-11-19T00:05:56+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:05:56
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-19T00:05:56+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:05:56
> TCP connection established with [AF_INET]118.193.36.63:34072'
> 2024-11-19T00:05:56+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:05:56
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-19T00:05:56+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:05:56
> 118.193.36.63:34072 Non-OpenVPN client protocol detected'
> 2024-11-19T00:05:56+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:05:56
> 118.193.36.63:34072 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-19T00:05:56+1100 [stdout#info] [WEB] OUT:
> '2024-11-19T00:05:56+1100 [twisted.python.log#info] "127.0.0.1" - -
> [18/Nov/2024:13:05:55 +0000] "GET
> /static/standalone/client/media/favicon-dark/favicon-32x32.png HTTP/1.1"
> 200 734 "-" "Go-http-client/1.1"'
> 2024-11-19T00:05:56+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:05:56
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-19T00:05:56+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:05:56
> TCP connection established with [AF_INET]118.193.36.63:34258'
> 2024-11-19T00:05:56+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:05:56
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-19T00:05:56+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:05:56
> 118.193.36.63:34258 Non-OpenVPN client protocol detected'
> 2024-11-19T00:05:56+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:05:56
> 118.193.36.63:34258 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-19T00:05:56+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:05:56
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-19T00:05:56+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:05:56
> TCP connection established with [AF_INET]118.193.36.63:34256'
> 2024-11-19T00:05:56+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:05:56
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-19T00:05:56+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:05:56
> 118.193.36.63:34256 Non-OpenVPN client protocol detected'
> 2024-11-19T00:05:56+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:05:56
> 118.193.36.63:34256 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-19T00:05:56+1100 [stdout#info] [WEB] OUT:
> '2024-11-19T00:05:56+1100 [twisted.python.log#info] "127.0.0.1" - -
> [18/Nov/2024:13:05:56 +0000] "GET /sitemap.xml HTTP/1.1" 404 167 "-"
> "Go-http-client/1.1"'
> 2024-11-19T00:05:56+1100 [stdout#info] [WEB] OUT:
> '2024-11-19T00:05:56+1100 [twisted.python.log#info] "127.0.0.1" - -
> [18/Nov/2024:13:05:56 +0000] "GET /robots.txt HTTP/1.1" 200 26 "-"
> "Go-http-client/1.1"'
> 2024-11-19T00:11:02+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:11:02
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-19T00:11:02+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:11:02
> TCP connection established with [AF_INET]138.68.26.173:33180'
> 2024-11-19T00:11:02+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:11:02
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-19T00:11:02+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:11:02
> 138.68.26.173:33180 Non-OpenVPN client protocol detected'
> 2024-11-19T00:11:02+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:11:02
> 138.68.26.173:33180 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-19T00:11:03+1100 [stdout#info] [WEB] OUT:
> '2024-11-19T00:11:03+1100 [twisted.python.log#info] "127.0.0.1" - -
> [18/Nov/2024:13:11:02 +0000] "GET /.env HTTP/1.1" 404 167 "-" "Mozilla/5.0
> Keydrop"'
> 2024-11-19T00:11:03+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:11:03
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-19T00:11:03+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:11:03
> TCP connection established with [AF_INET]138.68.26.173:33194'
> 2024-11-19T00:11:03+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:11:03
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-19T00:11:03+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:11:03
> 138.68.26.173:33194 Non-OpenVPN client protocol detected'
> 2024-11-19T00:11:03+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:11:03
> 138.68.26.173:33194 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-19T00:20:44+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:44
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-19T00:20:44+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:44
> TCP connection established with [AF_INET]172.206.143.215:60360'
> 2024-11-19T00:20:44+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:44
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-19T00:20:44+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:44
> 172.206.143.215:60360 Non-OpenVPN client protocol detected'
> 2024-11-19T00:20:44+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:44
> 172.206.143.215:60360 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-19T00:20:46+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:46
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-19T00:20:46+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:46
> TCP connection established with [AF_INET]172.206.143.215:60368'
> 2024-11-19T00:20:46+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:46
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-19T00:20:46+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:46
> 172.206.143.215:60368 Non-OpenVPN client protocol detected'
> 2024-11-19T00:20:46+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:46
> 172.206.143.215:60368 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-19T00:20:47+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:47
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-19T00:20:47+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:47
> TCP connection established with [AF_INET]172.206.143.215:46430'
> 2024-11-19T00:20:47+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:47
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-19T00:20:47+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:47
> 172.206.143.215:46430 Non-OpenVPN client protocol detected'
> 2024-11-19T00:20:47+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:47
> 172.206.143.215:46430 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-19T00:20:48+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:48
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-19T00:20:48+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:48
> TCP connection established with [AF_INET]172.206.143.215:46436'
> 2024-11-19T00:20:48+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:48
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-19T00:20:48+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:48
> 172.206.143.215:46436 Non-OpenVPN client protocol detected'
> 2024-11-19T00:20:48+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:48
> 172.206.143.215:46436 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-19T00:20:49+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:49
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-19T00:20:49+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:49
> TCP connection established with [AF_INET]172.206.143.215:46440'
> 2024-11-19T00:20:49+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:49
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-19T00:20:49+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:49
> 172.206.143.215:46440 Non-OpenVPN client protocol detected'
> 2024-11-19T00:20:49+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:49
> 172.206.143.215:46440 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-19T00:20:49+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:49
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-19T00:20:49+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:49
> TCP connection established with [AF_INET]172.206.143.215:46450'
> 2024-11-19T00:20:49+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:49
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-19T00:20:49+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:49
> 172.206.143.215:46450 Non-OpenVPN client protocol detected'
> 2024-11-19T00:20:49+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:49
> 172.206.143.215:46450 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-19T00:20:49+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:49
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-19T00:20:49+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:49
> TCP connection established with [AF_INET]172.206.143.215:46456'
> 2024-11-19T00:20:49+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:49
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-19T00:20:49+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:49
> 172.206.143.215:46456 Non-OpenVPN client protocol detected'
> 2024-11-19T00:20:49+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:49
> 172.206.143.215:46456 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-19T00:20:51+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:51
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-19T00:20:51+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:51
> TCP connection established with [AF_INET]172.206.143.215:46462'
> 2024-11-19T00:20:51+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:51
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-19T00:20:51+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:51
> 172.206.143.215:46462 Non-OpenVPN client protocol detected'
> 2024-11-19T00:20:51+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:51
> 172.206.143.215:46462 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-19T00:20:52+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:52
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-19T00:20:52+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:52
> TCP connection established with [AF_INET]172.206.143.215:46476'
> 2024-11-19T00:20:52+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:52
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-19T00:20:52+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:52
> 172.206.143.215:46476 Non-OpenVPN client protocol detected'
> 2024-11-19T00:20:52+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:52
> 172.206.143.215:46476 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-19T00:20:52+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:52
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-19T00:20:52+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:52
> TCP connection established with [AF_INET]172.206.143.215:46484'
> 2024-11-19T00:20:52+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:52
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-19T00:20:52+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:52
> 172.206.143.215:46484 Non-OpenVPN client protocol detected'
> 2024-11-19T00:20:52+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:20:52
> 172.206.143.215:46484 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-19T00:51:52+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:51:52
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-19T00:51:52+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:51:52
> TCP connection established with [AF_INET]51.158.169.40:32931'
> 2024-11-19T00:51:52+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:51:52
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-19T00:51:52+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:51:52
> 51.158.169.40:32931 Non-OpenVPN client protocol detected'
> 2024-11-19T00:51:52+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:51:52
> 51.158.169.40:32931 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-19T00:54:27+1100 [stdout#info] [OVPN 1] OUT: "2024-11-18 13:54:27
> MANAGEMENT: CMD 'exit'"
> 2024-11-19T00:54:27+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 13:54:27
> MANAGEMENT: Client disconnected'
> 2024-11-19T00:54:27+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 13:54:27
> MANAGEMENT: Triggering management exit'
> 2024-11-19T00:54:27+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 13:54:27
> Closing TUN/TAP interface'
> 2024-11-19T00:54:27+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 13:54:27
> net_addr_v4_del: 172.27.232.1 dev as0t1'
> 2024-11-19T00:54:27+1100 [stdout#info] OMI Cancel pending deferred ['exit=
']
> 2024-11-19T00:54:27+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 13:54:27
> SIGTERM[soft,management-exit] received, process exiting'
> 2024-11-19T00:54:27+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 13:54:27
> MANAGEMENT: >STATE:1731938067,EXITING,management-exit,,,,,'
> 2024-11-19T00:54:27+1100 [stdout#info] [OVPN 0] OUT: "2024-11-18 13:54:27
> MANAGEMENT: CMD 'exit'"
> 2024-11-19T00:54:27+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:54:27
> MANAGEMENT: Client disconnected'
> 2024-11-19T00:54:27+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:54:27
> MANAGEMENT: Triggering management exit'
> 2024-11-19T00:54:27+1100 [stdout#info] OMI Cancel pending deferred ['exit=
']
> 2024-11-19T00:54:27+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:54:27
> Closing TUN/TAP interface'
> 2024-11-19T00:54:27+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:54:27
> net_addr_v4_del: 172.27.224.1 dev as0t0'
> 2024-11-19T00:54:27+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:54:27
> SIGTERM[soft,management-exit] received, process exiting'
> 2024-11-19T00:54:27+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:54:27
> MANAGEMENT: >STATE:1731938067,EXITING,management-exit,,,,,'
> 2024-11-19T00:54:27+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:54:27
> PORT SHARE PROXY: proxy exiting'
> 2024-11-19T00:54:27+1100 [stdout#info] PROC RESTORE
> /proc/sys/net/ipv4/ip_forward -> b'0'
> 2024-11-19T00:54:27+1100 [stdout#info] PROC RESTORE
> /proc/sys/net/netfilter/nf_conntrack_tcp_be_liberal -> b'0'
> 2024-11-19T00:54:27+1100 [stdout#info] WEB: Sending SIGTERM to pid 862
> 2024-11-19T00:54:27+1100 [stdout#info] [WEB] OUT:
> '2024-11-19T00:54:27+1100 [-] Received SIGTERM, shutting down.'
> 2024-11-19T00:54:27+1100 [stdout#info] [WEB] OUT:
> '2024-11-19T00:54:27+1100 [-] (TLS Port 909 Closed)'
> 2024-11-19T00:54:27+1100 [stdout#info] [WEB] OUT:
> '2024-11-19T00:54:27+1100 [-] (TLS Port 908 Closed)'
> 2024-11-19T00:54:27+1100 [stdout#info] [WEB] OUT:
> '2024-11-19T00:54:27+1100 [-] (TLS Port 907 Closed)'
> 2024-11-19T00:54:27+1100 [stdout#info] [WEB] OUT:
> '2024-11-19T00:54:27+1100 [-] (TLS Port 906 Closed)'
> 2024-11-19T00:54:27+1100 [stdout#info] [WEB] OUT:
> '2024-11-19T00:54:27+1100 [-] (TLS Port 905 Closed)'
> 2024-11-19T00:54:27+1100 [stdout#info] [WEB] OUT:
> '2024-11-19T00:54:27+1100 [-] (TLS Port 904 Closed)'
> 2024-11-19T00:54:27+1100 [stdout#info] [WEB] OUT:
> '2024-11-19T00:54:27+1100 [-] (TLS Port 943 Closed)'
> 2024-11-19T00:54:27+1100 [stdout#info] [WEB] OUT:
> '2024-11-19T00:54:27+1100 [-] Main loop terminated.'
> 2024-11-19T00:54:27+1100 [stdout#info] [WEB] OUT:
> '2024-11-19T00:54:27+1100 [-] Warning: No permission to delete pid file'
> 2024-11-19T00:54:27+1100 [stdout#info] [WEB] OUT:
> '2024-11-19T00:54:27+1100 [twisted.scripts._twistd_unix.UnixAppLogger#inf=
o]
> Server Shut Down.'
> 2024-11-19T00:54:27+1100 [stdout#info] Server Agent shutting down, stop
> status: {'errors': {}, 'service_status': {'api': 'off. Error: [None]',
> 'auth': 'off. Error: [None]', 'daemon_pre': 'off. Error: [None]', 'bridge=
':
> 'off. Error: [None]', 'db_push': 'off. Error: [None]', 'web': 'off. Error:
> [None]', 'log': 'off. Error: [None]', 'client_query': 'off. Error: [None]=
',
> 'iptables_api': 'off. Error: [None]', 'iptables_web': 'off. Error: [None]=
',
> 'iptables_openvpn': 'off. Error: [None]', 'ip6tables_openvpn': 'off. Erro=
r:
> [None]', 'ip6tables_live': 'off. Error: [None]', 'iptables_live': 'off.
> Error: [None]', 'user': 'off. Error: [None]', 'openvpn_0': 'off. Error:
> [None]', 'crl': 'off. Error: [None]', 'subscription': 'off. Error: [None]=
',
> 'openvpn_1': 'off. Error: [None]'}, 'last_restarted': 'Thu Nov 14 22:40:15
> 2024'}
> 2024-11-19T00:54:27+1100 [-] Received SIGTERM, shutting down.
> 2024-11-19T00:54:27+1100 [twisted.scripts._twistd_unix.UnixAppLogger#info]
> Server Shut Down.
> 2024-11-19T00:55:11+1100 [twisted.scripts._twistd_unix.UnixAppLogger#info]
> twistd 22.4.0 (/usr/bin/python3 3.12.3) starting up.
> 2024-11-19T00:55:11+1100 [twisted.scripts._twistd_unix.UnixAppLogger#info]
> reactor class: twisted.internet.asyncioreactor.AsyncioSelectorReactor.
> 2024-11-19T00:55:11+1100 [stdout#info] check_if_upgrade_needed: path_to_db
> -  sqlite:////usr/local/openvpn_as/etc/db/config.db
> 2024-11-19T00:55:11+1100 [stdout#info] check_for_upgrade: initial version
> [2.14.1], current - [2.14.1], value of current version in DB: [2.14.1]
> 2024-11-19T00:55:11+1100 [stdout#info] rmdir
> /usr/local/openvpn_as/etc/db_push
> 2024-11-19T00:55:11+1100 [stdout#info] ACCESS SERVER starting,
> version=3D2.14.1, build=3Dff013d4d
> 2024-11-19T00:55:11+1100 [stdout#info] Max open files set to (4096, 4096)
> 2024-11-19T00:55:12+1100 [-] /run/systemd/resolve/resolv.conf changed,
> reparsing
> 2024-11-19T00:55:12+1100 [-] Resolver added ('8.8.8.8', 53) to server list
> 2024-11-19T00:55:12+1100 [-] Resolver added ('8.8.4.4', 53) to server list
> 2024-11-19T00:55:12+1100 [-] Received SIGTERM, shutting down.
> 2024-11-19T00:55:12+1100 [twisted.web.client._HTTP11ClientFactory#info]
> Starting factory _HTTP11ClientFactory(<function
> HTTPConnectionPool._newConnection.<locals>.quiescentCallback at
> 0x708231886de0>, <twisted.internet.endpoints.TCP4ClientEndpoint object at
> 0x70823187dca0>)
> 2024-11-19T00:55:12+1100 [-] CurrentTimeSite starting on
> '/usr/local/openvpn_as/etc/sock/sagent'
> 2024-11-19T00:55:12+1100 [pyovpn.web.twisted.site.CurrentTimeSite#info]
> Starting factory <pyovpn.web.twisted.site.CurrentTimeSite object at
> 0x70822e91c200>
> 2024-11-19T00:55:12+1100 [-] CurrentTimeSite starting on
> '/usr/local/openvpn_as/etc/sock/sagent.localroot'
> 2024-11-19T00:55:12+1100 [pyovpn.web.twisted.site.CurrentTimeSite#info]
> Starting factory <pyovpn.web.twisted.site.CurrentTimeSite object at
> 0x70823187d1f0>
> 2024-11-19T00:55:12+1100 [-] CurrentTimeSite starting on
> '/usr/local/openvpn_as/etc/sock/sagent.api'
> 2024-11-19T00:55:12+1100 [pyovpn.web.twisted.site.CurrentTimeSite#info]
> Starting factory <pyovpn.web.twisted.site.CurrentTimeSite object at
> 0x70822e91c5c0>
> 2024-11-19T00:55:12+1100 [twisted.web.client._HTTP11ClientFactory#info]
> Stopping factory _HTTP11ClientFactory(<function
> HTTPConnectionPool._newConnection.<locals>.quiescentCallback at
> 0x708231886de0>, <twisted.internet.endpoints.TCP4ClientEndpoint object at
> 0x70823187dca0>)
> 2024-11-19T00:55:13+1100 [stdout#info] OpenVPNDataDir: using shared dir:
> '/run/openvpn_as/tmp'
> 2024-11-19T00:55:13+1100 [stdout#info] OpenVPNDataDir: using shared dir:
> '/run/openvpn_as/dev'
> 2024-11-19T00:55:13+1100 [stdout#info] /bin/mknod -m 0666
> /run/openvpn_as/dev/null c 1 3
> 2024-11-19T00:55:13+1100 [stdout#info] OpenVPNDataDir: using shared dir:
> '/run/openvpn_as/pso'
> 2024-11-19T00:55:13+1100 [stdout#info] /bin/mknod -m 0666
> /run/openvpn_as/dev/random c 1 8
> 2024-11-19T00:55:13+1100 [-] (UNIX Port
> /usr/local/openvpn_as/etc/sock/sagent.api Closed)
> 2024-11-19T00:55:13+1100 [pyovpn.web.twisted.site.CurrentTimeSite#info]
> Stopping factory <pyovpn.web.twisted.site.CurrentTimeSite object at
> 0x70822e91c5c0>
> 2024-11-19T00:55:13+1100 [-] (UNIX Port
> /usr/local/openvpn_as/etc/sock/sagent.localroot Closed)
> 2024-11-19T00:55:13+1100 [pyovpn.web.twisted.site.CurrentTimeSite#info]
> Stopping factory <pyovpn.web.twisted.site.CurrentTimeSite object at
> 0x70823187d1f0>
> 2024-11-19T00:55:13+1100 [-] (UNIX Port
> /usr/local/openvpn_as/etc/sock/sagent Closed)
> 2024-11-19T00:55:13+1100 [pyovpn.web.twisted.site.CurrentTimeSite#info]
> Stopping factory <pyovpn.web.twisted.site.CurrentTimeSite object at
> 0x70822e91c200>
> 2024-11-19T00:55:13+1100 [stdout#info] LOG: Sending SIGTERM to pid 1108
> 2024-11-19T00:55:13+1100 [stdout#info] WEB: Sending SIGTERM to pid 1107
> 2024-11-19T00:55:13+1100 [twisted.scripts._twistd_unix.UnixAppLogger#info]
> Server Shut Down.
> 2024-11-19T00:55:57+1100 [twisted.scripts._twistd_unix.UnixAppLogger#info]
> twistd 22.4.0 (/usr/bin/python3 3.12.3) starting up.
> 2024-11-19T00:55:57+1100 [twisted.scripts._twistd_unix.UnixAppLogger#info]
> reactor class: twisted.internet.asyncioreactor.AsyncioSelectorReactor.
> 2024-11-19T00:55:57+1100 [stdout#info] check_if_upgrade_needed: path_to_db
> -  sqlite:////usr/local/openvpn_as/etc/db/config.db
> 2024-11-19T00:55:57+1100 [stdout#info] check_for_upgrade: initial version
> [2.14.1], current - [2.14.1], value of current version in DB: [2.14.1]
> 2024-11-19T00:55:57+1100 [stdout#info] rmdir
> /usr/local/openvpn_as/etc/db_push
> 2024-11-19T00:55:57+1100 [stdout#info] ACCESS SERVER starting,
> version=3D2.14.1, build=3Dff013d4d
> 2024-11-19T00:55:57+1100 [stdout#info] Max open files set to (4096, 4096)
> 2024-11-19T00:55:57+1100 [-] /run/systemd/resolve/resolv.conf changed,
> reparsing
> 2024-11-19T00:55:57+1100 [-] Resolver added ('8.8.8.8', 53) to server list
> 2024-11-19T00:55:57+1100 [-] Resolver added ('8.8.4.4', 53) to server list
> 2024-11-19T00:55:57+1100 [twisted.web.client._HTTP11ClientFactory#info]
> Starting factory _HTTP11ClientFactory(<function
> HTTPConnectionPool._newConnection.<locals>.quiescentCallback at
> 0x72b8d5276d40>, <twisted.internet.endpoints.TCP4ClientEndpoint object at
> 0x72b8d526d910>)
> 2024-11-19T00:55:57+1100 [-] CurrentTimeSite starting on
> '/usr/local/openvpn_as/etc/sock/sagent'
> 2024-11-19T00:55:57+1100 [pyovpn.web.twisted.site.CurrentTimeSite#info]
> Starting factory <pyovpn.web.twisted.site.CurrentTimeSite object at
> 0x72b8d22e5310>
> 2024-11-19T00:55:57+1100 [-] CurrentTimeSite starting on
> '/usr/local/openvpn_as/etc/sock/sagent.localroot'
> 2024-11-19T00:55:57+1100 [pyovpn.web.twisted.site.CurrentTimeSite#info]
> Starting factory <pyovpn.web.twisted.site.CurrentTimeSite object at
> 0x72b8d24b5a00>
> 2024-11-19T00:55:57+1100 [-] CurrentTimeSite starting on
> '/usr/local/openvpn_as/etc/sock/sagent.api'
> 2024-11-19T00:55:57+1100 [pyovpn.web.twisted.site.CurrentTimeSite#info]
> Starting factory <pyovpn.web.twisted.site.CurrentTimeSite object at
> 0x72b8d2607a10>
> 2024-11-19T00:55:57+1100 [stdout#info] OpenVPNDataDir: using shared dir:
> '/run/openvpn_as/tmp'
> 2024-11-19T00:55:57+1100 [stdout#info] OpenVPNDataDir: using shared dir:
> '/run/openvpn_as/dev'
> 2024-11-19T00:55:57+1100 [stdout#info] /bin/mknod -m 0666
> /run/openvpn_as/dev/null c 1 3
> 2024-11-19T00:55:57+1100 [stdout#info] OpenVPNDataDir: using shared dir:
> '/run/openvpn_as/pso'
> 2024-11-19T00:55:57+1100 [stdout#info] /bin/mknod -m 0666
> /run/openvpn_as/dev/random c 1 8
> 2024-11-19T00:55:57+1100 [stdout#info] /bin/mknod -m 0444
> /run/openvpn_as/dev/urandom c 1 9
> 2024-11-19T00:55:58+1100 [stdout#info] [WEB] OUT: 'Content-type .eot is
> not found. Using the default application/octect-stream'
> 2024-11-19T00:55:58+1100 [stdout#info] [WEB] OUT: 'Content-type .eot is
> not found. Using the default application/octect-stream'
> 2024-11-19T00:55:58+1100 [twisted.web.client._HTTP11ClientFactory#info]
> Stopping factory _HTTP11ClientFactory(<function
> HTTPConnectionPool._newConnection.<locals>.quiescentCallback at
> 0x72b8d5276d40>, <twisted.internet.endpoints.TCP4ClientEndpoint object at
> 0x72b8d526d910>)
> 2024-11-19T00:55:59+1100 [stdout#info] [WEB] OUT: 'WSERV
> admin+client+xmlrpc 0.0.0.0 943'
> 2024-11-19T00:55:59+1100 [stdout#info] [WEB] OUT: 'WSERV admin+client
> 127.0.0.1 904'
> 2024-11-19T00:55:59+1100 [stdout#info] [WEB] OUT: 'WSERV admin 127.0.0.1
> 905'
> 2024-11-19T00:55:59+1100 [stdout#info] [WEB] OUT: 'WSERV client 127.0.0.1
> 906'
> 2024-11-19T00:55:59+1100 [stdout#info] [WEB] OUT: 'WSERV xmlrpc 127.0.0.1
> 907'
> 2024-11-19T00:55:59+1100 [stdout#info] [WEB] OUT: 'WSERV
> admin+client+xmlrpc 127.0.0.1 908'
> 2024-11-19T00:55:59+1100 [stdout#info] [WEB] OUT: 'WSERV client+xmlrpc
> 127.0.0.1 909'
> 2024-11-19T00:55:59+1100 [stdout#info] [WEB] OUT:
> '2024-11-19T00:55:59+1100 [twisted.scripts._twistd_unix.UnixAppLogger#inf=
o]
> twistd 22.4.0 (/usr/bin/python3 3.12.3) starting up.'
> 2024-11-19T00:55:59+1100 [stdout#info] [WEB] OUT:
> '2024-11-19T00:55:59+1100 [twisted.scripts._twistd_unix.UnixAppLogger#inf=
o]
> reactor class: twisted.internet.epollreactor.EPollReactor.'
> 2024-11-19T00:55:59+1100 [stdout#info] [WEB] OUT:
> '2024-11-19T00:55:59+1100 [-] ASWebSite (TLS) starting on 943'
> 2024-11-19T00:55:59+1100 [stdout#info] [WEB] OUT:
> '2024-11-19T00:55:59+1100 [-] ASWebSite (TLS) starting on 904'
> 2024-11-19T00:55:59+1100 [stdout#info] [WEB] OUT:
> '2024-11-19T00:55:59+1100 [-] ASWebSite (TLS) starting on 905'
> 2024-11-19T00:55:59+1100 [stdout#info] [WEB] OUT:
> '2024-11-19T00:55:59+1100 [-] ASWebSite (TLS) starting on 906'
> 2024-11-19T00:55:59+1100 [stdout#info] [WEB] OUT:
> '2024-11-19T00:55:59+1100 [-] ASWebSite (TLS) starting on 907'
> 2024-11-19T00:55:59+1100 [stdout#info] [WEB] OUT:
> '2024-11-19T00:55:59+1100 [-] ASWebSite (TLS) starting on 908'
> 2024-11-19T00:55:59+1100 [stdout#info] [WEB] OUT:
> '2024-11-19T00:55:59+1100 [-] ASWebSite (TLS) starting on 909'
> 2024-11-19T00:55:59+1100 [stdout#info] [WEB] OUT:
> '2024-11-19T00:55:59+1100 [-] set uid/gid 1001/1001'
> 2024-11-19T00:55:59+1100 [stdout#info] [WEB] OUT:
> '2024-11-19T00:55:59+1100 [stdout#info] Web server running as UID 1001'
> 2024-11-19T00:55:59+1100 [stdout#info] PROC SET
> /proc/sys/net/ipv4/ip_forward : b'0' -> 1
> 2024-11-19T00:55:59+1100 [stdout#info] PROC SET
> /proc/sys/net/netfilter/nf_conntrack_tcp_be_liberal : b'0' -> 1
> 2024-11-19T00:56:00+1100 [stdout#info] License Info
> {'concurrent_connections': 2, 'apc': False}
> 2024-11-19T00:56:00+1100 [-] OMIServerAuthFactory starting on
> '/usr/local/openvpn_as/etc/sock/omisock-Kk5zKaR0ZB7L'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: "2024-11-19 00:56:00
> DEPRECATED OPTION: --cipher set to 'AES-256-CBC' but missing in
> --data-ciphers (AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305). OpenVPN ignor=
es
> --cipher for cipher negotiations. "
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-19 00:56:00
> WARNING: POTENTIALLY DANGEROUS OPTION --verify-client-cert none|optional
> may accept clients which do not present a certificate'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-19 00:56:00
> OpenVPN 2.6.12 x86_64-pc-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL]
> [MH/PKTINFO] [AEAD] [DCO]'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-19 00:56:00
> library versions: OpenSSL 3.0.13 30 Jan 2024, LZO 2.10'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-19 00:56:00
> DCO version: N/A'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-19 00:56:00
> MANAGEMENT: client_uid=3D0'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-19 00:56:00
> MANAGEMENT: Connected to management server at
> /usr/local/openvpn_as/etc/sock/omisock-Kk5zKaR0ZB7L'
> 2024-11-19T00:56:00+1100 [-] (UNIX Port
> /usr/local/openvpn_as/etc/sock/omisock-Kk5zKaR0ZB7L Closed)
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: "2024-11-19 00:56:00
> MANAGEMENT: CMD 'state on'"
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: "2024-11-19 00:56:00
> MANAGEMENT: CMD 'echo on'"
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: "2024-11-19 00:56:00
> MANAGEMENT: CMD 'bytecount 300'"
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: "2024-11-19 00:56:00
> MANAGEMENT: CMD 'env-filter 1'"
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: "2024-11-19 00:56:00
> MANAGEMENT: CMD 'hold off'"
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: "2024-11-19 00:56:00
> MANAGEMENT: CMD 'hold release'"
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-19 00:56:00
> net_route_v4_best_gw query: dst 0.0.0.0'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-19 00:56:00
> net_route_v4_best_gw result: via 103.6.170.254 dev eth0'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-19 00:56:00
> NOTE: --fast-io is disabled since we are not using UDP'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-19 00:56:00
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-19 00:56:00
> Diffie-Hellman initialized with 4096 bit key'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-19 00:56:00
> TUN/TAP device as0t0 opened'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-19 00:56:00
> TUN/TAP TX queue length set to 200'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-19 00:56:00
> MANAGEMENT: >STATE:1731938160,ASSIGN_IP,,172.27.224.1,,,,'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-19 00:56:00
> net_iface_mtu_set: mtu 1420 for as0t0'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-19 00:56:00
> net_iface_up: set as0t0 up'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-19 00:56:00
> net_addr_v4_add: 172.27.224.1/21 dev as0t0'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-19 00:56:00
> Could not determine IPv4/IPv6 protocol. Using AF_INET'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-19 00:56:00
> Socket Buffers: R=3D[87380->87380] S=3D[16384->16384]'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-19 00:56:00
> Listening for incoming TCP connection on [AF_INET][undef]:443'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-19 00:56:00
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-19 00:56:00
> TCPv4_SERVER link local (bound): [AF_INET][undef]:443'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-19 00:56:00
> TCPv4_SERVER link remote: [AF_UNSPEC]'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: "2024-11-18 13:56:00
> chroot to '/run/openvpn_as' and cd to '/' succeeded"
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:56:00
> UID set to openvpn_as'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:56:00
> GID set to openvpn_as'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:56:00
> Capabilities retained: CAP_NET_ADMIN'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:56:00
> PORT SHARE PROXY: proxy starting'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:56:00
> MULTI: multi_init called, r=3D4096 v=3D4096'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:56:00
> MULTI: TCP INIT maxclients=3D2048 maxevents=3D2053'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:56:00
> Initialization Sequence Completed'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 13:56:00
> MANAGEMENT: >STATE:1731938160,CONNECTED,SUCCESS,172.27.224.1,,,,'
> 2024-11-19T00:56:00+1100 [stdout#info] License Info
> {'concurrent_connections': 2, 'apc': False}
> 2024-11-19T00:56:00+1100 [-] OMIServerAuthFactory starting on
> '/usr/local/openvpn_as/etc/sock/omisock-f0B8AK4qFxF1'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: "2024-11-19 00:56:00
> DEPRECATED OPTION: --cipher set to 'AES-256-CBC' but missing in
> --data-ciphers (AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305). OpenVPN ignor=
es
> --cipher for cipher negotiations. "
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: '2024-11-19 00:56:00
> WARNING: POTENTIALLY DANGEROUS OPTION --verify-client-cert none|optional
> may accept clients which do not present a certificate'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: '2024-11-19 00:56:00
> OpenVPN 2.6.12 x86_64-pc-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL]
> [MH/PKTINFO] [AEAD] [DCO]'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: '2024-11-19 00:56:00
> library versions: OpenSSL 3.0.13 30 Jan 2024, LZO 2.10'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: '2024-11-19 00:56:00
> DCO version: N/A'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: '2024-11-19 00:56:00
> MANAGEMENT: client_uid=3D0'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: '2024-11-19 00:56:00
> MANAGEMENT: Connected to management server at
> /usr/local/openvpn_as/etc/sock/omisock-f0B8AK4qFxF1'
> 2024-11-19T00:56:00+1100 [-] (UNIX Port
> /usr/local/openvpn_as/etc/sock/omisock-f0B8AK4qFxF1 Closed)
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: "2024-11-19 00:56:00
> MANAGEMENT: CMD 'state on'"
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: "2024-11-19 00:56:00
> MANAGEMENT: CMD 'echo on'"
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: "2024-11-19 00:56:00
> MANAGEMENT: CMD 'bytecount 300'"
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: "2024-11-19 00:56:00
> MANAGEMENT: CMD 'env-filter 1'"
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: "2024-11-19 00:56:00
> MANAGEMENT: CMD 'hold off'"
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: "2024-11-19 00:56:00
> MANAGEMENT: CMD 'hold release'"
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: '2024-11-19 00:56:00
> net_route_v4_best_gw query: dst 0.0.0.0'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: '2024-11-19 00:56:00
> net_route_v4_best_gw result: via 103.6.170.254 dev eth0'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: '2024-11-19 00:56:00
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: '2024-11-19 00:56:00
> Diffie-Hellman initialized with 4096 bit key'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: '2024-11-19 00:56:00
> TUN/TAP device as0t1 opened'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: '2024-11-19 00:56:00
> TUN/TAP TX queue length set to 200'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: '2024-11-19 00:56:00
> MANAGEMENT: >STATE:1731938160,ASSIGN_IP,,172.27.232.1,,,,'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: '2024-11-19 00:56:00
> net_iface_mtu_set: mtu 1420 for as0t1'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: '2024-11-19 00:56:00
> net_iface_up: set as0t1 up'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: '2024-11-19 00:56:00
> net_addr_v4_add: 172.27.232.1/21 dev as0t1'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: '2024-11-19 00:56:00
> Could not determine IPv4/IPv6 protocol. Using AF_INET'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: '2024-11-19 00:56:00
> Socket Buffers: R=3D[212992->212992] S=3D[212992->212992]'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: '2024-11-19 00:56:00
> UDPv4 link local (bound): [AF_INET][undef]:1194'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: '2024-11-19 00:56:00
> UDPv4 link remote: [AF_UNSPEC]'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: "2024-11-18 13:56:00
> chroot to '/run/openvpn_as' and cd to '/' succeeded"
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 13:56:00
> UID set to openvpn_as'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 13:56:00
> GID set to openvpn_as'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 13:56:00
> Capabilities retained: CAP_NET_ADMIN'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 13:56:00
> MULTI: multi_init called, r=3D4096 v=3D4096'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 13:56:00
> Initialization Sequence Completed'
> 2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 13:56:00
> MANAGEMENT: >STATE:1731938160,CONNECTED,SUCCESS,172.27.232.1,,,,'
> 2024-11-19T00:56:00+1100 [stdout#info] Server Agent initialization status:
> 2024-11-19T00:56:00+1100 [stdout#info] {
> 2024-11-19T00:56:00+1100 [stdout#info]   "errors": {
> 2024-11-19T00:56:00+1100 [stdout#info]     "openvpn_0": [
> 2024-11-19T00:56:00+1100 [stdout#info]       [
> 2024-11-19T00:56:00+1100 [stdout#info]         "info",
> 2024-11-19T00:56:00+1100 [stdout#info]         "process started
> successfully on 172.27.224.1"
> 2024-11-19T00:56:00+1100 [stdout#info]       ]
> 2024-11-19T00:56:00+1100 [stdout#info]     ],
> 2024-11-19T00:56:00+1100 [stdout#info]     "openvpn_1": [
> 2024-11-19T00:56:00+1100 [stdout#info]       [
> 2024-11-19T00:56:00+1100 [stdout#info]         "info",
> 2024-11-19T00:56:00+1100 [stdout#info]         "process started
> successfully on 172.27.232.1"
> 2024-11-19T00:56:00+1100 [stdout#info]       ]
> 2024-11-19T00:56:00+1100 [stdout#info]     ]
> 2024-11-19T00:56:00+1100 [stdout#info]   },
> 2024-11-19T00:56:00+1100 [stdout#info]   "last_restarted": "Tue Nov 19
> 00:55:57 2024",
> 2024-11-19T00:56:00+1100 [stdout#info]   "service_status": {
> 2024-11-19T00:56:00+1100 [stdout#info]     "api": "started",
> 2024-11-19T00:56:00+1100 [stdout#info]     "auth": "started",
> 2024-11-19T00:56:00+1100 [stdout#info]     "bridge": "started",
> 2024-11-19T00:56:00+1100 [stdout#info]     "client_query": "started",
> 2024-11-19T00:56:00+1100 [stdout#info]     "crl": "started",
> 2024-11-19T00:56:00+1100 [stdout#info]     "daemon_pre": "started",
> 2024-11-19T00:56:00+1100 [stdout#info]     "db_push": "started",
> 2024-11-19T00:56:00+1100 [stdout#info]     "ip6tables_live": "started",
> 2024-11-19T00:56:00+1100 [stdout#info]     "ip6tables_openvpn": "started",
> 2024-11-19T00:56:00+1100 [stdout#info]     "iptables_api": "started",
> 2024-11-19T00:56:00+1100 [stdout#info]     "iptables_live": "started",
> 2024-11-19T00:56:00+1100 [stdout#info]     "iptables_openvpn": "started",
> 2024-11-19T00:56:00+1100 [stdout#info]     "iptables_web": "started",
> 2024-11-19T00:56:00+1100 [stdout#info]     "log": "started",
> 2024-11-19T00:56:00+1100 [stdout#info]     "openvpn_0": "started",
> 2024-11-19T00:56:00+1100 [stdout#info]     "openvpn_1": "started",
> 2024-11-19T00:56:00+1100 [stdout#info]     "subscription": "started",
> 2024-11-19T00:56:00+1100 [stdout#info]     "user": "started",
> 2024-11-19T00:56:00+1100 [stdout#info]     "web": "started"
> 2024-11-19T00:56:00+1100 [stdout#info]   }
> 2024-11-19T00:56:00+1100 [stdout#info] }
> 2024-11-19T00:56:00+1100 [stdout#info] Server Agent started
> 2024-11-19T00:56:05+1100 [stdout#info] License Info
> {'concurrent_connections': 2, 'apc': False}
> 2024-11-19T01:03:16+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 14:03:16
> Note: OpenSSL hardware crypto engine functionality is not available'
> 2024-11-19T01:03:16+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 14:03:16
> TCP connection established with [AF_INET]104.166.80.177:23432'
> 2024-11-19T01:03:16+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 14:03:16
> Socket flags: TCP_NODELAY=3D1 succeeded'
> 2024-11-19T01:03:17+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 14:03:17
> 104.166.80.177:23432 Non-OpenVPN client protocol detected'
> 2024-11-19T01:03:17+1100 [stdout#info] [OVPN 0] OUT: '2024-11-18 14:03:17
> 104.166.80.177:23432 SIGTERM[soft,port-share-redirect] received,
> client-instance exiting'
> 2024-11-19T01:03:17+1100 [stdout#info] [WEB] OUT:
> '2024-11-19T01:03:17+1100 [twisted.python.log#info] "127.0.0.1" - -
> [18/Nov/2024:14:03:16 +0000] "GET / HTTP/1.1" 200 1707 "-" "Mozilla/5.0
> (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0"'
> 2024-11-19T01:11:25+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:11:25
> tls-crypt unwrap error: packet too short'
> 2024-11-19T01:11:25+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:11:25
> TLS Error: tls-crypt unwrapping failed from [AF_INET]195.28.180.102:16753
> (via [AF_INET]103.6.170.21%eth0)'
> 2024-11-19T01:11:27+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:11:27
> tls-crypt unwrap error: packet too short'
> 2024-11-19T01:11:27+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:11:27
> TLS Error: tls-crypt unwrapping failed from [AF_INET]195.28.180.102:16753
> (via [AF_INET]103.6.170.21%eth0)'
> 2024-11-19T01:11:31+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:11:31
> tls-crypt unwrap error: packet too short'
> 2024-11-19T01:11:31+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:11:31
> TLS Error: tls-crypt unwrapping failed from [AF_INET]195.28.180.102:16753
> (via [AF_INET]103.6.170.21%eth0)'
> 2024-11-19T01:11:39+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:11:39
> tls-crypt unwrap error: packet too short'
> 2024-11-19T01:11:39+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:11:39
> TLS Error: tls-crypt unwrapping failed from [AF_INET]195.28.180.102:16753
> (via [AF_INET]103.6.170.21%eth0)'
> 2024-11-19T01:11:55+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:11:55
> tls-crypt unwrap error: packet too short'
> 2024-11-19T01:11:55+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:11:55
> TLS Error: tls-crypt unwrapping failed from [AF_INET]195.28.180.102:16753
> (via [AF_INET]103.6.170.21%eth0)'
> 2024-11-19T01:12:30+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:12:30
> tls-crypt unwrap error: packet too short'
> 2024-11-19T01:12:30+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:12:30
> TLS Error: tls-crypt unwrapping failed from [AF_INET]195.28.180.102:36515
> (via [AF_INET]103.6.170.21%eth0)'
> 2024-11-19T01:12:32+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:12:32
> tls-crypt unwrap error: packet too short'
> 2024-11-19T01:12:32+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:12:32
> TLS Error: tls-crypt unwrapping failed from [AF_INET]195.28.180.102:36515
> (via [AF_INET]103.6.170.21%eth0)'
> 2024-11-19T01:12:36+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:12:36
> tls-crypt unwrap error: packet too short'
> 2024-11-19T01:12:36+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:12:36
> TLS Error: tls-crypt unwrapping failed from [AF_INET]195.28.180.102:36515
> (via [AF_INET]103.6.170.21%eth0)'
> 2024-11-19T01:12:44+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:12:44
> tls-crypt unwrap error: packet too short'
> 2024-11-19T01:12:44+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:12:44
> TLS Error: tls-crypt unwrapping failed from [AF_INET]195.28.180.102:36515
> (via [AF_INET]103.6.170.21%eth0)'
> 2024-11-19T01:13:00+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:13:00
> tls-crypt unwrap error: packet too short'
> 2024-11-19T01:13:00+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:13:00
> TLS Error: tls-crypt unwrapping failed from [AF_INET]195.28.180.102:36515
> (via [AF_INET]103.6.170.21%eth0)'
> 2024-11-19T01:13:35+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:13:35
> tls-crypt unwrap error: packet too short'
> 2024-11-19T01:13:35+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:13:35
> TLS Error: tls-crypt unwrapping failed from [AF_INET]195.28.180.102:58550
> (via [AF_INET]103.6.170.21%eth0)'
> 2024-11-19T01:13:37+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:13:37
> tls-crypt unwrap error: packet too short'
> 2024-11-19T01:13:37+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:13:37
> TLS Error: tls-crypt unwrapping failed from [AF_INET]195.28.180.102:58550
> (via [AF_INET]103.6.170.21%eth0)'
> 2024-11-19T01:13:41+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:13:41
> tls-crypt unwrap error: packet too short'
> 2024-11-19T01:13:41+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:13:41
> TLS Error: tls-crypt unwrapping failed from [AF_INET]195.28.180.102:58550
> (via [AF_INET]103.6.170.21%eth0)'
> 2024-11-19T01:13:50+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:13:50
> tls-crypt unwrap error: packet too short'
> 2024-11-19T01:13:50+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:13:50
> TLS Error: tls-crypt unwrapping failed from [AF_INET]195.28.180.102:58550
> (via [AF_INET]103.6.170.21%eth0)'
> 2024-11-19T01:14:05+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:14:05
> tls-crypt unwrap error: packet too short'
> 2024-11-19T01:14:05+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:14:05
> TLS Error: tls-crypt unwrapping failed from [AF_INET]195.28.180.102:58550
> (via [AF_INET]103.6.170.21%eth0)'
> 2024-11-19T01:14:40+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:14:40
> tls-crypt unwrap error: packet too short'
> 2024-11-19T01:14:40+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:14:40
> TLS Error: tls-crypt unwrapping failed from [AF_INET]195.28.180.102:19642
> (via [AF_INET]103.6.170.21%eth0)'
> 2024-11-19T01:14:42+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:14:42
> tls-crypt unwrap error: packet too short'
> 2024-11-19T01:14:42+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:14:42
> TLS Error: tls-crypt unwrapping failed from [AF_INET]195.28.180.102:19642
> (via [AF_INET]103.6.170.21%eth0)'
> 2024-11-19T01:14:46+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:14:46
> tls-crypt unwrap error: packet too short'
> 2024-11-19T01:14:46+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:14:46
> TLS Error: tls-crypt unwrapping failed from [AF_INET]195.28.180.102:19642
> (via [AF_INET]103.6.170.21%eth0)'
> 2024-11-19T01:14:54+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:14:54
> tls-crypt unwrap error: packet too short'
> 2024-11-19T01:14:54+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:14:54
> TLS Error: tls-crypt unwrapping failed from [AF_INET]195.28.180.102:19642
> (via [AF_INET]103.6.170.21%eth0)'
> 2024-11-19T01:15:10+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:15:10
> tls-crypt unwrap error: packet too short'
> 2024-11-19T01:15:10+1100 [stdout#info] [OVPN 1] OUT: '2024-11-18 14:15:10
> TLS Error: tls-crypt unwrapping failed from [AF_INET]195.28.180.102:19642
> (via [AF_INET]103.6.170.21%eth0)'
> root@...2835...:~# cat /var/log/openvpnas.log
>
> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=
=D7=B3, 18 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-14:07 =D7=9E=D7=90=D7=
=AA =D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=D7=9F <=E2=80=AAnsh531@...277...=
=E2=80=AC=E2=80=8F>:=E2=80=AC
>
>> i had as problem to connect to server using SSH but I opened an  case
>> with hosting support
>>
>>
>> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=
=D7=B3, 18 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-13:58 =D7=9E=D7=90=D7=
=AA =E2=80=AA=D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=
=D0=BD=E2=80=AC=E2=80=8F <=E2=80=AA
>> chipitsine@...277...=E2=80=AC=E2=80=8F>:=E2=80=AC
>>
>>> I initially thought it was not your server, because you told us that you
>>> do not have server logs.
>>>
>>> do you have at least any client packet that reaches server ?
>>>
>>> (I know you may ask how to check that. I'd choose tcpdump. in case if
>>> you wish to ask how to use tcpdump - sorry, no answer. Please use the t=
ool
>>> of your choice, whatever you are comfortable with)
>>>
>>>
>>> if no packet reaches server, most probably you did not open firewall
>>> (either on vm itself or in cloud level).
>>>
>>> (if you are going to ask how to manage firewall on vm or cloud level,
>>> sorry, no idea here, please consult cloud guides or contact cloud suppo=
rt).
>>>
>>> =E2=80=AA=D0=BF=D0=BD, 18 =D0=BD=D0=BE=D1=8F=D0=B1. 2024=E2=80=AF=D0=B3=
. =D0=B2 12:43, =E2=80=AB=D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=D7=9F=E2=80=
=AC=E2=80=8E <nsh531@...277...>:=E2=80=AC
>>>
>>>> How to solve this problem?
>>>> because both the client and server are my  own
>>>>
>>>>
>>>> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=
=91=D7=B3, 18 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-12:04 =D7=9E=D7=90=
=D7=AA =E2=80=AADavid Sommerseth=E2=80=AC=E2=80=8F <=E2=80=AA
>>>> dazo+openvpn@...2108...=E2=80=AC=E2=80=8F>:=E2=80=AC
>>>>
>>>>>
>>>>> Please stop now.
>>>>>
>>>>> A client which cannot reach a server because the client side has
>>>>> connectivity issues towards the server is not a DoS, it is not a CVE
>>>>> and
>>>>> will never be considered a security issue.
>>>>>
>>>>> First of all, a DoS attack is commonly related to a SERVER becoming
>>>>> unresponsive due to traffic to the server causing it to stop
>>>>> responding.
>>>>>   Or that one VPN clients misbehaviour (not due to misconfiguration,
>>>>> though) results in no other clients being able to connect.
>>>>>
>>>>> What you have described so far is that you cannot reach the server.
>>>>> And
>>>>> OpenVPN tries to reconnect regularly.  This is the expected behaviour
>>>>> of
>>>>> most VPN clients - they try to keep the tunnel running with as little
>>>>> user interaction as possible.  The back-off timer is there to also
>>>>> needlessly keep trying if there seems to be longer persisting
>>>>> connectivity issues.
>>>>>
>>>>> And just to entertain you a bit more.  This is the logs when using
>>>>> OpenVPN 3 Linux:
>>>>>
>>>>>
>>>>> ---------------------------------------------------------------------=
-------
>>>>> Press CTRL-C to stop the connection
>>>>>
>>>>> 2024-11-18 09:59:19.854568 [STATUS] (StatusMajor.CONNECTION,
>>>>> StatusMinor.CFG_OK)
>>>>>
>>>>> config_path=3D/net/openvpn/v3/configuration/4c2bba36x2151x4291xb7acx3=
60000375d2a
>>>>> 2024-11-18 09:59:19.854636 [LOG] Starting connection
>>>>> 2024-11-18 09:59:19.854694 [LOG] Using DNS resolver scope: global
>>>>> 2024-11-18 09:59:19.862369 [LOG] [Connect] DCO flag: disabled
>>>>> 2024-11-18 09:59:19.862479 [STATUS] (StatusMajor.CONNECTION,
>>>>> StatusMinor.CONN_CONNECTING)
>>>>> 2024-11-18 09:59:19.862548 [LOG] [Core] OpenVPN core v3.10.1 linux
>>>>> x86_64 64-bit OVPN-DCO
>>>>> 2024-11-18 09:59:19.862596 [LOG] [Core] Frame=3D512/2112/512
>>>>> mssfix-ctrl=3D1250
>>>>> 2024-11-18 09:59:19.862636 [LOG] Resolving
>>>>> 2024-11-18 09:59:19.866525 [LOG] [Core] Contacting 103.6.170.21:1194
>>>>> via UDP
>>>>> 2024-11-18 09:59:19.866638 [LOG] Waiting for server response
>>>>> 2024-11-18 09:59:19.878505 [LOG] [Core] Connecting to
>>>>> [103.6.170.21]:1194 (103.6.170.21) via UDP
>>>>> 2024-11-18 09:59:29.861733 [LOG] [Core] Server poll timeout, trying
>>>>> next
>>>>> remote entry...
>>>>> 2024-11-18 09:59:29.861875 [LOG] Resolving
>>>>> 2024-11-18 09:59:29.865648 [LOG] [Core] Contacting 103.6.170.21:1194
>>>>> via UDP
>>>>> 2024-11-18 09:59:29.865769 [LOG] Waiting for server response
>>>>> 2024-11-18 09:59:29.876299 [LOG] [Core] Connecting to
>>>>> [103.6.170.21]:1194 (103.6.170.21) via UDP
>>>>> 2024-11-18 09:59:39.862254 [LOG] [Core] Server poll timeout, trying
>>>>> next
>>>>> remote entry...
>>>>> 2024-11-18 09:59:39.862347 [LOG] Resolving
>>>>> 2024-11-18 09:59:39.866157 [LOG] [Core] Contacting 103.6.170.21:1194
>>>>> via UDP
>>>>> 2024-11-18 09:59:39.866262 [LOG] Waiting for server response
>>>>> 2024-11-18 09:59:39.877288 [LOG] [Core] Connecting to
>>>>> [103.6.170.21]:1194 (103.6.170.21) via UDP
>>>>> 2024-11-18 09:59:49.862757 [LOG] [Core] Server poll timeout, trying
>>>>> next
>>>>> remote entry...
>>>>> 2024-11-18 09:59:49.862852 [LOG] Resolving
>>>>> 2024-11-18 09:59:49.866514 [LOG] [Core] Contacting 103.6.170.21:1194
>>>>> via UDP
>>>>> 2024-11-18 09:59:49.866614 [LOG] Waiting for server response
>>>>> 2024-11-18 09:59:49.875998 [LOG] [Core] Connecting to
>>>>> [103.6.170.21]:1194 (103.6.170.21) via UDP
>>>>> 2024-11-18 09:59:59.863047 [LOG] [Core] Server poll timeout, trying
>>>>> next
>>>>> remote entry...
>>>>> 2024-11-18 09:59:59.863179 [LOG] Resolving
>>>>> 2024-11-18 09:59:59.866699 [LOG] [Core] Contacting 103.6.170.21:1194
>>>>> via UDP
>>>>> 2024-11-18 09:59:59.866798 [LOG] Waiting for server response
>>>>> 2024-11-18 09:59:59.876724 [LOG] [Core] Connecting to
>>>>> [103.6.170.21]:1194 (103.6.170.21) via UDP
>>>>> 2024-11-18 10:00:09.863146 [LOG] [Core] Server poll timeout, trying
>>>>> next
>>>>> remote entry...
>>>>> 2024-11-18 10:00:09.863242 [LOG] Resolving
>>>>> 2024-11-18 10:00:09.867305 [LOG] [Core] Contacting 103.6.170.21:1194
>>>>> via UDP
>>>>> 2024-11-18 10:00:09.867406 [LOG] Waiting for server response
>>>>> 2024-11-18 10:00:09.879292 [LOG] [Core] Connecting to
>>>>> [103.6.170.21]:1194 (103.6.170.21) via UDP
>>>>> 2024-11-18 10:00:19.863499 [LOG] [Core] Server poll timeout, trying
>>>>> next
>>>>> remote entry...
>>>>> 2024-11-18 10:00:19.863623 [LOG] Resolving
>>>>> 2024-11-18 10:00:19.867758 [LOG] [Core] Contacting 103.6.170.21:1194
>>>>> via UDP
>>>>> 2024-11-18 10:00:19.867845 [LOG] Waiting for server response
>>>>> 2024-11-18 10:00:19.879066 [LOG] [Core] Connecting to
>>>>> [103.6.170.21]:1194 (103.6.170.21) via UDP
>>>>> ^C
>>>>> Disconnecting...
>>>>> Connection statistics:
>>>>>                      BYTES_OUT: 2814
>>>>>                    PACKETS_OUT: 67
>>>>>                    N_RECONNECT: 6
>>>>>
>>>>> ---------------------------------------------------------------------=
-------
>>>>>
>>>>> This needs to stop.  This is not a CVE.  This is an OpenVPN server
>>>>> which
>>>>> doesn't respond on port 1194/udp.
>>>>>
>>>>> If you want to keep some kind of credibility with any security teams,
>>>>> you need to back down and spend time looking for real issues and
>>>>> document it far better.  And you will need to provide the server side
>>>>> perspective as well, not just the client side.
>>>>>
>>>>> Once again: Clients not being able to connect to the server because of
>>>>> network connectivity issues is not a CVE.
>>>>>
>>>>>
>>>>> This case is closed.
>>>>>
>>>>>
>>>>> --
>>>>> kind regards,
>>>>>
>>>>> David Sommerseth
>>>>> OpenVPN Inc
>>>>>
>>>>>
>>>>>
>>>>> On 18/11/2024 08:37, =D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=D7=9F wrot=
e:
>>>>> > What can I do to assign a CVE?
>>>>> >   I attached the CVE team of ISRAEL CERT  to conversation
>>>>> >
>>>>> > tnx
>>>>> >
>>>>> > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =
=D7=91=D7=B3, 18 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-9:29 =D7=9E=D7=
=90=D7=AA =E2=80=AA=D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD=E2=80=AC=E2=80=8F
>>>>> > <=E2=80=AAchipitsine@...277... <mailto:chipitsine@...277...>=E2=80=
=AC=E2=80=8F>:=E2=80=AC
>>>>> >
>>>>> >     As many details as possible. Configuration file usually helps.
>>>>> >
>>>>> >     Other than that also server side logs are nice to have. As well
>>>>> as
>>>>> >     the detailed repro steps
>>>>> >
>>>>> >     On Mon, Nov 18, 2024, 08:27 =D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=
=A8=D7=9F <nsh531@...277...
>>>>> >     <mailto:nsh531@...277...>> wrote:
>>>>> >
>>>>> >         Do you want the configuration file?
>>>>> >
>>>>> >         =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=
=D7=9D =D7=91=D7=B3, 18 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-9:14 =D7=
=9E=D7=90=D7=AA =E2=80=AAGert Doering=E2=80=AC=E2=80=8F
>>>>> >         <=E2=80=AAgert@...1296... <mailto:gert@...1296...>=E2=80=AC=
=E2=80=8F>:=E2=80=AC
>>>>> >
>>>>> >             Hi,
>>>>> >
>>>>> >             On Mon, Nov 18, 2024 at 09:09:57AM +0200, ??????
>>>>> ???????? wrote:
>>>>> >              > I don't have access to server logs, I sent you the
>>>>> client
>>>>> >             logs as well as
>>>>> >              > the line pointing to the DoS:
>>>>> >              > TLS Error: TLS key negotiation failed to occur within
>>>>> 5
>>>>> >             seconds
>>>>> >              > SIGUSR1[soft,tls-error] received, process restarting
>>>>> >
>>>>> >             What makes you think it's a DoS that can be fixed by a
>>>>> code
>>>>> >             change?
>>>>> >
>>>>> >             If you break the network, programs will not be able to
>>>>> >             connect - and there
>>>>> >             is nothing "a patch to the software" will be able to fi=
x.
>>>>> >
>>>>> >             gert
>>>>> >             --
>>>>> >             "If was one thing all people took for granted, was
>>>>> >             conviction that if you
>>>>> >               feed honest figures into a computer, honest figures
>>>>> come
>>>>> >             out. Never doubted
>>>>> >               it myself till I met a computer with a sense of humor=
."
>>>>> >                                           Robert A. Heinlein, The
>>>>> Moon
>>>>> >             is a Harsh Mistress
>>>>> >
>>>>> >             Gert Doering - Munich, Germany gert@...1296...
>>>>> >             <mailto:gert@...1296...>
>>>>> >
>>>>> >
>>>>> >
>>>>> >         --
>>>>> >         <https://netanel.ml>
>>>>> >         _______________________________________________
>>>>> >         Openvpn-devel mailing list
>>>>> >         Openvpn-devel@lists.sourceforge.net
>>>>> >         <mailto:Openvpn-devel@lists.sourceforge.net>
>>>>> >         https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>>>> >         <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>
>>>>> >
>>>>> >
>>>>> >
>>>>> > --
>>>>> > <https://netanel.ml>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>
>>>> --
>>>> <https://netanel.ml>
>>>>
>>>
>>
>> --
>> <https://netanel.ml>
>>
>
>
> --
> <https://netanel.ml>
>

--0000000000003093a306273ffd1a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">I see &quot;Access server&quot; in logs.<=
div><br></div><div>which means that you are running OpenVPN Access Server (=
not a community edition).</div><div><br></div><div>that product has dedicat=
ed support at=C2=A0<a href=3D"https://support.openvpn.com/hc/en-us">OpenVPN=
 Support Center</a>=C2=A0(I hope you&#39;ve purchased it).=C2=A0</div></div=
></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"=
>=E2=80=AA=D0=BF=D0=BD, 18 =D0=BD=D0=BE=D1=8F=D0=B1. 2024=E2=80=AF=D0=B3. =
=D0=B2 15:21, =E2=80=AB=D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=D7=9F=E2=80=AC=
=E2=80=8E &lt;<a href=3D"mailto:nsh531@...277...">nsh531@...277...</a>&gt;:=
=E2=80=AC<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div d=
ir=3D"rtl"><div dir=3D"ltr">server logs:</div><div dir=3D"ltr"><br></div><d=
iv dir=3D"ltr"><br></div><div dir=3D"ltr">2024-11-18T22:07:43+1100 [stdout#=
info] [OVPN 0] OUT: &#39;2024-11-18 11:07:43 Socket flags: TCP_NODELAY=3D1 =
succeeded&#39;<br>2024-11-18T22:07:49+1100 [stdout#info] [OVPN 0] OUT: &#39=
;2024-11-18 11:07:49 <a href=3D"http://165.154.42.209:42098" target=3D"_bla=
nk">165.154.42.209:42098</a> Connection reset, restarting [0]&#39;<br>2024-=
11-18T22:07:49+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:07:49 <a=
 href=3D"http://165.154.42.209:42098" target=3D"_blank">165.154.42.209:4209=
8</a> SIGUSR1[soft,connection-reset] received, client-instance restarting&#=
39;<br>2024-11-18T22:07:52+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18=
 11:07:52 Note: OpenSSL hardware crypto engine functionality is not availab=
le&#39;<br>2024-11-18T22:07:52+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-1=
1-18 11:07:52 TCP connection established with [AF_INET]<a href=3D"http://16=
5.154.42.209:44954" target=3D"_blank">165.154.42.209:44954</a>&#39;<br>2024=
-11-18T22:07:52+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:07:52 S=
ocket flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-18T22:07:52+1100 [st=
dout#info] [OVPN 0] OUT: &#39;2024-11-18 11:07:52 <a href=3D"http://165.154=
.42.209:44954" target=3D"_blank">165.154.42.209:44954</a> Non-OpenVPN clien=
t protocol detected&#39;<br>2024-11-18T22:07:52+1100 [stdout#info] [OVPN 0]=
 OUT: &#39;2024-11-18 11:07:52 <a href=3D"http://165.154.42.209:44954" targ=
et=3D"_blank">165.154.42.209:44954</a> SIGTERM[soft,port-share-redirect] re=
ceived, client-instance exiting&#39;<br>2024-11-18T22:07:54+1100 [stdout#in=
fo] [OVPN 0] OUT: &#39;2024-11-18 11:07:54 Note: OpenSSL hardware crypto en=
gine functionality is not available&#39;<br>2024-11-18T22:07:54+1100 [stdou=
t#info] [OVPN 0] OUT: &#39;2024-11-18 11:07:54 TCP connection established w=
ith [AF_INET]<a href=3D"http://165.154.42.209:46014" target=3D"_blank">165.=
154.42.209:46014</a>&#39;<br>2024-11-18T22:07:54+1100 [stdout#info] [OVPN 0=
] OUT: &#39;2024-11-18 11:07:54 Socket flags: TCP_NODELAY=3D1 succeeded&#39=
;<br>2024-11-18T22:07:54+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 1=
1:07:54 <a href=3D"http://165.154.42.209:46014" target=3D"_blank">165.154.4=
2.209:46014</a> Non-OpenVPN client protocol detected&#39;<br>2024-11-18T22:=
07:54+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:07:54 <a href=3D"=
http://165.154.42.209:46014" target=3D"_blank">165.154.42.209:46014</a> SIG=
TERM[soft,port-share-redirect] received, client-instance exiting&#39;<br>20=
24-11-18T22:07:54+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:07:54=
 Note: OpenSSL hardware crypto engine functionality is not available&#39;<b=
r>2024-11-18T22:07:54+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:0=
7:54 TCP connection established with [AF_INET]<a href=3D"http://165.154.42.=
209:46248" target=3D"_blank">165.154.42.209:46248</a>&#39;<br>2024-11-18T22=
:07:54+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:07:54 Socket fla=
gs: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-18T22:07:54+1100 [stdout#info=
] [OVPN 0] OUT: &#39;2024-11-18 11:07:54 <a href=3D"http://165.154.42.209:4=
6248" target=3D"_blank">165.154.42.209:46248</a> Non-OpenVPN client protoco=
l detected&#39;<br>2024-11-18T22:07:54+1100 [stdout#info] [OVPN 0] OUT: &#3=
9;2024-11-18 11:07:54 <a href=3D"http://165.154.42.209:46248" target=3D"_bl=
ank">165.154.42.209:46248</a> SIGTERM[soft,port-share-redirect] received, c=
lient-instance exiting&#39;<br>2024-11-18T22:08:03+1100 [stdout#info] [OVPN=
 0] OUT: &#39;2024-11-18 11:08:03 Note: OpenSSL hardware crypto engine func=
tionality is not available&#39;<br>2024-11-18T22:08:03+1100 [stdout#info] [=
OVPN 0] OUT: &#39;2024-11-18 11:08:03 TCP connection established with [AF_I=
NET]<a href=3D"http://165.154.42.209:49206" target=3D"_blank">165.154.42.20=
9:49206</a>&#39;<br>2024-11-18T22:08:03+1100 [stdout#info] [OVPN 0] OUT: &#=
39;2024-11-18 11:08:03 Socket flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024=
-11-18T22:08:04+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:08:04 <=
a href=3D"http://165.154.42.209:49206" target=3D"_blank">165.154.42.209:492=
06</a> Non-OpenVPN client protocol detected&#39;<br>2024-11-18T22:08:04+110=
0 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:08:04 <a href=3D"http://16=
5.154.42.209:49206" target=3D"_blank">165.154.42.209:49206</a> SIGTERM[soft=
,port-share-redirect] received, client-instance exiting&#39;<br>2024-11-18T=
22:08:04+1100 [stdout#info] [WEB] OUT: &#39;2024-11-18T22:08:04+1100 [twist=
ed.python.log#info] &quot;127.0.0.1&quot; - - [18/Nov/2024:11:08:04 +0000] =
&quot;GET / HTTP/1.1&quot; 200 1707 &quot;-&quot; &quot;curl/7.29.0&quot;&#=
39;<br>2024-11-18T22:08:05+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18=
 11:08:05 Note: OpenSSL hardware crypto engine functionality is not availab=
le&#39;<br>2024-11-18T22:08:05+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-1=
1-18 11:08:05 TCP connection established with [AF_INET]<a href=3D"http://16=
5.154.42.209:50150" target=3D"_blank">165.154.42.209:50150</a>&#39;<br>2024=
-11-18T22:08:05+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:08:05 S=
ocket flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-18T22:08:05+1100 [st=
dout#info] [OVPN 0] OUT: &#39;2024-11-18 11:08:05 <a href=3D"http://165.154=
.42.209:50150" target=3D"_blank">165.154.42.209:50150</a> Non-OpenVPN clien=
t protocol detected&#39;<br>2024-11-18T22:08:05+1100 [stdout#info] [OVPN 0]=
 OUT: &#39;2024-11-18 11:08:05 <a href=3D"http://165.154.42.209:50150" targ=
et=3D"_blank">165.154.42.209:50150</a> SIGTERM[soft,port-share-redirect] re=
ceived, client-instance exiting&#39;<br>2024-11-18T22:08:14+1100 [stdout#in=
fo] [OVPN 0] OUT: &#39;2024-11-18 11:08:14 Note: OpenSSL hardware crypto en=
gine functionality is not available&#39;<br>2024-11-18T22:08:14+1100 [stdou=
t#info] [OVPN 0] OUT: &#39;2024-11-18 11:08:14 TCP connection established w=
ith [AF_INET]<a href=3D"http://165.154.42.209:54166" target=3D"_blank">165.=
154.42.209:54166</a>&#39;<br>2024-11-18T22:08:14+1100 [stdout#info] [OVPN 0=
] OUT: &#39;2024-11-18 11:08:14 Socket flags: TCP_NODELAY=3D1 succeeded&#39=
;<br>2024-11-18T22:08:14+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 1=
1:08:14 <a href=3D"http://165.154.42.209:54166" target=3D"_blank">165.154.4=
2.209:54166</a> Non-OpenVPN client protocol detected&#39;<br>2024-11-18T22:=
08:14+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:08:14 <a href=3D"=
http://165.154.42.209:54166" target=3D"_blank">165.154.42.209:54166</a> SIG=
TERM[soft,port-share-redirect] received, client-instance exiting&#39;<br>20=
24-11-18T22:08:14+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:08:14=
 Note: OpenSSL hardware crypto engine functionality is not available&#39;<b=
r>2024-11-18T22:08:14+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:0=
8:14 TCP connection established with [AF_INET]<a href=3D"http://165.154.42.=
209:54260" target=3D"_blank">165.154.42.209:54260</a>&#39;<br>2024-11-18T22=
:08:14+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:08:14 Socket fla=
gs: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-18T22:08:14+1100 [stdout#info=
] [OVPN 0] OUT: &#39;2024-11-18 11:08:14 <a href=3D"http://165.154.42.209:5=
4260" target=3D"_blank">165.154.42.209:54260</a> Non-OpenVPN client protoco=
l detected&#39;<br>2024-11-18T22:08:14+1100 [stdout#info] [OVPN 0] OUT: &#3=
9;2024-11-18 11:08:14 <a href=3D"http://165.154.42.209:54260" target=3D"_bl=
ank">165.154.42.209:54260</a> SIGTERM[soft,port-share-redirect] received, c=
lient-instance exiting&#39;<br>2024-11-18T22:08:15+1100 [stdout#info] [OVPN=
 0] OUT: &#39;2024-11-18 11:08:15 Note: OpenSSL hardware crypto engine func=
tionality is not available&#39;<br>2024-11-18T22:08:15+1100 [stdout#info] [=
OVPN 0] OUT: &#39;2024-11-18 11:08:15 TCP connection established with [AF_I=
NET]<a href=3D"http://165.154.42.209:54382" target=3D"_blank">165.154.42.20=
9:54382</a>&#39;<br>2024-11-18T22:08:15+1100 [stdout#info] [OVPN 0] OUT: &#=
39;2024-11-18 11:08:15 Socket flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024=
-11-18T22:08:15+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:08:15 <=
a href=3D"http://165.154.42.209:54382" target=3D"_blank">165.154.42.209:543=
82</a> Non-OpenVPN client protocol detected&#39;<br>2024-11-18T22:08:15+110=
0 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:08:15 <a href=3D"http://16=
5.154.42.209:54382" target=3D"_blank">165.154.42.209:54382</a> SIGTERM[soft=
,port-share-redirect] received, client-instance exiting&#39;<br>2024-11-18T=
22:08:15+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:08:15 Note: Op=
enSSL hardware crypto engine functionality is not available&#39;<br>2024-11=
-18T22:08:15+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:08:15 TCP =
connection established with [AF_INET]<a href=3D"http://165.154.42.209:54506=
" target=3D"_blank">165.154.42.209:54506</a>&#39;<br>2024-11-18T22:08:15+11=
00 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:08:15 Socket flags: TCP_N=
ODELAY=3D1 succeeded&#39;<br>2024-11-18T22:08:15+1100 [stdout#info] [OVPN 0=
] OUT: &#39;2024-11-18 11:08:15 <a href=3D"http://165.154.42.209:54506" tar=
get=3D"_blank">165.154.42.209:54506</a> Non-OpenVPN client protocol detecte=
d&#39;<br>2024-11-18T22:08:15+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11=
-18 11:08:15 <a href=3D"http://165.154.42.209:54506" target=3D"_blank">165.=
154.42.209:54506</a> SIGTERM[soft,port-share-redirect] received, client-ins=
tance exiting&#39;<br>2024-11-18T22:08:16+1100 [stdout#info] [OVPN 0] OUT: =
&#39;2024-11-18 11:08:16 Note: OpenSSL hardware crypto engine functionality=
 is not available&#39;<br>2024-11-18T22:08:16+1100 [stdout#info] [OVPN 0] O=
UT: &#39;2024-11-18 11:08:16 TCP connection established with [AF_INET]<a hr=
ef=3D"http://165.154.42.209:54660" target=3D"_blank">165.154.42.209:54660</=
a>&#39;<br>2024-11-18T22:08:16+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-1=
1-18 11:08:16 Socket flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-18T22=
:08:16+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:08:16 <a href=3D=
"http://165.154.42.209:54660" target=3D"_blank">165.154.42.209:54660</a> No=
n-OpenVPN client protocol detected&#39;<br>2024-11-18T22:08:16+1100 [stdout=
#info] [OVPN 0] OUT: &#39;2024-11-18 11:08:16 <a href=3D"http://165.154.42.=
209:54660" target=3D"_blank">165.154.42.209:54660</a> SIGTERM[soft,port-sha=
re-redirect] received, client-instance exiting&#39;<br>2024-11-18T22:08:16+=
1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:08:16 Note: OpenSSL har=
dware crypto engine functionality is not available&#39;<br>2024-11-18T22:08=
:16+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:08:16 TCP connectio=
n established with [AF_INET]<a href=3D"http://165.154.42.209:54804" target=
=3D"_blank">165.154.42.209:54804</a>&#39;<br>2024-11-18T22:08:16+1100 [stdo=
ut#info] [OVPN 0] OUT: &#39;2024-11-18 11:08:16 Socket flags: TCP_NODELAY=
=3D1 succeeded&#39;<br>2024-11-18T22:08:16+1100 [stdout#info] [OVPN 0] OUT:=
 &#39;2024-11-18 11:08:16 <a href=3D"http://165.154.42.209:54804" target=3D=
"_blank">165.154.42.209:54804</a> Non-OpenVPN client protocol detected&#39;=
<br>2024-11-18T22:08:16+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11=
:08:16 <a href=3D"http://165.154.42.209:54804" target=3D"_blank">165.154.42=
.209:54804</a> SIGTERM[soft,port-share-redirect] received, client-instance =
exiting&#39;<br>2024-11-18T22:08:17+1100 [stdout#info] [OVPN 0] OUT: &#39;2=
024-11-18 11:08:17 Note: OpenSSL hardware crypto engine functionality is no=
t available&#39;<br>2024-11-18T22:08:17+1100 [stdout#info] [OVPN 0] OUT: &#=
39;2024-11-18 11:08:17 TCP connection established with [AF_INET]<a href=3D"=
http://165.154.42.209:54950" target=3D"_blank">165.154.42.209:54950</a>&#39=
;<br>2024-11-18T22:08:17+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 1=
1:08:17 Socket flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-18T22:08:17=
+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:08:17 <a href=3D"http:=
//165.154.42.209:54950" target=3D"_blank">165.154.42.209:54950</a> Non-Open=
VPN client protocol detected&#39;<br>2024-11-18T22:08:17+1100 [stdout#info]=
 [OVPN 0] OUT: &#39;2024-11-18 11:08:17 <a href=3D"http://165.154.42.209:54=
950" target=3D"_blank">165.154.42.209:54950</a> SIGTERM[soft,port-share-red=
irect] received, client-instance exiting&#39;<br>2024-11-18T22:08:17+1100 [=
stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:08:17 Note: OpenSSL hardware =
crypto engine functionality is not available&#39;<br>2024-11-18T22:08:17+11=
00 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:08:17 TCP connection esta=
blished with [AF_INET]<a href=3D"http://165.154.42.209:55156" target=3D"_bl=
ank">165.154.42.209:55156</a>&#39;<br>2024-11-18T22:08:17+1100 [stdout#info=
] [OVPN 0] OUT: &#39;2024-11-18 11:08:17 Socket flags: TCP_NODELAY=3D1 succ=
eeded&#39;<br>2024-11-18T22:08:17+1100 [stdout#info] [OVPN 0] OUT: &#39;202=
4-11-18 11:08:17 <a href=3D"http://165.154.42.209:55156" target=3D"_blank">=
165.154.42.209:55156</a> Non-OpenVPN client protocol detected&#39;<br>2024-=
11-18T22:08:17+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:08:17 <a=
 href=3D"http://165.154.42.209:55156" target=3D"_blank">165.154.42.209:5515=
6</a> SIGTERM[soft,port-share-redirect] received, client-instance exiting&#=
39;<br>2024-11-18T22:08:18+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18=
 11:08:18 Note: OpenSSL hardware crypto engine functionality is not availab=
le&#39;<br>2024-11-18T22:08:18+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-1=
1-18 11:08:18 TCP connection established with [AF_INET]<a href=3D"http://16=
5.154.42.209:55284" target=3D"_blank">165.154.42.209:55284</a>&#39;<br>2024=
-11-18T22:08:18+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:08:18 S=
ocket flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-18T22:08:18+1100 [st=
dout#info] [OVPN 0] OUT: &#39;2024-11-18 11:08:18 <a href=3D"http://165.154=
.42.209:55284" target=3D"_blank">165.154.42.209:55284</a> Non-OpenVPN clien=
t protocol detected&#39;<br>2024-11-18T22:08:18+1100 [stdout#info] [OVPN 0]=
 OUT: &#39;2024-11-18 11:08:18 <a href=3D"http://165.154.42.209:55284" targ=
et=3D"_blank">165.154.42.209:55284</a> SIGTERM[soft,port-share-redirect] re=
ceived, client-instance exiting&#39;<br>2024-11-18T22:08:18+1100 [stdout#in=
fo] [OVPN 0] OUT: &#39;2024-11-18 11:08:18 Note: OpenSSL hardware crypto en=
gine functionality is not available&#39;<br>2024-11-18T22:08:18+1100 [stdou=
t#info] [OVPN 0] OUT: &#39;2024-11-18 11:08:18 TCP connection established w=
ith [AF_INET]<a href=3D"http://165.154.42.209:55410" target=3D"_blank">165.=
154.42.209:55410</a>&#39;<br>2024-11-18T22:08:18+1100 [stdout#info] [OVPN 0=
] OUT: &#39;2024-11-18 11:08:18 Socket flags: TCP_NODELAY=3D1 succeeded&#39=
;<br>2024-11-18T22:08:18+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 1=
1:08:18 <a href=3D"http://165.154.42.209:55410" target=3D"_blank">165.154.4=
2.209:55410</a> Non-OpenVPN client protocol detected&#39;<br>2024-11-18T22:=
08:18+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:08:18 <a href=3D"=
http://165.154.42.209:55410" target=3D"_blank">165.154.42.209:55410</a> SIG=
TERM[soft,port-share-redirect] received, client-instance exiting&#39;<br>20=
24-11-18T22:08:19+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:08:19=
 Note: OpenSSL hardware crypto engine functionality is not available&#39;<b=
r>2024-11-18T22:08:19+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:0=
8:19 TCP connection established with [AF_INET]<a href=3D"http://165.154.42.=
209:55610" target=3D"_blank">165.154.42.209:55610</a>&#39;<br>2024-11-18T22=
:08:19+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:08:19 Socket fla=
gs: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-18T22:08:19+1100 [stdout#info=
] [OVPN 0] OUT: &#39;2024-11-18 11:08:19 <a href=3D"http://165.154.42.209:5=
5610" target=3D"_blank">165.154.42.209:55610</a> Non-OpenVPN client protoco=
l detected&#39;<br>2024-11-18T22:08:19+1100 [stdout#info] [OVPN 0] OUT: &#3=
9;2024-11-18 11:08:19 <a href=3D"http://165.154.42.209:55610" target=3D"_bl=
ank">165.154.42.209:55610</a> SIGTERM[soft,port-share-redirect] received, c=
lient-instance exiting&#39;<br>2024-11-18T22:44:28+1100 [stdout#info] [OVPN=
 0] OUT: &#39;2024-11-18 11:44:28 Note: OpenSSL hardware crypto engine func=
tionality is not available&#39;<br>2024-11-18T22:44:28+1100 [stdout#info] [=
OVPN 0] OUT: &#39;2024-11-18 11:44:28 TCP connection established with [AF_I=
NET]<a href=3D"http://79.110.62.21:35294" target=3D"_blank">79.110.62.21:35=
294</a>&#39;<br>2024-11-18T22:44:28+1100 [stdout#info] [OVPN 0] OUT: &#39;2=
024-11-18 11:44:28 Socket flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-=
18T22:44:28+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:44:28 <a hr=
ef=3D"http://79.110.62.21:35294" target=3D"_blank">79.110.62.21:35294</a> N=
on-OpenVPN client protocol detected&#39;<br>2024-11-18T22:44:28+1100 [stdou=
t#info] [OVPN 0] OUT: &#39;2024-11-18 11:44:28 <a href=3D"http://79.110.62.=
21:35294" target=3D"_blank">79.110.62.21:35294</a> SIGTERM[soft,port-share-=
redirect] received, client-instance exiting&#39;<br>2024-11-18T22:48:46+110=
0 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:48:46 Note: OpenSSL hardwa=
re crypto engine functionality is not available&#39;<br>2024-11-18T22:48:46=
+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:48:46 TCP connection e=
stablished with [AF_INET]<a href=3D"http://94.156.177.228:51080" target=3D"=
_blank">94.156.177.228:51080</a>&#39;<br>2024-11-18T22:48:46+1100 [stdout#i=
nfo] [OVPN 0] OUT: &#39;2024-11-18 11:48:46 Socket flags: TCP_NODELAY=3D1 s=
ucceeded&#39;<br>2024-11-18T22:48:46+1100 [stdout#info] [OVPN 0] OUT: &#39;=
2024-11-18 11:48:46 <a href=3D"http://94.156.177.228:51080" target=3D"_blan=
k">94.156.177.228:51080</a> Non-OpenVPN client protocol detected&#39;<br>20=
24-11-18T22:48:46+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 11:48:46=
 <a href=3D"http://94.156.177.228:51080" target=3D"_blank">94.156.177.228:5=
1080</a> SIGTERM[soft,port-share-redirect] received, client-instance exitin=
g&#39;<br>2024-11-18T22:48:47+1100 [stdout#info] [WEB] OUT: &#39;2024-11-18=
T22:48:47+1100 [twisted.python.log#info] &quot;127.0.0.1&quot; - - [18/Nov/=
2024:11:48:47 +0000] &quot;GET /RDWeb/Pages/ HTTP/1.1&quot; 200 1707 &quot;=
-&quot; &quot;Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 =
(KHTML, like Gecko) Chrome/<a href=3D"http://115.0.0.0" target=3D"_blank">1=
15.0.0.0</a> Safari/537.36 Edg/115.0.1901.203&quot;&#39;<br>2024-11-18T22:5=
7:10+1100 [stdout#info] [WEB] OUT: &#39;2024-11-18T22:57:10+1100 [twisted.p=
ython.log#info] &quot;68.183.22.136&quot; - - [18/Nov/2024:11:57:10 +0000] =
&quot;GET / HTTP/1.0&quot; 400 - &quot;-&quot; &quot;-&quot;&#39;<br>2024-1=
1-18T22:57:12+1100 [stdout#info] [WEB] OUT: &#39;2024-11-18T22:57:12+1100 [=
twisted.python.log#info] &quot;68.183.22.136&quot; - - [18/Nov/2024:11:57:1=
1 +0000] &quot;OPTIONS / HTTP/1.0&quot; 400 - &quot;-&quot; &quot;-&quot;&#=
39;<br>2024-11-18T22:57:13+1100 [stdout#info] [WEB] OUT: &#39;2024-11-18T22=
:57:13+1100 [twisted.python.log#info] &quot;68.183.22.136&quot; - - [18/Nov=
/2024:11:57:12 +0000] &quot;OPTIONS / RTSP/1.0&quot; 400 - &quot;-&quot; &q=
uot;-&quot;&#39;<br>2024-11-18T22:57:14+1100 [stdout#info] [WEB] OUT: &#39;=
2024-11-18T22:57:14+1100 [twisted.python.log#info] &quot;68.183.22.136&quot=
; - - [18/Nov/2024:11:57:14 +0000] &quot;GET /nice%20ports%2C/Tri%6Eity.txt=
%2ebak HTTP/1.0&quot; 400 - &quot;-&quot; &quot;-&quot;&#39;<br>2024-11-18T=
22:57:15+1100 [stdout#info] [WEB] OUT: &#39;2024-11-18T22:57:15+1100 [twist=
ed.python.log#info] &quot;68.183.22.136&quot; - - [18/Nov/2024:11:57:15 +00=
00] &quot;OPTIONS sip:nm SIP/2.0&quot; 400 - &quot;-&quot; &quot;-&quot;&#3=
9;<br>2024-11-18T23:03:10+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 =
12:03:10 Note: OpenSSL hardware crypto engine functionality is not availabl=
e&#39;<br>2024-11-18T23:03:10+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11=
-18 12:03:10 TCP connection established with [AF_INET]<a href=3D"http://152=
.32.143.189:60324" target=3D"_blank">152.32.143.189:60324</a>&#39;<br>2024-=
11-18T23:03:10+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:10 So=
cket flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-18T23:03:12+1100 [std=
out#info] [WEB] OUT: &#39;2024-11-18T23:03:12+1100 [twisted.python.log#info=
] &quot;147.185.132.123&quot; - - [18/Nov/2024:12:03:11 +0000] &quot;GET /a=
dmin HTTP/1.1&quot; 302 240 &quot;-&quot; &quot;Expanse, a Palo Alto Networ=
ks company, searches across the global IPv4 space multiple times per day to=
 identify customers&amp;#39; presences on the Internet. If you would like t=
o be excluded from our scans, please send IP addresses/domains to: <a href=
=3D"mailto:scaninfo@...2834..." target=3D"_blank">scaninfo@...2834...</a>&q=
uot;&#39;<br>2024-11-18T23:03:12+1100 [stdout#info] [WEB] OUT: &#39;2024-11=
-18T23:03:12+1100 [twisted.python.log#info] &quot;147.185.132.123&quot; - -=
 [18/Nov/2024:12:03:12 +0000] &quot;GET /admin/ HTTP/1.1&quot; 302 - &quot;=
-&quot; &quot;Expanse, a Palo Alto Networks company, searches across the gl=
obal IPv4 space multiple times per day to identify customers&amp;#39; prese=
nces on the Internet. If you would like to be excluded from our scans, plea=
se send IP addresses/domains to: <a href=3D"mailto:scaninfo@...2834..." tar=
get=3D"_blank">scaninfo@...2834...</a>&quot;&#39;<br>2024-11-18T23:03:13+11=
00 [stdout#info] [WEB] OUT: &#39;2024-11-18T23:03:13+1100 [stdout#info] No =
Cookie or mismatched cookie&#39;<br>2024-11-18T23:03:13+1100 [stdout#info] =
[WEB] OUT: &#39;2024-11-18T23:03:13+1100 [twisted.python.log#info] &quot;14=
7.185.132.123&quot; - - [18/Nov/2024:12:03:12 +0000] &quot;GET /admin/__ses=
sion_start__ HTTP/1.1&quot; 200 164 &quot;-&quot; &quot;Expanse, a Palo Alt=
o Networks company, searches across the global IPv4 space multiple times pe=
r day to identify customers&amp;#39; presences on the Internet. If you woul=
d like to be excluded from our scans, please send IP addresses/domains to: =
<a href=3D"mailto:scaninfo@...2834..." target=3D"_blank">scaninfo@...2836...=
.</a>&quot;&#39;<br>2024-11-18T23:03:16+1100 [stdout#info] [OVPN 0] OUT: &#=
39;2024-11-18 12:03:16 <a href=3D"http://152.32.143.189:60324" target=3D"_b=
lank">152.32.143.189:60324</a> Connection reset, restarting [0]&#39;<br>202=
4-11-18T23:03:16+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:16 =
<a href=3D"http://152.32.143.189:60324" target=3D"_blank">152.32.143.189:60=
324</a> SIGUSR1[soft,connection-reset] received, client-instance restarting=
&#39;<br>2024-11-18T23:03:18+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-=
18 12:03:18 Note: OpenSSL hardware crypto engine functionality is not avail=
able&#39;<br>2024-11-18T23:03:18+1100 [stdout#info] [OVPN 0] OUT: &#39;2024=
-11-18 12:03:18 TCP connection established with [AF_INET]<a href=3D"http://=
152.32.143.189:34528" target=3D"_blank">152.32.143.189:34528</a>&#39;<br>20=
24-11-18T23:03:18+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:18=
 Socket flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-18T23:03:18+1100 [=
stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:18 <a href=3D"http://152.3=
2.143.189:34528" target=3D"_blank">152.32.143.189:34528</a> Non-OpenVPN cli=
ent protocol detected&#39;<br>2024-11-18T23:03:18+1100 [stdout#info] [OVPN =
0] OUT: &#39;2024-11-18 12:03:18 <a href=3D"http://152.32.143.189:34528" ta=
rget=3D"_blank">152.32.143.189:34528</a> SIGTERM[soft,port-share-redirect] =
received, client-instance exiting&#39;<br>2024-11-18T23:03:21+1100 [stdout#=
info] [OVPN 0] OUT: &#39;2024-11-18 12:03:21 Note: OpenSSL hardware crypto =
engine functionality is not available&#39;<br>2024-11-18T23:03:21+1100 [std=
out#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:21 TCP connection established=
 with [AF_INET]<a href=3D"http://152.32.143.189:35864" target=3D"_blank">15=
2.32.143.189:35864</a>&#39;<br>2024-11-18T23:03:21+1100 [stdout#info] [OVPN=
 0] OUT: &#39;2024-11-18 12:03:21 Socket flags: TCP_NODELAY=3D1 succeeded&#=
39;<br>2024-11-18T23:03:21+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18=
 12:03:21 <a href=3D"http://152.32.143.189:35864" target=3D"_blank">152.32.=
143.189:35864</a> Non-OpenVPN client protocol detected&#39;<br>2024-11-18T2=
3:03:21+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:21 <a href=
=3D"http://152.32.143.189:35864" target=3D"_blank">152.32.143.189:35864</a>=
 SIGTERM[soft,port-share-redirect] received, client-instance exiting&#39;<b=
r>2024-11-18T23:03:22+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:0=
3:22 Note: OpenSSL hardware crypto engine functionality is not available&#3=
9;<br>2024-11-18T23:03:22+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 =
12:03:22 TCP connection established with [AF_INET]<a href=3D"http://152.32.=
143.189:36138" target=3D"_blank">152.32.143.189:36138</a>&#39;<br>2024-11-1=
8T23:03:22+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:22 Socket=
 flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-18T23:03:22+1100 [stdout#=
info] [OVPN 0] OUT: &#39;2024-11-18 12:03:22 <a href=3D"http://152.32.143.1=
89:36138" target=3D"_blank">152.32.143.189:36138</a> Non-OpenVPN client pro=
tocol detected&#39;<br>2024-11-18T23:03:22+1100 [stdout#info] [OVPN 0] OUT:=
 &#39;2024-11-18 12:03:22 <a href=3D"http://152.32.143.189:36138" target=3D=
"_blank">152.32.143.189:36138</a> SIGTERM[soft,port-share-redirect] receive=
d, client-instance exiting&#39;<br>2024-11-18T23:03:30+1100 [stdout#info] [=
OVPN 0] OUT: &#39;2024-11-18 12:03:30 Note: OpenSSL hardware crypto engine =
functionality is not available&#39;<br>2024-11-18T23:03:30+1100 [stdout#inf=
o] [OVPN 0] OUT: &#39;2024-11-18 12:03:30 TCP connection established with [=
AF_INET]<a href=3D"http://152.32.143.189:40176" target=3D"_blank">152.32.14=
3.189:40176</a>&#39;<br>2024-11-18T23:03:30+1100 [stdout#info] [OVPN 0] OUT=
: &#39;2024-11-18 12:03:30 Socket flags: TCP_NODELAY=3D1 succeeded&#39;<br>=
2024-11-18T23:03:31+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:=
31 <a href=3D"http://152.32.143.189:40176" target=3D"_blank">152.32.143.189=
:40176</a> Non-OpenVPN client protocol detected&#39;<br>2024-11-18T23:03:31=
+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:31 <a href=3D"http:=
//152.32.143.189:40176" target=3D"_blank">152.32.143.189:40176</a> SIGTERM[=
soft,port-share-redirect] received, client-instance exiting&#39;<br>2024-11=
-18T23:03:31+1100 [stdout#info] [WEB] OUT: &#39;2024-11-18T23:03:31+1100 [t=
wisted.python.log#info] &quot;127.0.0.1&quot; - - [18/Nov/2024:12:03:30 +00=
00] &quot;GET / HTTP/1.1&quot; 200 1707 &quot;-&quot; &quot;curl/7.29.0&quo=
t;&#39;<br>2024-11-18T23:03:32+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-1=
1-18 12:03:32 Note: OpenSSL hardware crypto engine functionality is not ava=
ilable&#39;<br>2024-11-18T23:03:32+1100 [stdout#info] [OVPN 0] OUT: &#39;20=
24-11-18 12:03:32 TCP connection established with [AF_INET]<a href=3D"http:=
//152.32.143.189:41352" target=3D"_blank">152.32.143.189:41352</a>&#39;<br>=
2024-11-18T23:03:32+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:=
32 Socket flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-18T23:03:32+1100=
 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:32 <a href=3D"http://152=
.32.143.189:41352" target=3D"_blank">152.32.143.189:41352</a> Non-OpenVPN c=
lient protocol detected&#39;<br>2024-11-18T23:03:32+1100 [stdout#info] [OVP=
N 0] OUT: &#39;2024-11-18 12:03:32 <a href=3D"http://152.32.143.189:41352" =
target=3D"_blank">152.32.143.189:41352</a> SIGTERM[soft,port-share-redirect=
] received, client-instance exiting&#39;<br>2024-11-18T23:03:41+1100 [stdou=
t#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:41 Note: OpenSSL hardware crypt=
o engine functionality is not available&#39;<br>2024-11-18T23:03:41+1100 [s=
tdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:41 TCP connection establish=
ed with [AF_INET]<a href=3D"http://152.32.143.189:46888" target=3D"_blank">=
152.32.143.189:46888</a>&#39;<br>2024-11-18T23:03:41+1100 [stdout#info] [OV=
PN 0] OUT: &#39;2024-11-18 12:03:41 Socket flags: TCP_NODELAY=3D1 succeeded=
&#39;<br>2024-11-18T23:03:42+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-=
18 12:03:42 <a href=3D"http://152.32.143.189:46888" target=3D"_blank">152.3=
2.143.189:46888</a> Non-OpenVPN client protocol detected&#39;<br>2024-11-18=
T23:03:42+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:42 <a href=
=3D"http://152.32.143.189:46888" target=3D"_blank">152.32.143.189:46888</a>=
 SIGTERM[soft,port-share-redirect] received, client-instance exiting&#39;<b=
r>2024-11-18T23:03:42+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:0=
3:42 Note: OpenSSL hardware crypto engine functionality is not available&#3=
9;<br>2024-11-18T23:03:42+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 =
12:03:42 TCP connection established with [AF_INET]<a href=3D"http://152.32.=
143.189:47524" target=3D"_blank">152.32.143.189:47524</a>&#39;<br>2024-11-1=
8T23:03:42+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:42 Socket=
 flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-18T23:03:42+1100 [stdout#=
info] [OVPN 0] OUT: &#39;2024-11-18 12:03:42 <a href=3D"http://152.32.143.1=
89:47524" target=3D"_blank">152.32.143.189:47524</a> Non-OpenVPN client pro=
tocol detected&#39;<br>2024-11-18T23:03:42+1100 [stdout#info] [OVPN 0] OUT:=
 &#39;2024-11-18 12:03:42 <a href=3D"http://152.32.143.189:47524" target=3D=
"_blank">152.32.143.189:47524</a> SIGTERM[soft,port-share-redirect] receive=
d, client-instance exiting&#39;<br>2024-11-18T23:03:43+1100 [stdout#info] [=
OVPN 0] OUT: &#39;2024-11-18 12:03:43 Note: OpenSSL hardware crypto engine =
functionality is not available&#39;<br>2024-11-18T23:03:43+1100 [stdout#inf=
o] [OVPN 0] OUT: &#39;2024-11-18 12:03:43 TCP connection established with [=
AF_INET]<a href=3D"http://152.32.143.189:48008" target=3D"_blank">152.32.14=
3.189:48008</a>&#39;<br>2024-11-18T23:03:43+1100 [stdout#info] [OVPN 0] OUT=
: &#39;2024-11-18 12:03:43 Socket flags: TCP_NODELAY=3D1 succeeded&#39;<br>=
2024-11-18T23:03:43+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:=
43 <a href=3D"http://152.32.143.189:48008" target=3D"_blank">152.32.143.189=
:48008</a> Non-OpenVPN client protocol detected&#39;<br>2024-11-18T23:03:43=
+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:43 <a href=3D"http:=
//152.32.143.189:48008" target=3D"_blank">152.32.143.189:48008</a> SIGTERM[=
soft,port-share-redirect] received, client-instance exiting&#39;<br>2024-11=
-18T23:03:44+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:44 Note=
: OpenSSL hardware crypto engine functionality is not available&#39;<br>202=
4-11-18T23:03:44+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:44 =
TCP connection established with [AF_INET]<a href=3D"http://152.32.143.189:4=
8522" target=3D"_blank">152.32.143.189:48522</a>&#39;<br>2024-11-18T23:03:4=
4+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:44 Socket flags: T=
CP_NODELAY=3D1 succeeded&#39;<br>2024-11-18T23:03:44+1100 [stdout#info] [OV=
PN 0] OUT: &#39;2024-11-18 12:03:44 <a href=3D"http://152.32.143.189:48522"=
 target=3D"_blank">152.32.143.189:48522</a> Non-OpenVPN client protocol det=
ected&#39;<br>2024-11-18T23:03:44+1100 [stdout#info] [OVPN 0] OUT: &#39;202=
4-11-18 12:03:44 <a href=3D"http://152.32.143.189:48522" target=3D"_blank">=
152.32.143.189:48522</a> SIGTERM[soft,port-share-redirect] received, client=
-instance exiting&#39;<br>2024-11-18T23:03:45+1100 [stdout#info] [OVPN 0] O=
UT: &#39;2024-11-18 12:03:45 Note: OpenSSL hardware crypto engine functiona=
lity is not available&#39;<br>2024-11-18T23:03:45+1100 [stdout#info] [OVPN =
0] OUT: &#39;2024-11-18 12:03:45 TCP connection established with [AF_INET]<=
a href=3D"http://152.32.143.189:49156" target=3D"_blank">152.32.143.189:491=
56</a>&#39;<br>2024-11-18T23:03:45+1100 [stdout#info] [OVPN 0] OUT: &#39;20=
24-11-18 12:03:45 Socket flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-1=
8T23:03:45+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:45 <a hre=
f=3D"http://152.32.143.189:49156" target=3D"_blank">152.32.143.189:49156</a=
> Non-OpenVPN client protocol detected&#39;<br>2024-11-18T23:03:45+1100 [st=
dout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:45 <a href=3D"http://152.32.=
143.189:49156" target=3D"_blank">152.32.143.189:49156</a> SIGTERM[soft,port=
-share-redirect] received, client-instance exiting&#39;<br>2024-11-18T23:03=
:46+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:46 Note: OpenSSL=
 hardware crypto engine functionality is not available&#39;<br>2024-11-18T2=
3:03:46+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:46 TCP conne=
ction established with [AF_INET]<a href=3D"http://152.32.143.189:49756" tar=
get=3D"_blank">152.32.143.189:49756</a>&#39;<br>2024-11-18T23:03:46+1100 [s=
tdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:46 Socket flags: TCP_NODELA=
Y=3D1 succeeded&#39;<br>2024-11-18T23:03:46+1100 [stdout#info] [OVPN 0] OUT=
: &#39;2024-11-18 12:03:46 <a href=3D"http://152.32.143.189:49756" target=
=3D"_blank">152.32.143.189:49756</a> Non-OpenVPN client protocol detected&#=
39;<br>2024-11-18T23:03:46+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18=
 12:03:46 <a href=3D"http://152.32.143.189:49756" target=3D"_blank">152.32.=
143.189:49756</a> SIGTERM[soft,port-share-redirect] received, client-instan=
ce exiting&#39;<br>2024-11-18T23:03:47+1100 [stdout#info] [OVPN 0] OUT: &#3=
9;2024-11-18 12:03:47 Note: OpenSSL hardware crypto engine functionality is=
 not available&#39;<br>2024-11-18T23:03:47+1100 [stdout#info] [OVPN 0] OUT:=
 &#39;2024-11-18 12:03:47 TCP connection established with [AF_INET]<a href=
=3D"http://152.32.143.189:50234" target=3D"_blank">152.32.143.189:50234</a>=
&#39;<br>2024-11-18T23:03:47+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-=
18 12:03:47 Socket flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-18T23:0=
3:47+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:47 <a href=3D"h=
ttp://152.32.143.189:50234" target=3D"_blank">152.32.143.189:50234</a> Non-=
OpenVPN client protocol detected&#39;<br>2024-11-18T23:03:47+1100 [stdout#i=
nfo] [OVPN 0] OUT: &#39;2024-11-18 12:03:47 <a href=3D"http://152.32.143.18=
9:50234" target=3D"_blank">152.32.143.189:50234</a> SIGTERM[soft,port-share=
-redirect] received, client-instance exiting&#39;<br>2024-11-18T23:03:48+11=
00 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:48 Note: OpenSSL hardw=
are crypto engine functionality is not available&#39;<br>2024-11-18T23:03:4=
8+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:48 TCP connection =
established with [AF_INET]<a href=3D"http://152.32.143.189:51192" target=3D=
"_blank">152.32.143.189:51192</a>&#39;<br>2024-11-18T23:03:48+1100 [stdout#=
info] [OVPN 0] OUT: &#39;2024-11-18 12:03:48 Socket flags: TCP_NODELAY=3D1 =
succeeded&#39;<br>2024-11-18T23:03:48+1100 [stdout#info] [OVPN 0] OUT: &#39=
;2024-11-18 12:03:48 <a href=3D"http://152.32.143.189:51192" target=3D"_bla=
nk">152.32.143.189:51192</a> Non-OpenVPN client protocol detected&#39;<br>2=
024-11-18T23:03:48+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:4=
8 <a href=3D"http://152.32.143.189:51192" target=3D"_blank">152.32.143.189:=
51192</a> SIGTERM[soft,port-share-redirect] received, client-instance exiti=
ng&#39;<br>2024-11-18T23:03:49+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-1=
1-18 12:03:49 Note: OpenSSL hardware crypto engine functionality is not ava=
ilable&#39;<br>2024-11-18T23:03:49+1100 [stdout#info] [OVPN 0] OUT: &#39;20=
24-11-18 12:03:49 TCP connection established with [AF_INET]<a href=3D"http:=
//152.32.143.189:51718" target=3D"_blank">152.32.143.189:51718</a>&#39;<br>=
2024-11-18T23:03:49+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:=
49 Socket flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-18T23:03:49+1100=
 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:49 <a href=3D"http://152=
.32.143.189:51718" target=3D"_blank">152.32.143.189:51718</a> Non-OpenVPN c=
lient protocol detected&#39;<br>2024-11-18T23:03:49+1100 [stdout#info] [OVP=
N 0] OUT: &#39;2024-11-18 12:03:49 <a href=3D"http://152.32.143.189:51718" =
target=3D"_blank">152.32.143.189:51718</a> SIGTERM[soft,port-share-redirect=
] received, client-instance exiting&#39;<br>2024-11-18T23:03:50+1100 [stdou=
t#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:50 Note: OpenSSL hardware crypt=
o engine functionality is not available&#39;<br>2024-11-18T23:03:50+1100 [s=
tdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:50 TCP connection establish=
ed with [AF_INET]<a href=3D"http://152.32.143.189:52384" target=3D"_blank">=
152.32.143.189:52384</a>&#39;<br>2024-11-18T23:03:50+1100 [stdout#info] [OV=
PN 0] OUT: &#39;2024-11-18 12:03:50 Socket flags: TCP_NODELAY=3D1 succeeded=
&#39;<br>2024-11-18T23:03:50+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-=
18 12:03:50 <a href=3D"http://152.32.143.189:52384" target=3D"_blank">152.3=
2.143.189:52384</a> Non-OpenVPN client protocol detected&#39;<br>2024-11-18=
T23:03:50+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:50 <a href=
=3D"http://152.32.143.189:52384" target=3D"_blank">152.32.143.189:52384</a>=
 SIGTERM[soft,port-share-redirect] received, client-instance exiting&#39;<b=
r>2024-11-18T23:03:50+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:0=
3:50 Note: OpenSSL hardware crypto engine functionality is not available&#3=
9;<br>2024-11-18T23:03:50+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 =
12:03:50 TCP connection established with [AF_INET]<a href=3D"http://152.32.=
143.189:52844" target=3D"_blank">152.32.143.189:52844</a>&#39;<br>2024-11-1=
8T23:03:50+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:03:50 Socket=
 flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-18T23:03:50+1100 [stdout#=
info] [OVPN 0] OUT: &#39;2024-11-18 12:03:50 <a href=3D"http://152.32.143.1=
89:52844" target=3D"_blank">152.32.143.189:52844</a> Non-OpenVPN client pro=
tocol detected&#39;<br>2024-11-18T23:03:50+1100 [stdout#info] [OVPN 0] OUT:=
 &#39;2024-11-18 12:03:50 <a href=3D"http://152.32.143.189:52844" target=3D=
"_blank">152.32.143.189:52844</a> SIGTERM[soft,port-share-redirect] receive=
d, client-instance exiting&#39;<br>2024-11-18T23:04:12+1100 [stdout#info] [=
WEB] OUT: &quot;2024-11-18T23:04:12+1100 [-] expired session b&#39;x5NuuX..=
.&quot;<br>2024-11-18T23:51:30+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-1=
1-18 12:51:30 Note: OpenSSL hardware crypto engine functionality is not ava=
ilable&#39;<br>2024-11-18T23:51:30+1100 [stdout#info] [OVPN 0] OUT: &#39;20=
24-11-18 12:51:30 TCP connection established with [AF_INET]<a href=3D"http:=
//185.242.226.117:34407" target=3D"_blank">185.242.226.117:34407</a>&#39;<b=
r>2024-11-18T23:51:30+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:5=
1:30 Socket flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-18T23:51:31+11=
00 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:51:31 <a href=3D"http://1=
85.242.226.117:34407" target=3D"_blank">185.242.226.117:34407</a> Non-OpenV=
PN client protocol detected&#39;<br>2024-11-18T23:51:31+1100 [stdout#info] =
[OVPN 0] OUT: &#39;2024-11-18 12:51:31 <a href=3D"http://185.242.226.117:34=
407" target=3D"_blank">185.242.226.117:34407</a> SIGTERM[soft,port-share-re=
direct] received, client-instance exiting&#39;<br>2024-11-18T23:59:04+1100 =
[stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:59:04 Note: OpenSSL hardware=
 crypto engine functionality is not available&#39;<br>2024-11-18T23:59:04+1=
100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:59:04 TCP connection est=
ablished with [AF_INET]<a href=3D"http://165.154.36.105:42216" target=3D"_b=
lank">165.154.36.105:42216</a>&#39;<br>2024-11-18T23:59:04+1100 [stdout#inf=
o] [OVPN 0] OUT: &#39;2024-11-18 12:59:04 Socket flags: TCP_NODELAY=3D1 suc=
ceeded&#39;<br>2024-11-18T23:59:04+1100 [stdout#info] [OVPN 0] OUT: &#39;20=
24-11-18 12:59:04 <a href=3D"http://165.154.36.105:42216" target=3D"_blank"=
>165.154.36.105:42216</a> Non-OpenVPN client protocol detected&#39;<br>2024=
-11-18T23:59:04+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:59:04 <=
a href=3D"http://165.154.36.105:42216" target=3D"_blank">165.154.36.105:422=
16</a> SIGTERM[soft,port-share-redirect] received, client-instance exiting&=
#39;<br>2024-11-18T23:59:04+1100 [stdout#info] [WEB] OUT: &#39;2024-11-18T2=
3:59:04+1100 [twisted.python.log#info] &quot;127.0.0.1&quot; - - [18/Nov/20=
24:12:59:04 +0000] &quot;GET / HTTP/1.1&quot; 200 1707 &quot;-&quot; &quot;=
Mozilla/5.0 (Windows NT 7_1; Win64; x64) AppleWebKit/553.44 (KHTML, like Ge=
cko) Chrome/90.0.2093 Safari/537.36&quot;&#39;<br>2024-11-18T23:59:04+1100 =
[stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:59:04 Note: OpenSSL hardware=
 crypto engine functionality is not available&#39;<br>2024-11-18T23:59:04+1=
100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:59:04 TCP connection est=
ablished with [AF_INET]<a href=3D"http://165.154.36.105:42430" target=3D"_b=
lank">165.154.36.105:42430</a>&#39;<br>2024-11-18T23:59:04+1100 [stdout#inf=
o] [OVPN 0] OUT: &#39;2024-11-18 12:59:04 Socket flags: TCP_NODELAY=3D1 suc=
ceeded&#39;<br>2024-11-18T23:59:04+1100 [stdout#info] [OVPN 0] OUT: &#39;20=
24-11-18 12:59:04 <a href=3D"http://165.154.36.105:42430" target=3D"_blank"=
>165.154.36.105:42430</a> Non-OpenVPN client protocol detected&#39;<br>2024=
-11-18T23:59:04+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:59:04 <=
a href=3D"http://165.154.36.105:42430" target=3D"_blank">165.154.36.105:424=
30</a> SIGTERM[soft,port-share-redirect] received, client-instance exiting&=
#39;<br>2024-11-18T23:59:05+1100 [stdout#info] [WEB] OUT: &#39;2024-11-18T2=
3:59:05+1100 [twisted.python.log#info] &quot;127.0.0.1&quot; - - [18/Nov/20=
24:12:59:04 +0000] &quot;GET /static/standalone/client/media/favicon-dark/f=
avicon-32x32.png HTTP/1.1&quot; 200 734 &quot;-&quot; &quot;Go-http-client/=
1.1&quot;&#39;<br>2024-11-18T23:59:05+1100 [stdout#info] [OVPN 0] OUT: &#39=
;2024-11-18 12:59:05 Note: OpenSSL hardware crypto engine functionality is =
not available&#39;<br>2024-11-18T23:59:05+1100 [stdout#info] [OVPN 0] OUT: =
&#39;2024-11-18 12:59:05 TCP connection established with [AF_INET]<a href=
=3D"http://165.154.36.105:42530" target=3D"_blank">165.154.36.105:42530</a>=
&#39;<br>2024-11-18T23:59:05+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-=
18 12:59:05 Socket flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-18T23:5=
9:05+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:59:05 <a href=3D"h=
ttp://165.154.36.105:42530" target=3D"_blank">165.154.36.105:42530</a> Note=
: OpenSSL hardware crypto engine functionality is not available&#39;<br>202=
4-11-18T23:59:05+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:59:05 =
<a href=3D"http://165.154.36.105:42530" target=3D"_blank">165.154.36.105:42=
530</a> TCP connection established with [AF_INET]<a href=3D"http://165.154.=
36.105:42528" target=3D"_blank">165.154.36.105:42528</a>&#39;<br>2024-11-18=
T23:59:05+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:59:05 <a href=
=3D"http://165.154.36.105:42530" target=3D"_blank">165.154.36.105:42530</a>=
 Socket flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-18T23:59:05+1100 [=
stdout#info] [OVPN 0] OUT: &#39;2024-11-18 12:59:05 <a href=3D"http://165.1=
54.36.105:42530" target=3D"_blank">165.154.36.105:42530</a> Non-OpenVPN cli=
ent protocol detected&#39;<br>2024-11-18T23:59:05+1100 [stdout#info] [OVPN =
0] OUT: &#39;2024-11-18 12:59:05 <a href=3D"http://165.154.36.105:42530" ta=
rget=3D"_blank">165.154.36.105:42530</a> SIGTERM[soft,port-share-redirect] =
received, client-instance exiting&#39;<br>2024-11-18T23:59:05+1100 [stdout#=
info] [OVPN 0] OUT: &#39;2024-11-18 12:59:05 <a href=3D"http://165.154.36.1=
05:42528" target=3D"_blank">165.154.36.105:42528</a> Non-OpenVPN client pro=
tocol detected&#39;<br>2024-11-18T23:59:05+1100 [stdout#info] [OVPN 0] OUT:=
 &#39;2024-11-18 12:59:05 <a href=3D"http://165.154.36.105:42528" target=3D=
"_blank">165.154.36.105:42528</a> SIGTERM[soft,port-share-redirect] receive=
d, client-instance exiting&#39;<br>2024-11-18T23:59:05+1100 [stdout#info] [=
WEB] OUT: &#39;2024-11-18T23:59:05+1100 [twisted.python.log#info] &quot;127=
.0.0.1&quot; - - [18/Nov/2024:12:59:05 +0000] &quot;GET /sitemap.xml HTTP/1=
.1&quot; 404 167 &quot;-&quot; &quot;Go-http-client/1.1&quot;&#39;<br>2024-=
11-18T23:59:05+1100 [stdout#info] [WEB] OUT: &#39;2024-11-18T23:59:05+1100 =
[twisted.python.log#info] &quot;127.0.0.1&quot; - - [18/Nov/2024:12:59:05 +=
0000] &quot;GET /robots.txt HTTP/1.1&quot; 200 26 &quot;-&quot; &quot;Go-ht=
tp-client/1.1&quot;&#39;<br>2024-11-19T00:05:55+1100 [stdout#info] [OVPN 0]=
 OUT: &#39;2024-11-18 13:05:55 Note: OpenSSL hardware crypto engine functio=
nality is not available&#39;<br>2024-11-19T00:05:55+1100 [stdout#info] [OVP=
N 0] OUT: &#39;2024-11-18 13:05:55 TCP connection established with [AF_INET=
]<a href=3D"http://118.193.36.63:33848" target=3D"_blank">118.193.36.63:338=
48</a>&#39;<br>2024-11-19T00:05:55+1100 [stdout#info] [OVPN 0] OUT: &#39;20=
24-11-18 13:05:55 Socket flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-1=
9T00:05:55+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:05:55 <a hre=
f=3D"http://118.193.36.63:33848" target=3D"_blank">118.193.36.63:33848</a> =
Non-OpenVPN client protocol detected&#39;<br>2024-11-19T00:05:55+1100 [stdo=
ut#info] [OVPN 0] OUT: &#39;2024-11-18 13:05:55 <a href=3D"http://118.193.3=
6.63:33848" target=3D"_blank">118.193.36.63:33848</a> SIGTERM[soft,port-sha=
re-redirect] received, client-instance exiting&#39;<br>2024-11-19T00:05:55+=
1100 [stdout#info] [WEB] OUT: &#39;2024-11-19T00:05:55+1100 [twisted.python=
.log#info] &quot;127.0.0.1&quot; - - [18/Nov/2024:13:05:55 +0000] &quot;GET=
 / HTTP/1.1&quot; 200 1707 &quot;-&quot; &quot;Mozilla/5.0 (Windows NT 9_1_=
2; Win64; x64) AppleWebKit/594.54 (KHTML, like Gecko) Chrome/90.0.2915 Safa=
ri/537.36&quot;&#39;<br>2024-11-19T00:05:56+1100 [stdout#info] [OVPN 0] OUT=
: &#39;2024-11-18 13:05:56 Note: OpenSSL hardware crypto engine functionali=
ty is not available&#39;<br>2024-11-19T00:05:56+1100 [stdout#info] [OVPN 0]=
 OUT: &#39;2024-11-18 13:05:56 TCP connection established with [AF_INET]<a =
href=3D"http://118.193.36.63:34072" target=3D"_blank">118.193.36.63:34072</=
a>&#39;<br>2024-11-19T00:05:56+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-1=
1-18 13:05:56 Socket flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-19T00=
:05:56+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:05:56 <a href=3D=
"http://118.193.36.63:34072" target=3D"_blank">118.193.36.63:34072</a> Non-=
OpenVPN client protocol detected&#39;<br>2024-11-19T00:05:56+1100 [stdout#i=
nfo] [OVPN 0] OUT: &#39;2024-11-18 13:05:56 <a href=3D"http://118.193.36.63=
:34072" target=3D"_blank">118.193.36.63:34072</a> SIGTERM[soft,port-share-r=
edirect] received, client-instance exiting&#39;<br>2024-11-19T00:05:56+1100=
 [stdout#info] [WEB] OUT: &#39;2024-11-19T00:05:56+1100 [twisted.python.log=
#info] &quot;127.0.0.1&quot; - - [18/Nov/2024:13:05:55 +0000] &quot;GET /st=
atic/standalone/client/media/favicon-dark/favicon-32x32.png HTTP/1.1&quot; =
200 734 &quot;-&quot; &quot;Go-http-client/1.1&quot;&#39;<br>2024-11-19T00:=
05:56+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:05:56 Note: OpenS=
SL hardware crypto engine functionality is not available&#39;<br>2024-11-19=
T00:05:56+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:05:56 TCP con=
nection established with [AF_INET]<a href=3D"http://118.193.36.63:34258" ta=
rget=3D"_blank">118.193.36.63:34258</a>&#39;<br>2024-11-19T00:05:56+1100 [s=
tdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:05:56 Socket flags: TCP_NODELA=
Y=3D1 succeeded&#39;<br>2024-11-19T00:05:56+1100 [stdout#info] [OVPN 0] OUT=
: &#39;2024-11-18 13:05:56 <a href=3D"http://118.193.36.63:34258" target=3D=
"_blank">118.193.36.63:34258</a> Non-OpenVPN client protocol detected&#39;<=
br>2024-11-19T00:05:56+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:=
05:56 <a href=3D"http://118.193.36.63:34258" target=3D"_blank">118.193.36.6=
3:34258</a> SIGTERM[soft,port-share-redirect] received, client-instance exi=
ting&#39;<br>2024-11-19T00:05:56+1100 [stdout#info] [OVPN 0] OUT: &#39;2024=
-11-18 13:05:56 Note: OpenSSL hardware crypto engine functionality is not a=
vailable&#39;<br>2024-11-19T00:05:56+1100 [stdout#info] [OVPN 0] OUT: &#39;=
2024-11-18 13:05:56 TCP connection established with [AF_INET]<a href=3D"htt=
p://118.193.36.63:34256" target=3D"_blank">118.193.36.63:34256</a>&#39;<br>=
2024-11-19T00:05:56+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:05:=
56 Socket flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-19T00:05:56+1100=
 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:05:56 <a href=3D"http://118=
.193.36.63:34256" target=3D"_blank">118.193.36.63:34256</a> Non-OpenVPN cli=
ent protocol detected&#39;<br>2024-11-19T00:05:56+1100 [stdout#info] [OVPN =
0] OUT: &#39;2024-11-18 13:05:56 <a href=3D"http://118.193.36.63:34256" tar=
get=3D"_blank">118.193.36.63:34256</a> SIGTERM[soft,port-share-redirect] re=
ceived, client-instance exiting&#39;<br>2024-11-19T00:05:56+1100 [stdout#in=
fo] [WEB] OUT: &#39;2024-11-19T00:05:56+1100 [twisted.python.log#info] &quo=
t;127.0.0.1&quot; - - [18/Nov/2024:13:05:56 +0000] &quot;GET /sitemap.xml H=
TTP/1.1&quot; 404 167 &quot;-&quot; &quot;Go-http-client/1.1&quot;&#39;<br>=
2024-11-19T00:05:56+1100 [stdout#info] [WEB] OUT: &#39;2024-11-19T00:05:56+=
1100 [twisted.python.log#info] &quot;127.0.0.1&quot; - - [18/Nov/2024:13:05=
:56 +0000] &quot;GET /robots.txt HTTP/1.1&quot; 200 26 &quot;-&quot; &quot;=
Go-http-client/1.1&quot;&#39;<br>2024-11-19T00:11:02+1100 [stdout#info] [OV=
PN 0] OUT: &#39;2024-11-18 13:11:02 Note: OpenSSL hardware crypto engine fu=
nctionality is not available&#39;<br>2024-11-19T00:11:02+1100 [stdout#info]=
 [OVPN 0] OUT: &#39;2024-11-18 13:11:02 TCP connection established with [AF=
_INET]<a href=3D"http://138.68.26.173:33180" target=3D"_blank">138.68.26.17=
3:33180</a>&#39;<br>2024-11-19T00:11:02+1100 [stdout#info] [OVPN 0] OUT: &#=
39;2024-11-18 13:11:02 Socket flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024=
-11-19T00:11:02+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:11:02 <=
a href=3D"http://138.68.26.173:33180" target=3D"_blank">138.68.26.173:33180=
</a> Non-OpenVPN client protocol detected&#39;<br>2024-11-19T00:11:02+1100 =
[stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:11:02 <a href=3D"http://138.=
68.26.173:33180" target=3D"_blank">138.68.26.173:33180</a> SIGTERM[soft,por=
t-share-redirect] received, client-instance exiting&#39;<br>2024-11-19T00:1=
1:03+1100 [stdout#info] [WEB] OUT: &#39;2024-11-19T00:11:03+1100 [twisted.p=
ython.log#info] &quot;127.0.0.1&quot; - - [18/Nov/2024:13:11:02 +0000] &quo=
t;GET /.env HTTP/1.1&quot; 404 167 &quot;-&quot; &quot;Mozilla/5.0 Keydrop&=
quot;&#39;<br>2024-11-19T00:11:03+1100 [stdout#info] [OVPN 0] OUT: &#39;202=
4-11-18 13:11:03 Note: OpenSSL hardware crypto engine functionality is not =
available&#39;<br>2024-11-19T00:11:03+1100 [stdout#info] [OVPN 0] OUT: &#39=
;2024-11-18 13:11:03 TCP connection established with [AF_INET]<a href=3D"ht=
tp://138.68.26.173:33194" target=3D"_blank">138.68.26.173:33194</a>&#39;<br=
>2024-11-19T00:11:03+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:11=
:03 Socket flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-19T00:11:03+110=
0 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:11:03 <a href=3D"http://13=
8.68.26.173:33194" target=3D"_blank">138.68.26.173:33194</a> Non-OpenVPN cl=
ient protocol detected&#39;<br>2024-11-19T00:11:03+1100 [stdout#info] [OVPN=
 0] OUT: &#39;2024-11-18 13:11:03 <a href=3D"http://138.68.26.173:33194" ta=
rget=3D"_blank">138.68.26.173:33194</a> SIGTERM[soft,port-share-redirect] r=
eceived, client-instance exiting&#39;<br>2024-11-19T00:20:44+1100 [stdout#i=
nfo] [OVPN 0] OUT: &#39;2024-11-18 13:20:44 Note: OpenSSL hardware crypto e=
ngine functionality is not available&#39;<br>2024-11-19T00:20:44+1100 [stdo=
ut#info] [OVPN 0] OUT: &#39;2024-11-18 13:20:44 TCP connection established =
with [AF_INET]<a href=3D"http://172.206.143.215:60360" target=3D"_blank">17=
2.206.143.215:60360</a>&#39;<br>2024-11-19T00:20:44+1100 [stdout#info] [OVP=
N 0] OUT: &#39;2024-11-18 13:20:44 Socket flags: TCP_NODELAY=3D1 succeeded&=
#39;<br>2024-11-19T00:20:44+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-1=
8 13:20:44 <a href=3D"http://172.206.143.215:60360" target=3D"_blank">172.2=
06.143.215:60360</a> Non-OpenVPN client protocol detected&#39;<br>2024-11-1=
9T00:20:44+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:20:44 <a hre=
f=3D"http://172.206.143.215:60360" target=3D"_blank">172.206.143.215:60360<=
/a> SIGTERM[soft,port-share-redirect] received, client-instance exiting&#39=
;<br>2024-11-19T00:20:46+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 1=
3:20:46 Note: OpenSSL hardware crypto engine functionality is not available=
&#39;<br>2024-11-19T00:20:46+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-=
18 13:20:46 TCP connection established with [AF_INET]<a href=3D"http://172.=
206.143.215:60368" target=3D"_blank">172.206.143.215:60368</a>&#39;<br>2024=
-11-19T00:20:46+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:20:46 S=
ocket flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-19T00:20:46+1100 [st=
dout#info] [OVPN 0] OUT: &#39;2024-11-18 13:20:46 <a href=3D"http://172.206=
.143.215:60368" target=3D"_blank">172.206.143.215:60368</a> Non-OpenVPN cli=
ent protocol detected&#39;<br>2024-11-19T00:20:46+1100 [stdout#info] [OVPN =
0] OUT: &#39;2024-11-18 13:20:46 <a href=3D"http://172.206.143.215:60368" t=
arget=3D"_blank">172.206.143.215:60368</a> SIGTERM[soft,port-share-redirect=
] received, client-instance exiting&#39;<br>2024-11-19T00:20:47+1100 [stdou=
t#info] [OVPN 0] OUT: &#39;2024-11-18 13:20:47 Note: OpenSSL hardware crypt=
o engine functionality is not available&#39;<br>2024-11-19T00:20:47+1100 [s=
tdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:20:47 TCP connection establish=
ed with [AF_INET]<a href=3D"http://172.206.143.215:46430" target=3D"_blank"=
>172.206.143.215:46430</a>&#39;<br>2024-11-19T00:20:47+1100 [stdout#info] [=
OVPN 0] OUT: &#39;2024-11-18 13:20:47 Socket flags: TCP_NODELAY=3D1 succeed=
ed&#39;<br>2024-11-19T00:20:47+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-1=
1-18 13:20:47 <a href=3D"http://172.206.143.215:46430" target=3D"_blank">17=
2.206.143.215:46430</a> Non-OpenVPN client protocol detected&#39;<br>2024-1=
1-19T00:20:47+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:20:47 <a =
href=3D"http://172.206.143.215:46430" target=3D"_blank">172.206.143.215:464=
30</a> SIGTERM[soft,port-share-redirect] received, client-instance exiting&=
#39;<br>2024-11-19T00:20:48+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-1=
8 13:20:48 Note: OpenSSL hardware crypto engine functionality is not availa=
ble&#39;<br>2024-11-19T00:20:48+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-=
11-18 13:20:48 TCP connection established with [AF_INET]<a href=3D"http://1=
72.206.143.215:46436" target=3D"_blank">172.206.143.215:46436</a>&#39;<br>2=
024-11-19T00:20:48+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:20:4=
8 Socket flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-19T00:20:48+1100 =
[stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:20:48 <a href=3D"http://172.=
206.143.215:46436" target=3D"_blank">172.206.143.215:46436</a> Non-OpenVPN =
client protocol detected&#39;<br>2024-11-19T00:20:48+1100 [stdout#info] [OV=
PN 0] OUT: &#39;2024-11-18 13:20:48 <a href=3D"http://172.206.143.215:46436=
" target=3D"_blank">172.206.143.215:46436</a> SIGTERM[soft,port-share-redir=
ect] received, client-instance exiting&#39;<br>2024-11-19T00:20:49+1100 [st=
dout#info] [OVPN 0] OUT: &#39;2024-11-18 13:20:49 Note: OpenSSL hardware cr=
ypto engine functionality is not available&#39;<br>2024-11-19T00:20:49+1100=
 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:20:49 TCP connection establ=
ished with [AF_INET]<a href=3D"http://172.206.143.215:46440" target=3D"_bla=
nk">172.206.143.215:46440</a>&#39;<br>2024-11-19T00:20:49+1100 [stdout#info=
] [OVPN 0] OUT: &#39;2024-11-18 13:20:49 Socket flags: TCP_NODELAY=3D1 succ=
eeded&#39;<br>2024-11-19T00:20:49+1100 [stdout#info] [OVPN 0] OUT: &#39;202=
4-11-18 13:20:49 <a href=3D"http://172.206.143.215:46440" target=3D"_blank"=
>172.206.143.215:46440</a> Non-OpenVPN client protocol detected&#39;<br>202=
4-11-19T00:20:49+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:20:49 =
<a href=3D"http://172.206.143.215:46440" target=3D"_blank">172.206.143.215:=
46440</a> SIGTERM[soft,port-share-redirect] received, client-instance exiti=
ng&#39;<br>2024-11-19T00:20:49+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-1=
1-18 13:20:49 Note: OpenSSL hardware crypto engine functionality is not ava=
ilable&#39;<br>2024-11-19T00:20:49+1100 [stdout#info] [OVPN 0] OUT: &#39;20=
24-11-18 13:20:49 TCP connection established with [AF_INET]<a href=3D"http:=
//172.206.143.215:46450" target=3D"_blank">172.206.143.215:46450</a>&#39;<b=
r>2024-11-19T00:20:49+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:2=
0:49 Socket flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-19T00:20:49+11=
00 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:20:49 <a href=3D"http://1=
72.206.143.215:46450" target=3D"_blank">172.206.143.215:46450</a> Non-OpenV=
PN client protocol detected&#39;<br>2024-11-19T00:20:49+1100 [stdout#info] =
[OVPN 0] OUT: &#39;2024-11-18 13:20:49 <a href=3D"http://172.206.143.215:46=
450" target=3D"_blank">172.206.143.215:46450</a> SIGTERM[soft,port-share-re=
direct] received, client-instance exiting&#39;<br>2024-11-19T00:20:49+1100 =
[stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:20:49 Note: OpenSSL hardware=
 crypto engine functionality is not available&#39;<br>2024-11-19T00:20:49+1=
100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:20:49 TCP connection est=
ablished with [AF_INET]<a href=3D"http://172.206.143.215:46456" target=3D"_=
blank">172.206.143.215:46456</a>&#39;<br>2024-11-19T00:20:49+1100 [stdout#i=
nfo] [OVPN 0] OUT: &#39;2024-11-18 13:20:49 Socket flags: TCP_NODELAY=3D1 s=
ucceeded&#39;<br>2024-11-19T00:20:49+1100 [stdout#info] [OVPN 0] OUT: &#39;=
2024-11-18 13:20:49 <a href=3D"http://172.206.143.215:46456" target=3D"_bla=
nk">172.206.143.215:46456</a> Non-OpenVPN client protocol detected&#39;<br>=
2024-11-19T00:20:49+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:20:=
49 <a href=3D"http://172.206.143.215:46456" target=3D"_blank">172.206.143.2=
15:46456</a> SIGTERM[soft,port-share-redirect] received, client-instance ex=
iting&#39;<br>2024-11-19T00:20:51+1100 [stdout#info] [OVPN 0] OUT: &#39;202=
4-11-18 13:20:51 Note: OpenSSL hardware crypto engine functionality is not =
available&#39;<br>2024-11-19T00:20:51+1100 [stdout#info] [OVPN 0] OUT: &#39=
;2024-11-18 13:20:51 TCP connection established with [AF_INET]<a href=3D"ht=
tp://172.206.143.215:46462" target=3D"_blank">172.206.143.215:46462</a>&#39=
;<br>2024-11-19T00:20:51+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 1=
3:20:51 Socket flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-19T00:20:51=
+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:20:51 <a href=3D"http:=
//172.206.143.215:46462" target=3D"_blank">172.206.143.215:46462</a> Non-Op=
enVPN client protocol detected&#39;<br>2024-11-19T00:20:51+1100 [stdout#inf=
o] [OVPN 0] OUT: &#39;2024-11-18 13:20:51 <a href=3D"http://172.206.143.215=
:46462" target=3D"_blank">172.206.143.215:46462</a> SIGTERM[soft,port-share=
-redirect] received, client-instance exiting&#39;<br>2024-11-19T00:20:52+11=
00 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:20:52 Note: OpenSSL hardw=
are crypto engine functionality is not available&#39;<br>2024-11-19T00:20:5=
2+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:20:52 TCP connection =
established with [AF_INET]<a href=3D"http://172.206.143.215:46476" target=
=3D"_blank">172.206.143.215:46476</a>&#39;<br>2024-11-19T00:20:52+1100 [std=
out#info] [OVPN 0] OUT: &#39;2024-11-18 13:20:52 Socket flags: TCP_NODELAY=
=3D1 succeeded&#39;<br>2024-11-19T00:20:52+1100 [stdout#info] [OVPN 0] OUT:=
 &#39;2024-11-18 13:20:52 <a href=3D"http://172.206.143.215:46476" target=
=3D"_blank">172.206.143.215:46476</a> Non-OpenVPN client protocol detected&=
#39;<br>2024-11-19T00:20:52+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-1=
8 13:20:52 <a href=3D"http://172.206.143.215:46476" target=3D"_blank">172.2=
06.143.215:46476</a> SIGTERM[soft,port-share-redirect] received, client-ins=
tance exiting&#39;<br>2024-11-19T00:20:52+1100 [stdout#info] [OVPN 0] OUT: =
&#39;2024-11-18 13:20:52 Note: OpenSSL hardware crypto engine functionality=
 is not available&#39;<br>2024-11-19T00:20:52+1100 [stdout#info] [OVPN 0] O=
UT: &#39;2024-11-18 13:20:52 TCP connection established with [AF_INET]<a hr=
ef=3D"http://172.206.143.215:46484" target=3D"_blank">172.206.143.215:46484=
</a>&#39;<br>2024-11-19T00:20:52+1100 [stdout#info] [OVPN 0] OUT: &#39;2024=
-11-18 13:20:52 Socket flags: TCP_NODELAY=3D1 succeeded&#39;<br>2024-11-19T=
00:20:52+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:20:52 <a href=
=3D"http://172.206.143.215:46484" target=3D"_blank">172.206.143.215:46484</=
a> Non-OpenVPN client protocol detected&#39;<br>2024-11-19T00:20:52+1100 [s=
tdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:20:52 <a href=3D"http://172.20=
6.143.215:46484" target=3D"_blank">172.206.143.215:46484</a> SIGTERM[soft,p=
ort-share-redirect] received, client-instance exiting&#39;<br>2024-11-19T00=
:51:52+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:51:52 Note: Open=
SSL hardware crypto engine functionality is not available&#39;<br>2024-11-1=
9T00:51:52+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:51:52 TCP co=
nnection established with [AF_INET]<a href=3D"http://51.158.169.40:32931" t=
arget=3D"_blank">51.158.169.40:32931</a>&#39;<br>2024-11-19T00:51:52+1100 [=
stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:51:52 Socket flags: TCP_NODEL=
AY=3D1 succeeded&#39;<br>2024-11-19T00:51:52+1100 [stdout#info] [OVPN 0] OU=
T: &#39;2024-11-18 13:51:52 <a href=3D"http://51.158.169.40:32931" target=
=3D"_blank">51.158.169.40:32931</a> Non-OpenVPN client protocol detected&#3=
9;<br>2024-11-19T00:51:52+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 =
13:51:52 <a href=3D"http://51.158.169.40:32931" target=3D"_blank">51.158.16=
9.40:32931</a> SIGTERM[soft,port-share-redirect] received, client-instance =
exiting&#39;<br>2024-11-19T00:54:27+1100 [stdout#info] [OVPN 1] OUT: &quot;=
2024-11-18 13:54:27 MANAGEMENT: CMD &#39;exit&#39;&quot;<br>2024-11-19T00:5=
4:27+1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11-18 13:54:27 MANAGEMENT: =
Client disconnected&#39;<br>2024-11-19T00:54:27+1100 [stdout#info] [OVPN 1]=
 OUT: &#39;2024-11-18 13:54:27 MANAGEMENT: Triggering management exit&#39;<=
br>2024-11-19T00:54:27+1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11-18 13:=
54:27 Closing TUN/TAP interface&#39;<br>2024-11-19T00:54:27+1100 [stdout#in=
fo] [OVPN 1] OUT: &#39;2024-11-18 13:54:27 net_addr_v4_del: 172.27.232.1 de=
v as0t1&#39;<br>2024-11-19T00:54:27+1100 [stdout#info] OMI Cancel pending d=
eferred [&#39;exit&#39;]<br>2024-11-19T00:54:27+1100 [stdout#info] [OVPN 1]=
 OUT: &#39;2024-11-18 13:54:27 SIGTERM[soft,management-exit] received, proc=
ess exiting&#39;<br>2024-11-19T00:54:27+1100 [stdout#info] [OVPN 1] OUT: &#=
39;2024-11-18 13:54:27 MANAGEMENT: &gt;STATE:1731938067,EXITING,management-=
exit,,,,,&#39;<br>2024-11-19T00:54:27+1100 [stdout#info] [OVPN 0] OUT: &quo=
t;2024-11-18 13:54:27 MANAGEMENT: CMD &#39;exit&#39;&quot;<br>2024-11-19T00=
:54:27+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:54:27 MANAGEMENT=
: Client disconnected&#39;<br>2024-11-19T00:54:27+1100 [stdout#info] [OVPN =
0] OUT: &#39;2024-11-18 13:54:27 MANAGEMENT: Triggering management exit&#39=
;<br>2024-11-19T00:54:27+1100 [stdout#info] OMI Cancel pending deferred [&#=
39;exit&#39;]<br>2024-11-19T00:54:27+1100 [stdout#info] [OVPN 0] OUT: &#39;=
2024-11-18 13:54:27 Closing TUN/TAP interface&#39;<br>2024-11-19T00:54:27+1=
100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:54:27 net_addr_v4_del: 1=
72.27.224.1 dev as0t0&#39;<br>2024-11-19T00:54:27+1100 [stdout#info] [OVPN =
0] OUT: &#39;2024-11-18 13:54:27 SIGTERM[soft,management-exit] received, pr=
ocess exiting&#39;<br>2024-11-19T00:54:27+1100 [stdout#info] [OVPN 0] OUT: =
&#39;2024-11-18 13:54:27 MANAGEMENT: &gt;STATE:1731938067,EXITING,managemen=
t-exit,,,,,&#39;<br>2024-11-19T00:54:27+1100 [stdout#info] [OVPN 0] OUT: &#=
39;2024-11-18 13:54:27 PORT SHARE PROXY: proxy exiting&#39;<br>2024-11-19T0=
0:54:27+1100 [stdout#info] PROC RESTORE /proc/sys/net/ipv4/ip_forward -&gt;=
 b&#39;0&#39;<br>2024-11-19T00:54:27+1100 [stdout#info] PROC RESTORE /proc/=
sys/net/netfilter/nf_conntrack_tcp_be_liberal -&gt; b&#39;0&#39;<br>2024-11=
-19T00:54:27+1100 [stdout#info] WEB: Sending SIGTERM to pid 862<br>2024-11-=
19T00:54:27+1100 [stdout#info] [WEB] OUT: &#39;2024-11-19T00:54:27+1100 [-]=
 Received SIGTERM, shutting down.&#39;<br>2024-11-19T00:54:27+1100 [stdout#=
info] [WEB] OUT: &#39;2024-11-19T00:54:27+1100 [-] (TLS Port 909 Closed)&#3=
9;<br>2024-11-19T00:54:27+1100 [stdout#info] [WEB] OUT: &#39;2024-11-19T00:=
54:27+1100 [-] (TLS Port 908 Closed)&#39;<br>2024-11-19T00:54:27+1100 [stdo=
ut#info] [WEB] OUT: &#39;2024-11-19T00:54:27+1100 [-] (TLS Port 907 Closed)=
&#39;<br>2024-11-19T00:54:27+1100 [stdout#info] [WEB] OUT: &#39;2024-11-19T=
00:54:27+1100 [-] (TLS Port 906 Closed)&#39;<br>2024-11-19T00:54:27+1100 [s=
tdout#info] [WEB] OUT: &#39;2024-11-19T00:54:27+1100 [-] (TLS Port 905 Clos=
ed)&#39;<br>2024-11-19T00:54:27+1100 [stdout#info] [WEB] OUT: &#39;2024-11-=
19T00:54:27+1100 [-] (TLS Port 904 Closed)&#39;<br>2024-11-19T00:54:27+1100=
 [stdout#info] [WEB] OUT: &#39;2024-11-19T00:54:27+1100 [-] (TLS Port 943 C=
losed)&#39;<br>2024-11-19T00:54:27+1100 [stdout#info] [WEB] OUT: &#39;2024-=
11-19T00:54:27+1100 [-] Main loop terminated.&#39;<br>2024-11-19T00:54:27+1=
100 [stdout#info] [WEB] OUT: &#39;2024-11-19T00:54:27+1100 [-] Warning: No =
permission to delete pid file&#39;<br>2024-11-19T00:54:27+1100 [stdout#info=
] [WEB] OUT: &#39;2024-11-19T00:54:27+1100 [twisted.scripts._twistd_unix.Un=
ixAppLogger#info] Server Shut Down.&#39;<br>2024-11-19T00:54:27+1100 [stdou=
t#info] Server Agent shutting down, stop status: {&#39;errors&#39;: {}, &#3=
9;service_status&#39;: {&#39;api&#39;: &#39;off. Error: [None]&#39;, &#39;a=
uth&#39;: &#39;off. Error: [None]&#39;, &#39;daemon_pre&#39;: &#39;off. Err=
or: [None]&#39;, &#39;bridge&#39;: &#39;off. Error: [None]&#39;, &#39;db_pu=
sh&#39;: &#39;off. Error: [None]&#39;, &#39;web&#39;: &#39;off. Error: [Non=
e]&#39;, &#39;log&#39;: &#39;off. Error: [None]&#39;, &#39;client_query&#39=
;: &#39;off. Error: [None]&#39;, &#39;iptables_api&#39;: &#39;off. Error: [=
None]&#39;, &#39;iptables_web&#39;: &#39;off. Error: [None]&#39;, &#39;ipta=
bles_openvpn&#39;: &#39;off. Error: [None]&#39;, &#39;ip6tables_openvpn&#39=
;: &#39;off. Error: [None]&#39;, &#39;ip6tables_live&#39;: &#39;off. Error:=
 [None]&#39;, &#39;iptables_live&#39;: &#39;off. Error: [None]&#39;, &#39;u=
ser&#39;: &#39;off. Error: [None]&#39;, &#39;openvpn_0&#39;: &#39;off. Erro=
r: [None]&#39;, &#39;crl&#39;: &#39;off. Error: [None]&#39;, &#39;subscript=
ion&#39;: &#39;off. Error: [None]&#39;, &#39;openvpn_1&#39;: &#39;off. Erro=
r: [None]&#39;}, &#39;last_restarted&#39;: &#39;Thu Nov 14 22:40:15 2024&#3=
9;}<br>2024-11-19T00:54:27+1100 [-] Received SIGTERM, shutting down.<br>202=
4-11-19T00:54:27+1100 [twisted.scripts._twistd_unix.UnixAppLogger#info] Ser=
ver Shut Down.<br>2024-11-19T00:55:11+1100 [twisted.scripts._twistd_unix.Un=
ixAppLogger#info] twistd 22.4.0 (/usr/bin/python3 3.12.3) starting up.<br>2=
024-11-19T00:55:11+1100 [twisted.scripts._twistd_unix.UnixAppLogger#info] r=
eactor class: twisted.internet.asyncioreactor.AsyncioSelectorReactor.<br>20=
24-11-19T00:55:11+1100 [stdout#info] check_if_upgrade_needed: path_to_db - =
=C2=A0sqlite:////usr/local/openvpn_as/etc/db/config.db<br>2024-11-19T00:55:=
11+1100 [stdout#info] check_for_upgrade: initial version [2.14.1], current =
- [2.14.1], value of current version in DB: [2.14.1]<br>2024-11-19T00:55:11=
+1100 [stdout#info] rmdir /usr/local/openvpn_as/etc/db_push<br>2024-11-19T0=
0:55:11+1100 [stdout#info] ACCESS SERVER starting, version=3D2.14.1, build=
=3Dff013d4d<br>2024-11-19T00:55:11+1100 [stdout#info] Max open files set to=
 (4096, 4096)<br>2024-11-19T00:55:12+1100 [-] /run/systemd/resolve/resolv.c=
onf changed, reparsing<br>2024-11-19T00:55:12+1100 [-] Resolver added (&#39=
;8.8.8.8&#39;, 53) to server list<br>2024-11-19T00:55:12+1100 [-] Resolver =
added (&#39;8.8.4.4&#39;, 53) to server list<br>2024-11-19T00:55:12+1100 [-=
] Received SIGTERM, shutting down.<br>2024-11-19T00:55:12+1100 [twisted.web=
.client._HTTP11ClientFactory#info] Starting factory _HTTP11ClientFactory(&l=
t;function HTTPConnectionPool._newConnection.&lt;locals&gt;.quiescentCallba=
ck at 0x708231886de0&gt;, &lt;twisted.internet.endpoints.TCP4ClientEndpoint=
 object at 0x70823187dca0&gt;)<br>2024-11-19T00:55:12+1100 [-] CurrentTimeS=
ite starting on &#39;/usr/local/openvpn_as/etc/sock/sagent&#39;<br>2024-11-=
19T00:55:12+1100 [pyovpn.web.twisted.site.CurrentTimeSite#info] Starting fa=
ctory &lt;pyovpn.web.twisted.site.CurrentTimeSite object at 0x70822e91c200&=
gt;<br>2024-11-19T00:55:12+1100 [-] CurrentTimeSite starting on &#39;/usr/l=
ocal/openvpn_as/etc/sock/sagent.localroot&#39;<br>2024-11-19T00:55:12+1100 =
[pyovpn.web.twisted.site.CurrentTimeSite#info] Starting factory &lt;pyovpn.=
web.twisted.site.CurrentTimeSite object at 0x70823187d1f0&gt;<br>2024-11-19=
T00:55:12+1100 [-] CurrentTimeSite starting on &#39;/usr/local/openvpn_as/e=
tc/sock/sagent.api&#39;<br>2024-11-19T00:55:12+1100 [pyovpn.web.twisted.sit=
e.CurrentTimeSite#info] Starting factory &lt;pyovpn.web.twisted.site.Curren=
tTimeSite object at 0x70822e91c5c0&gt;<br>2024-11-19T00:55:12+1100 [twisted=
.web.client._HTTP11ClientFactory#info] Stopping factory _HTTP11ClientFactor=
y(&lt;function HTTPConnectionPool._newConnection.&lt;locals&gt;.quiescentCa=
llback at 0x708231886de0&gt;, &lt;twisted.internet.endpoints.TCP4ClientEndp=
oint object at 0x70823187dca0&gt;)<br>2024-11-19T00:55:13+1100 [stdout#info=
] OpenVPNDataDir: using shared dir: &#39;/run/openvpn_as/tmp&#39;<br>2024-1=
1-19T00:55:13+1100 [stdout#info] OpenVPNDataDir: using shared dir: &#39;/ru=
n/openvpn_as/dev&#39;<br>2024-11-19T00:55:13+1100 [stdout#info] /bin/mknod =
-m 0666 /run/openvpn_as/dev/null c 1 3<br>2024-11-19T00:55:13+1100 [stdout#=
info] OpenVPNDataDir: using shared dir: &#39;/run/openvpn_as/pso&#39;<br>20=
24-11-19T00:55:13+1100 [stdout#info] /bin/mknod -m 0666 /run/openvpn_as/dev=
/random c 1 8<br>2024-11-19T00:55:13+1100 [-] (UNIX Port /usr/local/openvpn=
_as/etc/sock/sagent.api Closed)<br>2024-11-19T00:55:13+1100 [pyovpn.web.twi=
sted.site.CurrentTimeSite#info] Stopping factory &lt;pyovpn.web.twisted.sit=
e.CurrentTimeSite object at 0x70822e91c5c0&gt;<br>2024-11-19T00:55:13+1100 =
[-] (UNIX Port /usr/local/openvpn_as/etc/sock/sagent.localroot Closed)<br>2=
024-11-19T00:55:13+1100 [pyovpn.web.twisted.site.CurrentTimeSite#info] Stop=
ping factory &lt;pyovpn.web.twisted.site.CurrentTimeSite object at 0x708231=
87d1f0&gt;<br>2024-11-19T00:55:13+1100 [-] (UNIX Port /usr/local/openvpn_as=
/etc/sock/sagent Closed)<br>2024-11-19T00:55:13+1100 [pyovpn.web.twisted.si=
te.CurrentTimeSite#info] Stopping factory &lt;pyovpn.web.twisted.site.Curre=
ntTimeSite object at 0x70822e91c200&gt;<br>2024-11-19T00:55:13+1100 [stdout=
#info] LOG: Sending SIGTERM to pid 1108<br>2024-11-19T00:55:13+1100 [stdout=
#info] WEB: Sending SIGTERM to pid 1107<br>2024-11-19T00:55:13+1100 [twiste=
d.scripts._twistd_unix.UnixAppLogger#info] Server Shut Down.<br>2024-11-19T=
00:55:57+1100 [twisted.scripts._twistd_unix.UnixAppLogger#info] twistd 22.4=
.0 (/usr/bin/python3 3.12.3) starting up.<br>2024-11-19T00:55:57+1100 [twis=
ted.scripts._twistd_unix.UnixAppLogger#info] reactor class: twisted.interne=
t.asyncioreactor.AsyncioSelectorReactor.<br>2024-11-19T00:55:57+1100 [stdou=
t#info] check_if_upgrade_needed: path_to_db - =C2=A0sqlite:////usr/local/op=
envpn_as/etc/db/config.db<br>2024-11-19T00:55:57+1100 [stdout#info] check_f=
or_upgrade: initial version [2.14.1], current - [2.14.1], value of current =
version in DB: [2.14.1]<br>2024-11-19T00:55:57+1100 [stdout#info] rmdir /us=
r/local/openvpn_as/etc/db_push<br>2024-11-19T00:55:57+1100 [stdout#info] AC=
CESS SERVER starting, version=3D2.14.1, build=3Dff013d4d<br>2024-11-19T00:5=
5:57+1100 [stdout#info] Max open files set to (4096, 4096)<br>2024-11-19T00=
:55:57+1100 [-] /run/systemd/resolve/resolv.conf changed, reparsing<br>2024=
-11-19T00:55:57+1100 [-] Resolver added (&#39;8.8.8.8&#39;, 53) to server l=
ist<br>2024-11-19T00:55:57+1100 [-] Resolver added (&#39;8.8.4.4&#39;, 53) =
to server list<br>2024-11-19T00:55:57+1100 [twisted.web.client._HTTP11Clien=
tFactory#info] Starting factory _HTTP11ClientFactory(&lt;function HTTPConne=
ctionPool._newConnection.&lt;locals&gt;.quiescentCallback at 0x72b8d5276d40=
&gt;, &lt;twisted.internet.endpoints.TCP4ClientEndpoint object at 0x72b8d52=
6d910&gt;)<br>2024-11-19T00:55:57+1100 [-] CurrentTimeSite starting on &#39=
;/usr/local/openvpn_as/etc/sock/sagent&#39;<br>2024-11-19T00:55:57+1100 [py=
ovpn.web.twisted.site.CurrentTimeSite#info] Starting factory &lt;pyovpn.web=
.twisted.site.CurrentTimeSite object at 0x72b8d22e5310&gt;<br>2024-11-19T00=
:55:57+1100 [-] CurrentTimeSite starting on &#39;/usr/local/openvpn_as/etc/=
sock/sagent.localroot&#39;<br>2024-11-19T00:55:57+1100 [pyovpn.web.twisted.=
site.CurrentTimeSite#info] Starting factory &lt;pyovpn.web.twisted.site.Cur=
rentTimeSite object at 0x72b8d24b5a00&gt;<br>2024-11-19T00:55:57+1100 [-] C=
urrentTimeSite starting on &#39;/usr/local/openvpn_as/etc/sock/sagent.api&#=
39;<br>2024-11-19T00:55:57+1100 [pyovpn.web.twisted.site.CurrentTimeSite#in=
fo] Starting factory &lt;pyovpn.web.twisted.site.CurrentTimeSite object at =
0x72b8d2607a10&gt;<br>2024-11-19T00:55:57+1100 [stdout#info] OpenVPNDataDir=
: using shared dir: &#39;/run/openvpn_as/tmp&#39;<br>2024-11-19T00:55:57+11=
00 [stdout#info] OpenVPNDataDir: using shared dir: &#39;/run/openvpn_as/dev=
&#39;<br>2024-11-19T00:55:57+1100 [stdout#info] /bin/mknod -m 0666 /run/ope=
nvpn_as/dev/null c 1 3<br>2024-11-19T00:55:57+1100 [stdout#info] OpenVPNDat=
aDir: using shared dir: &#39;/run/openvpn_as/pso&#39;<br>2024-11-19T00:55:5=
7+1100 [stdout#info] /bin/mknod -m 0666 /run/openvpn_as/dev/random c 1 8<br=
>2024-11-19T00:55:57+1100 [stdout#info] /bin/mknod -m 0444 /run/openvpn_as/=
dev/urandom c 1 9<br>2024-11-19T00:55:58+1100 [stdout#info] [WEB] OUT: &#39=
;Content-type .eot is not found. Using the default application/octect-strea=
m&#39;<br>2024-11-19T00:55:58+1100 [stdout#info] [WEB] OUT: &#39;Content-ty=
pe .eot is not found. Using the default application/octect-stream&#39;<br>2=
024-11-19T00:55:58+1100 [twisted.web.client._HTTP11ClientFactory#info] Stop=
ping factory _HTTP11ClientFactory(&lt;function HTTPConnectionPool._newConne=
ction.&lt;locals&gt;.quiescentCallback at 0x72b8d5276d40&gt;, &lt;twisted.i=
nternet.endpoints.TCP4ClientEndpoint object at 0x72b8d526d910&gt;)<br>2024-=
11-19T00:55:59+1100 [stdout#info] [WEB] OUT: &#39;WSERV admin+client+xmlrpc=
 0.0.0.0 943&#39;<br>2024-11-19T00:55:59+1100 [stdout#info] [WEB] OUT: &#39=
;WSERV admin+client 127.0.0.1 904&#39;<br>2024-11-19T00:55:59+1100 [stdout#=
info] [WEB] OUT: &#39;WSERV admin 127.0.0.1 905&#39;<br>2024-11-19T00:55:59=
+1100 [stdout#info] [WEB] OUT: &#39;WSERV client 127.0.0.1 906&#39;<br>2024=
-11-19T00:55:59+1100 [stdout#info] [WEB] OUT: &#39;WSERV xmlrpc 127.0.0.1 9=
07&#39;<br>2024-11-19T00:55:59+1100 [stdout#info] [WEB] OUT: &#39;WSERV adm=
in+client+xmlrpc 127.0.0.1 908&#39;<br>2024-11-19T00:55:59+1100 [stdout#inf=
o] [WEB] OUT: &#39;WSERV client+xmlrpc 127.0.0.1 909&#39;<br>2024-11-19T00:=
55:59+1100 [stdout#info] [WEB] OUT: &#39;2024-11-19T00:55:59+1100 [twisted.=
scripts._twistd_unix.UnixAppLogger#info] twistd 22.4.0 (/usr/bin/python3 3.=
12.3) starting up.&#39;<br>2024-11-19T00:55:59+1100 [stdout#info] [WEB] OUT=
: &#39;2024-11-19T00:55:59+1100 [twisted.scripts._twistd_unix.UnixAppLogger=
#info] reactor class: twisted.internet.epollreactor.EPollReactor.&#39;<br>2=
024-11-19T00:55:59+1100 [stdout#info] [WEB] OUT: &#39;2024-11-19T00:55:59+1=
100 [-] ASWebSite (TLS) starting on 943&#39;<br>2024-11-19T00:55:59+1100 [s=
tdout#info] [WEB] OUT: &#39;2024-11-19T00:55:59+1100 [-] ASWebSite (TLS) st=
arting on 904&#39;<br>2024-11-19T00:55:59+1100 [stdout#info] [WEB] OUT: &#3=
9;2024-11-19T00:55:59+1100 [-] ASWebSite (TLS) starting on 905&#39;<br>2024=
-11-19T00:55:59+1100 [stdout#info] [WEB] OUT: &#39;2024-11-19T00:55:59+1100=
 [-] ASWebSite (TLS) starting on 906&#39;<br>2024-11-19T00:55:59+1100 [stdo=
ut#info] [WEB] OUT: &#39;2024-11-19T00:55:59+1100 [-] ASWebSite (TLS) start=
ing on 907&#39;<br>2024-11-19T00:55:59+1100 [stdout#info] [WEB] OUT: &#39;2=
024-11-19T00:55:59+1100 [-] ASWebSite (TLS) starting on 908&#39;<br>2024-11=
-19T00:55:59+1100 [stdout#info] [WEB] OUT: &#39;2024-11-19T00:55:59+1100 [-=
] ASWebSite (TLS) starting on 909&#39;<br>2024-11-19T00:55:59+1100 [stdout#=
info] [WEB] OUT: &#39;2024-11-19T00:55:59+1100 [-] set uid/gid 1001/1001&#3=
9;<br>2024-11-19T00:55:59+1100 [stdout#info] [WEB] OUT: &#39;2024-11-19T00:=
55:59+1100 [stdout#info] Web server running as UID 1001&#39;<br>2024-11-19T=
00:55:59+1100 [stdout#info] PROC SET /proc/sys/net/ipv4/ip_forward : b&#39;=
0&#39; -&gt; 1<br>2024-11-19T00:55:59+1100 [stdout#info] PROC SET /proc/sys=
/net/netfilter/nf_conntrack_tcp_be_liberal : b&#39;0&#39; -&gt; 1<br>2024-1=
1-19T00:56:00+1100 [stdout#info] License Info {&#39;concurrent_connections&=
#39;: 2, &#39;apc&#39;: False}<br>2024-11-19T00:56:00+1100 [-] OMIServerAut=
hFactory starting on &#39;/usr/local/openvpn_as/etc/sock/omisock-Kk5zKaR0ZB=
7L&#39;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: &quot;2024-=
11-19 00:56:00 DEPRECATED OPTION: --cipher set to &#39;AES-256-CBC&#39; but=
 missing in --data-ciphers (AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305). Ope=
nVPN ignores --cipher for cipher negotiations. &quot;<br>2024-11-19T00:56:0=
0+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-19 00:56:00 WARNING: POTENT=
IALLY DANGEROUS OPTION --verify-client-cert none|optional may accept client=
s which do not present a certificate&#39;<br>2024-11-19T00:56:00+1100 [stdo=
ut#info] [OVPN 0] OUT: &#39;2024-11-19 00:56:00 OpenVPN 2.6.12 x86_64-pc-li=
nux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] [DCO]&#39;<=
br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-19 00:=
56:00 library versions: OpenSSL 3.0.13 30 Jan 2024, LZO 2.10&#39;<br>2024-1=
1-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-19 00:56:00 DCO=
 version: N/A&#39;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: =
&#39;2024-11-19 00:56:00 MANAGEMENT: client_uid=3D0&#39;<br>2024-11-19T00:5=
6:00+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-19 00:56:00 MANAGEMENT: =
Connected to management server at /usr/local/openvpn_as/etc/sock/omisock-Kk=
5zKaR0ZB7L&#39;<br>2024-11-19T00:56:00+1100 [-] (UNIX Port /usr/local/openv=
pn_as/etc/sock/omisock-Kk5zKaR0ZB7L Closed)<br>2024-11-19T00:56:00+1100 [st=
dout#info] [OVPN 0] OUT: &quot;2024-11-19 00:56:00 MANAGEMENT: CMD &#39;sta=
te on&#39;&quot;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: &q=
uot;2024-11-19 00:56:00 MANAGEMENT: CMD &#39;echo on&#39;&quot;<br>2024-11-=
19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: &quot;2024-11-19 00:56:00 MANA=
GEMENT: CMD &#39;bytecount 300&#39;&quot;<br>2024-11-19T00:56:00+1100 [stdo=
ut#info] [OVPN 0] OUT: &quot;2024-11-19 00:56:00 MANAGEMENT: CMD &#39;env-f=
ilter 1&#39;&quot;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: =
&quot;2024-11-19 00:56:00 MANAGEMENT: CMD &#39;hold off&#39;&quot;<br>2024-=
11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: &quot;2024-11-19 00:56:00 M=
ANAGEMENT: CMD &#39;hold release&#39;&quot;<br>2024-11-19T00:56:00+1100 [st=
dout#info] [OVPN 0] OUT: &#39;2024-11-19 00:56:00 net_route_v4_best_gw quer=
y: dst 0.0.0.0&#39;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT:=
 &#39;2024-11-19 00:56:00 net_route_v4_best_gw result: via 103.6.170.254 de=
v eth0&#39;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: &#39;20=
24-11-19 00:56:00 NOTE: --fast-io is disabled since we are not using UDP&#3=
9;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-19 =
00:56:00 Note: OpenSSL hardware crypto engine functionality is not availabl=
e&#39;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11=
-19 00:56:00 Diffie-Hellman initialized with 4096 bit key&#39;<br>2024-11-1=
9T00:56:00+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-19 00:56:00 TUN/TA=
P device as0t0 opened&#39;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN =
0] OUT: &#39;2024-11-19 00:56:00 TUN/TAP TX queue length set to 200&#39;<br=
>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-19 00:56=
:00 MANAGEMENT: &gt;STATE:1731938160,ASSIGN_IP,,172.27.224.1,,,,&#39;<br>20=
24-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-19 00:56:00=
 net_iface_mtu_set: mtu 1420 for as0t0&#39;<br>2024-11-19T00:56:00+1100 [st=
dout#info] [OVPN 0] OUT: &#39;2024-11-19 00:56:00 net_iface_up: set as0t0 u=
p&#39;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11=
-19 00:56:00 net_addr_v4_add: <a href=3D"http://172.27.224.1/21" target=3D"=
_blank">172.27.224.1/21</a> dev as0t0&#39;<br>2024-11-19T00:56:00+1100 [std=
out#info] [OVPN 0] OUT: &#39;2024-11-19 00:56:00 Could not determine IPv4/I=
Pv6 protocol. Using AF_INET&#39;<br>2024-11-19T00:56:00+1100 [stdout#info] =
[OVPN 0] OUT: &#39;2024-11-19 00:56:00 Socket Buffers: R=3D[87380-&gt;87380=
] S=3D[16384-&gt;16384]&#39;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVP=
N 0] OUT: &#39;2024-11-19 00:56:00 Listening for incoming TCP connection on=
 [AF_INET][undef]:443&#39;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN =
0] OUT: &#39;2024-11-19 00:56:00 Socket flags: TCP_NODELAY=3D1 succeeded&#3=
9;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-19 =
00:56:00 TCPv4_SERVER link local (bound): [AF_INET][undef]:443&#39;<br>2024=
-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-19 00:56:00 T=
CPv4_SERVER link remote: [AF_UNSPEC]&#39;<br>2024-11-19T00:56:00+1100 [stdo=
ut#info] [OVPN 0] OUT: &quot;2024-11-18 13:56:00 chroot to &#39;/run/openvp=
n_as&#39; and cd to &#39;/&#39; succeeded&quot;<br>2024-11-19T00:56:00+1100=
 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:56:00 UID set to openvpn_as=
&#39;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-=
18 13:56:00 GID set to openvpn_as&#39;<br>2024-11-19T00:56:00+1100 [stdout#=
info] [OVPN 0] OUT: &#39;2024-11-18 13:56:00 Capabilities retained: CAP_NET=
_ADMIN&#39;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: &#39;20=
24-11-18 13:56:00 PORT SHARE PROXY: proxy starting&#39;<br>2024-11-19T00:56=
:00+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:56:00 MULTI: multi_=
init called, r=3D4096 v=3D4096&#39;<br>2024-11-19T00:56:00+1100 [stdout#inf=
o] [OVPN 0] OUT: &#39;2024-11-18 13:56:00 MULTI: TCP INIT maxclients=3D2048=
 maxevents=3D2053&#39;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 0] O=
UT: &#39;2024-11-18 13:56:00 Initialization Sequence Completed&#39;<br>2024=
-11-19T00:56:00+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 13:56:00 M=
ANAGEMENT: &gt;STATE:1731938160,CONNECTED,SUCCESS,172.27.224.1,,,,&#39;<br>=
2024-11-19T00:56:00+1100 [stdout#info] License Info {&#39;concurrent_connec=
tions&#39;: 2, &#39;apc&#39;: False}<br>2024-11-19T00:56:00+1100 [-] OMISer=
verAuthFactory starting on &#39;/usr/local/openvpn_as/etc/sock/omisock-f0B8=
AK4qFxF1&#39;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: &quot=
;2024-11-19 00:56:00 DEPRECATED OPTION: --cipher set to &#39;AES-256-CBC&#3=
9; but missing in --data-ciphers (AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305=
). OpenVPN ignores --cipher for cipher negotiations. &quot;<br>2024-11-19T0=
0:56:00+1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11-19 00:56:00 WARNING: =
POTENTIALLY DANGEROUS OPTION --verify-client-cert none|optional may accept =
clients which do not present a certificate&#39;<br>2024-11-19T00:56:00+1100=
 [stdout#info] [OVPN 1] OUT: &#39;2024-11-19 00:56:00 OpenVPN 2.6.12 x86_64=
-pc-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] [DCO]=
&#39;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11-=
19 00:56:00 library versions: OpenSSL 3.0.13 30 Jan 2024, LZO 2.10&#39;<br>=
2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11-19 00:56:=
00 DCO version: N/A&#39;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1]=
 OUT: &#39;2024-11-19 00:56:00 MANAGEMENT: client_uid=3D0&#39;<br>2024-11-1=
9T00:56:00+1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11-19 00:56:00 MANAGE=
MENT: Connected to management server at /usr/local/openvpn_as/etc/sock/omis=
ock-f0B8AK4qFxF1&#39;<br>2024-11-19T00:56:00+1100 [-] (UNIX Port /usr/local=
/openvpn_as/etc/sock/omisock-f0B8AK4qFxF1 Closed)<br>2024-11-19T00:56:00+11=
00 [stdout#info] [OVPN 1] OUT: &quot;2024-11-19 00:56:00 MANAGEMENT: CMD &#=
39;state on&#39;&quot;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] O=
UT: &quot;2024-11-19 00:56:00 MANAGEMENT: CMD &#39;echo on&#39;&quot;<br>20=
24-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: &quot;2024-11-19 00:56:0=
0 MANAGEMENT: CMD &#39;bytecount 300&#39;&quot;<br>2024-11-19T00:56:00+1100=
 [stdout#info] [OVPN 1] OUT: &quot;2024-11-19 00:56:00 MANAGEMENT: CMD &#39=
;env-filter 1&#39;&quot;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1]=
 OUT: &quot;2024-11-19 00:56:00 MANAGEMENT: CMD &#39;hold off&#39;&quot;<br=
>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: &quot;2024-11-19 00:5=
6:00 MANAGEMENT: CMD &#39;hold release&#39;&quot;<br>2024-11-19T00:56:00+11=
00 [stdout#info] [OVPN 1] OUT: &#39;2024-11-19 00:56:00 net_route_v4_best_g=
w query: dst 0.0.0.0&#39;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1=
] OUT: &#39;2024-11-19 00:56:00 net_route_v4_best_gw result: via 103.6.170.=
254 dev eth0&#39;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: &=
#39;2024-11-19 00:56:00 Note: OpenSSL hardware crypto engine functionality =
is not available&#39;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OU=
T: &#39;2024-11-19 00:56:00 Diffie-Hellman initialized with 4096 bit key&#3=
9;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11-19 =
00:56:00 TUN/TAP device as0t1 opened&#39;<br>2024-11-19T00:56:00+1100 [stdo=
ut#info] [OVPN 1] OUT: &#39;2024-11-19 00:56:00 TUN/TAP TX queue length set=
 to 200&#39;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: &#39;2=
024-11-19 00:56:00 MANAGEMENT: &gt;STATE:1731938160,ASSIGN_IP,,172.27.232.1=
,,,,&#39;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: &#39;2024=
-11-19 00:56:00 net_iface_mtu_set: mtu 1420 for as0t1&#39;<br>2024-11-19T00=
:56:00+1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11-19 00:56:00 net_iface_=
up: set as0t1 up&#39;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OU=
T: &#39;2024-11-19 00:56:00 net_addr_v4_add: <a href=3D"http://172.27.232.1=
/21" target=3D"_blank">172.27.232.1/21</a> dev as0t1&#39;<br>2024-11-19T00:=
56:00+1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11-19 00:56:00 Could not d=
etermine IPv4/IPv6 protocol. Using AF_INET&#39;<br>2024-11-19T00:56:00+1100=
 [stdout#info] [OVPN 1] OUT: &#39;2024-11-19 00:56:00 Socket Buffers: R=3D[=
212992-&gt;212992] S=3D[212992-&gt;212992]&#39;<br>2024-11-19T00:56:00+1100=
 [stdout#info] [OVPN 1] OUT: &#39;2024-11-19 00:56:00 UDPv4 link local (bou=
nd): [AF_INET][undef]:1194&#39;<br>2024-11-19T00:56:00+1100 [stdout#info] [=
OVPN 1] OUT: &#39;2024-11-19 00:56:00 UDPv4 link remote: [AF_UNSPEC]&#39;<b=
r>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: &quot;2024-11-18 13:=
56:00 chroot to &#39;/run/openvpn_as&#39; and cd to &#39;/&#39; succeeded&q=
uot;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11-1=
8 13:56:00 UID set to openvpn_as&#39;<br>2024-11-19T00:56:00+1100 [stdout#i=
nfo] [OVPN 1] OUT: &#39;2024-11-18 13:56:00 GID set to openvpn_as&#39;<br>2=
024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11-18 13:56:0=
0 Capabilities retained: CAP_NET_ADMIN&#39;<br>2024-11-19T00:56:00+1100 [st=
dout#info] [OVPN 1] OUT: &#39;2024-11-18 13:56:00 MULTI: multi_init called,=
 r=3D4096 v=3D4096&#39;<br>2024-11-19T00:56:00+1100 [stdout#info] [OVPN 1] =
OUT: &#39;2024-11-18 13:56:00 Initialization Sequence Completed&#39;<br>202=
4-11-19T00:56:00+1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11-18 13:56:00 =
MANAGEMENT: &gt;STATE:1731938160,CONNECTED,SUCCESS,172.27.232.1,,,,&#39;<br=
>2024-11-19T00:56:00+1100 [stdout#info] Server Agent initialization status:=
<br>2024-11-19T00:56:00+1100 [stdout#info] {<br>2024-11-19T00:56:00+1100 [s=
tdout#info] =C2=A0 &quot;errors&quot;: {<br>2024-11-19T00:56:00+1100 [stdou=
t#info] =C2=A0 =C2=A0 &quot;openvpn_0&quot;: [<br>2024-11-19T00:56:00+1100 =
[stdout#info] =C2=A0 =C2=A0 =C2=A0 [<br>2024-11-19T00:56:00+1100 [stdout#in=
fo] =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;info&quot;,<br>2024-11-19T00:56:00+11=
00 [stdout#info] =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;process started successf=
ully on 172.27.224.1&quot;<br>2024-11-19T00:56:00+1100 [stdout#info] =C2=A0=
 =C2=A0 =C2=A0 ]<br>2024-11-19T00:56:00+1100 [stdout#info] =C2=A0 =C2=A0 ],=
<br>2024-11-19T00:56:00+1100 [stdout#info] =C2=A0 =C2=A0 &quot;openvpn_1&qu=
ot;: [<br>2024-11-19T00:56:00+1100 [stdout#info] =C2=A0 =C2=A0 =C2=A0 [<br>=
2024-11-19T00:56:00+1100 [stdout#info] =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;in=
fo&quot;,<br>2024-11-19T00:56:00+1100 [stdout#info] =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;process started successfully on 172.27.232.1&quot;<br>2024-11-=
19T00:56:00+1100 [stdout#info] =C2=A0 =C2=A0 =C2=A0 ]<br>2024-11-19T00:56:0=
0+1100 [stdout#info] =C2=A0 =C2=A0 ]<br>2024-11-19T00:56:00+1100 [stdout#in=
fo] =C2=A0 },<br>2024-11-19T00:56:00+1100 [stdout#info] =C2=A0 &quot;last_r=
estarted&quot;: &quot;Tue Nov 19 00:55:57 2024&quot;,<br>2024-11-19T00:56:0=
0+1100 [stdout#info] =C2=A0 &quot;service_status&quot;: {<br>2024-11-19T00:=
56:00+1100 [stdout#info] =C2=A0 =C2=A0 &quot;api&quot;: &quot;started&quot;=
,<br>2024-11-19T00:56:00+1100 [stdout#info] =C2=A0 =C2=A0 &quot;auth&quot;:=
 &quot;started&quot;,<br>2024-11-19T00:56:00+1100 [stdout#info] =C2=A0 =C2=
=A0 &quot;bridge&quot;: &quot;started&quot;,<br>2024-11-19T00:56:00+1100 [s=
tdout#info] =C2=A0 =C2=A0 &quot;client_query&quot;: &quot;started&quot;,<br=
>2024-11-19T00:56:00+1100 [stdout#info] =C2=A0 =C2=A0 &quot;crl&quot;: &quo=
t;started&quot;,<br>2024-11-19T00:56:00+1100 [stdout#info] =C2=A0 =C2=A0 &q=
uot;daemon_pre&quot;: &quot;started&quot;,<br>2024-11-19T00:56:00+1100 [std=
out#info] =C2=A0 =C2=A0 &quot;db_push&quot;: &quot;started&quot;,<br>2024-1=
1-19T00:56:00+1100 [stdout#info] =C2=A0 =C2=A0 &quot;ip6tables_live&quot;: =
&quot;started&quot;,<br>2024-11-19T00:56:00+1100 [stdout#info] =C2=A0 =C2=
=A0 &quot;ip6tables_openvpn&quot;: &quot;started&quot;,<br>2024-11-19T00:56=
:00+1100 [stdout#info] =C2=A0 =C2=A0 &quot;iptables_api&quot;: &quot;starte=
d&quot;,<br>2024-11-19T00:56:00+1100 [stdout#info] =C2=A0 =C2=A0 &quot;ipta=
bles_live&quot;: &quot;started&quot;,<br>2024-11-19T00:56:00+1100 [stdout#i=
nfo] =C2=A0 =C2=A0 &quot;iptables_openvpn&quot;: &quot;started&quot;,<br>20=
24-11-19T00:56:00+1100 [stdout#info] =C2=A0 =C2=A0 &quot;iptables_web&quot;=
: &quot;started&quot;,<br>2024-11-19T00:56:00+1100 [stdout#info] =C2=A0 =C2=
=A0 &quot;log&quot;: &quot;started&quot;,<br>2024-11-19T00:56:00+1100 [stdo=
ut#info] =C2=A0 =C2=A0 &quot;openvpn_0&quot;: &quot;started&quot;,<br>2024-=
11-19T00:56:00+1100 [stdout#info] =C2=A0 =C2=A0 &quot;openvpn_1&quot;: &quo=
t;started&quot;,<br>2024-11-19T00:56:00+1100 [stdout#info] =C2=A0 =C2=A0 &q=
uot;subscription&quot;: &quot;started&quot;,<br>2024-11-19T00:56:00+1100 [s=
tdout#info] =C2=A0 =C2=A0 &quot;user&quot;: &quot;started&quot;,<br>2024-11=
-19T00:56:00+1100 [stdout#info] =C2=A0 =C2=A0 &quot;web&quot;: &quot;starte=
d&quot;<br>2024-11-19T00:56:00+1100 [stdout#info] =C2=A0 }<br>2024-11-19T00=
:56:00+1100 [stdout#info] }<br>2024-11-19T00:56:00+1100 [stdout#info] Serve=
r Agent started<br>2024-11-19T00:56:05+1100 [stdout#info] License Info {&#3=
9;concurrent_connections&#39;: 2, &#39;apc&#39;: False}<br>2024-11-19T01:03=
:16+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 14:03:16 Note: OpenSSL=
 hardware crypto engine functionality is not available&#39;<br>2024-11-19T0=
1:03:16+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18 14:03:16 TCP conne=
ction established with [AF_INET]<a href=3D"http://104.166.80.177:23432" tar=
get=3D"_blank">104.166.80.177:23432</a>&#39;<br>2024-11-19T01:03:16+1100 [s=
tdout#info] [OVPN 0] OUT: &#39;2024-11-18 14:03:16 Socket flags: TCP_NODELA=
Y=3D1 succeeded&#39;<br>2024-11-19T01:03:17+1100 [stdout#info] [OVPN 0] OUT=
: &#39;2024-11-18 14:03:17 <a href=3D"http://104.166.80.177:23432" target=
=3D"_blank">104.166.80.177:23432</a> Non-OpenVPN client protocol detected&#=
39;<br>2024-11-19T01:03:17+1100 [stdout#info] [OVPN 0] OUT: &#39;2024-11-18=
 14:03:17 <a href=3D"http://104.166.80.177:23432" target=3D"_blank">104.166=
.80.177:23432</a> SIGTERM[soft,port-share-redirect] received, client-instan=
ce exiting&#39;<br>2024-11-19T01:03:17+1100 [stdout#info] [WEB] OUT: &#39;2=
024-11-19T01:03:17+1100 [twisted.python.log#info] &quot;127.0.0.1&quot; - -=
 [18/Nov/2024:14:03:16 +0000] &quot;GET / HTTP/1.1&quot; 200 1707 &quot;-&q=
uot; &quot;Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/1=
20.0&quot;&#39;<br>2024-11-19T01:11:25+1100 [stdout#info] [OVPN 1] OUT: &#3=
9;2024-11-18 14:11:25 tls-crypt unwrap error: packet too short&#39;<br>2024=
-11-19T01:11:25+1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11-18 14:11:25 T=
LS Error: tls-crypt unwrapping failed from [AF_INET]<a href=3D"http://195.2=
8.180.102:16753" target=3D"_blank">195.28.180.102:16753</a> (via [AF_INET]1=
03.6.170.21%eth0)&#39;<br>2024-11-19T01:11:27+1100 [stdout#info] [OVPN 1] O=
UT: &#39;2024-11-18 14:11:27 tls-crypt unwrap error: packet too short&#39;<=
br>2024-11-19T01:11:27+1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11-18 14:=
11:27 TLS Error: tls-crypt unwrapping failed from [AF_INET]<a href=3D"http:=
//195.28.180.102:16753" target=3D"_blank">195.28.180.102:16753</a> (via [AF=
_INET]103.6.170.21%eth0)&#39;<br>2024-11-19T01:11:31+1100 [stdout#info] [OV=
PN 1] OUT: &#39;2024-11-18 14:11:31 tls-crypt unwrap error: packet too shor=
t&#39;<br>2024-11-19T01:11:31+1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11=
-18 14:11:31 TLS Error: tls-crypt unwrapping failed from [AF_INET]<a href=
=3D"http://195.28.180.102:16753" target=3D"_blank">195.28.180.102:16753</a>=
 (via [AF_INET]103.6.170.21%eth0)&#39;<br>2024-11-19T01:11:39+1100 [stdout#=
info] [OVPN 1] OUT: &#39;2024-11-18 14:11:39 tls-crypt unwrap error: packet=
 too short&#39;<br>2024-11-19T01:11:39+1100 [stdout#info] [OVPN 1] OUT: &#3=
9;2024-11-18 14:11:39 TLS Error: tls-crypt unwrapping failed from [AF_INET]=
<a href=3D"http://195.28.180.102:16753" target=3D"_blank">195.28.180.102:16=
753</a> (via [AF_INET]103.6.170.21%eth0)&#39;<br>2024-11-19T01:11:55+1100 [=
stdout#info] [OVPN 1] OUT: &#39;2024-11-18 14:11:55 tls-crypt unwrap error:=
 packet too short&#39;<br>2024-11-19T01:11:55+1100 [stdout#info] [OVPN 1] O=
UT: &#39;2024-11-18 14:11:55 TLS Error: tls-crypt unwrapping failed from [A=
F_INET]<a href=3D"http://195.28.180.102:16753" target=3D"_blank">195.28.180=
.102:16753</a> (via [AF_INET]103.6.170.21%eth0)&#39;<br>2024-11-19T01:12:30=
+1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11-18 14:12:30 tls-crypt unwrap=
 error: packet too short&#39;<br>2024-11-19T01:12:30+1100 [stdout#info] [OV=
PN 1] OUT: &#39;2024-11-18 14:12:30 TLS Error: tls-crypt unwrapping failed =
from [AF_INET]<a href=3D"http://195.28.180.102:36515" target=3D"_blank">195=
.28.180.102:36515</a> (via [AF_INET]103.6.170.21%eth0)&#39;<br>2024-11-19T0=
1:12:32+1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11-18 14:12:32 tls-crypt=
 unwrap error: packet too short&#39;<br>2024-11-19T01:12:32+1100 [stdout#in=
fo] [OVPN 1] OUT: &#39;2024-11-18 14:12:32 TLS Error: tls-crypt unwrapping =
failed from [AF_INET]<a href=3D"http://195.28.180.102:36515" target=3D"_bla=
nk">195.28.180.102:36515</a> (via [AF_INET]103.6.170.21%eth0)&#39;<br>2024-=
11-19T01:12:36+1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11-18 14:12:36 tl=
s-crypt unwrap error: packet too short&#39;<br>2024-11-19T01:12:36+1100 [st=
dout#info] [OVPN 1] OUT: &#39;2024-11-18 14:12:36 TLS Error: tls-crypt unwr=
apping failed from [AF_INET]<a href=3D"http://195.28.180.102:36515" target=
=3D"_blank">195.28.180.102:36515</a> (via [AF_INET]103.6.170.21%eth0)&#39;<=
br>2024-11-19T01:12:44+1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11-18 14:=
12:44 tls-crypt unwrap error: packet too short&#39;<br>2024-11-19T01:12:44+=
1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11-18 14:12:44 TLS Error: tls-cr=
ypt unwrapping failed from [AF_INET]<a href=3D"http://195.28.180.102:36515"=
 target=3D"_blank">195.28.180.102:36515</a> (via [AF_INET]103.6.170.21%eth0=
)&#39;<br>2024-11-19T01:13:00+1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11=
-18 14:13:00 tls-crypt unwrap error: packet too short&#39;<br>2024-11-19T01=
:13:00+1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11-18 14:13:00 TLS Error:=
 tls-crypt unwrapping failed from [AF_INET]<a href=3D"http://195.28.180.102=
:36515" target=3D"_blank">195.28.180.102:36515</a> (via [AF_INET]103.6.170.=
21%eth0)&#39;<br>2024-11-19T01:13:35+1100 [stdout#info] [OVPN 1] OUT: &#39;=
2024-11-18 14:13:35 tls-crypt unwrap error: packet too short&#39;<br>2024-1=
1-19T01:13:35+1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11-18 14:13:35 TLS=
 Error: tls-crypt unwrapping failed from [AF_INET]<a href=3D"http://195.28.=
180.102:58550" target=3D"_blank">195.28.180.102:58550</a> (via [AF_INET]103=
.6.170.21%eth0)&#39;<br>2024-11-19T01:13:37+1100 [stdout#info] [OVPN 1] OUT=
: &#39;2024-11-18 14:13:37 tls-crypt unwrap error: packet too short&#39;<br=
>2024-11-19T01:13:37+1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11-18 14:13=
:37 TLS Error: tls-crypt unwrapping failed from [AF_INET]<a href=3D"http://=
195.28.180.102:58550" target=3D"_blank">195.28.180.102:58550</a> (via [AF_I=
NET]103.6.170.21%eth0)&#39;<br>2024-11-19T01:13:41+1100 [stdout#info] [OVPN=
 1] OUT: &#39;2024-11-18 14:13:41 tls-crypt unwrap error: packet too short&=
#39;<br>2024-11-19T01:13:41+1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11-1=
8 14:13:41 TLS Error: tls-crypt unwrapping failed from [AF_INET]<a href=3D"=
http://195.28.180.102:58550" target=3D"_blank">195.28.180.102:58550</a> (vi=
a [AF_INET]103.6.170.21%eth0)&#39;<br>2024-11-19T01:13:50+1100 [stdout#info=
] [OVPN 1] OUT: &#39;2024-11-18 14:13:50 tls-crypt unwrap error: packet too=
 short&#39;<br>2024-11-19T01:13:50+1100 [stdout#info] [OVPN 1] OUT: &#39;20=
24-11-18 14:13:50 TLS Error: tls-crypt unwrapping failed from [AF_INET]<a h=
ref=3D"http://195.28.180.102:58550" target=3D"_blank">195.28.180.102:58550<=
/a> (via [AF_INET]103.6.170.21%eth0)&#39;<br>2024-11-19T01:14:05+1100 [stdo=
ut#info] [OVPN 1] OUT: &#39;2024-11-18 14:14:05 tls-crypt unwrap error: pac=
ket too short&#39;<br>2024-11-19T01:14:05+1100 [stdout#info] [OVPN 1] OUT: =
&#39;2024-11-18 14:14:05 TLS Error: tls-crypt unwrapping failed from [AF_IN=
ET]<a href=3D"http://195.28.180.102:58550" target=3D"_blank">195.28.180.102=
:58550</a> (via [AF_INET]103.6.170.21%eth0)&#39;<br>2024-11-19T01:14:40+110=
0 [stdout#info] [OVPN 1] OUT: &#39;2024-11-18 14:14:40 tls-crypt unwrap err=
or: packet too short&#39;<br>2024-11-19T01:14:40+1100 [stdout#info] [OVPN 1=
] OUT: &#39;2024-11-18 14:14:40 TLS Error: tls-crypt unwrapping failed from=
 [AF_INET]<a href=3D"http://195.28.180.102:19642" target=3D"_blank">195.28.=
180.102:19642</a> (via [AF_INET]103.6.170.21%eth0)&#39;<br>2024-11-19T01:14=
:42+1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11-18 14:14:42 tls-crypt unw=
rap error: packet too short&#39;<br>2024-11-19T01:14:42+1100 [stdout#info] =
[OVPN 1] OUT: &#39;2024-11-18 14:14:42 TLS Error: tls-crypt unwrapping fail=
ed from [AF_INET]<a href=3D"http://195.28.180.102:19642" target=3D"_blank">=
195.28.180.102:19642</a> (via [AF_INET]103.6.170.21%eth0)&#39;<br>2024-11-1=
9T01:14:46+1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11-18 14:14:46 tls-cr=
ypt unwrap error: packet too short&#39;<br>2024-11-19T01:14:46+1100 [stdout=
#info] [OVPN 1] OUT: &#39;2024-11-18 14:14:46 TLS Error: tls-crypt unwrappi=
ng failed from [AF_INET]<a href=3D"http://195.28.180.102:19642" target=3D"_=
blank">195.28.180.102:19642</a> (via [AF_INET]103.6.170.21%eth0)&#39;<br>20=
24-11-19T01:14:54+1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11-18 14:14:54=
 tls-crypt unwrap error: packet too short&#39;<br>2024-11-19T01:14:54+1100 =
[stdout#info] [OVPN 1] OUT: &#39;2024-11-18 14:14:54 TLS Error: tls-crypt u=
nwrapping failed from [AF_INET]<a href=3D"http://195.28.180.102:19642" targ=
et=3D"_blank">195.28.180.102:19642</a> (via [AF_INET]103.6.170.21%eth0)&#39=
;<br>2024-11-19T01:15:10+1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11-18 1=
4:15:10 tls-crypt unwrap error: packet too short&#39;<br>2024-11-19T01:15:1=
0+1100 [stdout#info] [OVPN 1] OUT: &#39;2024-11-18 14:15:10 TLS Error: tls-=
crypt unwrapping failed from [AF_INET]<a href=3D"http://195.28.180.102:1964=
2" target=3D"_blank">195.28.180.102:19642</a> (via [AF_INET]103.6.170.21%et=
h0)&#39;<br>root@...2835...:~# cat /var/log/openvpnas.log<br></div></div><b=
r><div class=3D"gmail_quote"><div dir=3D"rtl" class=3D"gmail_attr">=E2=80=
=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=D7=B3, 18=
 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-14:07 =D7=9E=D7=90=D7=AA =D7=A0=
=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=D7=9F &lt;=E2=80=AA<a href=3D"mailto:nsh531=
@...277..." target=3D"_blank">nsh531@...277...</a>=E2=80=AC=E2=80=8F&gt;:=
=E2=80=AC<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div d=
ir=3D"rtl"><div dir=3D"rtl"><div dir=3D"ltr"><div dir=3D"ltr">i had as prob=
lem to connect to server using SSH but I opened an=C2=A0 case with hosting =
support</div><div dir=3D"ltr"><br></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"rtl" class=3D"gmail_attr">=E2=80=AB=D7=91=D7=AA=D7=90=
=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=D7=B3, 18 =D7=91=D7=A0=D7=95=
=D7=91=D7=B3 2024 =D7=91-13:58 =D7=9E=D7=90=D7=AA =E2=80=AA=D0=98=D0=BB=D1=
=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD=E2=80=AC=E2=80=8F &lt;=
=E2=80=AA<a href=3D"mailto:chipitsine@...277..." target=3D"_blank">chipitsi=
ne@...277...</a>=E2=80=AC=E2=80=8F&gt;:=E2=80=AC<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>I initially thought =
it was not your server, because you told us that you do not have server log=
s.</div><div><br></div><div>do you have at least any client packet that rea=
ches server ?</div><div><br></div><div>(I know you may ask how to check tha=
t. I&#39;d choose tcpdump. in case if you wish to ask how to use tcpdump - =
sorry, no answer. Please use the tool of your choice, whatever you are comf=
ortable with)</div><div><br></div><div><br></div><div>if no packet reaches =
server, most probably you did not open firewall (either on vm itself or in =
cloud level).</div><div><br></div><div>(if you are going to ask how to mana=
ge firewall on vm or cloud level, sorry, no idea here, please consult cloud=
 guides=C2=A0or contact cloud support).</div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">=E2=80=AA=D0=BF=D0=BD, 18 =D0=BD=D0=
=BE=D1=8F=D0=B1. 2024=E2=80=AF=D0=B3. =D0=B2 12:43, =E2=80=AB=D7=A0=D7=AA=
=D7=99 =D7=A9=D7=98=D7=A8=D7=9F=E2=80=AC=E2=80=8E &lt;<a href=3D"mailto:nsh=
531@...277..." target=3D"_blank">nsh531@...277...</a>&gt;:=E2=80=AC<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"rtl"><div d=
ir=3D"ltr">How to solve this problem?=C2=A0</div><div dir=3D"ltr">because b=
oth the client and server are my=C2=A0 own</div><div dir=3D"ltr"><br></div>=
</div><br><div class=3D"gmail_quote"><div dir=3D"rtl" class=3D"gmail_attr">=
=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=D7=
=B3, 18 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-12:04 =D7=9E=D7=90=D7=AA=
 =E2=80=AADavid Sommerseth=E2=80=AC=E2=80=8F &lt;=E2=80=AA<a href=3D"mailto=
:dazo%2Bopenvpn@...2108..." target=3D"_blank">dazo+openvpn@...2108...</a>=
=E2=80=AC=E2=80=8F&gt;:=E2=80=AC<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex"><br>
Please stop now.<br>
<br>
A client which cannot reach a server because the client side has <br>
connectivity issues towards the server is not a DoS, it is not a CVE and <b=
r>
will never be considered a security issue.<br>
<br>
First of all, a DoS attack is commonly related to a SERVER becoming <br>
unresponsive due to traffic to the server causing it to stop responding. <b=
r>
=C2=A0 Or that one VPN clients misbehaviour (not due to misconfiguration, <=
br>
though) results in no other clients being able to connect.<br>
<br>
What you have described so far is that you cannot reach the server.=C2=A0 A=
nd <br>
OpenVPN tries to reconnect regularly.=C2=A0 This is the expected behaviour =
of <br>
most VPN clients - they try to keep the tunnel running with as little <br>
user interaction as possible.=C2=A0 The back-off timer is there to also <br>
needlessly keep trying if there seems to be longer persisting <br>
connectivity issues.<br>
<br>
And just to entertain you a bit more.=C2=A0 This is the logs when using <br>
OpenVPN 3 Linux:<br>
<br>
---------------------------------------------------------------------------=
-<br>
Press CTRL-C to stop the connection<br>
<br>
2024-11-18 09:59:19.854568 [STATUS] (StatusMajor.CONNECTION, <br>
StatusMinor.CFG_OK) <br>
config_path=3D/net/openvpn/v3/configuration/4c2bba36x2151x4291xb7acx3600003=
75d2a<br>
2024-11-18 09:59:19.854636 [LOG] Starting connection<br>
2024-11-18 09:59:19.854694 [LOG] Using DNS resolver scope: global<br>
2024-11-18 09:59:19.862369 [LOG] [Connect] DCO flag: disabled<br>
2024-11-18 09:59:19.862479 [STATUS] (StatusMajor.CONNECTION, <br>
StatusMinor.CONN_CONNECTING)<br>
2024-11-18 09:59:19.862548 [LOG] [Core] OpenVPN core v3.10.1 linux <br>
x86_64 64-bit OVPN-DCO<br>
2024-11-18 09:59:19.862596 [LOG] [Core] Frame=3D512/2112/512 mssfix-ctrl=3D=
1250<br>
2024-11-18 09:59:19.862636 [LOG] Resolving<br>
2024-11-18 09:59:19.866525 [LOG] [Core] Contacting <a href=3D"http://103.6.=
170.21:1194" rel=3D"noreferrer" target=3D"_blank">103.6.170.21:1194</a> via=
 UDP<br>
2024-11-18 09:59:19.866638 [LOG] Waiting for server response<br>
2024-11-18 09:59:19.878505 [LOG] [Core] Connecting to <br>
[103.6.170.21]:1194 (103.6.170.21) via UDP<br>
2024-11-18 09:59:29.861733 [LOG] [Core] Server poll timeout, trying next <b=
r>
remote entry...<br>
2024-11-18 09:59:29.861875 [LOG] Resolving<br>
2024-11-18 09:59:29.865648 [LOG] [Core] Contacting <a href=3D"http://103.6.=
170.21:1194" rel=3D"noreferrer" target=3D"_blank">103.6.170.21:1194</a> via=
 UDP<br>
2024-11-18 09:59:29.865769 [LOG] Waiting for server response<br>
2024-11-18 09:59:29.876299 [LOG] [Core] Connecting to <br>
[103.6.170.21]:1194 (103.6.170.21) via UDP<br>
2024-11-18 09:59:39.862254 [LOG] [Core] Server poll timeout, trying next <b=
r>
remote entry...<br>
2024-11-18 09:59:39.862347 [LOG] Resolving<br>
2024-11-18 09:59:39.866157 [LOG] [Core] Contacting <a href=3D"http://103.6.=
170.21:1194" rel=3D"noreferrer" target=3D"_blank">103.6.170.21:1194</a> via=
 UDP<br>
2024-11-18 09:59:39.866262 [LOG] Waiting for server response<br>
2024-11-18 09:59:39.877288 [LOG] [Core] Connecting to <br>
[103.6.170.21]:1194 (103.6.170.21) via UDP<br>
2024-11-18 09:59:49.862757 [LOG] [Core] Server poll timeout, trying next <b=
r>
remote entry...<br>
2024-11-18 09:59:49.862852 [LOG] Resolving<br>
2024-11-18 09:59:49.866514 [LOG] [Core] Contacting <a href=3D"http://103.6.=
170.21:1194" rel=3D"noreferrer" target=3D"_blank">103.6.170.21:1194</a> via=
 UDP<br>
2024-11-18 09:59:49.866614 [LOG] Waiting for server response<br>
2024-11-18 09:59:49.875998 [LOG] [Core] Connecting to <br>
[103.6.170.21]:1194 (103.6.170.21) via UDP<br>
2024-11-18 09:59:59.863047 [LOG] [Core] Server poll timeout, trying next <b=
r>
remote entry...<br>
2024-11-18 09:59:59.863179 [LOG] Resolving<br>
2024-11-18 09:59:59.866699 [LOG] [Core] Contacting <a href=3D"http://103.6.=
170.21:1194" rel=3D"noreferrer" target=3D"_blank">103.6.170.21:1194</a> via=
 UDP<br>
2024-11-18 09:59:59.866798 [LOG] Waiting for server response<br>
2024-11-18 09:59:59.876724 [LOG] [Core] Connecting to <br>
[103.6.170.21]:1194 (103.6.170.21) via UDP<br>
2024-11-18 10:00:09.863146 [LOG] [Core] Server poll timeout, trying next <b=
r>
remote entry...<br>
2024-11-18 10:00:09.863242 [LOG] Resolving<br>
2024-11-18 10:00:09.867305 [LOG] [Core] Contacting <a href=3D"http://103.6.=
170.21:1194" rel=3D"noreferrer" target=3D"_blank">103.6.170.21:1194</a> via=
 UDP<br>
2024-11-18 10:00:09.867406 [LOG] Waiting for server response<br>
2024-11-18 10:00:09.879292 [LOG] [Core] Connecting to <br>
[103.6.170.21]:1194 (103.6.170.21) via UDP<br>
2024-11-18 10:00:19.863499 [LOG] [Core] Server poll timeout, trying next <b=
r>
remote entry...<br>
2024-11-18 10:00:19.863623 [LOG] Resolving<br>
2024-11-18 10:00:19.867758 [LOG] [Core] Contacting <a href=3D"http://103.6.=
170.21:1194" rel=3D"noreferrer" target=3D"_blank">103.6.170.21:1194</a> via=
 UDP<br>
2024-11-18 10:00:19.867845 [LOG] Waiting for server response<br>
2024-11-18 10:00:19.879066 [LOG] [Core] Connecting to <br>
[103.6.170.21]:1194 (103.6.170.21) via UDP<br>
^C<br>
Disconnecting...<br>
Connection statistics:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0BYTES_OUT: 2814<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PACKET=
S_OUT: 67<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0N_RECO=
NNECT: 6<br>
---------------------------------------------------------------------------=
-<br>
<br>
This needs to stop.=C2=A0 This is not a CVE.=C2=A0 This is an OpenVPN serve=
r which <br>
doesn&#39;t respond on port 1194/udp.<br>
<br>
If you want to keep some kind of credibility with any security teams, <br>
you need to back down and spend time looking for real issues and <br>
document it far better.=C2=A0 And you will need to provide the server side =
<br>
perspective as well, not just the client side.<br>
<br>
Once again: Clients not being able to connect to the server because of <br>
network connectivity issues is not a CVE.<br>
<br>
<br>
This case is closed.<br>
<br>
<br>
-- <br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN Inc<br>
<br>
<br>
<br>
On 18/11/2024 08:37, =D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=D7=9F wrote:<br>
&gt; What can I do to assign a CVE?<br>
&gt;=C2=A0 =C2=A0I attached the CVE team of ISRAEL=C2=A0CERT=C2=A0 to conve=
rsation<br>
&gt; <br>
&gt; tnx<br>
&gt; <br>
&gt; =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=
=91=D7=B3, 18 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-9:29 =D7=9E=D7=90=
=D7=AA =E2=80=AA=D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=
=B8=D0=BD=E2=80=AC=E2=80=8F <br>
&gt; &lt;=E2=80=AA<a href=3D"mailto:chipitsine@...277..." target=3D"_blank"=
>chipitsine@...277...</a> &lt;mailto:<a href=3D"mailto:chipitsine@...277...=
" target=3D"_blank">chipitsine@...277...</a>&gt;=E2=80=AC=E2=80=8F&gt;:=E2=
=80=AC<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0As many details as possible. Configuration file usu=
ally helps.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Other than that also server side logs are nice to h=
ave. As well as<br>
&gt;=C2=A0 =C2=A0 =C2=A0the detailed repro steps<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Mon, Nov 18, 2024, 08:27 =D7=A0=D7=AA=D7=99 =D7=
=A9=D7=98=D7=A8=D7=9F &lt;<a href=3D"mailto:nsh531@...277..." target=3D"_bl=
ank">nsh531@...277...</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:nsh531@...277..." targ=
et=3D"_blank">nsh531@...277...</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Do you want the configuration file?<b=
r>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=
=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=D7=B3, 18 =D7=91=D7=A0=D7=95=D7=91=D7=
=B3 2024 =D7=91-9:14 =D7=9E=D7=90=D7=AA =E2=80=AAGert Doering=E2=80=AC=E2=
=80=8F<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;=E2=80=AA<a href=3D"mailto:gert@...220...=
..1296..." target=3D"_blank">gert@...1296...</a> &lt;mailto:<a href=3D"mail=
to:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;=E2=80=AC=E2=
=80=8F&gt;:=E2=80=AC<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Hi,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0On Mon, Nov 18, 2024 at=
 09:09:57AM +0200, ?????? ???????? wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; I don&#39;t have =
access to server logs, I sent you the client<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logs as well as<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; the line pointing=
 to the DoS:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; TLS Error: TLS ke=
y negotiation failed to occur within 5<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0seconds<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; SIGUSR1[soft,tls-=
error] received, process restarting<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0What makes you think it=
&#39;s a DoS that can be fixed by a code<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0change?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0If you break the networ=
k, programs will not be able to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0connect - and there<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0is nothing &quot;a patc=
h to the software&quot; will be able to fix.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gert<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-- <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;If was one thing =
all people took for granted, was<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0conviction that if you<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0feed honest figu=
res into a computer, honest figures come<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0out. Never doubted<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0it myself till I=
 met a computer with a sense of humor.&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Robert A. Heinlein, The Moon<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0is a Harsh Mistress<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Gert Doering - Munich, =
Germany <a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...2132...=
.</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"m=
ailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-- <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://netanel.ml" re=
l=3D"noreferrer" target=3D"_blank">https://netanel.ml</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_____________________________________=
__________<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Openvpn-devel mailing list<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailto:Openvpn-devel@...1697...=
.sourceforge.net" target=3D"_blank">Openvpn-devel@lists.sourceforge.net</a>=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:Openvpn-=
devel@lists.sourceforge.net" target=3D"_blank">Openvpn-devel@...1357...=
rge.net</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://lists.sourceforge.=
net/lists/listinfo/openvpn-devel" rel=3D"noreferrer" target=3D"_blank">http=
s://lists.sourceforge.net/lists/listinfo/openvpn-devel</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://lists.sourcefo=
rge.net/lists/listinfo/openvpn-devel" rel=3D"noreferrer" target=3D"_blank">=
https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a>&gt;<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; -- <br>
&gt; &lt;<a href=3D"https://netanel.ml" rel=3D"noreferrer" target=3D"_blank=
">https://netanel.ml</a>&gt;<br>
<br>
<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"rtl" class=3D"gmail_s=
ignature"><div dir=3D"rtl"><a href=3D"https://netanel.ml" target=3D"_blank"=
><img width=3D"200" height=3D"51" src=3D"https://ci3.googleusercontent.com/=
mail-sig/AIorK4y1ahZg0mqH5UnDCjKIkW6FTSni5R5bezS1idSRECO6GXQ1uH3RgELXk8RqqC=
oNk3985_jsnIQnnclo"></a></div></div>
</blockquote></div></div>
</blockquote></div></div><div><br clear=3D"all"></div><div><br></div><span =
class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"rtl" class=3D"gm=
ail_signature"><div dir=3D"rtl"><a href=3D"https://netanel.ml" target=3D"_b=
lank"><img width=3D"200" height=3D"51" src=3D"https://ci3.googleusercontent=
.com/mail-sig/AIorK4y1ahZg0mqH5UnDCjKIkW6FTSni5R5bezS1idSRECO6GXQ1uH3RgELXk=
8RqqCoNk3985_jsnIQnnclo"></a></div></div>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"rtl" class=3D"gmail_s=
ignature"><div dir=3D"rtl"><a href=3D"https://netanel.ml" target=3D"_blank"=
><img width=3D"200" height=3D"51" src=3D"https://ci3.googleusercontent.com/=
mail-sig/AIorK4y1ahZg0mqH5UnDCjKIkW6FTSni5R5bezS1idSRECO6GXQ1uH3RgELXk8RqqC=
oNk3985_jsnIQnnclo"></a></div></div>
</blockquote></div>

--0000000000003093a306273ffd1a--


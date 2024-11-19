MIME-Version: 1.0
References: <CAC8x_z10PT_ToTzVUKQENA5ZJgJ4EMvBJARphDR5_wdytA2JSw@...278...>
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
 <CAC8x_z2WjPATPgbOs9JPooP=gEShrvJfnVYddS=2pCYv+vq0fg@...278...>
 <a93d1b95.AW8AAFg_hhMAAAAAAAAAAauy6DYAAYCsnhYAAAAAABXTlQBnPEmt@...2677...>
In-Reply-To: <a93d1b95.AW8AAFg_hhMAAAAAAAAAAauy6DYAAYCsnhYAAAAAABXTlQBnPEmt@...2677...>
From: =?UTF-8?B?16DXqteZINep15jXqNef?= <nsh531@...277...>
Date: Tue, 19 Nov 2024 10:25:36 +0200
Message-ID: <CAC8x_z1z-==qM14AOLVj0LeGvMPjxMMXEHJeyfJ0pz9w0rX4+Q@...278...>
Content-Type: multipart/alternative; boundary="000000000000aa061106273fc761"
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
To: David Sommerseth <dazo+openvpn@...2108...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, =?UTF-8?B?15PXmdeV15XXl9eZINek15LXmdei15XXmdeV16o=?= <cve@...2832...>

--000000000000aa061106273fc761
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

have something to fix configuration?


=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=92=D7=
=B3, 19 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-10:17 =D7=9E=D7=90=D7=AA=
 =E2=80=AADavid Sommerseth=E2=80=AC=E2=80=8F <=E2=80=AA
dazo+openvpn@...2108...=E2=80=AC=E2=80=8F>:=E2=80=AC

>
> The interesting lines are these:
>
>
> 2024-11-18T20:53:01+1100 [stdout#info] [OVPN 0]
>       OUT: '2024-11-18 09:53:01 152.32.247.23:55730
>          Non-OpenVPN client protocol detected'
>
> These lines indicates the server seems to be configured with
> --port-share.  And those packets are forwarded to the service behind
> OpenVPN.  In this case OpenVPN behaves like a proxy.
>
>
> 2024-11-19T01:13:00+1100 [stdout#info] [OVPN 1]
>       OUT: '2024-11-18 14:13:00 TLS Error:
>           tls-crypt unwrapping failed from [AF_INET]195.28.180.102:36515
>               (via [AF_INET]103.6.170.21%eth0)'
> 2024-11-19T01:13:35+1100 [stdout#info] [OVPN 1]
>       OUT: '2024-11-18 14:13:35 tls-crypt unwrap error: packet too short'
>
>
> That just means someone is trying to connect to the server not using
> --tls-crypt or --tls-crypt-v2.  In this case, your client configuration
> uses --tls-auth, which will result in this kind of error and not being
> able to connect.
>
> I believe --mute will reduce the number of duplicated log lines in these
> cases on the server side.
>
> I am not able to see anything extraordinary in these log lines.  This is
> just plain misconfiguration.
>
> Since you seem to run OpenVPN Access Server, just log into the web
> portal and download a new configuration profile.
>
> This has certainly nothing to do with any kind of security issues.
>
>
> --
> kind regards,
>
> David Sommerseth
> OpenVPN Inc
>
>
>
> On 18/11/2024 15:17, =D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=D7=9F wrote:
> > *_
> > _*
> > *_server logs:_*
> [...snip...]
> > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=
=D7=B3, 18 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-13:58 =D7=9E=D7=90=D7=
=AA =E2=80=AA=D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=
=D0=BD=E2=80=AC=E2=80=8F
> > <=E2=80=AAchipitsine@...277... <mailto:chipitsine@...277...>=E2=80=AC=
=E2=80=8F>:=E2=80=AC
> >
> >     I initially thought it was not your server, because you told us that
> >     you do not have server logs.
> >
> >     do you have at least any client packet that reaches server ?
> >
> >     (I know you may ask how to check that. I'd choose tcpdump. in case
> >     if you wish to ask how to use tcpdump - sorry, no answer. Please use
> >     the tool of your choice, whatever you are comfortable with)
> >
> >
> >     if no packet reaches server, most probably you did not open firewall
> >     (either on vm itself or in cloud level).
> >
> >     (if you are going to ask how to manage firewall on vm or cloud
> >     level, sorry, no idea here, please consult cloud guides or contact
> >     cloud support).
> >
> >     =E2=80=AA=D0=BF=D0=BD, 18 =D0=BD=D0=BE=D1=8F=D0=B1. 2024=E2=80=AF=
=D0=B3. =D0=B2 12:43, =E2=80=AB=D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=D7=9F=
=E2=80=AC=E2=80=8E <nsh531@...277...
> >     <mailto:nsh531@...277...>>:=E2=80=AC
> >
> >         How to solve this problem?
> >         because both the client and server are my  own
> >
> >
> >         =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=
=9D =D7=91=D7=B3, 18 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-12:04 =D7=
=9E=D7=90=D7=AA =E2=80=AADavid Sommerseth=E2=80=AC=E2=80=8F
> >         <=E2=80=AAdazo+openvpn@...2108...
> >         <mailto:dazo%2Bopenvpn@...2108...>=E2=80=AC=E2=80=8F>:=E2=80=AC
> >
> >
> >             Please stop now.
> >
> >             A client which cannot reach a server because the client side
> >             has
> >             connectivity issues towards the server is not a DoS, it is
> >             not a CVE and
> >             will never be considered a security issue.
> >
> >             First of all, a DoS attack is commonly related to a SERVER
> >             becoming
> >             unresponsive due to traffic to the server causing it to stop
> >             responding.
> >                Or that one VPN clients misbehaviour (not due to
> >             misconfiguration,
> >             though) results in no other clients being able to connect.
> >
> >             What you have described so far is that you cannot reach the
> >             server.  And
> >             OpenVPN tries to reconnect regularly.  This is the expected
> >             behaviour of
> >             most VPN clients - they try to keep the tunnel running with
> >             as little
> >             user interaction as possible.  The back-off timer is there
> >             to also
> >             needlessly keep trying if there seems to be longer persisti=
ng
> >             connectivity issues.
> >
> >             And just to entertain you a bit more.  This is the logs when
> >             using
> >             OpenVPN 3 Linux:
> >
> >
>  ------------------------------------------------------------------------=
----
> >             Press CTRL-C to stop the connection
> >
> >             2024-11-18 09:59:19.854568 [STATUS] (StatusMajor.CONNECTION,
> >             StatusMinor.CFG_OK)
> >
>  config_path=3D/net/openvpn/v3/configuration/4c2bba36x2151x4291xb7acx3600=
00375d2a
> >             2024-11-18 09:59:19.854636 [LOG] Starting connection
> >             2024-11-18 09:59:19.854694 [LOG] Using DNS resolver scope:
> >             global
> >             2024-11-18 09:59:19.862369 [LOG] [Connect] DCO flag: disabl=
ed
> >             2024-11-18 09:59:19.862479 [STATUS] (StatusMajor.CONNECTION,
> >             StatusMinor.CONN_CONNECTING)
> >             2024-11-18 09:59:19.862548 [LOG] [Core] OpenVPN core v3.10.1
> >             linux
> >             x86_64 64-bit OVPN-DCO
> >             2024-11-18 09:59:19.862596 [LOG] [Core] Frame=3D512/2112/512
> >             mssfix-ctrl=3D1250
> >             2024-11-18 09:59:19.862636 [LOG] Resolving
> >             2024-11-18 09:59:19.866525 [LOG] [Core] Contacting
> >             103.6.170.21:1194 <http://103.6.170.21:1194> via UDP
> >             2024-11-18 09:59:19.866638 [LOG] Waiting for server response
> >             2024-11-18 09:59:19.878505 [LOG] [Core] Connecting to
> >             [103.6.170.21]:1194 (103.6.170.21) via UDP
> >             2024-11-18 09:59:29.861733 [LOG] [Core] Server poll timeout,
> >             trying next
> >             remote entry...
> >             2024-11-18 09:59:29.861875 [LOG] Resolving
> >             2024-11-18 09:59:29.865648 [LOG] [Core] Contacting
> >             103.6.170.21:1194 <http://103.6.170.21:1194> via UDP
> >             2024-11-18 09:59:29.865769 [LOG] Waiting for server response
> >             2024-11-18 09:59:29.876299 [LOG] [Core] Connecting to
> >             [103.6.170.21]:1194 (103.6.170.21) via UDP
> >             2024-11-18 09:59:39.862254 [LOG] [Core] Server poll timeout,
> >             trying next
> >             remote entry...
> >             2024-11-18 09:59:39.862347 [LOG] Resolving
> >             2024-11-18 09:59:39.866157 [LOG] [Core] Contacting
> >             103.6.170.21:1194 <http://103.6.170.21:1194> via UDP
> >             2024-11-18 09:59:39.866262 [LOG] Waiting for server response
> >             2024-11-18 09:59:39.877288 [LOG] [Core] Connecting to
> >             [103.6.170.21]:1194 (103.6.170.21) via UDP
> >             2024-11-18 09:59:49.862757 [LOG] [Core] Server poll timeout,
> >             trying next
> >             remote entry...
> >             2024-11-18 09:59:49.862852 [LOG] Resolving
> >             2024-11-18 09:59:49.866514 [LOG] [Core] Contacting
> >             103.6.170.21:1194 <http://103.6.170.21:1194> via UDP
> >             2024-11-18 09:59:49.866614 [LOG] Waiting for server response
> >             2024-11-18 09:59:49.875998 [LOG] [Core] Connecting to
> >             [103.6.170.21]:1194 (103.6.170.21) via UDP
> >             2024-11-18 09:59:59.863047 [LOG] [Core] Server poll timeout,
> >             trying next
> >             remote entry...
> >             2024-11-18 09:59:59.863179 [LOG] Resolving
> >             2024-11-18 09:59:59.866699 [LOG] [Core] Contacting
> >             103.6.170.21:1194 <http://103.6.170.21:1194> via UDP
> >             2024-11-18 09:59:59.866798 [LOG] Waiting for server response
> >             2024-11-18 09:59:59.876724 [LOG] [Core] Connecting to
> >             [103.6.170.21]:1194 (103.6.170.21) via UDP
> >             2024-11-18 10:00:09.863146 [LOG] [Core] Server poll timeout,
> >             trying next
> >             remote entry...
> >             2024-11-18 10:00:09.863242 [LOG] Resolving
> >             2024-11-18 10:00:09.867305 [LOG] [Core] Contacting
> >             103.6.170.21:1194 <http://103.6.170.21:1194> via UDP
> >             2024-11-18 10:00:09.867406 [LOG] Waiting for server response
> >             2024-11-18 10:00:09.879292 [LOG] [Core] Connecting to
> >             [103.6.170.21]:1194 (103.6.170.21) via UDP
> >             2024-11-18 10:00:19.863499 [LOG] [Core] Server poll timeout,
> >             trying next
> >             remote entry...
> >             2024-11-18 10:00:19.863623 [LOG] Resolving
> >             2024-11-18 10:00:19.867758 [LOG] [Core] Contacting
> >             103.6.170.21:1194 <http://103.6.170.21:1194> via UDP
> >             2024-11-18 10:00:19.867845 [LOG] Waiting for server response
> >             2024-11-18 10:00:19.879066 [LOG] [Core] Connecting to
> >             [103.6.170.21]:1194 (103.6.170.21) via UDP
> >             ^C
> >             Disconnecting...
> >             Connection statistics:
> >                                   BYTES_OUT: 2814
> >                                 PACKETS_OUT: 67
> >                                 N_RECONNECT: 6
> >
>  ------------------------------------------------------------------------=
----
> >
> >             This needs to stop.  This is not a CVE.  This is an OpenVPN
> >             server which
> >             doesn't respond on port 1194/udp.
> >
> >             If you want to keep some kind of credibility with any
> >             security teams,
> >             you need to back down and spend time looking for real issues
> >             and
> >             document it far better.  And you will need to provide the
> >             server side
> >             perspective as well, not just the client side.
> >
> >             Once again: Clients not being able to connect to the server
> >             because of
> >             network connectivity issues is not a CVE.
> >
> >
> >             This case is closed.
> >
> >
> >             --
> >             kind regards,
> >
> >             David Sommerseth
> >             OpenVPN Inc
> >
> >
> >
> >             On 18/11/2024 08:37, =D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=
=D7=9F wrote:
> >              > What can I do to assign a CVE?
> >              >   I attached the CVE team of ISRAEL CERT  to conversation
> >              >
> >              > tnx
> >              >
> >              > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=
=95=D7=9D =D7=91=D7=B3, 18 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-9:29 =
=D7=9E=D7=90=D7=AA =E2=80=AA=D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD=E2=80=AC=E2=80=8F
> >              > <=E2=80=AAchipitsine@...277... <mailto:chipitsine@...1482...=
...>
> >             <mailto:chipitsine@...277... <mailto:chipitsine@...277...
> >>=E2=80=AC=E2=80=8F>:=E2=80=AC
> >              >
> >              >     As many details as possible. Configuration file
> >             usually helps.
> >              >
> >              >     Other than that also server side logs are nice to
> >             have. As well as
> >              >     the detailed repro steps
> >              >
> >              >     On Mon, Nov 18, 2024, 08:27 =D7=A0=D7=AA=D7=99 =D7=
=A9=D7=98=D7=A8=D7=9F
> >             <nsh531@...277... <mailto:nsh531@...277...>
> >              >     <mailto:nsh531@...277... <mailto:nsh531@...277...>>>
> >             wrote:
> >              >
> >              >         Do you want the configuration file?
> >              >
> >              >         =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =
=D7=99=D7=95=D7=9D =D7=91=D7=B3, 18 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=
=91-9:14 =D7=9E=D7=90=D7=AA =E2=80=AAGert
> >             Doering=E2=80=AC=E2=80=8F
> >              >         <=E2=80=AAgert@...1296...
> >             <mailto:gert@...1296...> <mailto:gert@...1296...
> >             <mailto:gert@...1296...>>=E2=80=AC=E2=80=8F>:=E2=80=AC
> >              >
> >              >             Hi,
> >              >
> >              >             On Mon, Nov 18, 2024 at 09:09:57AM +0200,
> >             ?????? ???????? wrote:
> >              >              > I don't have access to server logs, I sent
> >             you the client
> >              >             logs as well as
> >              >              > the line pointing to the DoS:
> >              >              > TLS Error: TLS key negotiation failed to
> >             occur within 5
> >              >             seconds
> >              >              > SIGUSR1[soft,tls-error] received, process
> >             restarting
> >              >
> >              >             What makes you think it's a DoS that can be
> >             fixed by a code
> >              >             change?
> >              >
> >              >             If you break the network, programs will not
> >             be able to
> >              >             connect - and there
> >              >             is nothing "a patch to the software" will be
> >             able to fix.
> >              >
> >              >             gert
> >              >             --
> >              >             "If was one thing all people took for
> >             granted, was
> >              >             conviction that if you
> >              >               feed honest figures into a computer, honest
> >             figures come
> >              >             out. Never doubted
> >              >               it myself till I met a computer with a
> >             sense of humor."
> >              >                                           Robert A.
> >             Heinlein, The Moon
> >              >             is a Harsh Mistress
> >              >
> >              >             Gert Doering - Munich, Germany
> >             gert@...1296... <mailto:gert@...1296...>
> >              >             <mailto:gert@...1296...
> >             <mailto:gert@...1296...>>
> >              >
> >              >
> >              >
> >              >         --
> >              >         <https://netanel.ml <https://netanel.ml>>
> >              >         _______________________________________________
> >              >         Openvpn-devel mailing list
> >              > Openvpn-devel@lists.sourceforge.net
> >             <mailto:Openvpn-devel@lists.sourceforge.net>
> >              >         <mailto:Openvpn-devel@lists.sourceforge.net
> >             <mailto:Openvpn-devel@lists.sourceforge.net>>
> >              >
> >             https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >             <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>
> >              >
> >               <
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel <
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel>>
> >              >
> >              >
> >              >
> >              > --
> >              > <https://netanel.ml <https://netanel.ml>>
> >
> >
> >
> >
> >
> >         --
> >         <https://netanel.ml>
> >
> >
> >
> > --
> > <https://netanel.ml>
>
>
>

--=20
<https://netanel.ml>

--000000000000aa061106273fc761
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9InJ0bCI+PGRpdiBkaXI9Imx0ciI+aGF2ZSBzb21ldGhpbmcgdG8gZml4IGNvbmZp
Z3VyYXRpb24/PC9kaXY+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNs
YXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9InJ0bCIgY2xhc3M9ImdtYWlsX2F0dHIiPuKAq9eR
16rXkNeo15nXmiDXmdeV150g15LXsywgMTkg15HXoNeV15HXsyAyMDI0INeRLTEwOjE3INee15DX
qiDigKpEYXZpZCBTb21tZXJzZXRo4oCs4oCPICZsdDvigKo8YSBocmVmPSJtYWlsdG86ZGF6byUy
Qm9wZW52cG5ALi4uMjEwOC4uLiI+ZGF6bytvcGVudnBuQC4uLjIxMDguLi48L2E+4oCs4oCPJmd0
OzrigKw8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFy
Z2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwy
MDQpO3BhZGRpbmctbGVmdDoxZXgiPjxicj4NClRoZSBpbnRlcmVzdGluZyBsaW5lcyBhcmUgdGhl
c2U6PGJyPg0KPGJyPg0KPGJyPg0KMjAyNC0xMS0xOFQyMDo1MzowMSsxMTAwIFtzdGRvdXQjaW5m
b10gW09WUE4gMF08YnI+DQrCoCDCoCDCoCBPVVQ6ICYjMzk7MjAyNC0xMS0xOCAwOTo1MzowMSA8
YSBocmVmPSJodHRwOi8vMTUyLjMyLjI0Ny4yMzo1NTczMCIgcmVsPSJub3JlZmVycmVyIiB0YXJn
ZXQ9Il9ibGFuayI+MTUyLjMyLjI0Ny4yMzo1NTczMDwvYT48YnI+DQrCoCDCoCDCoCDCoCDCoE5v
bi1PcGVuVlBOIGNsaWVudCBwcm90b2NvbCBkZXRlY3RlZCYjMzk7PGJyPg0KPGJyPg0KVGhlc2Ug
bGluZXMgaW5kaWNhdGVzIHRoZSBzZXJ2ZXIgc2VlbXMgdG8gYmUgY29uZmlndXJlZCB3aXRoPGJy
Pg0KLS1wb3J0LXNoYXJlLsKgIEFuZCB0aG9zZSBwYWNrZXRzIGFyZSBmb3J3YXJkZWQgdG8gdGhl
IHNlcnZpY2UgYmVoaW5kIDxicj4NCk9wZW5WUE4uwqAgSW4gdGhpcyBjYXNlIE9wZW5WUE4gYmVo
YXZlcyBsaWtlIGEgcHJveHkuPGJyPg0KPGJyPg0KPGJyPg0KMjAyNC0xMS0xOVQwMToxMzowMCsx
MTAwIFtzdGRvdXQjaW5mb10gW09WUE4gMV08YnI+DQrCoCDCoCDCoCBPVVQ6ICYjMzk7MjAyNC0x
MS0xOCAxNDoxMzowMCBUTFMgRXJyb3I6PGJyPg0KwqAgwqAgwqAgwqAgwqAgdGxzLWNyeXB0IHVu
d3JhcHBpbmcgZmFpbGVkIGZyb20gW0FGX0lORVRdPGEgaHJlZj0iaHR0cDovLzE5NS4yOC4xODAu
MTAyOjM2NTE1IiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj4xOTUuMjguMTgwLjEw
MjozNjUxNTwvYT48YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCAodmlhIFtBRl9JTkVUXTEwMy42
LjE3MC4yMSVldGgwKSYjMzk7PGJyPg0KMjAyNC0xMS0xOVQwMToxMzozNSsxMTAwIFtzdGRvdXQj
aW5mb10gW09WUE4gMV08YnI+DQrCoCDCoCDCoCBPVVQ6ICYjMzk7MjAyNC0xMS0xOCAxNDoxMzoz
NSB0bHMtY3J5cHQgdW53cmFwIGVycm9yOiBwYWNrZXQgdG9vIHNob3J0JiMzOTs8YnI+DQo8YnI+
DQo8YnI+DQpUaGF0IGp1c3QgbWVhbnMgc29tZW9uZSBpcyB0cnlpbmcgdG8gY29ubmVjdCB0byB0
aGUgc2VydmVyIG5vdCB1c2luZyA8YnI+DQotLXRscy1jcnlwdCBvciAtLXRscy1jcnlwdC12Mi7C
oCBJbiB0aGlzIGNhc2UsIHlvdXIgY2xpZW50IGNvbmZpZ3VyYXRpb24gPGJyPg0KdXNlcyAtLXRs
cy1hdXRoLCB3aGljaCB3aWxsIHJlc3VsdCBpbiB0aGlzIGtpbmQgb2YgZXJyb3IgYW5kIG5vdCBi
ZWluZyA8YnI+DQphYmxlIHRvIGNvbm5lY3QuPGJyPg0KPGJyPg0KSSBiZWxpZXZlIC0tbXV0ZSB3
aWxsIHJlZHVjZSB0aGUgbnVtYmVyIG9mIGR1cGxpY2F0ZWQgbG9nIGxpbmVzIGluIHRoZXNlIDxi
cj4NCmNhc2VzIG9uIHRoZSBzZXJ2ZXIgc2lkZS48YnI+DQo8YnI+DQpJIGFtIG5vdCBhYmxlIHRv
IHNlZSBhbnl0aGluZyBleHRyYW9yZGluYXJ5IGluIHRoZXNlIGxvZyBsaW5lcy7CoCBUaGlzIGlz
IDxicj4NCmp1c3QgcGxhaW4gbWlzY29uZmlndXJhdGlvbi48YnI+DQo8YnI+DQpTaW5jZSB5b3Ug
c2VlbSB0byBydW4gT3BlblZQTiBBY2Nlc3MgU2VydmVyLCBqdXN0IGxvZyBpbnRvIHRoZSB3ZWIg
PGJyPg0KcG9ydGFsIGFuZCBkb3dubG9hZCBhIG5ldyBjb25maWd1cmF0aW9uIHByb2ZpbGUuPGJy
Pg0KPGJyPg0KVGhpcyBoYXMgY2VydGFpbmx5IG5vdGhpbmcgdG8gZG8gd2l0aCBhbnkga2luZCBv
ZiBzZWN1cml0eSBpc3N1ZXMuPGJyPg0KPGJyPg0KPGJyPg0KLS0gPGJyPg0Ka2luZCByZWdhcmRz
LDxicj4NCjxicj4NCkRhdmlkIFNvbW1lcnNldGg8YnI+DQpPcGVuVlBOIEluYzxicj4NCjxicj4N
Cjxicj4NCjxicj4NCk9uIDE4LzExLzIwMjQgMTU6MTcsINeg16rXmSDXqdeY16jXnyB3cm90ZTo8
YnI+DQomZ3Q7ICpfPGJyPg0KJmd0OyBfKjxicj4NCiZndDsgKl9zZXJ2ZXIgbG9nczpfKjxicj4N
ClsuLi5zbmlwLi4uXTxicj4NCiZndDsg4oCr15HXqteQ16jXmdeaINeZ15XXnSDXkdezLCAxOCDX
kdeg15XXkdezIDIwMjQg15EtMTM6NTgg157XkNeqIOKAqtCY0LvRjNGPINCo0LjQv9C40YbQuNC9
4oCs4oCPIDxicj4NCiZndDsgJmx0O+KAqjxhIGhyZWY9Im1haWx0bzpjaGlwaXRzaW5lQC4uLjI3
Ny4uLiIgdGFyZ2V0PSJfYmxhbmsiPmNoaXBpdHNpbmVALi4uMjc3Li4uPC9hPiAmbHQ7bWFpbHRv
OjxhIGhyZWY9Im1haWx0bzpjaGlwaXRzaW5lQC4uLjI3Ny4uLiIgdGFyZ2V0PSJfYmxhbmsiPmNo
aXBpdHNpbmVALi4uMjc3Li4uPC9hPiZndDvigKzigI8mZ3Q7OuKArDxicj4NCiZndDsgPGJyPg0K
Jmd0O8KgIMKgIMKgSSBpbml0aWFsbHkgdGhvdWdodCBpdCB3YXMgbm90IHlvdXIgc2VydmVyLCBi
ZWNhdXNlIHlvdSB0b2xkIHVzIHRoYXQ8YnI+DQomZ3Q7wqAgwqAgwqB5b3UgZG8gbm90IGhhdmUg
c2VydmVyIGxvZ3MuPGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqAgwqBkbyB5b3UgaGF2ZSBhdCBs
ZWFzdCBhbnkgY2xpZW50IHBhY2tldCB0aGF0IHJlYWNoZXMgc2VydmVyID88YnI+DQomZ3Q7IDxi
cj4NCiZndDvCoCDCoCDCoChJIGtub3cgeW91IG1heSBhc2sgaG93IHRvIGNoZWNrIHRoYXQuIEkm
IzM5O2QgY2hvb3NlIHRjcGR1bXAuIGluIGNhc2U8YnI+DQomZ3Q7wqAgwqAgwqBpZiB5b3Ugd2lz
aCB0byBhc2sgaG93IHRvIHVzZSB0Y3BkdW1wIC0gc29ycnksIG5vIGFuc3dlci4gUGxlYXNlIHVz
ZTxicj4NCiZndDvCoCDCoCDCoHRoZSB0b29sIG9mIHlvdXIgY2hvaWNlLCB3aGF0ZXZlciB5b3Ug
YXJlIGNvbWZvcnRhYmxlIHdpdGgpPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDC
oCDCoGlmIG5vIHBhY2tldCByZWFjaGVzIHNlcnZlciwgbW9zdCBwcm9iYWJseSB5b3UgZGlkIG5v
dCBvcGVuIGZpcmV3YWxsPGJyPg0KJmd0O8KgIMKgIMKgKGVpdGhlciBvbiB2bSBpdHNlbGYgb3Ig
aW4gY2xvdWQgbGV2ZWwpLjxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgKGlmIHlvdSBhcmUg
Z29pbmcgdG8gYXNrIGhvdyB0byBtYW5hZ2UgZmlyZXdhbGwgb24gdm0gb3IgY2xvdWQ8YnI+DQom
Z3Q7wqAgwqAgwqBsZXZlbCwgc29ycnksIG5vIGlkZWEgaGVyZSwgcGxlYXNlIGNvbnN1bHQgY2xv
dWQgZ3VpZGVzwqBvciBjb250YWN0PGJyPg0KJmd0O8KgIMKgIMKgY2xvdWQgc3VwcG9ydCkuPGJy
Pg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqAgwqDigKrQv9C9LCAxOCDQvdC+0Y/QsS4gMjAyNOKAr9Cz
LiDQsiAxMjo0Mywg4oCr16DXqteZINep15jXqNef4oCs4oCOICZsdDs8YSBocmVmPSJtYWlsdG86
bnNoNTMxQC4uLjI3Ny4uLiIgdGFyZ2V0PSJfYmxhbmsiPm5zaDUzMUAuLi4yNzcuLi48L2E+PGJy
Pg0KJmd0O8KgIMKgIMKgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86bnNoNTMxQC4uLjI3Ny4u
LiIgdGFyZ2V0PSJfYmxhbmsiPm5zaDUzMUAuLi4yNzcuLi48L2E+Jmd0OyZndDs64oCsPGJyPg0K
Jmd0OyA8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqBIb3cgdG8gc29sdmUgdGhpcyBwcm9ibGVtPzxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoGJlY2F1c2UgYm90aCB0aGUgY2xpZW50IGFuZCBzZXJ2ZXIg
YXJlIG15wqAgb3duPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoCDCoCDC
oOKAq9eR16rXkNeo15nXmiDXmdeV150g15HXsywgMTgg15HXoNeV15HXsyAyMDI0INeRLTEyOjA0
INee15DXqiDigKpEYXZpZCBTb21tZXJzZXRo4oCs4oCPPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKg
Jmx0O+KAqjxhIGhyZWY9Im1haWx0bzpkYXpvJTJCb3BlbnZwbkAuLi4yMTA4Li4uIiB0YXJnZXQ9
Il9ibGFuayI+ZGF6bytvcGVudnBuQC4uLjIxMDguLi48L2E+PGJyPg0KJmd0O8KgIMKgIMKgIMKg
IMKgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86ZGF6byUyNTJCb3BlbnZwbkAuLi4yMTA4Li4u
IiB0YXJnZXQ9Il9ibGFuayI+ZGF6byUyQm9wZW52cG5ALi4uMjEwOC4uLjwvYT4mZ3Q74oCs4oCP
Jmd0OzrigKw8YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgUGxlYXNlIHN0b3Agbm93Ljxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgQSBjbGllbnQgd2hpY2ggY2Fubm90IHJlYWNoIGEgc2VydmVyIGJlY2F1c2UgdGhlIGNsaWVu
dCBzaWRlPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgaGFzPGJyPg0KJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgY29ubmVjdGl2aXR5IGlzc3VlcyB0b3dhcmRzIHRoZSBzZXJ2ZXIgaXMgbm90
IGEgRG9TLCBpdCBpczxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoG5vdCBhIENWRSBhbmQ8
YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqB3aWxsIG5ldmVyIGJlIGNvbnNpZGVyZWQgYSBz
ZWN1cml0eSBpc3N1ZS48YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoEZp
cnN0IG9mIGFsbCwgYSBEb1MgYXR0YWNrIGlzIGNvbW1vbmx5IHJlbGF0ZWQgdG8gYSBTRVJWRVI8
YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBiZWNvbWluZzxicj4NCiZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoHVucmVzcG9uc2l2ZSBkdWUgdG8gdHJhZmZpYyB0byB0aGUgc2VydmVyIGNhdXNp
bmcgaXQgdG8gc3RvcDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoHJlc3BvbmRpbmcuPGJy
Pg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE9yIHRoYXQgb25lIFZQTiBjbGllbnRzIG1p
c2JlaGF2aW91ciAobm90IGR1ZSB0bzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoG1pc2Nv
bmZpZ3VyYXRpb24sPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgdGhvdWdoKSByZXN1bHRz
IGluIG5vIG90aGVyIGNsaWVudHMgYmVpbmcgYWJsZSB0byBjb25uZWN0Ljxicj4NCiZndDsgPGJy
Pg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgV2hhdCB5b3UgaGF2ZSBkZXNjcmliZWQgc28gZmFy
IGlzIHRoYXQgeW91IGNhbm5vdCByZWFjaCB0aGU8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqBzZXJ2ZXIuwqAgQW5kPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgT3BlblZQTiB0cmll
cyB0byByZWNvbm5lY3QgcmVndWxhcmx5LsKgIFRoaXMgaXMgdGhlIGV4cGVjdGVkPGJyPg0KJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgYmVoYXZpb3VyIG9mPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgbW9zdCBWUE4gY2xpZW50cyAtIHRoZXkgdHJ5IHRvIGtlZXAgdGhlIHR1bm5lbCBydW5u
aW5nIHdpdGg8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBhcyBsaXR0bGU8YnI+DQomZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqB1c2VyIGludGVyYWN0aW9uIGFzIHBvc3NpYmxlLsKgIFRoZSBi
YWNrLW9mZiB0aW1lciBpcyB0aGVyZTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoHRvIGFs
c288YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBuZWVkbGVzc2x5IGtlZXAgdHJ5aW5nIGlm
IHRoZXJlIHNlZW1zIHRvIGJlIGxvbmdlciBwZXJzaXN0aW5nPGJyPg0KJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgY29ubmVjdGl2aXR5IGlzc3Vlcy48YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoEFuZCBqdXN0IHRvIGVudGVydGFpbiB5b3UgYSBiaXQgbW9yZS7CoCBUaGlz
IGlzIHRoZSBsb2dzIHdoZW48YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqB1c2luZzxicj4N
CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoE9wZW5WUE4gMyBMaW51eDo8YnI+DQomZ3Q7IDxicj4N
CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+DQomZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqBQcmVzcyBDVFJMLUMgdG8gc3RvcCB0aGUgY29ubmVjdGlvbjxicj4N
CiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgMjAyNC0xMS0xOCAwOTo1OToxOS44
NTQ1NjggW1NUQVRVU10gKFN0YXR1c01ham9yLkNPTk5FQ1RJT04sPGJyPg0KJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgU3RhdHVzTWlub3IuQ0ZHX09LKTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoGNvbmZpZ19wYXRoPS9uZXQvb3BlbnZwbi92My9jb25maWd1cmF0aW9uLzRjMmJiYTM2eDIx
NTF4NDI5MXhiN2FjeDM2MDAwMDM3NWQyYTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoDIw
MjQtMTEtMTggMDk6NTk6MTkuODU0NjM2IFtMT0ddIFN0YXJ0aW5nIGNvbm5lY3Rpb248YnI+DQom
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAyMDI0LTExLTE4IDA5OjU5OjE5Ljg1NDY5NCBbTE9HXSBV
c2luZyBETlMgcmVzb2x2ZXIgc2NvcGU6PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgZ2xv
YmFsPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgMjAyNC0xMS0xOCAwOTo1OToxOS44NjIz
NjkgW0xPR10gW0Nvbm5lY3RdIERDTyBmbGFnOiBkaXNhYmxlZDxicj4NCiZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoDIwMjQtMTEtMTggMDk6NTk6MTkuODYyNDc5IFtTVEFUVVNdIChTdGF0dXNNYWpv
ci5DT05ORUNUSU9OLDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoFN0YXR1c01pbm9yLkNP
Tk5fQ09OTkVDVElORyk8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAyMDI0LTExLTE4IDA5
OjU5OjE5Ljg2MjU0OCBbTE9HXSBbQ29yZV0gT3BlblZQTiBjb3JlIHYzLjEwLjE8YnI+DQomZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqBsaW51eDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoHg4
Nl82NCA2NC1iaXQgT1ZQTi1EQ088YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAyMDI0LTEx
LTE4IDA5OjU5OjE5Ljg2MjU5NiBbTE9HXSBbQ29yZV0gRnJhbWU9NTEyLzIxMTIvNTEyPGJyPg0K
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgbXNzZml4LWN0cmw9MTI1MDxicj4NCiZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoDIwMjQtMTEtMTggMDk6NTk6MTkuODYyNjM2IFtMT0ddIFJlc29sdmluZzxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoDIwMjQtMTEtMTggMDk6NTk6MTkuODY2NTI1IFtM
T0ddIFtDb3JlXSBDb250YWN0aW5nPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgPGEgaHJl
Zj0iaHR0cDovLzEwMy42LjE3MC4yMToxMTk0IiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2Js
YW5rIj4xMDMuNi4xNzAuMjE6MTE5NDwvYT4gJmx0OzxhIGhyZWY9Imh0dHA6Ly8xMDMuNi4xNzAu
MjE6MTE5NCIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cDovLzEwMy42LjE3
MC4yMToxMTk0PC9hPiZndDsgdmlhIFVEUDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoDIw
MjQtMTEtMTggMDk6NTk6MTkuODY2NjM4IFtMT0ddIFdhaXRpbmcgZm9yIHNlcnZlciByZXNwb25z
ZTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoDIwMjQtMTEtMTggMDk6NTk6MTkuODc4NTA1
IFtMT0ddIFtDb3JlXSBDb25uZWN0aW5nIHRvPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
WzEwMy42LjE3MC4yMV06MTE5NCAoMTAzLjYuMTcwLjIxKSB2aWEgVURQPGJyPg0KJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgMjAyNC0xMS0xOCAwOTo1OToyOS44NjE3MzMgW0xPR10gW0NvcmVdIFNl
cnZlciBwb2xsIHRpbWVvdXQsPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgdHJ5aW5nIG5l
eHQ8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqByZW1vdGUgZW50cnkuLi48YnI+DQomZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAyMDI0LTExLTE4IDA5OjU5OjI5Ljg2MTg3NSBbTE9HXSBSZXNv
bHZpbmc8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAyMDI0LTExLTE4IDA5OjU5OjI5Ljg2
NTY0OCBbTE9HXSBbQ29yZV0gQ29udGFjdGluZzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDC
oDxhIGhyZWY9Imh0dHA6Ly8xMDMuNi4xNzAuMjE6MTE5NCIgcmVsPSJub3JlZmVycmVyIiB0YXJn
ZXQ9Il9ibGFuayI+MTAzLjYuMTcwLjIxOjExOTQ8L2E+ICZsdDs8YSBocmVmPSJodHRwOi8vMTAz
LjYuMTcwLjIxOjExOTQiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly8x
MDMuNi4xNzAuMjE6MTE5NDwvYT4mZ3Q7IHZpYSBVRFA8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAg
wqAgwqAyMDI0LTExLTE4IDA5OjU5OjI5Ljg2NTc2OSBbTE9HXSBXYWl0aW5nIGZvciBzZXJ2ZXIg
cmVzcG9uc2U8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAyMDI0LTExLTE4IDA5OjU5OjI5
Ljg3NjI5OSBbTE9HXSBbQ29yZV0gQ29ubmVjdGluZyB0bzxicj4NCiZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoFsxMDMuNi4xNzAuMjFdOjExOTQgKDEwMy42LjE3MC4yMSkgdmlhIFVEUDxicj4NCiZn
dDvCoCDCoCDCoCDCoCDCoCDCoCDCoDIwMjQtMTEtMTggMDk6NTk6MzkuODYyMjU0IFtMT0ddIFtD
b3JlXSBTZXJ2ZXIgcG9sbCB0aW1lb3V0LDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoHRy
eWluZyBuZXh0PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgcmVtb3RlIGVudHJ5Li4uPGJy
Pg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgMjAyNC0xMS0xOCAwOTo1OTozOS44NjIzNDcgW0xP
R10gUmVzb2x2aW5nPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgMjAyNC0xMS0xOCAwOTo1
OTozOS44NjYxNTcgW0xPR10gW0NvcmVdIENvbnRhY3Rpbmc8YnI+DQomZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqA8YSBocmVmPSJodHRwOi8vMTAzLjYuMTcwLjIxOjExOTQiIHJlbD0ibm9yZWZlcnJl
ciIgdGFyZ2V0PSJfYmxhbmsiPjEwMy42LjE3MC4yMToxMTk0PC9hPiAmbHQ7PGEgaHJlZj0iaHR0
cDovLzEwMy42LjE3MC4yMToxMTk0IiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5o
dHRwOi8vMTAzLjYuMTcwLjIxOjExOTQ8L2E+Jmd0OyB2aWEgVURQPGJyPg0KJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgMjAyNC0xMS0xOCAwOTo1OTozOS44NjYyNjIgW0xPR10gV2FpdGluZyBmb3Ig
c2VydmVyIHJlc3BvbnNlPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgMjAyNC0xMS0xOCAw
OTo1OTozOS44NzcyODggW0xPR10gW0NvcmVdIENvbm5lY3RpbmcgdG88YnI+DQomZ3Q7wqAgwqAg
wqAgwqAgwqAgwqAgwqBbMTAzLjYuMTcwLjIxXToxMTk0ICgxMDMuNi4xNzAuMjEpIHZpYSBVRFA8
YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAyMDI0LTExLTE4IDA5OjU5OjQ5Ljg2Mjc1NyBb
TE9HXSBbQ29yZV0gU2VydmVyIHBvbGwgdGltZW91dCw8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAg
wqAgwqB0cnlpbmcgbmV4dDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoHJlbW90ZSBlbnRy
eS4uLjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoDIwMjQtMTEtMTggMDk6NTk6NDkuODYy
ODUyIFtMT0ddIFJlc29sdmluZzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoDIwMjQtMTEt
MTggMDk6NTk6NDkuODY2NTE0IFtMT0ddIFtDb3JlXSBDb250YWN0aW5nPGJyPg0KJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgPGEgaHJlZj0iaHR0cDovLzEwMy42LjE3MC4yMToxMTk0IiByZWw9Im5v
cmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj4xMDMuNi4xNzAuMjE6MTE5NDwvYT4gJmx0OzxhIGhy
ZWY9Imh0dHA6Ly8xMDMuNi4xNzAuMjE6MTE5NCIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9i
bGFuayI+aHR0cDovLzEwMy42LjE3MC4yMToxMTk0PC9hPiZndDsgdmlhIFVEUDxicj4NCiZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoDIwMjQtMTEtMTggMDk6NTk6NDkuODY2NjE0IFtMT0ddIFdhaXRp
bmcgZm9yIHNlcnZlciByZXNwb25zZTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoDIwMjQt
MTEtMTggMDk6NTk6NDkuODc1OTk4IFtMT0ddIFtDb3JlXSBDb25uZWN0aW5nIHRvPGJyPg0KJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgWzEwMy42LjE3MC4yMV06MTE5NCAoMTAzLjYuMTcwLjIxKSB2
aWEgVURQPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgMjAyNC0xMS0xOCAwOTo1OTo1OS44
NjMwNDcgW0xPR10gW0NvcmVdIFNlcnZlciBwb2xsIHRpbWVvdXQsPGJyPg0KJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgdHJ5aW5nIG5leHQ8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqByZW1v
dGUgZW50cnkuLi48YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAyMDI0LTExLTE4IDA5OjU5
OjU5Ljg2MzE3OSBbTE9HXSBSZXNvbHZpbmc8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAy
MDI0LTExLTE4IDA5OjU5OjU5Ljg2NjY5OSBbTE9HXSBbQ29yZV0gQ29udGFjdGluZzxicj4NCiZn
dDvCoCDCoCDCoCDCoCDCoCDCoCDCoDxhIGhyZWY9Imh0dHA6Ly8xMDMuNi4xNzAuMjE6MTE5NCIg
cmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+MTAzLjYuMTcwLjIxOjExOTQ8L2E+ICZs
dDs8YSBocmVmPSJodHRwOi8vMTAzLjYuMTcwLjIxOjExOTQiIHJlbD0ibm9yZWZlcnJlciIgdGFy
Z2V0PSJfYmxhbmsiPmh0dHA6Ly8xMDMuNi4xNzAuMjE6MTE5NDwvYT4mZ3Q7IHZpYSBVRFA8YnI+
DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAyMDI0LTExLTE4IDA5OjU5OjU5Ljg2Njc5OCBbTE9H
XSBXYWl0aW5nIGZvciBzZXJ2ZXIgcmVzcG9uc2U8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAyMDI0LTExLTE4IDA5OjU5OjU5Ljg3NjcyNCBbTE9HXSBbQ29yZV0gQ29ubmVjdGluZyB0bzxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoFsxMDMuNi4xNzAuMjFdOjExOTQgKDEwMy42LjE3
MC4yMSkgdmlhIFVEUDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoDIwMjQtMTEtMTggMTA6
MDA6MDkuODYzMTQ2IFtMT0ddIFtDb3JlXSBTZXJ2ZXIgcG9sbCB0aW1lb3V0LDxicj4NCiZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoHRyeWluZyBuZXh0PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgcmVtb3RlIGVudHJ5Li4uPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgMjAyNC0xMS0x
OCAxMDowMDowOS44NjMyNDIgW0xPR10gUmVzb2x2aW5nPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgMjAyNC0xMS0xOCAxMDowMDowOS44NjczMDUgW0xPR10gW0NvcmVdIENvbnRhY3Rpbmc8
YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqA8YSBocmVmPSJodHRwOi8vMTAzLjYuMTcwLjIx
OjExOTQiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPjEwMy42LjE3MC4yMToxMTk0
PC9hPiAmbHQ7PGEgaHJlZj0iaHR0cDovLzEwMy42LjE3MC4yMToxMTk0IiByZWw9Im5vcmVmZXJy
ZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwOi8vMTAzLjYuMTcwLjIxOjExOTQ8L2E+Jmd0OyB2aWEg
VURQPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgMjAyNC0xMS0xOCAxMDowMDowOS44Njc0
MDYgW0xPR10gV2FpdGluZyBmb3Igc2VydmVyIHJlc3BvbnNlPGJyPg0KJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgMjAyNC0xMS0xOCAxMDowMDowOS44NzkyOTIgW0xPR10gW0NvcmVdIENvbm5lY3Rp
bmcgdG88YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBbMTAzLjYuMTcwLjIxXToxMTk0ICgx
MDMuNi4xNzAuMjEpIHZpYSBVRFA8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAyMDI0LTEx
LTE4IDEwOjAwOjE5Ljg2MzQ5OSBbTE9HXSBbQ29yZV0gU2VydmVyIHBvbGwgdGltZW91dCw8YnI+
DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqB0cnlpbmcgbmV4dDxicj4NCiZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoHJlbW90ZSBlbnRyeS4uLjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoDIw
MjQtMTEtMTggMTA6MDA6MTkuODYzNjIzIFtMT0ddIFJlc29sdmluZzxicj4NCiZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoDIwMjQtMTEtMTggMTA6MDA6MTkuODY3NzU4IFtMT0ddIFtDb3JlXSBDb250
YWN0aW5nPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgPGEgaHJlZj0iaHR0cDovLzEwMy42
LjE3MC4yMToxMTk0IiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj4xMDMuNi4xNzAu
MjE6MTE5NDwvYT4gJmx0OzxhIGhyZWY9Imh0dHA6Ly8xMDMuNi4xNzAuMjE6MTE5NCIgcmVsPSJu
b3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cDovLzEwMy42LjE3MC4yMToxMTk0PC9hPiZn
dDsgdmlhIFVEUDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoDIwMjQtMTEtMTggMTA6MDA6
MTkuODY3ODQ1IFtMT0ddIFdhaXRpbmcgZm9yIHNlcnZlciByZXNwb25zZTxicj4NCiZndDvCoCDC
oCDCoCDCoCDCoCDCoCDCoDIwMjQtMTEtMTggMTA6MDA6MTkuODc5MDY2IFtMT0ddIFtDb3JlXSBD
b25uZWN0aW5nIHRvPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgWzEwMy42LjE3MC4yMV06
MTE5NCAoMTAzLjYuMTcwLjIxKSB2aWEgVURQPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
XkM8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBEaXNjb25uZWN0aW5nLi4uPGJyPg0KJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgQ29ubmVjdGlvbiBzdGF0aXN0aWNzOjxicj4NCiZndDvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEJZVEVTX09V
VDogMjgxNDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoFBBQ0tFVFNfT1VUOiA2Nzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE5fUkVDT05ORUNUOiA2PGJyPg0KJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxicj4NCiZndDsgPGJyPg0KJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgVGhpcyBuZWVkcyB0byBzdG9wLsKgIFRoaXMgaXMgbm90IGEgQ1ZF
LsKgIFRoaXMgaXMgYW4gT3BlblZQTjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoHNlcnZl
ciB3aGljaDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoGRvZXNuJiMzOTt0IHJlc3BvbmQg
b24gcG9ydCAxMTk0L3VkcC48YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDC
oElmIHlvdSB3YW50IHRvIGtlZXAgc29tZSBraW5kIG9mIGNyZWRpYmlsaXR5IHdpdGggYW55PGJy
Pg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgc2VjdXJpdHkgdGVhbXMsPGJyPg0KJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgeW91IG5lZWQgdG8gYmFjayBkb3duIGFuZCBzcGVuZCB0aW1lIGxvb2tp
bmcgZm9yIHJlYWwgaXNzdWVzPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgYW5kPGJyPg0K
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgZG9jdW1lbnQgaXQgZmFyIGJldHRlci7CoCBBbmQgeW91
IHdpbGwgbmVlZCB0byBwcm92aWRlIHRoZTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoHNl
cnZlciBzaWRlPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgcGVyc3BlY3RpdmUgYXMgd2Vs
bCwgbm90IGp1c3QgdGhlIGNsaWVudCBzaWRlLjxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgT25jZSBhZ2FpbjogQ2xpZW50cyBub3QgYmVpbmcgYWJsZSB0byBjb25uZWN0
IHRvIHRoZSBzZXJ2ZXI8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBiZWNhdXNlIG9mPGJy
Pg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgbmV0d29yayBjb25uZWN0aXZpdHkgaXNzdWVzIGlz
IG5vdCBhIENWRS48YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgVGhpcyBjYXNlIGlzIGNsb3NlZC48YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgLS0gPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKga2lu
ZCByZWdhcmRzLDxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgRGF2aWQg
U29tbWVyc2V0aDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoE9wZW5WUE4gSW5jPGJyPg0K
Jmd0OyA8YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
T24gMTgvMTEvMjAyNCAwODozNywg16DXqteZINep15jXqNefIHdyb3RlOjxicj4NCiZndDvCoCDC
oCDCoCDCoCDCoCDCoCDCoCAmZ3Q7IFdoYXQgY2FuIEkgZG8gdG8gYXNzaWduIGEgQ1ZFPzxicj4N
CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7wqAgwqBJIGF0dGFjaGVkIHRoZSBDVkUgdGVh
bSBvZiBJU1JBRUzCoENFUlTCoCB0byBjb252ZXJzYXRpb248YnI+DQomZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7IHRueDxicj4N
CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgICZndDsg4oCr15HXqteQ16jXmdeaINeZ15XXnSDXkdezLCAxOCDXkdeg15XXkdezIDIwMjQg
15EtOToyOSDXnteQ16og4oCq0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L3igKzigI88YnI+DQomZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyAmbHQ74oCqPGEgaHJlZj0ibWFpbHRvOmNoaXBpdHNp
bmVALi4uMjc3Li4uIiB0YXJnZXQ9Il9ibGFuayI+Y2hpcGl0c2luZUAuLi4yNzcuLi48L2E+ICZs
dDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOmNoaXBpdHNpbmVALi4uMjc3Li4uIiB0YXJnZXQ9Il9i
bGFuayI+Y2hpcGl0c2luZUAuLi4yNzcuLi48L2E+Jmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoCZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOmNoaXBpdHNpbmVALi4uMjc3Li4uIiB0
YXJnZXQ9Il9ibGFuayI+Y2hpcGl0c2luZUAuLi4yNzcuLi48L2E+ICZsdDttYWlsdG86PGEgaHJl
Zj0ibWFpbHRvOmNoaXBpdHNpbmVALi4uMjc3Li4uIiB0YXJnZXQ9Il9ibGFuayI+Y2hpcGl0c2lu
ZUAuLi4yNzcuLi48L2E+Jmd0OyZndDvigKzigI8mZ3Q7OuKArDxicj4NCiZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoCAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgICZndDvCoCDCoCDC
oEFzIG1hbnkgZGV0YWlscyBhcyBwb3NzaWJsZS4gQ29uZmlndXJhdGlvbiBmaWxlPGJyPg0KJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgdXN1YWxseSBoZWxwcy48YnI+DQomZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBP
dGhlciB0aGFuIHRoYXQgYWxzbyBzZXJ2ZXIgc2lkZSBsb2dzIGFyZSBuaWNlIHRvPGJyPg0KJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgaGF2ZS4gQXMgd2VsbCBhczxicj4NCiZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoCAmZ3Q7wqAgwqAgwqB0aGUgZGV0YWlsZWQgcmVwcm8gc3RlcHM8YnI+DQomZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCAm
Z3Q7wqAgwqAgwqBPbiBNb24sIE5vdiAxOCwgMjAyNCwgMDg6Mjcg16DXqteZINep15jXqNefPGJy
Pg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmx0OzxhIGhyZWY9Im1haWx0bzpuc2g1MzFALi4u
Mjc3Li4uIiB0YXJnZXQ9Il9ibGFuayI+bnNoNTMxQC4uLjI3Ny4uLjwvYT4gJmx0O21haWx0bzo8
YSBocmVmPSJtYWlsdG86bnNoNTMxQC4uLjI3Ny4uLiIgdGFyZ2V0PSJfYmxhbmsiPm5zaDUzMUAu
Li4yNzcuLi48L2E+Jmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7wqAgwqAg
wqAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpuc2g1MzFALi4uMjc3Li4uIiB0YXJnZXQ9Il9i
bGFuayI+bnNoNTMxQC4uLjI3Ny4uLjwvYT4gJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86bnNo
NTMxQC4uLjI3Ny4uLiIgdGFyZ2V0PSJfYmxhbmsiPm5zaDUzMUAuLi4yNzcuLi48L2E+Jmd0OyZn
dDsmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgd3JvdGU6PGJyPg0KJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgICZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0O8Kg
IMKgIMKgIMKgIMKgRG8geW91IHdhbnQgdGhlIGNvbmZpZ3VyYXRpb24gZmlsZT88YnI+DQomZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCAm
Z3Q7wqAgwqAgwqAgwqAgwqDigKvXkdeq15DXqNeZ15og15nXldedINeR17MsIDE4INeR16DXldeR
17MgMjAyNCDXkS05OjE0INee15DXqiDigKpHZXJ0PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgRG9lcmluZ+KArOKAjzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7wqAgwqAg
wqAgwqAgwqAmbHQ74oCqPGEgaHJlZj0ibWFpbHRvOmdlcnRALi4uMTI5Ni4uLiIgdGFyZ2V0PSJf
YmxhbmsiPmdlcnRALi4uMTI5Ni4uLjwvYT48YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAm
bHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpnZXJ0QC4uLjEyOTYuLi4iIHRhcmdldD0iX2JsYW5r
Ij5nZXJ0QC4uLjEyOTYuLi48L2E+Jmd0OyAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpnZXJ0
QC4uLjEyOTYuLi4iIHRhcmdldD0iX2JsYW5rIj5nZXJ0QC4uLjEyOTYuLi48L2E+PGJyPg0KJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86Z2VydEAuLi4x
Mjk2Li4uIiB0YXJnZXQ9Il9ibGFuayI+Z2VydEAuLi4xMjk2Li4uPC9hPiZndDsmZ3Q74oCs4oCP
Jmd0OzrigKw8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0Ozxicj4NCiZndDvCoCDC
oCDCoCDCoCDCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBIaSw8YnI+DQomZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqBPbiBNb24sIE5vdiAxOCwgMjAyNCBhdCAwOTowOTo1N0FNICsw
MjAwLDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoD8/Pz8/PyA/Pz8/Pz8/PyB3cm90ZTo8
YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgICZn
dDsgSSBkb24mIzM5O3QgaGF2ZSBhY2Nlc3MgdG8gc2VydmVyIGxvZ3MsIEkgc2VudDxicj4NCiZn
dDvCoCDCoCDCoCDCoCDCoCDCoCDCoHlvdSB0aGUgY2xpZW50PGJyPg0KJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoGxvZ3MgYXMgd2VsbCBhczxicj4NCiZn
dDvCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyB0aGUg
bGluZSBwb2ludGluZyB0byB0aGUgRG9TOjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCAm
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyBUTFMgRXJyb3I6IFRMUyBrZXkgbmVnb3RpYXRp
b24gZmFpbGVkIHRvPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgb2NjdXIgd2l0aGluIDU8
YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgc2Vj
b25kczxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgJmd0OyBTSUdVU1IxW3NvZnQsdGxzLWVycm9yXSByZWNlaXZlZCwgcHJvY2Vzczxicj4NCiZn
dDvCoCDCoCDCoCDCoCDCoCDCoCDCoHJlc3RhcnRpbmc8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAg
wqAgwqAgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqBXaGF0IG1ha2VzIHlvdSB0aGluayBpdCYjMzk7cyBhIERvUyB0aGF0IGNhbiBiZTxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoGZpeGVkIGJ5IGEgY29kZTxicj4NCiZndDvCoCDC
oCDCoCDCoCDCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBjaGFuZ2U/PGJyPg0KJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgICZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgSWYgeW91IGJyZWFrIHRoZSBuZXR3b3JrLCBwcm9ncmFt
cyB3aWxsIG5vdDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoGJlIGFibGUgdG88YnI+DQom
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgY29ubmVjdCAt
IGFuZCB0aGVyZTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqBpcyBub3RoaW5nICZxdW90O2EgcGF0Y2ggdG8gdGhlIHNvZnR3YXJlJnF1b3Q7IHdp
bGwgYmU8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBhYmxlIHRvIGZpeC48YnI+DQomZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCAm
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBnZXJ0PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoC0tPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90O0lmIHdhcyBvbmUgdGhpbmcgYWxsIHBlb3Bs
ZSB0b29rIGZvcjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoGdyYW50ZWQsIHdhczxicj4N
CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBjb252aWN0
aW9uIHRoYXQgaWYgeW91PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgICZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGZlZWQgaG9uZXN0IGZpZ3VyZXMgaW50byBhIGNvbXB1dGVyLCBob25l
c3Q8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBmaWd1cmVzIGNvbWU8YnI+DQomZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgb3V0LiBOZXZlciBkb3Vi
dGVkPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgICZndDvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGl0IG15c2VsZiB0aWxsIEkgbWV0IGEgY29tcHV0ZXIgd2l0aCBhPGJyPg0KJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgc2Vuc2Ugb2YgaHVtb3IuJnF1b3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoFJvYmVydCBBLjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoEhlaW5sZWluLCBUaGUgTW9vbjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqBpcyBhIEhhcnNoIE1pc3RyZXNzPGJyPg0KJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgICZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgR2VydCBEb2VyaW5nIC0gTXVuaWNoLCBHZXJtYW55PGJyPg0KJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgPGEgaHJlZj0ibWFpbHRvOmdlcnRALi4uMTI5Ni4uLiIgdGFyZ2V0
PSJfYmxhbmsiPmdlcnRALi4uMTI5Ni4uLjwvYT4gJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86
Z2VydEAuLi4xMjk2Li4uIiB0YXJnZXQ9Il9ibGFuayI+Z2VydEAuLi4xMjk2Li4uPC9hPiZndDs8
YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmx0
O21haWx0bzo8YSBocmVmPSJtYWlsdG86Z2VydEAuLi4xMjk2Li4uIiB0YXJnZXQ9Il9ibGFuayI+
Z2VydEAuLi4xMjk2Li4uPC9hPjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZsdDttYWls
dG86PGEgaHJlZj0ibWFpbHRvOmdlcnRALi4uMTI5Ni4uLiIgdGFyZ2V0PSJfYmxhbmsiPmdlcnRA
Li4uMTI5Ni4uLjwvYT4mZ3Q7Jmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7
PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgICZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAg
wqAgwqAtLTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgwqAgwqAm
bHQ7PGEgaHJlZj0iaHR0cHM6Ly9uZXRhbmVsLm1sIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0i
X2JsYW5rIj5odHRwczovL25ldGFuZWwubWw8L2E+ICZsdDs8YSBocmVmPSJodHRwczovL25ldGFu
ZWwubWwiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vbmV0YW5lbC5t
bDwvYT4mZ3Q7Jmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAg
wqAgwqBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzxicj4N
CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgwqAgwqBPcGVudnBuLWRldmVs
IG1haWxpbmcgbGlzdDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCAmZ3Q7IDxhIGhyZWY9
Im1haWx0bzpPcGVudnBuLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldCIgdGFyZ2V0PSJfYmxh
bmsiPk9wZW52cG4tZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0PC9hPjxicj4NCiZndDvCoCDC
oCDCoCDCoCDCoCDCoCDCoCZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOk9wZW52cG4tZGV2ZWxA
bGlzdHMuc291cmNlZm9yZ2UubmV0IiB0YXJnZXQ9Il9ibGFuayI+T3BlbnZwbi1kZXZlbEBsaXN0
cy5zb3VyY2Vmb3JnZS5uZXQ8L2E+Jmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCAm
Z3Q7wqAgwqAgwqAgwqAgwqAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpPcGVudnBuLWRldmVs
QGxpc3RzLnNvdXJjZWZvcmdlLm5ldCIgdGFyZ2V0PSJfYmxhbmsiPk9wZW52cG4tZGV2ZWxAbGlz
dHMuc291cmNlZm9yZ2UubmV0PC9hPjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZsdDtt
YWlsdG86PGEgaHJlZj0ibWFpbHRvOk9wZW52cG4tZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0
IiB0YXJnZXQ9Il9ibGFuayI+T3BlbnZwbi1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQ8L2E+
Jmd0OyZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0Ozxicj4NCiZndDvCoCDC
oCDCoCDCoCDCoCDCoCDCoDxhIGhyZWY9Imh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xp
c3RzL2xpc3RpbmZvL29wZW52cG4tZGV2ZWwiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxh
bmsiPmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL29wZW52cG4t
ZGV2ZWw8L2E+PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmx0OzxhIGhyZWY9Imh0dHBz
Oi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL29wZW52cG4tZGV2ZWwiIHJl
bD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2Uu
bmV0L2xpc3RzL2xpc3RpbmZvL29wZW52cG4tZGV2ZWw8L2E+Jmd0Ozxicj4NCiZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgwqA8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAmbHQ7PGEgaHJlZj0iaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlz
dGluZm8vb3BlbnZwbi1kZXZlbCIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0
cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vb3BlbnZwbi1kZXZlbDwv
YT4gJmx0OzxhIGhyZWY9Imh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3Rp
bmZvL29wZW52cG4tZGV2ZWwiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBz
Oi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL29wZW52cG4tZGV2ZWw8L2E+
Jmd0OyZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0Ozxicj4NCiZndDvCoCDC
oCDCoCDCoCDCoCDCoCDCoCAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgICZndDs8
YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgJmd0OyAtLTxicj4NCiZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoCAmZ3Q7ICZsdDs8YSBocmVmPSJodHRwczovL25ldGFuZWwubWwiIHJlbD0ibm9y
ZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vbmV0YW5lbC5tbDwvYT4gJmx0OzxhIGhy
ZWY9Imh0dHBzOi8vbmV0YW5lbC5tbCIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+
aHR0cHM6Ly9uZXRhbmVsLm1sPC9hPiZndDsmZ3Q7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4N
CiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoC0tIDxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoCZsdDs8YSBocmVmPSJodHRwczovL25ldGFuZWwubWwiIHJl
bD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vbmV0YW5lbC5tbDwvYT4mZ3Q7
PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0OyAtLSA8YnI+DQomZ3Q7
ICZsdDs8YSBocmVmPSJodHRwczovL25ldGFuZWwubWwiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0
PSJfYmxhbmsiPmh0dHBzOi8vbmV0YW5lbC5tbDwvYT4mZ3Q7PGJyPg0KPGJyPg0KPGJyPg0KPC9i
bG9ja3F1b3RlPjwvZGl2PjxkaXY+PGJyIGNsZWFyPSJhbGwiPjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxzcGFuIGNsYXNzPSJnbWFpbF9zaWduYXR1cmVfcHJlZml4Ij4tLSA8L3NwYW4+PGJyPjxkaXYg
ZGlyPSJydGwiIGNsYXNzPSJnbWFpbF9zaWduYXR1cmUiPjxkaXYgZGlyPSJydGwiPjxhIGhyZWY9
Imh0dHBzOi8vbmV0YW5lbC5tbCIgdGFyZ2V0PSJfYmxhbmsiPjxpbWcgd2lkdGg9IjIwMCIgaGVp
Z2h0PSI1MSIgc3JjPSJodHRwczovL2NpMy5nb29nbGV1c2VyY29udGVudC5jb20vbWFpbC1zaWcv
QUlvcks0eTFhaFpnMG1xSDVVbkRDaktJa1c2RlRTbmk1UjViZXpTMWlkU1JFQ082R1hRMXVIM1Jn
RUxYazhScXFDb05rMzk4NV9qc25JUW5uY2xvIj48L2E+PC9kaXY+PC9kaXY+DQo=

--000000000000aa061106273fc761--


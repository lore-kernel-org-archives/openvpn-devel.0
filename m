References: <562EB0A1.8010403@...2070...> <56307DAA.30700@...2070...>
	<CAKuzo_hn+jSim98XcDSUPpMmvCiqEtfRBVjpPouHn__qFciErA@...278...>
From: ValdikSS <iam@...2070...>
Message-ID: <56479784.9090109@...2070...>
Date: Sat, 14 Nov 2015 23:20:20 +0300
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hn+jSim98XcDSUPpMmvCiqEtfRBVjpPouHn__qFciErA@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="h70W6KL8mQf8NxvwqCfdMVquGGBnVALO9"
Subject: Re: [Openvpn-devel] [PATCH v2] Add Windows DNS Leak fix using WFP
 ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h70W6KL8mQf8NxvwqCfdMVquGGBnVALO9
Content-Type: multipart/alternative;
	boundary="------------020706030903070002040207"

This is a multi-part message in MIME format.
--------------020706030903070002040207
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi.
It stops resolving DNS right after connection for me every time too, but th=
at lasts 15 seconds at most, not the minutes.
I've no idea what could be wrong. Lev has a similar issue. I can't reproduc=
e it in Windows 7, Windows 8.1 and Windows 10 on both VMs and real hardware.

On 14.11.2015 23:01, Selva Nair wrote:
> Hi,
>
> On Wed, Oct 28, 2015 at 3:47 AM, ValdikSS <iam@...2070... <mailto:iam@...493...=
2070...>> wrote:
>
> I tested this on Windows 7 and ran into some problems.
>
> Blocking dns through all interfaces except the tun/tap works (tested by s=
niffing the traffic etc.).
>
> But most often (see below) name resolution fails after the vpn is connect=
ed:
>
> openvpn: git-master + this patch locally compiled using mingw (64bit)
> LAN: IP (dhcp): 192.168.0.110  dns (dhcp): 1192.168.0.30
> TUN/TAP: IP (automatic): 10.9.0.10 dns (fixed): 8.8.8.8
> Windows firewall: disabled
>
> openvpn --config some-config.ovpn --block-outside-dns --verb4 --redirect-=
gateway def1
>
> Name resolution times-out  after connect (checked by ping and browser).  =
But nslookup continues to work, so direct connection to 8.8.8.8:53
> <http://8.8.8.8:53> via the tun is working. In this state, the only stran=
ge thing I notice is
>=20=20
> ipconfig /displaydns
> returns "Could not display the resolver cache".
> as if  the dnscache service is stopped, but it is running.
>
> Name resolution starts to work again after a
> (i) ipconfig /registerdns
> OR
> (ii) sc stop dnscache (starting it again is also ok)
> OR
> (iii) wait for several minutes
> /displaydns also displlays the cache correctly after that.
>
> On restarting the vpn (SIGHUP or SIGUSR1), it goes back to the non resolv=
ing state again. Once start working there are no obvious delays with dns --=
 tested
> only on a fast connection to the vpn server.
>
> I could not enable logging of the firewall without which its hard to say =
what's going on. I can only guess the system continues to try only 192.168.=
0.30 which
> gets blocked by the filter.
>
> So, how to enable firewall logging? -- enabling via netsh or Windows fire=
wall UI (wf.msc) does not generate any logs. Also the firewall rules added =
by the
> program does not show up in the firewall UI or in netsh advfirewall outpu=
ts. How to make these filters visible in the UI and how to log the dropped
> connections? The filters are in place and do work, but doesnt show up in =
the UI -- is that expected? The UI continues to show firewall as disabled w=
ith no
> filters in place.
>
> I couldn't find anything wrong with the code, but I'm not familiar with W=
FP.
>
> Thanks
> ,


--------------020706030903070002040207
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Type=
">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    Hi.<br>
    It stops resolving DNS right after connection for me every time too,
    but that lasts 15 seconds at most, not the minutes.<br>
    I've no idea what could be wrong. Lev has a similar issue. I can't
    reproduce it in Windows 7, Windows 8.1 and Windows 10 on both VMs
    and real hardware.<br>
    <br>
    <div class=3D"moz-cite-prefix">On 14.11.2015 23:01, Selva Nair wrote:<b=
r>
    </div>
    <blockquote
cite=3D"mid:CAKuzo_hn+jSim98XcDSUPpMmvCiqEtfRBVjpPouHn__qFciErA@...278..."
      type=3D"cite">
      <div dir=3D"ltr">
        <div>Hi,<br>
        </div>
        <br>
        <div>
          <div>
            <div class=3D"gmail_extra">
              <div class=3D"gmail_quote">On Wed, Oct 28, 2015 at 3:47 AM,
                ValdikSS <span dir=3D"ltr">&lt;<a moz-do-not-send=3D"true"
                    href=3D"mailto:iam@...2070..." target=3D"_blank">iam@...1186...=
.2070...</a>&gt;</span>
                wrote:<br>
                <div><br>
                </div>
                <div>I tested this on Windows 7 and ran into some
                  problems.<br>
                  <br>
                </div>
                <div>Blocking dns through all interfaces except the
                  tun/tap works (tested by sniffing the traffic etc.). <br>
                  <br>
                  But most often (see below) name resolution fails after
                  the vpn is connected:<br>
                  <br>
                </div>
                <div>openvpn: git-master + this patch locally compiled
                  using mingw (64bit)<br>
                </div>
                <div>LAN: IP (dhcp): 192.168.0.110=C2=A0 dns (dhcp):
                  1192.168.0.30<br>
                </div>
                <div>TUN/TAP: IP (automatic): 10.9.0.10 dns (fixed):
                  8.8.8.8<br>
                </div>
                <div>Windows firewall: disabled<br>
                  <br>
                </div>
                <div>openvpn --config some-config.ovpn
                  --block-outside-dns --verb4 --redirect-gateway def1<br>
                  <br>
                </div>
                <div>Name resolution times-out=C2=A0 after connect (checked
                  by ping and browser).=C2=A0 But nslookup continues to wor=
k,
                  so direct connection to <a moz-do-not-send=3D"true"
                    href=3D"http://8.8.8.8:53">8.8.8.8:53</a> via the tun
                  is working. In this state, the only strange thing I
                  notice is<br>
                  =C2=A0<br>
                  ipconfig /displaydns <br>
                  returns "Could not display the resolver cache". <br>
                </div>
                <div>as if=C2=A0 the dnscache service is stopped, but it is
                  running. <br>
                </div>
                <div><br>
                  Name resolution starts to work again after a<br>
                </div>
                <div>(i) ipconfig /registerdns<br>
                </div>
                <div>OR<br>
                </div>
                <div>(ii) sc stop dnscache (starting it again is also
                  ok)<br>
                </div>
                <div>OR<br>
                </div>
                <div>(iii) wait for several minutes<br>
                </div>
                <div>/displaydns also displlays the cache correctly
                  after that.<br>
                  <br>
                </div>
                <div>On restarting the vpn (SIGHUP or SIGUSR1), it goes
                  back to the non resolving state again. Once start
                  working there are no obvious delays with dns -- tested
                  only on a fast connection to the vpn server.<br>
                  <br>
                </div>
                <div>I could not enable logging of the firewall without
                  which its hard to say what's going on. I can only
                  guess the system continues to try only 192.168.0.30
                  which gets blocked by the filter.<br>
                  <br>
                </div>
                <div>So, how to enable firewall logging? -- enabling via
                  netsh or Windows firewall UI (wf.msc) does not
                  generate any logs. Also the firewall rules added by
                  the program does not show up in the firewall UI or in
                  netsh advfirewall outputs. How to make these filters
                  visible in the UI and how to log the dropped
                  connections? The filters are in place and do work, but
                  doesnt show up in the UI -- is that expected? The UI
                  continues to show firewall as disabled with no filters
                  in place.<br>
                  <br>
                </div>
                <div>I couldn't find anything wrong with the code, but
                  I'm not familiar with WFP. <br>
                  <br>
                </div>
                <div>Thanks<br>
                  ,<br>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------020706030903070002040207--

--h70W6KL8mQf8NxvwqCfdMVquGGBnVALO9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIcBAEBCAAGBQJWR5eEAAoJEFzXIC7viPdy3pwQAJFkz/ue42aeV0LLzd3/olVn
YLrUEWHFEbBWLqQhbbicOrZHfms5aytFEx4HNbWcRmObfrKMg5rZjxqVHpAnVyCE
yXM18V8yULtwdGiuVHIVf7pIxTDqQLbPwTiX89RT3jxA2iIZoLSInnXQV16383pC
NidEk5A5AyNSfOcd+CeSmq11h25PouJIG0Q4joHfEPgkiqDHUbIpouR8EZrmOAZe
Fc5E4+VZsfnVEBbt/xNxIlEmmoL3nFZFASc94tNNXaUYKkuGLNFMxLpPyJePVpPZ
AFq3Wo0k6YWhqeTMIw3mGHEtB9ifFN5Am7gYyc91BkJQH3RspH+9tk1Lb4PtDcJT
T8CK5zPsIuspCcrJfe4SgucZ3NxuCiodzNZkMv1BXWFdhsesTzeseuO4WWQAR/oC
cEat2HdXbbgGPNubUMtdKZ3qJkZODT6J8to5j2ov0dEH9aXvmSC928rSLjHuJk/5
s5rraJTYmd/3cf7YT5jgp3MtyK/xESNrf9h8tJ0FciR8ouYW5/TFo1XxmPlGqoOi
e7tQHx7rhsTpSSoegG+gpxT/gittcfjz/94sz5DF2WM1dDzG+LU4ukspQQvEO/7u
xSprvKN8SFxKMh1OhHrbwrYQIWvI+q7l4QzWdX8lRv3ljbcUarBtXhf/aXGigMyA
PvTXtpGCEWI6+dpI/tfJ
=KNFJ
-----END PGP SIGNATURE-----

--h70W6KL8mQf8NxvwqCfdMVquGGBnVALO9--


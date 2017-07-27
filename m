Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Karl Mueller <ewiley@...277...>
In-Reply-To: <CAKuzo_iwaB2cAWqd8xFuod5fLnDS8tUrSm-5SoEmz6F83-sMXg@...278...>
Date: Thu, 27 Jul 2017 14:01:32 -0400
Message-Id: <7A47FC49-E60F-4703-A093-80802FDB9B1C@...277...>
References: <334D9817-7B72-4E78-B0CB-BC65EC004037@...277...>
 <20170726143612.GJ70062@...1296...>
 <870CFEC0-4040-4DA0-A56B-E7CF835765A7@...277...>
 <CAKuzo_iwaB2cAWqd8xFuod5fLnDS8tUrSm-5SoEmz6F83-sMXg@...278...>
Subject: Re: [Openvpn-devel] TAP-adapter iftype question
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>=20
> This should be easy to test by editing the installed OemVista.inf  (in C:=
\Program Files\Tap-Windows\driver\ by default) and running addtap to create=
 a new adapter with the required iftype. The resulting interface will most =
likely not show up in the adapter list in control panel, but should show in=
 'openvpn --show-adapters=E2=80=99

Well, Win10 has very strict signing requirements and I have all secure boot=
 enabled machines, so I=E2=80=99m not able to easily break them to test :)
>=20
> But I do not think it will work: with iftype =3D 0x83 (131) the interface=
 will not get a physical address (MAC) etc. Further, the tap-windows driver=
 source sets the iftype as IF_TYPE_ETHERNET_CSMACD (=3D0x06) which is suppo=
sed to match the value in the inf file.

That would explain why editing the registry after it=E2=80=99s installed to=
 change the iftype does not work, if the driver itself is looking for the s=
pecific iftype. So I suppose there will have to be some further modificatio=
n of the driver code to accommodate this.
>=20
> I have a couple of wifi only win10 machines on which I have not seen this=
 disconnection behaviour.  Is it because I do not use redirect-gateway? Doe=
s the wifi disconnection happen only when default route is overwritten or i=
s even "--redirect-gateway def1" not immune to it?

I think it is due to the redirect-gateway, and def1 does not change the beh=
avior. I believe it=E2=80=99s because Windows sends NCSI internet probes to=
 determine if an adapter has =E2=80=9CInternet=E2=80=9D access. If you=E2=
=80=99re not redirecting your gateway, those probes will probably fail via =
the VPN interface so it won=E2=80=99t consider the VPN interface as a viabl=
e alternative.

A frustrating part of the problem is that Windows overrides the routing tab=
le by *silently* directing new connections to the =E2=80=9Cbetter=E2=80=9D =
Ethernet interface (in anticipation of the WiFi losing signal altogether, I=
 suppose).  The only way to observe this is to use the powershell command =
=E2=80=98find-netroute -remote <ip>=E2=80=99 which tells you where Windows =
will *really* send the packet. Also the effect of the redirection isn=E2=80=
=99t immediate, Windows waits from 30-120 seconds to start redirecting traf=
fic to the VPN interface once it detects weak WiFi signal.

Some more details of my setup: I use the Windows service-based VPN connecti=
on rather than user-initiated by way of openvpnserv2.exe.  We are using bui=
ld 1511 of Windows 10. I posted my configs here: https://forums.openvpn.net=
/viewtopic.php?f=3D4&t=3D24499

Thank you for taking the time to look at this.

Karl Mueller
ewiley@...277...

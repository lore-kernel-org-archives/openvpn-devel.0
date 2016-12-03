MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Sat, 3 Dec 2016 13:48:26 -0500
Message-ID: <CAKuzo_jj4H3toE0JXp-HNKBH5=Y_iXqVPKOndkycFTYmQoL0=g@...278...>
Content-Type: multipart/alternative; boundary=94eb2c05ab40308b6d0542c581b5
Subject: [Openvpn-devel] The windows installer and interactive service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c05ab40308b6d0542c581b5
Content-Type: text/plain; charset=UTF-8

Hi,

In the installer, interactive service is tied to the installation of
automatic service (openvpnserv2) --- if you opt not to install
openvpnserv2, interactive service is also disabled. You can install
openvpnserv2 without installing the interactive service, but not the other
way.

I think we should consider interactive service as a requirement for
properly running the GUI (note that we do not set the GUI to request admin
rights anymore). So I suggest:

1. Always install the interactive service along with openvpn core (and set
up the required HKLM registry entries) OR at least automatically select
interactive service if the GUI is selected.

I prefer the first option as that service doesn't do anything unless a
client connects to its service pipe, and has some uses even without the GUI.

2. Make it possible to uncheck automatic service (openvpnserv2)  without
unchecking interactive service.

A vast majority of installations would need only openvpn core, the GUI and
interactive service. Most users will not use the automatic service
(openvpnserv2) at all. Given that the latter requires .NET 4.0 which means
an additional 50MB+ download for some, a very slow installation and
possible restarts, forcing it on to get interactive service is not good.

That said we could still leave openvpnserv2 selected by default as changing
that at this stage may be unwise. Hopefully many Windows users may already
have .NET 4.0 or higher installed.

Thanks,

Selva

--94eb2c05ab40308b6d0542c581b5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div>Hi,<br><br></div>In the installer=
, interactive service is tied to the installation of automatic service (ope=
nvpnserv2) --- if you opt not to install openvpnserv2, interactive service =
is also disabled. You can install openvpnserv2 without installing the inter=
active service, but not the other way.<br><br></div>I think we should consi=
der interactive service as a requirement for properly running the GUI (note=
 that we do not set the GUI to request admin rights anymore). So I suggest:=
<br><br></div>1. Always install the interactive service along with openvpn =
core (and set up the required HKLM registry entries) OR at least automatica=
lly select interactive service if the GUI is selected. <br><br>I prefer the=
 first option as that service doesn&#39;t do anything unless a client conne=
cts to its service pipe, and has some uses even without the GUI.<br><br></d=
iv>2. Make it possible to uncheck automatic service (openvpnserv2)=C2=A0 wi=
thout unchecking interactive service.<br><br>A vast majority of installatio=
ns would need only openvpn core, the GUI and interactive service. Most user=
s will not use the automatic service (openvpnserv2) at all. Given that the =
latter requires .NET 4.0 which means an additional 50MB+ download for some,=
 a very slow installation and possible restarts, forcing it on to get inter=
active service is not good. <br></div><div><br>That said we could still lea=
ve openvpnserv2 selected by default as changing that at this stage may be u=
nwise. Hopefully many Windows users may already have .NET 4.0 or higher ins=
talled.<br><br></div><div>Thanks,<br><br></div><div>Selva<br></div></div>

--94eb2c05ab40308b6d0542c581b5--


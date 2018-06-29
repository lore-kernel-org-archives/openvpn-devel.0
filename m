From: "Morris, Russell" <rmorris@...1315...>
Date: Fri, 29 Jun 2018 01:56:25 +0000
Message-ID: <DM5PR08MB3642C3F6067B680D5BE439A8B94E0@...2422...>
References: <DM5PR08MB36429068FCBF60610B6E85CFB94F0@...2422...>
 <20180628065703.GS57262@...1296...>
 <046f2ff7-2340-abd0-7f3a-6a31455b2fc3@...515...>
 <DM5PR08MB36420E57A6907302D18A515FB94F0@...2422...>
 <20180628165617.GZ57262@...1296...>
In-Reply-To: <20180628165617.GZ57262@...1296...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN GUI, and routes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: =?iso-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Good find - thanks! Yep, that was it. And it had me very confused how that =
happened (static settings), then a bit of sleuthing here - Tether changed i=
t, as part of tethering my Android phone (tried it again, found it in the l=
ogs).

Much appreciated! And just a though, but - perhaps something to have the se=
rvice be able to do in the future?

Thanks again,
... Russell



-----Original Message-----
From: Gert Doering <gert@...1296...>=20
Sent: Thursday, June 28, 2018 11:56 AM
To: Morris, Russell <rmorris@...1315...>
Cc: Samuli Sepp=E4nen <samuli@...515...>; Gert Doering <gert@...1296...>; o=
penvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] OpenVPN GUI, and routes

Hi,

On Thu, Jun 28, 2018 at 04:50:41PM +0000, Morris, Russell wrote:
> Thanks for the thoughts - and they do align with my understanding as well=
. But it is failing unfortunately - only if the GUI is run as non-admin. Lo=
g for this case is below, from Windows of course (as it shows). Suggestions?
>=20
> Thu Jun 28 11:46:35 2018 TAP-WIN32 device [OpenVPN] opened:=20
> \\.\Global\{7D008A8F-BEC3-4196-9CCE-C8970FB55962}.tap
> Thu Jun 28 11:46:36 2018 NETSH: C:\WINDOWS\system32\netsh.exe=20
> interface ip set address OpenVPN dhcp

This looks like the tap interface has been (manually) set to "static IP add=
ress" - and it seems we can't change it back using the service yet.

Please change the config of the TAP adapter to "DHCP" and re-try.

gert
--
"If was one thing all people took for granted, was conviction that if you  =
feed honest figures into a computer, honest figures come out. Never doubted=
  it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...


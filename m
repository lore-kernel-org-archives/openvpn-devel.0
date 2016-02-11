Date: Thu, 11 Feb 2016 10:28:42 +0200
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@...124...>
Message-ID: <20160211082842.GD2461@...1281...>
References: <56B86D5C.5070506@...515...>
MIME-Version: 1.0
In-Reply-To: <56B86D5C.5070506@...515...>
Subject: Re: [Openvpn-devel] OpenVPN installers with openvpn-gui pull
 request #13's code included
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Mon, Feb 08, 2016 at 12:26:36PM +0200, Samuli Sepp=E4nen wrote:
> Hi,
>=20
> Selva has a pending pull request to openvpn-gui, which completes the=20
> integration of interactive service into OpenVPN installers:
>=20
> <https://github.com/OpenVPN/openvpn-gui/pull/13>
>=20
> The pull request contains several changes which need testing:
>=20
> <https://github.com/OpenVPN/openvpn-gui/pull/13/commits>
>=20
> I built test installers which include the new openvpn-gui code:
>=20
> <http://build.openvpn.net/downloads/temp/openvpn-install-2.3_guipr13-I601=
-i686.exe>
> <http://build.openvpn.net/downloads/temp/openvpn-install-2.3_guipr13-I601=
-x86_64.exe>
>=20
> If you test these installers please report back and tell how things=20
> went. I'll try to do testing on my own later today.
>=20

Maybe I'll give it a shot soon, but a quick question first:

I noticed this commit:
https://github.com/selvanair/openvpn-gui/commit/91acf14726b15144fc2f00c206f=
590090a123158

"Change the default log file location to OpenVPN/log in user's profile dire=
ctory
to support running without admin privileges using the interactive service."


Do you know if it's now possible to have also the OpenVPN config files and =
certs in user's profile directory
(not on system-wide c:\windows\program files\openvpn\config\) ?=20


Thanks,

-- Pasi



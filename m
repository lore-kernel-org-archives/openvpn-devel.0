Date: Sun, 28 Jun 2015 21:24:15 +0300
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@...124...>
Message-ID: <20150628182415.GA17713@...1281...>
References: <558AD438.9050105@...515...>
MIME-Version: 1.0
In-Reply-To: <558AD438.9050105@...515...>
Subject: Re: [Openvpn-devel] Writing an OpenVPN-specific NSSM configuration
 frontend?
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

On Wed, Jun 24, 2015 at 07:00:56PM +0300, Samuli Sepp=E4nen wrote:
> Hi,
>=20
> There is a question at the end, so scroll down if you're impatient :).=20
> Anyways, some of you may know I've been looking into NSSM:
>=20
> <http://nssm.cc>
>=20
> The idea is to use NSSM to replace the OpenVPN Service Wrapper=20
> ("openvpnserv.exe") which is buggy, unmaintained, causes all sorts of=20
> issues and seems disintegrate more and more with every new Windows releas=
e.
>=20
> NSSM on is actively maintained[1] general purpose service manager which=20
> can launch an arbitrary program and restart it if it crashes. NSSM=20
> registers itself as a Windows service and manages a set of services,=20
> which can be arbitrary programs. In our case nssm.exe would run a=20
> command such as this:
>=20
> ..\bin\openvpn.exe --config default.ovpn
>=20
> The working directory would be set to C:\Program Files\OpenVPN\config.=20
>

If changing the OpenVPN Windows stuff, please also support having config fi=
les under user's profile directory,
not only in the system-wide config-directory.

-- Pasi



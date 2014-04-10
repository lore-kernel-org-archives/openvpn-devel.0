Date: Thu, 10 Apr 2014 12:14:26 +0200
From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20140410101426.GR13903@...1894...>
References: <25014025.40055.1397123169966.JavaMail.root@...1893...>
MIME-Version: 1.0
In-Reply-To: <25014025.40055.1397123169966.JavaMail.root@...1893...>
Subject: Re: [Openvpn-devel] Regarding pkcs11 support in our Debian/Ubuntu
 packages
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
To: openvpn-devel@lists.sourceforge.net

On Thu, Apr 10, 2014 at 11:46:09AM +0200, Lisa Minogue wrote:
> I would prefer that Samuli patches pkcs11 for Debian/Ubuntu. I am sure pa=
tches for pkcs11 exist for other Linux distros. So why should Debian/Ubuntu=
 be left out? In addition Ubuntu is the most popular among Linux distros.
>=20
> How long does it take for Samuli to issue the pkcs11 patch for Debian/Ubu=
ntu? One week? Two weeks? One month? We can wait so long as we know that a =
quality patch is available at the end of the wait.
>=20
> Is it difficult to patch pkcs11 for Debian/Ubuntu compared to patching fo=
r other Linux distros? That could be the reason Samuli decided not to patch=
 for Debian/Ubuntu.
>=20
> It is the OpenSSL "Heartbleed" bug that leads to Samuli being so busy ove=
r the past few days. We appreciate his time and effort spent on rolling out=
 new versions of OpenVPN software.
>=20

Hi Leroy,

Mind this patch is only required for Samuli's (backported) packages. The
packages in Debian (and later Ubuntu) do not need any patching, since
the required version of pkcs11 is already present in the development and
testing suites (sid and jessie).

Regards,

Alberto

--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
mailto/sip: agi@...64... | en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 5347 CBD8 3E30 A9EB 4D7D  4BF2 009B 3375 6B9A AA55


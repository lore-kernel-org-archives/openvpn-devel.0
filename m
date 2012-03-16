Date: Fri, 16 Mar 2012 12:47:48 +0100
From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20120316114747.GV6615@...1330...>
References: <4F632647.30603@...515...>
MIME-Version: 1.0
In-Reply-To: <4F632647.30603@...515...>
Subject: Re: [Openvpn-devel] New generic buildsystem: lzo enabled or
 disabled by default?
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

On Fri, Mar 16, 2012 at 01:38:47PM +0200, Samuli Sepp=E4nen wrote:
> Hi all,
>=20
> In yesterday's meeting we reviewed this patch
>=20
> PATCH 39/52 build: proper lzo detection and usage
>  URL: http://thread.gmane.org/gmane.network.openvpn.devel/5772/focus=3D58=
11
>=20
> The patch was ACKed, but there was disagreement whether LZO should be ena=
bled or disabled by default. Whichever the case, it will only affect people=
 building OpenVPN, not the end-users. Official builds will continue to have=
 LZO support.
>=20
> Opinions?
>=20

I'll still build Debian packages with LZO support (if I don't forget to
set the option when upgrading to the new version).

Since support for LZO is enabled/disabled in runtime configuration, I
don't see why disabling it on built time, thus limiting its use later.

Regards,

Alberto

--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
agi@(inittab.org|debian.org)| en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3


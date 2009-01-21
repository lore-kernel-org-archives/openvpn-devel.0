Message-ID: <49775688.9020600@...41...>
Date: Wed, 21 Jan 2009 10:08:24 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <b8592ed80901162243i4b32d0cbk5af6a3466fd5d419@...278...>
In-Reply-To: <b8592ed80901162243i4b32d0cbk5af6a3466fd5d419@...278...>
Subject: Re: [Openvpn-devel] windows 7 and openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Istv=E1n_Szuk=E1cs?= <leccine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

I've patched the NSIS installer to omit the Windows version check.

Try this installer:

http://openvpn.net/beta/openvpn-2.1_rc15e-install.exe

James

Istv=E1n Szuk=E1cs wrote:
> Hi folks!
>=20
>=20
> I am wondering if you have ever had success to run openvpn on windows 7.=
=20
> The problem is the latest=20
> installer(http://openvpn.net/release/openvpn-2.1_rc15-install.exe) says=20
> this version is not supporting windows.... I try to install=20
> http://openvpn.se/files/install_packages/openvpn-2.0.9-gui-1.0.3-install.=
exe,=20
> works fine except the fact that the tap driver is not signed and because=
=20
> of this it remains disabled and you cannot use openvpn(but runs well up=20
> to the point when initialize the driver).
>=20
> If you could point me a doc how to make it run on win7 it would be much=20
> appreciated. If I could help with anything the win7 build let me know....
>=20
>=20
> Regards,
> Istvan
>=20
>=20
> --=20
> the sun shines for all
>=20
>=20
> ------------------------------------------------------------------------
>=20
> -------------------------------------------------------------------------=
-----
> This SF.net email is sponsored by:
> SourcForge Community
> SourceForge wants to tell your story.
> http://p.sf.net/sfu/sf-spreadtheword
>=20
>=20
> ------------------------------------------------------------------------
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


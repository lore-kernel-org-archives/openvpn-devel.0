Message-ID: <51A9F04E.8080706@...68...>
Date: Sat, 01 Jun 2013 14:59:58 +0200
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <51A8991C.2060501@...515...>
In-Reply-To: <51A8991C.2060501@...515...>
Subject: Re: [Openvpn-devel] OpenVPN 2.3.2 tagged and source packages ready
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Am 31.05.2013 14:35, schrieb Samuli Sepp=E4nen:
> Hi all,
>=20
> OpenVPN 2.3.2 is now tagged, but I won't have time to make a proper
> release until next Monday. However, here are the source packages for
> your enjoyment:
>=20
> <http://swupdate.openvpn.org/community/releases/openvpn-2.3.2.tar.gz>
> <http://swupdate.openvpn.org/community/releases/openvpn-2.3.2.tar.xz>
> <http://swupdate.openvpn.org/community/releases/openvpn-2.3.2.zip>
>=20
> Feel free to push them to your distro repositories or build packages
> based on them. The GPG signatures are here:
>=20
> <http://swupdate.openvpn.org/community/releases/openvpn-2.3.2.tar.gz.asc>
> <http://swupdate.openvpn.org/community/releases/openvpn-2.3.2.tar.xz.asc>
> <http://swupdate.openvpn.org/community/releases/openvpn-2.3.2.zip.asc>
>=20
> You can verify the signatures with
>=20
> $ gpg -v --verify <filename>.asc
>=20
> Best regards,
>=20

I see this (haven't checked if this was previously present)

560 	misc.c: In function 'env_set_add_nolock':
561 	misc.c:566: warning: passing argument 1 of 'add_env_item' discards
qualifiers from pointer target type

Apparently (from a cursory glance over git gui blame), this has been
lingering for a while.



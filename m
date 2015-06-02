Date: Tue, 2 Jun 2015 10:09:19 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150602080919.GT382@...1296...>
References: <CANXi7D2e1pzQ8JTW47sz=2wgWOmNOpH2e3_NSmSysHwbow0VWA@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sa8Wro6pbQmO8/rE"
Content-Disposition: inline
In-Reply-To: <CANXi7D2e1pzQ8JTW47sz=2wgWOmNOpH2e3_NSmSysHwbow0VWA@...278...>
Subject: Re: [Openvpn-devel] How to create openvpn channel between multiple
	interface linux machines.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arun Kumar <mailinform@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--Sa8Wro6pbQmO8/rE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 02, 2015 at 01:17:26PM +0530, Arun Kumar wrote:
> I have two ubuntu machine say host1 and host2.
> Each have two interfaces say eth0 and eth1.
> I want to create seperate openvpn channels between the interfaces of two
> hosts.
> i tried openvpn and create secure key. and add eth0 and eth1 in config
> file, but only one vpn channel created.
> what is my mistake and how to make it.
> please help me on this.

First mistake: wrong list.  Openvpn-users is the list for user questions.

Second mistake: please describe more precisely what you want to achieve -=20
OpenVPN does not care for "eth0/eth1", it will connect to an IP address
of the remote host.

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Sa8Wro6pbQmO8/rE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVW1krqkuBuNlUUl1AQK40QP+M2Fqnzh4jZvyVQ6ThxKDF4RwK2BVTPDZ
7VR6wm8VSymZDCW20BGQYTOM3GoLc+XVwuNVXfusYmNMApgmG4qQ8KA++hPLycDa
AxSUu3vsSJwzHXtAPSJtbrGD91y3D0ouUsAP/zf7BHqwse+cqAnFqy8cB0QNwEOA
p6/bSMymW7g=
=7+pO
-----END PGP SIGNATURE-----

--Sa8Wro6pbQmO8/rE--


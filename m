References: <bd1a4942-aea3-bbe8-6f87-87c45f9ca009@...515...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <61f56d4b-1aa1-1459-c858-4cdcd176631b@...277...>
Date: Fri, 28 Dec 2018 14:21:47 +0000
MIME-Version: 1.0
In-Reply-To: <bd1a4942-aea3-bbe8-6f87-87c45f9ca009@...515...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] Ubuntu 18.04 packages available for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,

On 27/12/2018 18:11, Samuli Sepp=E4nen wrote:
> Hi,
>=20
> I've produced OpenVPN 2.4.6 packages for Ubuntu 18.04 and they're now
> available here:
>=20
> https://build.openvpn.net/downloads/temp/
>=20
> The Debian packaging files are taken from Ubuntu's own 18.04 openvpn
> package. They already used our openvpn-client@...1685... and
> openvpn-server@...1685... so I only need to make a few enhancements:
>=20
> - Restart active VPN client and server instances on upgrade
> - Stop activate VPN client and server instances on uninstall
>=20
> I also tested upgrading from Ubuntu's own openvpn package and that
> worked fine.
>=20
> Let me know if these packages work for you or if they don't. I'd like to
> get the to our official apt repositories soon.
>=20

Successfully installed openvpn_2.4.6-bionic0_amd64.deb in Ubuntu 18.04,
tested newly installed openvpn-client@...1685... which worked correctly.


> Also, if you can, please review these PRs which enable anyone to build
> the Ubuntu/Debian packages, including ones for Ubuntu 18.04:
>=20
> https://github.com/OpenVPN/sbuild_wrapper/pull/1
> https://github.com/OpenVPN/openvpn-vagrant/pull/6
>=20

Working on it ..




> Samuli
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20


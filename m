References: <bd1a4942-aea3-bbe8-6f87-87c45f9ca009@...515...>
 <61f56d4b-1aa1-1459-c858-4cdcd176631b@...277...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <6b45e7db-4dd8-3880-a3da-9f78845d7fc3@...515...>
Date: Sun, 30 Dec 2018 14:37:12 +0200
MIME-Version: 1.0
In-Reply-To: <61f56d4b-1aa1-1459-c858-4cdcd176631b@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] Ubuntu 18.04 packages available for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: tincanteksup <tincanteksup@...277...>, openvpn-devel@lists.sourceforge.net

Il 28/12/18 16:21, tincanteksup ha scritto:
> Hi,
>=20
> On 27/12/2018 18:11, Samuli Sepp=E4nen wrote:
>> Hi,
>>
>> I've produced OpenVPN 2.4.6 packages for Ubuntu 18.04 and they're now
>> available here:
>>
>> https://build.openvpn.net/downloads/temp/
>>
>> The Debian packaging files are taken from Ubuntu's own 18.04 openvpn
>> package. They already used our openvpn-client@...1685... and
>> openvpn-server@...1685... so I only need to make a few enhancements:
>>
>> - Restart active VPN client and server instances on upgrade
>> - Stop activate VPN client and server instances on uninstall
>>
>> I also tested upgrading from Ubuntu's own openvpn package and that
>> worked fine.
>>
>> Let me know if these packages work for you or if they don't. I'd like to
>> get the to our official apt repositories soon.
>>
>=20
> Successfully installed openvpn_2.4.6-bionic0_amd64.deb in Ubuntu 18.04,
> tested newly installed openvpn-client@...1685... which worked correctly.

Excellent! The openvpn-client@ and openvpn-server@ unit file templates
"sneak in" to the Debian package from our upstream tarball. When looking
at the Debian packaging files there's absolutely no sign of them. But
they get installed and seem to work, including the tmpfiles configuration.

>=20
>> Also, if you can, please review these PRs which enable anyone to build
>> the Ubuntu/Debian packages, including ones for Ubuntu 18.04:
>>
>> https://github.com/OpenVPN/sbuild_wrapper/pull/1
>> https://github.com/OpenVPN/openvpn-vagrant/pull/6
>>
>=20
> Working on it ..
>

Samuli


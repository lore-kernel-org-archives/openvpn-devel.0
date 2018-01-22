References: <CAKuzo_jF_fHfcEPUXeo6WKWQ4tw7T72-cexEUda=USGd9Ref7g@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <7fcee878-48cb-ed2a-951e-72082bf9254a@...515...>
Date: Mon, 22 Jan 2018 11:45:08 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jF_fHfcEPUXeo6WKWQ4tw7T72-cexEUda=USGd9Ref7g@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] On testing with openssl 0.9.8
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
To: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Il 20/01/2018 19:22, Selva Nair ha scritto:
> Hi,
>=20
> Does openvpn-vagrant include any VM provisioning with openssl-0.9.8?
> Until recently I had access to a few old debian boxes but now all
> updated and 0.9.8 testing is getting harder.
>=20
> Selva

Right now openvpn-vagrant[*] contains only fairly recent operating systems:

grep "vm.define" Vagrantfile
  config.vm.define "centos-7" do |box|
  config.vm.define "debian-9" do |box|
  config.vm.define "freebsd-11" do |box|
  config.vm.define "openbsd-6" do |box|
  config.vm.define "solaris-113" do |box|
  config.vm.define "ubuntu-1604" do |box|
  config.vm.define "openvpn-build" do |box|
  config.vm.define "netbsd-7" do |box|

If you want, I can easily add a new VM (say, Ubuntu 12.04), which has
OpenSSL 0.9.8.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


[*] <https://github.com/OpenVPN/openvpn-vagrant>


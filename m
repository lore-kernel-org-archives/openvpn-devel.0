Message-ID: <4F3EFC6F.3010500@...1552...>
Date: Fri, 17 Feb 2012 17:18:39 -0800
From: awgh <awgh@...1552...>
MIME-Version: 1.0
References: <4F3EE1BD.9090306@...1553...>
In-Reply-To: <4F3EE1BD.9090306@...1553...>
Content-Type: multipart/signed;
	boundary="PGP_Universal_2B2E507D_75B3C2F5_6336AD71_9425CD11";
	protocol="application/pgp-signature"; micalg="pgp-sha256"
Subject: Re: [Openvpn-devel] Obfuscation for Iran SSL blocking
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: junflow@...277..., openvpn-devel@lists.sourceforge.net

--PGP_Universal_2B2E507D_75B3C2F5_6336AD71_9425CD11
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable


Hello Jun!

   I have spent the last couple of days preparing a bundled installer
for the Tor Obfuscation Proxy combined with OpenVPN.  The installer
currently works on 32-bit and 64-bit Windows.

   It simply installs obfsproxy in SOCKS proxy mode and sets it up as a
Windows service, so it starts at boot.  The goal is to make this an=20
automatic install for both clients and servers.

   To convert an existing OpenVPN profile to use the obfsproxy, you
simply change the destination port of your remote line to point at the
obfuscated server port instead of the regular OpenVPN server port:
BEFORE:  remote my.server.com 443
AFTER:   remote my.server.com 80  (assuming obfsproxy server is
listening on 80)

   Then, you just set OpenVPN to use a socks proxy by adding these lines
to you config file:
socks-proxy-retry
socks-proxy 127.0.0.1 1050

   After this, when you initiate the OpenVPN connection, it will use
obfsproxy as a SOCKS proxy.  Just remember to connect to the obfsproxy
port on the server, not the OpenVPN port, in your client config and it
works great!

   A couple of important notes:
    1)  I have only tested this with TCP mode.  I don't expect UDP to
work through Socks proxy, but haven't yet tried it.
    2)  Once, obfsproxy died on me and I had to go to Control
Panel->Administrative Tools->Services and restart the obfsproxy service.
  This seems to be a one-time crash, though.

   The Windows Installer is available here:
	http://awgh.org/files/obfsvpn-installer-0_0_1.exe

   You can build it yourself by checking out the project on bitbucket here:
	https://bitbucket.org/awgh/obfsproxy-windows-installer

   I am also working on init scripts and packages for Linux distros,
which can be used for both the client side and server side of an
obfsproxy connection.  So far, I just have CentOS RPMs and init scripts,
which are available in this project:
	https://bitbucket.org/awgh/obfsproxy-rpm-build

   I am planning on adding some additional features to the installer
bundle, to allow the configuration of shared secrets and the importation
of existing config files.

   Please feel free to either email me with bugs/feature requests or to
use the issue tracking on bitbucket!  Hope this will be useful to some
of you.


Best Regards,

- Ben


> -------- Original Message --------
> Subject:        Re: [Openvpn-devel] Obfuscation for Iran SSL blocking
> Date:   Thu, 16 Feb 2012 15:01:45 +0200
> From:   Samuli Sepp=C3=A4nen<  samuli@...515...>
> Organization:   OpenVPN Technologies, Inc
> To:     Jun Matsushita<  junflow@...277...>
> CC:     David Sommerseth<  openvpn.list@...1114...>,
> " openvpn-devel@lists.sourceforge.net"
> <  openvpn-devel@lists.sourceforge.net>
>
>
>
>
> Hi Jun,
>
> I would try David's obfsproxy + OpenVPN suggestion first and reconsider
> if that fails.
> If we would add obfuscation into OpenVPN itself, we'd soon be in the
> same cat and mouse game as Tor, with the exception we don't have the
> same amount of developer interest to follow it through. So, I think
> keeping the obfuscation functionality would be challenging in the long
> run.
>
> * Unknown Key
> * 0xA036E792(L)
>
>


--PGP_Universal_2B2E507D_75B3C2F5_6336AD71_9425CD11
Content-Type: application/pgp-signature;
	x-mac-type=70674453;
	name=PGP.sig
Content-Disposition: attachment; filename=PGP.sig

-----BEGIN PGP SIGNATURE-----
Version: PGP Desktop 10.2.0 (Build 1672)

iQEVAwUBTz78cE7y/e9dE4VrAQhAWwgAj4XV8VKdgKvC69l+QRKOJ99mOgFZmkJJ
HjB8HT+vYIS4ILgjzqFzHrSDt+Y9wkC5oV1BAt853J0msN7tBtDk85fG/vaz537p
iqI2yPiQOJgm416Vd0ZZ0KHCTvLKl9uiQheDw3E3wdBj86H0iqbFFzmh1F6Gx8Wx
OlbG4wuAOxvZ7kyeqMTGOP3hufRKtLp8YlWk3y5zD5SNl4GE42sCgxWShbqfBW3Q
435IYiPp6V1HxA5434RC1xaqekZ0RCJkODgm+eRWiWX0aNY7+r2Z/FqZY2OlAB/m
dSQAOIcEr1BfVvlXgHJpm/HGue9njeGAzMdLLxzpFZl4/bxIuDpVtw==
=yH9t
-----END PGP SIGNATURE-----

--PGP_Universal_2B2E507D_75B3C2F5_6336AD71_9425CD11--


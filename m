Date: Fri, 19 Aug 2022 19:37:18 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yv/KTuu8IUbiPlCv@...1296...>
References: <20220812134154.16729-1-kprovost@...2661...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Kr0WeMdGpirqOp1p"
Content-Disposition: inline
In-Reply-To: <20220812134154.16729-1-kprovost@...2661...>
Subject: Re: [Openvpn-devel] [PATCHv2]: FreeBSD DCO support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kristof Provost <kprovost@...2661...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Kr0WeMdGpirqOp1p
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 12, 2022 at 03:41:52PM +0200, Kristof Provost via Openvpn-devel=
 wrote:
> Here's the updated version of the FreeBSD DCO patch. It should address
> all remarks on the userspace side of things.

As I said, I only tested the client side of things so far.  Now I started
building a server test rig, to see what I could break :-) - and then
see if the iroute patch does what it should (looks generally good).

Before getting to routing, I discovered something that "upstream changes"
might have broken in your patch:

Namely, if I run multiple instances with --dev tun, the first one
grabs "tun0", and the next one will *fail*

2022-08-19 19:21:08 us=3D399955 OpenVPN 2.6_git [git:vw/master/d7f16eea8e93=
9b42] amd64-unknown-freebsd14.0 [SSL (OpenSSL)] [LZO] [LZ4] [MH/RECVDA] [AE=
AD] [DCO] built on Aug 13 2022
2022-08-19 19:21:08 us=3D399974 library versions: OpenSSL 1.1.1q-freebsd  5=
 Jul 2022, LZO 2.10
[...]
2022-08-19 19:21:08 us=3D403141 GDG6: remote_host_ipv6=3Dn/a
2022-08-19 19:21:08 us=3D403225 ROUTE6_GATEWAY 2001:608:0:814::ffff IFACE=
=3Dem0
2022-08-19 19:21:08 us=3D414627 Failed to create interface tun0: File exist=
s (errno=3D17)
2022-08-19 19:21:08 us=3D414703 Exiting due to fatal error

This is because of a misunderstanding between tun.c:open_tun_dco_generic()
and FreeBSD's open_tun_dco() / create_interface() - tun.c expects the
return code to be "-errno", and gives up on -EPERM - which happens to
be "-1" on FreeBSD ("if we can not create a single interface due to
*permission*, break the loop").

Changing the flow to return -errno makes it succeed.  I will send a patch
for that in a few minutes (feed family first).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Kr0WeMdGpirqOp1p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi/8pNAAoJEB2Cnv7KVigS3fkMAKSxzV30mpTwhXqrGpGIK967
4GnmDf6sbUkxqIFBlwAT8bU0cPKeMORk3GWcHWaCJeDMGdoX1qvRWrF//unNRyAz
eRKxWLk/O8dNl8bYV3Qzw6OYFBVSUfzusBtkyHGR7kMqn91dmtkuBHbOCGvNXELo
Yq/ODjopd9Tj//j2+fRdEQeW5DZYzNEHvYYWnLM8UwV9hS3ZOMvlUJDAIRPR0Z0p
JTN5lQgB0YuRZtmNsMspV5Hc9oQa/7lol5RqI4EzNsY6BuZSZHxFdqOPzcsc63cX
NUMdIJbW/uRDspNsafilknJJN2fI/OWksB/TCgNqPJSH+RxrXq7CYzirsjB4gMtl
EV2Kk3wZyNz3wqG9Niz9MInxuJZH8BzipY4mSYN5mAJ566CjWot7oTGwvohPHhAZ
EhBKXd2XWGYGdFV9rewASGeOGR1QGbp9I2rrcOeNUdVI7TVuLj49kmG5yvt6M1RQ
7VVmynhbh4p7Fpwa2oIquluDrZms3FkI1fzSEgRfNw==
=RWa4
-----END PGP SIGNATURE-----

--Kr0WeMdGpirqOp1p--


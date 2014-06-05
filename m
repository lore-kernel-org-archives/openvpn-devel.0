Message-ID: <53907810.5090403@...515...>
Date: Thu, 05 Jun 2014 17:00:48 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <53907082.70804@...1800...>
In-Reply-To: <53907082.70804@...1800...>
Subject: Re: [Openvpn-devel] latest OpenSSL security advisories
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Mike Tancsa <mike@...1800...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> A few more vulnerabilities it would seem. Can anyone shed light on how
> this impacts OpenVPN ?
>
> http://www.openssl.org/news/secadv_20140605.txt
>
> Does OpenVPN make use of DTLS ? or SSL_MODE_RELEASE_BUFFERS  ?
>
>     ---Mike
Hi,

According to the developers on #openvpn-devel the MITM vulnerability
(CVE-2014-0224) is the only issue that affects OpenVPN. I'm in the
process of building and testing updated Windows installers, which should
get released in about an hour if all goes well.

- --=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOQeBAACgkQwp2X7RmNIqP9WQCfXBWzQw9ub6azmH0EiVcemKmy
tcQAnjdqOSJgGqSBfXHubXQfiJjtLZrv
=3DxuKZ
-----END PGP SIGNATURE-----



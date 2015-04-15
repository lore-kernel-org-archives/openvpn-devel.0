Message-ID: <552E39D1.8050808@...1114...>
Date: Wed, 15 Apr 2015 12:13:37 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1429036445-17223-1-git-send-email-yegorslists@...1030...>
	<552E1111.6010201@...68...>
In-Reply-To: <552E1111.6010201@...68...>
Subject: Re: [Openvpn-devel] [PATCH] m4: enable silent build
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Matthias Andree <matthias.andree@...68...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 15/04/15 09:19, Matthias Andree wrote:
> If the oldest distro we need to support (James? Samuli?) offers 
> "silent-rules" through AM_INIT_AUTOMAKE, we should just add it
> there, but we should not touch the default. Then still anyone can
> call "make V=0" or ./configure --enable-silent-rules and hide the
> output details.

The oldest distribution we support currently is RHEL5 (which
implicitly includes  CentOS 5 and Scientific Linux 5).

Just checked on an updated CentOS 5 box:

$ automake --version
automake (GNU automake) 1.9.6

$ rpm -q automake
automake-1.9.6-3.el5

$ cat /etc/redhat-release
CentOS release 5.11 (Final)

- -- 
kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUuOdEACgkQDC186MBRfrracQCcCT/MxjVbw36dsFj3ND2IKIkU
kMMAnRsPfFLmInI8YyB/rrtpKmIzJF2o
=X4Jr
-----END PGP SIGNATURE-----


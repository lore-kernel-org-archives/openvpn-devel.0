Message-ID: <5409C39F.1050009@...1114...>
Date: Fri, 05 Sep 2014 16:07:27 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1404419045-14728-1-git-send-email-floppym@...594...>
In-Reply-To: <1404419045-14728-1-git-send-email-floppym@...594...>
Subject: Re: [Openvpn-devel] [PATCH] Add configure check for the path to
	systemd-ask-password
Reply-To: openvpn-users@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net, Mike Gilbert <floppym@...594...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/07/14 22:24, Mike Gilbert wrote:
> Gentoo Linux installs this in /usr/bin by default. Also, the user
> may have installed it in /usr/local/bin if building from source.

ACK.  Also considering that Fedora have moved /{bin,sbin} to
/usr/{bin,sbin}, this makes a lot of sense.  More Linux distros may be
on the same path as well.


- -- 
kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQJw58ACgkQDC186MBRfrqlDQCfWPlExpi46t7oOdZObDucIseL
IlYAoKbCGExCNgAijRq4JeYtN9v0CylX
=oHk/
-----END PGP SIGNATURE-----


Message-ID: <4B8246B2.40808@...1114...>
Date: Mon, 22 Feb 2010 09:56:18 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1266620250-10045-1-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1266620250-10045-1-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH v2] Do not randomize resolving of
 IP	addresses in getaddr()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 19/02/10 23:57, David Sommerseth wrote:
> From: David Sommerseth <dazo@...384...>
> 
> (I'm withdrawing the first version, and suggesting this patch to be used instead,
> as this one follows the new feature deprecation process.)
> 
> Based on a discussion on the mailing list and in the IRC meeting Feb 18,
> it was decided to remove get_random() from the getaddr() function as that
> can conflict with round-robin/randomization done by DNS servers.
> 
> For now this feature is enabled by default, but can be disabled by running
> ./configure with --disable-depr-random-resolv.  In the future this will be
> changed to being disabled by default before getting removed.
> 
> Signed-off-by: David Sommerseth <dazo@...384...>

Applied to the feature_removal branch and merged into allmerged.

commit 684790552dde0475745015a76762ecc5a11eedab

Commit log changed to say:
FRP: Prepare to remove randomisation of resolved IP addresses in getaddr()


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuCRq8ACgkQDC186MBRfrqyBQCfQPW8L78mbIDU9WI6ri5gUvax
W/AAoJDNuqeriduNAMqZUxVwxKewoQl6
=Gpks
-----END PGP SIGNATURE-----


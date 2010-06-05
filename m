Message-ID: <4C0AB229.4050307@...1114...>
Date: Sat, 05 Jun 2010 22:23:05 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20100604224938.GA19956@...1375...>
In-Reply-To: <20100604224938.GA19956@...1375...>
Subject: Re: [Openvpn-devel] PATCH: remove bashisms from easy-rsa
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
To: Matthias Andree <ma+ovpnd@...31...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/06/10 00:49, Matthias Andree wrote:
> Hi,
> 
> based on a FreeBSD problem report, I am attaching a patch against the
> 2.1 branch to remove a bashism (source FILE needs to become . FILE) and
> switch the shebang lines to /bin/sh.

Thank you very much for your patch!

> Note that some parts of the scripts may be Solaris /bin/sh unfriendly,
> for instance, Solaris's sh doesn't support test -e or [ -e. My patch
> does not address this.

This makes me very reluctant from accepting the patch, to be very
honest.  I'd rather keep the current bashism which works on all
platforms where bash is available than to apply a patch which will break
the script from working on one of the supported platforms.

I would rather like to see a patch which works safely on all platforms.
 If 'test -e' or '[ -e' does not work in /bin/sh on some platforms, that
do indeed speak for keeping the bash support - unless there are other
ways how to solve this issue.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkwKsikACgkQDC186MBRfrqlGwCffs/zQP5ZKmYD7mMlT9rse4TB
ml4AoIxTVVpKHnOJgMNDKPFaCSHdGb6D
=ACWx
-----END PGP SIGNATURE-----


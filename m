Message-ID: <4FF15F13.6000902@...1114...>
Date: Mon, 02 Jul 2012 10:42:59 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4FF1546D.4090907@...1114...>
In-Reply-To: <4FF1546D.4090907@...1114...>
Subject: Re: [Openvpn-devel] Build issues on ScientificLinux 6.2
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/07/12 09:57, David Sommerseth wrote:
> 
> Hi Alon & al,
> 
> Just tried to do a scratch build on SL6.2 from the git tree.
> 
> ------------------------------------------------------------- $
> autoreconf -vi autoreconf: Entering directory `.' autoreconf:
> configure.ac: not using Gettext autoreconf: running: aclocal -I m4 
> autoreconf: configure.ac: tracing autoreconf: configure.ac: not
> using Libtool autoreconf: running: /usr/bin/autoconf 
> configure.ac:380: error: possibly undefined macro:
> AC_LIBTOOL_WIN32_DLL If this token and others are legitimate,
> please use m4_pattern_allow. See the Autoconf documentation. 
> configure.ac:381: error: possibly undefined macro: AC_LIBTOOL_RC 
> configure.ac:382: error: possibly undefined macro: AC_PROG_LIBTOOL 
> autoreconf: /usr/bin/autoconf failed with exit status: 1 $ 
> -------------------------------------------------------------
> 
> autoconf-2.63-5.1.el6.noarch automake-1.11.1-1.2.el6.noarch
> 
> Can we please fix this?  The workaround currently is to do 'make
> dist' on box where autoreconf can complete.

Duh! Never mind!  I realised now that I was lacking libtool.
Installing that, and it works just fine.  Sorry about the noise!


kind regards,

David Sommerseth





-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/xXxEACgkQDC186MBRfrr5ewCfbnrf5u3s+TUKJKrHZGA/Pslq
1qcAn0+6E4oyGySXtC3wxuVUnBTJZDGw
=/c76
-----END PGP SIGNATURE-----


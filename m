Message-ID: <4FF161E3.8090802@...1114...>
Date: Mon, 02 Jul 2012 10:54:59 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4FF1546D.4090907@...1114...>
	<CAOazyz1zbfAQ2Z=vz5+03KcN0rTpn4Ca9Rs1kdag+6=1RtoY_A@...278...>
In-Reply-To: <CAOazyz1zbfAQ2Z=vz5+03KcN0rTpn4Ca9Rs1kdag+6=1RtoY_A@...278...>
Subject: Re: [Openvpn-devel] Build issues on ScientificLinux 6.2
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/07/12 10:45, Alon Bar-Lev wrote:
> Libtool version please. Thanks

As I noticed a few minutes ago, I didn't have libtool installed.  All
builds fine when installing libtool-2.2.6-15.5.el6.x86_64.


kind regards,

David Sommerseth



> On 7/2/12, David Sommerseth <openvpn.list@...1114...> wrote:
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
> 
> 
> kind regards,
> 
> David Sommerseth
>> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/xYeMACgkQDC186MBRfrppPgCbBpCmPw6TYof77BctR5P5E5FM
vnAAnjMQSqZKM6goTYjqJvh/JFB/5jbC
=p5M2
-----END PGP SIGNATURE-----


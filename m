Message-ID: <4B97D7EB.9020101@...1114...>
Date: Wed, 10 Mar 2010 18:33:31 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1268218182-21015-1-git-send-email-openvpn.list@...1114...>	
	<4B978D0E.9090606@...1114...>	
	<9e0cf0bf1003100842r408389c7occa7dcf0d27ad59a@...278...>	
	<4B97CDF3.6060703@...1114...>	
	<9e0cf0bf1003100903k3647ba78t40bb93d5d9a5d8d8@...278...>	
	<4B97D385.3010506@...1114...>
	<9e0cf0bf1003100919l307a653er7c619b5f2fc97dc@...278...>
In-Reply-To: <9e0cf0bf1003100919l307a653er7c619b5f2fc97dc@...278...>
Subject: Re: [Openvpn-devel] [PATCH] On TARGET_LINUX define _GNU_SOURCE if
 not defined
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
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/03/10 18:19, Alon Bar-Lev wrote:
> I will try to explain again.
> 
> You have two roles of environments:
> 
> 1. Developer/packager workstation.
> 
> 2. Target environment.
> 
> For example, 1 would be my computer, and 2 would be the old redhat computer.
> 
> You go to (1) and do:
> $ autoreconf -ivf
> $ ./configure && make dist
> 
> Now, you transfer the tarball to users, the old redhat computer is one
> of them. The tarball will work WITHOUT ANY AUTOCONF/AUTOMAKE/LIBTOOL
> installed.
> 
> I use older environments as (2) such as solaris-8.
> 
> If you don't believe me try it out.

Thank you!  I do believe you.  Now it's a lot clearer for me, as this
was the detail I was missing.  I'll bring this up on the meeting on
tomorrow.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuX1+gACgkQDC186MBRfrrbwACfRVnBrmDFOqx94o3i1yfSxSjg
sS0AoKe9pVqohgwLj8HwkwWcj1KJRe2d
=OUUn
-----END PGP SIGNATURE-----


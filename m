Message-ID: <547CA65E.50807@...1114...>
Date: Mon, 01 Dec 2014 18:33:18 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1416852578-7581-1-git-send-email-openvpn.list@...1114...>
	<201411301648.sAUGmn3S007220@...1295...>
In-Reply-To: <201411301648.sAUGmn3S007220@...1295...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: autotools: Fix wrong
 ./configure help screen default values
Reply-To: openvpn-users@lists.sourceforge.net
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


On 30/11/14 17:48, Gert Doering wrote:
> 
> As a matter of discussion, I wonder why we have "default=yes" and
> "no" in our --help text, and not "default=enabled"/"disabled",
> which might be slightly less confusing... any autoconf style guides
> here?

Do we need the "default=" stuff at all?  Isn't the default state quite
obvious when you see --enable-feature-abc or --disable-feature-xyz?


- --
kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlR8plsACgkQDC186MBRfrqzFACbBBY7j7x/FG9GAkij7IKje5KS
sREAoJygMPmlnZvqIXgchrnY8oA3gHZV
=jvC0
-----END PGP SIGNATURE-----


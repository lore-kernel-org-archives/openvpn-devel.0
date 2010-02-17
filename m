MIME-Version: 1.0
In-Reply-To: <4B7BF370.8070807@...1114...>
References: <4B7BF370.8070807@...1114...>
From: JuanJo Ciarlante <jjo+ml@...410...>
Date: Wed, 17 Feb 2010 18:55:00 +0100
Message-ID: <7bb795fd1002170955u7b241a1euff7f313480dabf09@...278...>
Subject: Re: [Openvpn-devel] [IPv6 support] - usage of gethostbyname() in
	getaddr()
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: Openvpn-devel@lists.sourceforge.net

On Wed, Feb 17, 2010 at 2:47 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Hi all!
>
> When reviewing the patch "FQDN for routes should expand to all IPs"
> today, I spotted that there is a function called getaddr() (renamed to
> getaddr_all() in the mentioned patch). =A0This function again makes use of
> the old gethostbyname() function. =A0This is not compatible with IPv6
> addresses.
>
> I would strongly recommend a move to getaddrinfo() instead. =A0This is
> based on an article [1] written by Ulrich Drepper, who is a glibc
> maintainer. =A0Any thoughts about that? =A0It might even be more functions
> needing to be ported as well. =A0The mentioned article lists most
> important functions which should be ported to newer APIs.
>
> Any comments on this issue would be appreciated. =A0Another issue is of
> course how this will influence other platforms than Linux.

Plenty adhere to this.

In my ipv6 transport patch I only use getaddrinfo()/getnameinfo(), not
only for the 'nixes, but also for the win32 build (x-compiled under Linux
with mingw32xxx and tested under wine by me and by other fellow
in the field [1] ).

[1]  http://github.com/jjo/openvpn-ipv6/downloads
       naked openvpn.exe built w/ipv6 transport support

>
>
> kind regards,
>
> David Sommerseth
>
>
>
> [1] <http://people.redhat.com/drepper/userapi-ipv6.html>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAkt783AACgkQDC186MBRfrrIxgCgnpCvbJMWzxutz4You8Qj8Qki
> DFcAoJp5eGTHkee7Lz6AU+gKl5BOXiNv
> =3D5ITZ
> -----END PGP SIGNATURE-----
>
> -------------------------------------------------------------------------=
-----
> SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
> Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
> http://p.sf.net/sfu/solaris-dev2dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>



--=20
--JuanJo ; echo jAjo@...1263... | sed 's/[SPAM]//g'


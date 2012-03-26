Message-ID: <4F70BC8E.4030007@...384...>
Date: Mon, 26 Mar 2012 20:59:26 +0200
From: David Sommerseth <dazo@...384...>
MIME-Version: 1.0
References: <20120326093629.GN1359@...1296...>
	<20120326095049.GO1359@...1296...>
	<CAOazyz1S_As1M7RkKw7BFt3fNwM5VOz3f7qwBdDk+h+KDVM9-A@...278...>
	<4F70BA6C.1090007@...384...>
	<CAOazyz0SKESDUYTVNzaKDBDPc7J=BjFuNeRGz8crKZAwCL3OsA@...278...>
In-Reply-To: <CAOazyz0SKESDUYTVNzaKDBDPc7J=BjFuNeRGz8crKZAwCL3OsA@...278...>
Subject: Re: [Openvpn-devel] build problems on FreeBSD of latest openvpn git
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

On 26/03/12 20:52, Alon Bar-Lev wrote:
> On Mon, Mar 26, 2012 at 8:50 PM, David Sommerseth 
> <dazo@...384...> wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> On 26/03/12 20:38, Alon Bar-Lev wrote:
>>> On Mon, Mar 26, 2012 at 11:50 AM, Gert Doering 
>>> <gert@...1296...> wrote:
>>>> I have now installed libtool 2.2.10, and with that,
>>>> "autoreconf -vi" does not return an error anymore.
>>> 
>>> Gentoo stable libtool is sys-devel/libtool-2.4, it contains
>>> some fixes for mingw which I use. Why did you chose 2.2.10?
>> 
>> Remember we need to support the RHEL5 platform.  That ships with 
>> libtool-1.5.22.  EL6 ships with 2.2.10.
> 
> I remember, it will work (please test). Just to know that if you
> install, why not the latest... :)

There are people who build on RHEL5, so they install the Red Hat
provided tools.  And for example, these same tool versions are also
used when you build EPEL packages via Fedora's koji tool.

> Just keep in mind that formal source tarballs should be provided
> using libtool-2.4, to avoid Windows build issues.

That's no problem.  'make dist' can be run on a newer platform.  That
will be when I'm upgrading to Fedora 17 or so.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9wvIgACgkQDC186MBRfro8JwCdEVYLe+JG3pKcWVbs/nTPaIh8
RnsAn0r9nETx5x94/xD6scrvyM4DnhTm
=OSBs
-----END PGP SIGNATURE-----


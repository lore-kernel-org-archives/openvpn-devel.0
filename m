Message-ID: <4B8246EA.3030503@...1114...>
Date: Mon, 22 Feb 2010 09:57:14 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <7bb795fd1002211100l760645cfl1a3cfc07ebd91e4@...278...>
	<20100221212707.GA2349@...1293...>
In-Reply-To: <20100221212707.GA2349@...1293...>
Subject: Re: [Openvpn-devel] [PATCH] make ipv6_payload compile under
 windowze ( feat_ipv6_payload branch )
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Bernhard Schmidt <berni@...376...>
Cc: =?UTF-8?B?SnVhbkpvIENpYXJsYW50ZeKYgA==?= <jjo@...410...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 21/02/10 22:27, Bernhard Schmidt wrote:
> On Sun, Feb 21, 2010 at 08:00:27PM +0100, JuanJo Ciarlante☀  wrote:
> 
>> This patch makes ipv6_payload successfully cross *compile*
>> (and just that :) under my mingw32msvc setup on Linux.
>>
>> Because same syshead.h changes are already included in
>> feat_ipv6_transport, it may merge-conflict applying it over
>> allmerged once the latter includes ipv6_transport.
>>
>> Patch follows
>> (also at http://github.com/jjo/openvpn-ipv6/commit/b7e46bd5ebfd4b55146299129e8b9813fab91b5e
>> ):
> 
> Thank you very much, applied to my gert-ipv6 branch (at least I hope
> so).
> 
> David, please pull gert-ipv6 from git://git.birkenwald.de/openvpn.git to
> receive that change.
> 

Pulled and merged into allmerged


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuCRuoACgkQDC186MBRfrpKlACeIz+74E4sESJbB13DqjVSZg7X
WBIAoK2JYgnThZsoHNgG5VG56y89paDf
=2290
-----END PGP SIGNATURE-----


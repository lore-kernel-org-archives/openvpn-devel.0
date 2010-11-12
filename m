Message-ID: <4CDD7309.3030808@...1114...>
Date: Fri, 12 Nov 2010 18:02:01 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4CDD641F.30408@...515...>
	<20101112163620.27677.qmail@...1287...>	<4CDD704B.7080505@...1114...>
	<20101112165541.29963.qmail@...1287...>
In-Reply-To: <20101112165541.29963.qmail@...1287...>
Subject: Re: [Openvpn-devel] [PATCH] Removed hardcoded signtool	dependency
 from win/build_all.py
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
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/11/10 17:55, Peter Stuge wrote:
> David Sommerseth wrote:
>>>> Modified win/build_all.py so that build does not fail even if
>>>> the optional signtool python class is not available.
>>>
>>> What is it needed for? Is it really *always* optional?
>>
>> If I've understood it correctly, this is related to signing the Windows
>> TUN/TAP driver.
> 
> Right.
> 
> 
>> So if you don't have a signing key/tool available, it is still
>> possible to build the rest of OpenVPN.
> 
> Fine, but this is not really acceptable when James&co builds OpenVPN,
> so I am requesting a solution that allows them to specify to the
> build process that they want a fatal error if signing is not
> possible.

That's a good point!  I didn't think about this one.

What about that the build script stops up and asks if it should continue
without signing?  And in addition having a command line argument
accepting building without signing?  This latter one is more useful for
automated community builds of the allmerged branch from openvpn-testing.git.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkzdcwUACgkQDC186MBRfroz3QCfaejhSR92xYXy6RLHbapbV4Pt
wkYAnR5xpl5fSsIZjTLHF1ZKJHkXnDmS
=WOYo
-----END PGP SIGNATURE-----


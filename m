Message-ID: <4CDD704B.7080505@...1114...>
Date: Fri, 12 Nov 2010 17:50:19 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4CDD641F.30408@...515...> <20101112163620.27677.qmail@...1287...>
In-Reply-To: <20101112163620.27677.qmail@...1287...>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/11/10 17:36, Peter Stuge wrote:
> Samuli Seppänen wrote:
>> From 57b983dc2a1f4a31d3b7c0e2f6de7f778d234b2e Mon Sep 17 00:00:00 2001
>> From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
>> Date: Fri, 12 Nov 2010 17:32:19 +0200
>> Subject: [PATCH] Removed hardcoded signtool dependency from win/build_all.py
>>
>> Modified win/build_all.py so that build does not fail even if the optional
>> signtool python class is not available.
> 
> What is it needed for? Is it really *always* optional? Maybe some
> setting or parameter to the script so that build can fail e.g. at
> openvpn.net if building, where signing should always be done?

If I've understood it correctly, this is related to signing the Windows
TUN/TAP driver.  So if you don't have a signing key/tool available, it
is still possible to build the rest of OpenVPN.  You might even manage
to install the unsigned TUN/TAP driver with some tweaking.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkzdcEoACgkQDC186MBRfroGqwCfRZoxPtTfp08Qvs+Uvi3KzjBj
Ts0AnAp3EVN3Ht2u6I6fFQ1QdQ4D+JAD
=yh6e
-----END PGP SIGNATURE-----


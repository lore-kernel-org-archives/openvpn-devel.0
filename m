Message-ID: <4B7EB9D5.7090104@...1114...>
Date: Fri, 19 Feb 2010 17:18:29 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1266595502.31441.7@...1207...>
In-Reply-To: <1266595502.31441.7@...1207...>
Subject: Re: [Openvpn-devel] [PATCH] FQDN for routes should expand to all IPs
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
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 19/02/10 17:05, Karl O. Pinc wrote:
> On 02/19/2010 03:02:40 AM, David Sommerseth wrote:
>> On 19/02/10 04:18, Stefan Monnier wrote:
> 
>>>
>>> If it's a config var, it could indeed just be a global var, so I
>> don't
>>> think it would be very complex.  But that's really not something 
>> the
>>> user should have to configure.
>>
>> That depends on the solution we end up with.
> 
> What do you mean "configure"?
> 
> This is exactly the sort of thing that a 
> 
> ./configure --connection-limit=20
> 
> sort of configuration setting is good for.  Someone
> might want to frob it, but does it need to be dynamically
> configurable in the openvpn config file?  If you make
> the default large enough for anybody then the embedded systems
> people can reconfigure their binary to shrink it need be.

I initially meant a more dynamic approach, changing it via the config
file at runtime - by modifying a global C variable.  But I agree, doing
it via the ./configure script should really be sufficient.  This makes
more sense for me now.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkt+udMACgkQDC186MBRfroXRwCfX/qmYT1iuB8A8h/Nano7ZaNe
CrYAnjo/zrx+dmXuqo2hdEocTRLSl6dh
=qOkR
-----END PGP SIGNATURE-----


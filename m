Message-ID: <4B82FB39.1090703@...1114...>
Date: Mon, 22 Feb 2010 22:46:33 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1266858979.5921.0@...1207...>
In-Reply-To: <1266858979.5921.0@...1207...>
Subject: Re: [Openvpn-devel] [PATCH v2] Do not randomize resolving of IP
 addresses in getaddr()
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
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 22/02/10 18:16, Karl O. Pinc wrote:
> On 02/22/2010 10:52:17 AM, Peter Stuge wrote:
>> Karl O. Pinc wrote:
>>> Someone may be relying on the behavior but, at the moment
>>> or depending on present dns circumstances, does not have
>>> multiple A records returned.  In this case no warning will
>>> be generated.
>>
>> The flip side of that coin is also valid I think.
>>
>> Consider independent configuration of VPN and DNS. Early errors would
>> restrict VPN setup and possibly shipment until after DNS has been set
>> up, while lazy evaluation allows DNS changes to happen later.
> 
> Right, but there's nothing to "restrict" because in this case we're
> talking about a warning not an error; generating a warning that default
> behavior will change in a future release.  OpenVPN _should_ 
> continue happily along its way no matter where
> the warning is generated.
> 
> It's a pretty trivial point really, but may provide a template
> for future changes.

Agreed! ... and I've sent out a patch giving such a simple "template",
for the source code.

Now the code will present a very early warning about deprecated features
which is enabled, and it will give yet another warning when the feature
is triggered.  That way, we should get the attention if it happens.

Having that said, it's probably wise to consider which features removals
which will print a warning each it is called.  In this case, I feel it
is safe, as it's probably not too often you will trigger this.

On the other hand, we want to bother the users and really make them see
these messages.  If they dislike it, they then have a reason to discuss
the planned feature removal.

Does that cover your concerns?


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuC+zkACgkQDC186MBRfrpWYgCdEU6ime0X9b0kqdA2Nu0k0IvJ
lwoAoJ8Pkc0wNyYNGP0DuxfbosdVeqjj
=1PLD
-----END PGP SIGNATURE-----


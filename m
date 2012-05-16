Message-ID: <4FB39166.9050906@...1114...>
Date: Wed, 16 May 2012 13:37:10 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz0V=cE7R=nTefCbP4Z1=+WoYnxhPfNuWasEZjf1EUSOHA@...278...>
	<4FB3810A.4050209@...1114...>
	<CAOazyz11iQ6wuNJ_tp=2U5gH5=jeLkLHL6EG_8+yrDjXtEbFUA@...278...>
	<4FB38570.90902@...1114...>
	<CAOazyz29iYJ2rDPBZzk0Otac543AcYFf_gbHgRgaFo+qcVLpTQ@...278...>
In-Reply-To: <CAOazyz29iYJ2rDPBZzk0Otac543AcYFf_gbHgRgaFo+qcVLpTQ@...278...>
Subject: Re: [Openvpn-devel] eurephia plugin
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
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 16/05/12 12:55, Alon Bar-Lev wrote:
> On Wed, May 16, 2012 at 1:46 PM, David Sommerseth
> <openvpn.list@...1114...> wrote:
>> On 16/05/12 12:37, Alon Bar-Lev wrote:
>>> On Wed, May 16, 2012 at 1:27 PM, David Sommerseth
>>> <openvpn.list@...1114...> wrote:
>>>> On 16/05/12 09:17, Alon Bar-Lev wrote:
>>>>> Hello David,
[...snip...]
>>>>> Can you please explain what this plugin is and why just
>>>>> remove the conditional?
>>>> 
>>>> You can find more info about the plug-in here: 
>>>> http://www.eurephia.net/
>>>> 
>>>> Basically, it's a username/password authentication plug-in
>>>> which also matches a user account up against a certificate
>>>> too (plus some extra features too as well).  The
>>>> 'tls_digest_%d' environment variable is used to get better
>>>> data when matching certificates information against the
>>>> database.
[...snip...]
> 
> hmmm... why not to digest only end certificate? this what you
> actually need right?

For the most common setup where you only have a single CA and the
client cert, the tls_digest_0 env. variable is the important factor.

But some users might do some tricks with certificate chains, using CA
and sub-CA(s), which a plug-in/script then can better validate if it
has all the levels.

For example, the firewall profiles for each user can be different
based on which kind of device you're connecting from (workstation,
laptop, tablet, etc) - and each group of devices can have certificates
issued by different sub-CAs.  But the end-user have only one
username/password to care about (the certificates/keys are distributed
by the enterprise in their preferred way to their devices), and based
on the certificate chain, the network access changes.

This way, if one sub-CA is removed/disabled from the eurephia
database, you can easily remove access from a complete group.  Maybe
that's something you only want to do temporarily, so issuing a CRL for
a sub-CA would be too extreme.  Such setups are more interesting for
enterprises, though.  But key point is to have a fine-grained control
of all the VPN accesses.

The thoughts behind eurephia has been to provide a runtime modularity
and being as flexible as possible; not locking the users towards only
a limited kind of setups.

Granted, all the certificate-chain support isn't implemented in
eurephia yet, but it's on the TODO list.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+zkWQACgkQDC186MBRfrr2iQCgjkAJX4l0KNkrZjcChAws6+Dc
5mAAn0Wki7i0ZiMcsNL6W6npWtw7kqW5
=Gomp
-----END PGP SIGNATURE-----


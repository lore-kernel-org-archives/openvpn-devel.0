Message-ID: <4C49C13B.4050004@...1114...>
Date: Fri, 23 Jul 2010 18:20:11 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4C494C31.7020601@...1114...>
	<20100723140617.19037.qmail@...1287...>
In-Reply-To: <20100723140617.19037.qmail@...1287...>
Subject: Re: [Openvpn-devel] [RFC] - (ticket #29) - Fix for --push-reset
 resetting --topology and --route-gateway
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
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 23/07/10 16:06, Peter Stuge wrote:
> David Sommerseth wrote:
>> 1) Adding a new configure option which "unpush" chosen elements
>> 2) Add a new immutable option list for PUSH_REPLY
>> 3) Add a flag to the PUSH_REPLY list indicating if it is immutable
> ..
>> Does anyone see another solution which is better?  Or which
>> suggestion do you consider preferable?
> 
> The problem in this particular case seems to be that push-reset is
> removing options that were added to the push list *implicitly* by
> other configuration directives.
> 
> Would it make sense to simply treat all implicitly added elements as
> immutable?

That is what we're looking into now.  After having spent some time in
the code today, this looks more and more like the obvious way how to
solve it.

> As for how to make elements immutable I prefer option 3, adding a
> flag to the existing data structure.

That makes sense for me too.  And the developer who proposed two lists
seems to have changed opinion as well after digging deeper.

Thank you for your input!


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkxJwTkACgkQDC186MBRfrrjdACfa2uj2F2kQJ+PpKFIHGn/rQsX
FWEAoJU9dicfTqI6Lsep1vqvmHRNpf9H
=pGJd
-----END PGP SIGNATURE-----


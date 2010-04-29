Message-ID: <4BD9410D.3070909@...1114...>
Date: Thu, 29 Apr 2010 10:19:25 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <i2j251896ce1004282102v38fd0e79l2a222c4501dad9db@...278...>
	<20100429070322.GW12312@...1296...>
	<4BD93D4B.5050601@...1114...>
	<20100429080838.GZ12312@...1296...>
In-Reply-To: <20100429080838.GZ12312@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] TAP interface support for
	Solaris/OpenSolaris
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Kazuyoshi Aizawa <admin2@...628...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 29/04/10 10:08, Gert Doering wrote:
> Hi,
> 
> On Thu, Apr 29, 2010 at 10:03:23AM +0200, David Sommerseth wrote:
>>> If we include it in feat_ipv6_payload, it won't have merge conflicts - but
>>> then you only get the TAP-on-Solaris in combination with all the IPv6 stuff,
>>> which people might not want.
>>>
>>> David?
>>
>> You seem to have pretty well good control over this TUN/TAP
>> infrastructure.  So I have no problems with you pulling whatever you
>> find useful into your IPv6 branch, which covers this.
> 
> OK, if nobody objects, I'll integrate the rest of these patches into 
> "my" tun.c, and commit to the IPv6 payload branch.  (Will take a few
> days...)
> 
> If someone urgently needs TAP support for Solaris later on, but refuses
> to use the IPv6 stuff, we can still sort out what to do then.

Agreed!  And I really struggle to see this being a reality, unless the
IPv6 branch got stability issues for IPv4 only users.  Which I can't say
is an issue now.

Send me a PULL REQUEST when you're ready, and I'll get it into allmerged
after ACK.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvZQQ0ACgkQDC186MBRfroX0QCeL1nQ61nh+MDY1l0YUsS0gsQ0
D58AmgNK+LWCqJSNGzCeFh8QgouMdlXi
=no9p
-----END PGP SIGNATURE-----


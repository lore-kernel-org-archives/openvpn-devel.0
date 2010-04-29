Message-ID: <4BD93D4B.5050601@...1114...>
Date: Thu, 29 Apr 2010 10:03:23 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <i2j251896ce1004282102v38fd0e79l2a222c4501dad9db@...278...>
	<20100429070322.GW12312@...1296...>
In-Reply-To: <20100429070322.GW12312@...1296...>
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

On 29/04/10 09:03, Gert Doering wrote:
> Hi,
> 
> On Thu, Apr 29, 2010 at 01:02:37PM +0900, Kazuyoshi Aizawa wrote:
>> I've attached a patch for tun.c which includes support for tap
>> interface for solaris/opensolaris.
>> The code is based on OpneVPN 2.1.1. And it has a routine to
>> plumb/unplumb tap interface like ifconfig command.
>>
>> tap driver for solarsi/opensolaris is here:
>>       http://www.whiteboard.ne.jp/~admin2/tuntap/
> 
> Thanks for your work!.  I have already used bits from there when adding 
> IPv6 payload support to OpenVPN on Solaris :-)
> 
> Question to the community: how do we want to integrate the tun.c changes
> for Solaris?  Its own branch, feat_misc branch, feat_ipv6_payload branch?
> 
> If we include it in feat_ipv6_payload, it won't have merge conflicts - but
> then you only get the TAP-on-Solaris in combination with all the IPv6 stuff,
> which people might not want.
> 
> David?

You seem to have pretty well good control over this TUN/TAP
infrastructure.  So I have no problems with you pulling whatever you
find useful into your IPv6 branch, which covers this.

If given a separate branch, I'm not going to be the one who solves
potential conflicts unless they're bloody obvious and trivial.  So I'll
just be going to push someone to fix these branches so they can be merged.

Gert, I'll let you know decide if you feel this is good for inclusion
into your tree.  If you prefer to have it separately, including the work
needed to make these branches merge-able, I'm fine with that.  It's
easier to track things if they have separate branches, but if this patch
is close to what you do in your tree, I don't see it that important to
split it out.


kind regards,

David Sommerseth


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvZPUsACgkQDC186MBRfrpElQCdHZPAXh0LuPfiKtNWRt2+e6IK
UEIAnjXlVySWFUgOxxhU3bCp3mv5hlSI
=SydE
-----END PGP SIGNATURE-----


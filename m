Message-ID: <4B9684F1.5020202@...1114...>
Date: Tue, 09 Mar 2010 18:27:13 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1268152860.24740.8@...1207...>
In-Reply-To: <1268152860.24740.8@...1207...>
Subject: Re: [Openvpn-devel] Supporting "route-gateway dhcp" on non-Windows
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
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, James Yonan <jim@...41...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/03/10 17:41, Karl O. Pinc wrote:
> On 03/09/2010 10:16:37 AM, David Sommerseth wrote:
> 
>>> Over-automating things will cause people headaches.
>>> You don't want to willy-nilly startup a dhcp client
>>> and have all your interfaces configured with dhcp without
>>> your consent.
>>
>> Exactly!  Which again moves it more in the direction of some built-in
>> DHCP client in OpenVPN, but as stated earlier - that mostly solves 
>> the
>> core DHCP issues - but not the resolv.conf issue.
> 
> I'm not at all sure it solves the core issues, which is that
> an already running dhcp client won't have auto-detected
> the tap interface that OpenVPN creates -- iff OpenVPN is 
> started after the dhcp client.  

Can you actually start an DHCP client on a non-existing TAP device?  I
don't think so.  And I haven't seen any clients which do have such
auto-detect features ... I begin to feel we're talking about different
things now.

> This is the
> core issue, right? Otherwise it would just work so long
> as dhcp is turned on.  I think we need to decide where
> the problem really is before we decide how to fix it.

I don't think we're on the same page now.  The issue how I see it:
There is a real DHCP server which provides DHCP clients network
configurations automatically, including IP addresses, routes and default
gateway, DNS/WINS servers, and a lot of the other options the DHCP
server supports.

The challenge for OpenVPN in this is that now a separate DHCP client
needs to be started via a --up script, and to be torn down via a --down
script.  But this needs to be run as root (at least on most platforms I
know about).

The problem, how I see it, is how to do this in an easier and more
robust way, configuration wise - to make OpenVPN on *nix behave more
like it does on Windows, where no extra configuration is needed at all
(if you ignore the DNS cache issues in Windows for now), it just works.

Please correct me, if you think I have made it too vague and simple, or
simply wrong.

> If you build a dhcp client into openvpn you push the problem in
> the other direction.  Now you've, potentially, got
> multiple dhcp clients running and you need to do
> something to keep them from interfering with each other.

Why is this an issue?  Unless they operate on each separate network
segment, this shouldn't cause any unexpected behaviour.  And it's not
uncommon to see boxes with multiple interfaces running separate DHCP
clients per interface, and that don't seem to cause any problems in
those setups I've done that with.

In fact, with TAP devices, they will have different MAC addresses, so
even if you have multiple OpenVPN connections to a network, the DHCP
server will see them as separate clients, giving them separate IP addresses.

> You can't rely on processes being started and stopped
> in boot-time order because the sysadmin might start
> and stop services as needed to maintain the system
> and you don't want surprising things to happen.
> (The principle of least surprise is a good one.)

Exactly, and if a user stops OpenVPN, the DHCP client for that TAP
interface should also be taken down, right?  And if the OpenVPN is
started at boot time, OpenVPN will take care of getting the DHCP config
when the link is established, right?  I don't see any obstacles here,
nor any potential surprises.

You start OpenVPN, and expect it to do the setup properly.  If the DHCP
client is built into OpenVPN, that should really not cause any
surprises.  It should simply, just work(tm).

I don't see how this relies on boot-time order, etc, etc.  As long as
OpenVPN has not established a connection it would not start a DHCP
request anywhere.

> You may as well just statically configure your existing
> dhcp client so that it knows to go looking for the
> tap device.

How would you do that?  The different DHCP client applications might
have different arguments, where and how would you configure this statically?

> I think the only way to go is to integrate with
> anything that the local admin may decide to use
> for dhcp/resolv.conf/etc.

For resolv.conf issues, at present, using a third-party DHCP application
is probably a safer bet right now.  I agree to that one.  But I'm far
from convinced that it is the best solution, just because of the wide
range of DHCP clients and distribution specific adjustments.


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuWhO4ACgkQDC186MBRfrraiQCfRtC3Lx3Wbxr99L6+Z5mGq9D3
7oEAnjEhBegux6kNLp2yTFTF8DObIWLd
=Ll81
-----END PGP SIGNATURE-----


Message-ID: <4B9677A9.8040408@...1114...>
Date: Tue, 09 Mar 2010 17:30:33 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4B9515FF.6000704@...41...>	<20100308174321.GA25238@...1296...>
	<4B966A98.4000206@...41...>
In-Reply-To: <4B966A98.4000206@...41...>
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
To: James Yonan <jim@...41...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/03/10 16:34, James Yonan wrote:
>> looking at the multitude of DHCP clients available for unix, the completely
>> different handling of DHCP on MacOS, and the issues that most unix clients
>> seem to have with "DHCP active on two different interfaces (ethX and tapY),
>> and both trying to set a default gateway", ...
>>
>> On Mon, Mar 08, 2010 at 08:21:35AM -0700, James Yonan wrote:
>>> (2) Complex method: Write code in OpenVPN to simulate a DHCP client, 
>>> then translate the settings received in the DHCP reply to OpenVPN 
>>> push-style directives (such as ifconfig, route, etc.) as if they had 
>>> been pushed by the OpenVPN server.
>>
>> ... this seems to be the most portable way, as we already have the 
>> ifconfig/route code for all the platforms.
>>
>> Well.  Let me rephrase.
>>
>> The "simple way" is simple as far as the packet flow inside OpenVPN
>> goes (because OpenVPN only needs to transport packets, but not generate
>> them or parse them), but is, at the same time, the "most complex way" 
>> as far as getting it to work reliably across all supported operating 
>> systems.  Lots of testing and "configure" magic would be necessary to
>> reliably figure out how to do DHCP properly on each individual system.
>>
>> I'm not saying it can't be done :-) - but just that the "simple way"
>> is not so simple, it's just complex in other places.
> 
> I would tend to agree.  All the discussion about the non-portable 
> semantics of DHCP clients on different platforms makes me think that the 
> "complex" method might really be the correct approach.
> 
> OpenVPN is already in the business of abstracting platform-specific 
> network configuration complexity to a portable interface, i.e. in the 
> manner of pushable directives such as route, ifconfig, dhcp-option, 
> etc., so I think it makes sense to leverage on this.  Implementing a 
> DHCP client within OpenVPN tends to make this a more self-contained problem.
> 

I agree.

What I am wondering about what we should do with updates of
/etc/resolv.conf.  It's not directly connected to DHCP, but it is
tightly related to it.  As long as DHCP can push DNS servers as well,
this will be the next challenge.  This has been solved in several
distroes by calling its own script for updating the resolv.conf
file. [1]

And it's needed to consider the consequences when using --user/--group
and/or chrooting.


kind regards,

David Sommerseth


[1]
<http://www.phocean.net/2006/12/07/openvpn-and-dns-on-a-linux-client.html>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuWd6kACgkQDC186MBRfrqCRQCdE9XxyO9q+5MxNTm24lRfBJoT
DEcAoKMwEiw6BJDh0kCWLYSWitkq88sA
=b3AJ
-----END PGP SIGNATURE-----


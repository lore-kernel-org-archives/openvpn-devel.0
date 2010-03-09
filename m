Message-ID: <4B96559D.30305@...1114...>
Date: Tue, 09 Mar 2010 15:05:17 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1268064888.17518.1@...1207...>
In-Reply-To: <1268064888.17518.1@...1207...>
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

On 08/03/10 17:14, Karl O. Pinc wrote:
> On 03/08/2010 09:21:35 AM, James Yonan wrote:
>> OpenVPN 2.1 has a relatively recent feature that allows a TAP-based 
>> OpenVPN session to be established where the client gets its IP 
>> address
>>
[...snip...]
> C) A combination of A and B, where there's a separate dhclient
> process run just for openvpn.  This might avoid problems with
> B where the regular interfaces must also be configured because
> autodetection is turned off.  It might also be more portable
> across different dhcp client implimentations (or not.)
[...snip...]

If going for a "simpler way", I'd say this is probably the best
solution.  This gives a flexibility.  On the other hand, ./configure
could try to detect which DHCP client the system got and could use that
as a default client to kick off.

But having that said, it looks pretty close to what --up and --down
scripts can do.  Except that you probably need to be root to run and
stop the DHCP client.  With --user/--group you might have troubles
getting --down run without a downroot plug-in or something like that.

And adding a --dhcp-client feature might be (mis-)used for more things
than just DHCP - depending on the final implementation.  If not
supporting a script interface via --dhcp-client, should OpenVPN know
about different ways how to start and stop each supported DHCP client,
in regards to needed parameters?  How would the maintenance work be
staying updated on behavioural changes in different versions, etc, etc.

I don't know how complex it would be to parse DHCP requests.  Even
though I dislike the idea of making OpenVPN more "feature full" by
extending it to include stuff which is available other places ... but
considering the amount of different DHCP client solutions that exists on
Linux, *BSD, MacOSX and other Unices, I *might* begin to lean towards an
included solution which don't depend on external DHCP clients at all.
But the drawback is that more code need to be maintained, but that's
code which should be able to rely on RFC docs.

But DHCP parsing and configuring IP addresses and routes are one thing
... the next obstacle will then be updating /etc/resolv.conf, which
again is another chapter.  The vpnc client updates that itself, which is
then funny if you're using NetworkManager which haven't understood
another program modified it on purpose, and resets it back.  Many
distroes now make use of the openresolv or similar packages to solve
this.  But, this is a similar issue as the DHCP client issue as well,
which again favours doing the DHCP stuff via a fork()ed DHCP client.


Just my thoughts.


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuWVZsACgkQDC186MBRfroqMgCfZWcJgPdzxzWjkSJwnafHkvtf
07cAn3fCJuDCYUEhI0WnUz7AheUEM+mx
=7yxH
-----END PGP SIGNATURE-----


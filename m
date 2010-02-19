Message-ID: <4B7EA181.4050103@...1114...>
Date: Fri, 19 Feb 2010 15:34:41 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4B7E71A5.3020806@...1114...>
	<20100219134650.GR9556@...1296...>
	<7bb795fd1002190621oefc5e4dx9ccb19d55f0e7534@...278...>
In-Reply-To: <7bb795fd1002190621oefc5e4dx9ccb19d55f0e7534@...278...>
Subject: Re: [Openvpn-devel] [IPv6] Merge conflicts in mroute.c (was: Re:
 openvpn-testing tree available)
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
To: JuanJo Ciarlante <jjo+ml@...410...>
Cc: Openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 19/02/10 15:21, JuanJo Ciarlante wrote:
> On Fri, Feb 19, 2010 at 2:46 PM, Gert Doering <gert@...1296...> wrote:
[...snip...]
>> The existing
>> code doesn't do reverse DNS lookups for IPv4 mroute printing, and so
>> the IPv6 code should behave similar to the IPv4 code, and not do DNS
>> either (also, depending on DNS lookup in this place might lead to
>> weird delays in unexpected situations).  But this is partly religious,
>> partly "follow the coding style of the existing code" stuff.
> 
> IMO we should void using inet_ntop() and friends, personally
> I don't like locking around their lack of multi-threading.

I believe this is a general discussion which will come often up.

Even though OpenVPN is not multi-threaded today, there are no guarantee
that this will not change.  If we get an implementation which will
handle multi-threading, I will favour that one.  I believe OpenVPN will
in the future need to bite the (bitter?) apple and really look into
threading.

So I lean towards JJO here, as far as possible, avoid using functions
which are not thread safe.

[...snip...]


Kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkt+oYEACgkQDC186MBRfrp6FQCeLSKI7OVRHzj09+ATRpP31Lbn
pz0An2X4oqoGbu8syFHmLP5vxqHDAt2p
=qQXQ
-----END PGP SIGNATURE-----


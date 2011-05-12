Message-ID: <4DCBFE39.7080508@...1114...>
Date: Thu, 12 May 2011 17:35:21 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Fwd: Re: [Openvpn-users] behavior of remote address
 with more than one A	record
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Whoops, forgot Cc to openvpn-devel.

David S.


- -------- Original Message --------
Subject: Re: [Openvpn-users] behavior of remote address with more than
one A	record
Date: Thu, 12 May 2011 17:22:45 +0200
From: David Sommerseth <openvpn.list@...1114...>
To: William Cooley <william@...1460...>
CC: Jan Just Keijser <janjust@...1147...>,  openvpn-users
<openvpn-users@lists.sourceforge.net>

On 12/05/11 14:23, William Cooley wrote:
>
> On 5/12/2011 1:46 PM, Jan Just Keijser wrote:
>> William Cooley wrote:
>>> I'd like to have a remote address setting that has two A records. The
>>> client should randomly try to connect to one of the addresses and if it
>>> fails it should either try the other IP address or do a randomize
>>> operation on the IP selection again.
>>> In previous versions of openvpn if you specified a domain that resolved
>>> to two or more IP addresses you'd get a long line like
>>> /RESOLVE: NOTE: vpndomain.com resolves to 2 addresses, choosing one by
>>> random/
>>> and I believe it performed as I described above.
>>> However it looks like with openvpn 2.1.4 and newer you simply get
>>> /RESOLVE: NOTE: vpndomain.com resolves to 2 addresses/
>>> and if it fails to connect to the first IP address it never tries the
>>> other address and simply indefinitely tries to connect to the same address.
>>>
>>> Was there some type of change in the code that was not mentioned in the
>>> changelog? Does any one have more information on this? Is there a
>>> setting that can restore this behavior?
>>>
>> it's mentioned in the changelog:
>>
>> * Implemented multi-address DNS expansion on the network field of route
>>  commands.
>>
>>  When only a single IP address is desired from a multi-address DNS
>>  expansion, use the first address rather than a random selection.
>>
>>
>> but it seems this had the unintentional side-effect , namely what you
>> describe.
>> this is either a bug or it should have been documented better.
>>
>> cheers,
>>
>> JJK
>>
> Yes I say this but I assumed it only applied to the route command.
> The man pages for both 2.1 and 2.2 still say
>> If *host* is a DNS name which resolves to multiple IP addresses, one will
>> be randomly chosen, providing a sort of basic load-balancing and failover
>> capability.
> So can this be called a bug?

Let me first start with this last question.  No, this is not a bug.  I will
explain this better.

This change came in commit f9b2ada0eece0615 / SVN r6291 [1] and was
discussed in a couple of developer meetings last spring.

To summarize it quickly:

The previous behaviour was prune to misbehave in many setups.  DNS servers
will by default do this kind of round-robin load balancing.  So if you had
two servers with IN A records (f.ex: serverA and then serverB), OpenVPN
would not consider the order of these two records and take one randomly.
After the TTL for this record expires and OpenVPN again does a name lookup
(lets say there have not been any other requests to the DNS for this IN A
record in this case) the order would be different (f.ex: serverB and then
serverA).  In this case OpenVPN most likely pick the same host as it used
the first time, and then "un-randomise" the order.  Which would again lead
to no load balancing at all.

So the conclusion was to not do any randomisation in OpenVPN at all, and
trust that the DNS server does its round-robin job.  And lowering the TTL
for these IN A addresses used for OpenVPN servers will therefore give a
better control of the round-robin handling - resulting in load balancing.


You can test this by making sure the TTL is set low enough on your server
records (say 60 seconds), make sure that your client will do a new DNS
lookup with the proper TTL (you can check this with 'dig').  Then connect
to your server and break the connection after one minute and then
reconnect.  In this case, if the DNS server does the job properly, it would
now give your second server - which OpenVPN should use.



kind regards,

David Sommerseth


[1]
<http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn-testing.git;a=commitdiff;h=f9b2ada0eece06158cc3ce6f6348bd431dfd7f0a>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk3L/jkACgkQDC186MBRfrr61QCgl2HQt5VR6QwUyUdnzF9kSmTk
8DoAn0dl44UWCp/KJtn/P0Jl4CPjDCi0
=c7SN
-----END PGP SIGNATURE-----


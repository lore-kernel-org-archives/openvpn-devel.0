Message-ID: <4DCC4CC7.9050803@...1114...>
Date: Thu, 12 May 2011 23:10:31 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4DCBFE39.7080508@...1114...>
	<jwvwrhv4sxr.fsf-monnier+INBOX@...1269...>
In-Reply-To: <jwvwrhv4sxr.fsf-monnier+INBOX@...1269...>
Subject: Re: [Openvpn-devel] Fwd: Re: [Openvpn-users] behavior of remote
 address with more than one A	record
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
To: Stefan Monnier <monnier@...1268...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/05/11 21:46, Stefan Monnier wrote:
>> You can test this by making sure the TTL is set low enough on your server
>> records (say 60 seconds), make sure that your client will do a new DNS
>> lookup with the proper TTL (you can check this with 'dig').  Then connect
>> to your server and break the connection after one minute and then
>> reconnect.  In this case, if the DNS server does the job properly, it would
>> now give your second server - which OpenVPN should use.
> 
> But this is about load-balancing, whereas the OP's issue is with
> fail-over.  If the TTL is not low enough then the fail-over will not
> happen (OpenVPN will keep trying to connect to same first host in the
> list).  It seems that for fail-over, OpenVPN should do a single DNS
> request and then cycle though the list of hosts it received.

Fair enough, but playing the devils advocate, would you use a
load-balancing feature (round-robin) as fail-over solution generally?

Rightfully enough, the former behaviour could be used for both, but the
fail-over would still just be a side-effect - which still would be prune to
get the same host again, due to TTL and randomisation of that result could
pick the same host again.

For a more proper and cleaner fail-over solution, you can use multiple
- --remote options together with --remote-random.  This can also be used for
load-balancing as well.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk3MTMIACgkQDC186MBRfrrxyQCgpfOxcPJqNZAgDzR739HsCg/8
utgAnA7NHvmDw8fokZpsHQDa7q45BB3K
=xzG8
-----END PGP SIGNATURE-----


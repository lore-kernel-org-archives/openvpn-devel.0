Message-ID: <4BCCC1ED.2030500@...1114...>
Date: Mon, 19 Apr 2010 22:49:49 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1267391523-1123-1-git-send-email-openvpn.list@...1114...>	<201003101634.58839.dave_br@...1278...>	<4B98179E.9020904@...1114...>
	<201003112141.01092.dave_br@...1278...>
In-Reply-To: <201003112141.01092.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [PATCH] bash->bourne script cleanup
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
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/03/10 22:41, Davide Brini wrote:
> On Wednesday 10 March 2010, David Sommerseth wrote:
> 
>>> Well, I was actually going to write a patch, but shortly after starting I
>>> found out that it would end up being essentially the same as Gentoo's
>>> scripts. Would it be worth separately maintaining something that has
>>> already been written somewhere else?
>>
>> I would say that if there are things which are distro related, they
>> should either be found only in that distribution or we can consider (if
>> it is considered important by more people) to put distro specific stuff
>> into a separate folder in the OpenVPN source tree.
>>
>> If it is possible to get some up/down scripts which are generic for the
>> vast majority of POSIX sh based distributions, that would be the
>> preferred approach.  If not, then we are back to where we started :)
> 
> Ok, here it goes (it's against 2.1.1). As said, it's basically a complete 
> rewrite that draws many ideas from the Gentoo scripts. These are the main 
> differences from the "old" client.{up,down} scripts:
> 
> - No more bashisms (AFAICT). Should work with any POSIX-compatible shell 
> (which means "almost all reasonably recent shells"), though I've only tested 
> with bash and dash.
> 
> - Unnecessary calls to external tools (sed) removed 
> 
> - Manages multiple DNS and DOMAIN options. Each DNS option becomes a 
> "nameserver" line in the new resolv.conf (up to a maximum of 3). If there's a 
> single DOMAIN option, it becomes a "domain" line in resolv.conf; otherwise, 
> all the domains are listed in a "search" line in resolv.conf (eg "search 
> foo.com example.net").
> 
> - Client.up renames the existing resolv.conf and creates a brand new one; 
> client.down restores it from the saved copy when the VPN terminates (the usual 
> rules about running as root apply). This is how Gentoo does that; the old 
> scripts instead added/removed some lines at the beginning of the file, which 
> looks a less clean approach to me. The rename approach also dramatically 
> simplifies and shortens client.down, as you'll see.
> 
> - Uses resolvconf if it's available (detected by the presence of 
> /sbin/resolvconf) rather than writing to resolv.conf directly. Not sure 
> whether this is a Linux-only thing or other systems use it though.
> 
> A doubt I have is: should the script output its errors as it does now? If yes, 
> is it possible to somehow send them to the main OpenVPN log so they appear 
> among the other normal messages?
> 
> Let me know what you think.

ACK!

I've done a quick test on one of my connections on Fedora 12 without any
resolvconf package (meaning it invokes the simple cp approach), and it
worked like a charm.

Applied to bugfix2.1 and merged into allmerged.
Commit a9c9a89e96dc1e4e843e05ecadc4349b81606b06


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvMwe0ACgkQDC186MBRfroWOwCeMFu3NO/s6UDeTSjGkmde/DpQ
MtsAn0rqsF7B5/4RIjcF4k7zyoryvhsw
=RuVf
-----END PGP SIGNATURE-----


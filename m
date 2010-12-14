Message-ID: <4D07AEC7.3010408@...1114...>
Date: Tue, 14 Dec 2010 18:52:07 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <AANLkTi=Fykb-NkSxx+=HM1U0ob4mmD0GkyfP_Mhb9=m1@...278...>	<1292286924.6222.3.camel@...1259...>
	<AANLkTikhRr-YhNP4OaZM8kCJ++-OcKh=eQ9jAeedxjNj@...278...>
In-Reply-To: <AANLkTikhRr-YhNP4OaZM8kCJ++-OcKh=eQ9jAeedxjNj@...278...>
Subject: Re: [Openvpn-devel] Can *plugin* kill specific ovpn tunnel?...
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
To: Vineet Kumar <vineet.kumar@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 14/12/10 18:47, Vineet Kumar wrote:
> Thanks for your response. This seems to involve file I/O and iptables
> right? File I/O seems like a performance bottleneck, no?

Maybe, if you're still using tapes and need to rewind the tape ;-)

Seriously, not really.  All decent OSes today have pretty good caching,
so most likely will things not manage to get written properly to disk
before the file is read, parsed and removed again by OpenVPN.

But to improve things a bit, you can always mount a directory for such
files in a tmpfs (or a RAM disk) and let OpenVPN use that.


kind regards,

David Sommerseth



> Vineet
> On Mon, Dec 13, 2010 at 4:35 PM, chantra <chantra@...1258...
> <mailto:chantra@...1258...>> wrote:
> 
>     Vineet,
> 
>     I think you could use Packet filtering plugin hook and use the
>     [KILL] tag at the end of the pf file .
> 
>     See
>     http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn-testing.git;a=blob;f=openvpn-plugin.h;h=56b0a701574e6913b3a714e941cdc4899dbea8e1;hb=HEAD#l316
> 
>     I have never used it myself, but I think that should sort you out.
> 
>     The doc says that this file may be dynamically updated during a
>     client session. I assume the main process will pick up the change
>     quick fast.
> 
>     Chantra
> 
> 
>     On Mon, 2010-12-13 at 15:16 -0800, Vineet Kumar wrote:
>>     Hi,
>>       If my openvpn plugin spawns its own thread and from that thread
>>     wants to kill a tunnel specified by IP:port how can that be done?
>>     (something like what the 'telnet' management provides: "kill IP:port")
>>     This plugin is meant to do other stuff and in certain scenarios wants
>>     to close specific tunnels.
>>     First I thought of using the plugin to write code to establish a
>>     telnet-client sessions and send over "kill IP:port" command. But I
>>     notice an issue with the management listener: if I run more than 1
>>     telnet session only the first one can pass through data whereas all
>>     others' telnet sessions just hang.
>>
>>     Is this even possible?
>>
>>     Vineet
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0HrsYACgkQDC186MBRfrqm1ACfeP0/aDdh9Ss2Xuas583v+R5A
dtkAnRBv1+3Ky9BOQwDana06n3xxKOMa
=8ouQ
-----END PGP SIGNATURE-----


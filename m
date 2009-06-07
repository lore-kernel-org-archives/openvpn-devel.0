Message-ID: <4A2B5F8B.4040208@...41...>
Date: Sun, 07 Jun 2009 00:34:51 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <16130.65.118.50.246.1232730850.squirrel@...1166...>	<24624.65.118.50.246.1244149998.squirrel@...1166...>	<1244174393l.6685l.3l@...1207...>
	<31530.65.118.50.246.1244212489.squirrel@...1166...>
In-Reply-To: <31530.65.118.50.246.1244212489.squirrel@...1166...>
Subject: Re: [Openvpn-devel] Loss of routes causes routing loop
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Daniel Johnson <Progman2000@...1085...>
Cc: openvpn-devel@lists.sourceforge.net

Daniel Johnson wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Karl O. Pinc wrote:
>> Openvpn does not do DNS at all.  You can use it to push DNS related
>> DHCP options to the "clients" so that they are directed to a DNS
>> server that does the right thing.  (There may be a way to do
>> something similar in a "client-side" config, I don't recall.) That's
>> about it.
> 
> Sorry, I wasn't specific.  My clients look up
> "openvpn1[2,3,4].chguernsey.com" to connect, and I'm interested in how
> it handles the results.  I expect it uses the Windows resolver, and
> that it will receive all of the numeric results.  So if I change my
> DNS entries to report
>   PTR mercury.chguernsey.com.
>   A   65.120.131.235
>   A   172.21.166.249
> can I get the client to "notice" that it is directly connected to the
> 172.21.166 subnet and use that IP?
> 
> For the moment I'm pursuing a split-view DNS to report only the
> internal address on that subnet.  It should hide the effects of the
> routing-loop problem until it can be properly resolved.

Daniel,

Earlier you mentioned that "In wireless use, we find that Windows will
dump SOME of the routes created by OpenVPN when the radio changes APs".

When this occurs, does it trigger a reconnection by the OpenVPN clients
to the server?  If so, you can ensure that client-side routes are reset
as part of the reconnection by NOT using the "persist-tun" directive in
the client config file.

James



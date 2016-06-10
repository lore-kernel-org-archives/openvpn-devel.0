References: <575AA2BD.60908@...277...> <20160610125457.GC62247@...1296...>
From: debbie10t <debbie10t@...277...>
Message-ID: <575AC1E2.9000802@...277...>
Date: Fri, 10 Jun 2016 14:34:26 +0100
MIME-Version: 1.0
In-Reply-To: <20160610125457.GC62247@...1296...>
Subject: Re: [Openvpn-devel] pull-filter reject = server hammering !
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 10/06/16 13:54, Gert Doering wrote:
> Hi,
>
> On Fri, Jun 10, 2016 at 12:21:33PM +0100, debbie10t wrote:
>> today I successfully built git-master for windows x86_64
>> and started testing the new features.
>>
>> You will be pleased to know that everything works well
>> (as far as my limited knowledge and testing goes)
>>
>> However, why does pull-filter reject throw SIGUSER1 ?
> So the client can move to the next server - or retry, in case it was
> a temporary hickup at the server...
>
>> If the server pushes an item the client rejects then
>> the client will just reconnect endlessly, completing a
>> full reconnect to the server then restarting !
>> Thispractically constitutes a DDOS ..
> "If you send me stuff that I find reject-worthy, you should be DoSed!!!"
>
> Seriously: I expect people to notice that their VPN isn't connecting, and
> check the log, no?
>
> @Selva, Arne: can we make the reconnect logic somewhat smarter overall, like
> "if reconnecting to the same host, wait 30 seconds instead of 5"?
>
> gert

Very well .. going for the jugular ..

Consider:

VPN provider A (VPNA) doing good business
(Also fighting the GreatFireWall of China)

VPN provider B (VPNB) want to stop VPNA
(VPNB is the *Chinese Government* masquerading as VPNB)

VPNB modifies VPNA client configs to include
--pull-filter reject ""

VPNB deploys 1000s of machines with 1000s of VMs
all running VPNA's modified client config ..

VPNA has to block China! (plus any other co-conspirators)

Chinese Government deals a huge blow to VPN providers.
VPN providers drop openvpn as a supported platform.

IMO,
if a client wants to ignore and continue using a VPN - OK
if a client wants to reject a pushed item then there must
be a real reason, otherwise just ignore.
If a client believes a server is pushing maliciously then
they would *not* want to connect again, until it is resolved.

Regards.



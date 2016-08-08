References: <57A87572.6080306@...277...>
	<20160808122011.GC78279@...1296...>
From: debbie10t <debbie10t@...277...>
Message-ID: <57A896DD.1020004@...277...>
Date: Mon, 8 Aug 2016 15:27:41 +0100
MIME-Version: 1.0
In-Reply-To: <20160808122011.GC78279@...1296...>
Subject: Re: [Openvpn-devel] Is --ifconfig-ipv6-noexec planned ?
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>



On 08/08/16 13:20, Gert Doering wrote:
> Hi,
>
> On Mon, Aug 08, 2016 at 01:05:06PM +0100, debbie10t wrote:
>> --ifconfig-ipv6-noexec
>>
>> not sure if this would be a 'feature request/wish list' item
>> or if it has just been over looked.
>>
>> I did have an annoying use case but I reconfigured so as not
>> to need it, but I feel like there would be cases for it.
> I do not see the use case to have "only IPv6" --ifconfig-noexec - so the
> generic command does that for both IPv4 and IPv6 (as will --route-noexec
> do for both IPv4 and IPv6).
>
> What is your use case?
Use case is a service listening on client tun device would crash if
the connection was not up.  So I used --mktun to create the interface
at boot for the service and then start the service.  when starting
openvpn, pulling the ipv4&6 addresses would exit openvpn as the ipv6
address already existed.  ifconfig exit with error status 1, FATAL etc.

>
> (The idea behind --ifconfig-noexec is not "do not enable IPv6", use
> --pull-filter for that.  --ifconfig-noexec is used together with --up
> to run more custom stuff on ifconfig, which the built-in mechanisms
> cannot do)
>

Sorry gert, I must have done something stupid before because now
--ifconfig-noexec *does* work for IPv4 & 6 .. For some reason as
it was the IPv6 address causing the fault I thought it only worked
for IPv4 .. unfortunately, I don't know what mistake I made :(

So I can setup the original way, although, now that I have
reconfigured I prefer the new setup, so I don't actually need
ifconfig-noexec.



Regards



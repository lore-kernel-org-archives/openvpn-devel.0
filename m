References: <c97c0fd6-3d34-fb94-40e4-3ec8dc7af0c9@...277...>
	<f910a64e-235f-56ad-52b4-aff5dae46acf@...277...>
	<CAKuzo_hUiYVxZSEnB=8=ijO86_VbiZep2mR=1_FCi2pFJYLYmg@...278...>
	<20170613192559.GX97029@...1296...>
	<CAKuzo_gGy8xWAwBCzrxshHBPyzV=iMA=17vxnfSngfZ_b5MUrQ@...278...>
	<20170613193756.GY97029@...1296...>
	<CAKuzo_ig=HFtgzxc3qSzFWZ5H4pGi_JKjiL50DRc3GRdFL1Yaw@...278...>
From: debbie10t <debbie10t@...277...>
Message-ID: <1c726aa0-84eb-5956-1621-e0afef500193@...277...>
Date: Fri, 16 Jun 2017 00:59:55 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_ig=HFtgzxc3qSzFWZ5H4pGi_JKjiL50DRc3GRdFL1Yaw@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] W10 Client assigns old AND new IPv6 address to
 TAP with GUI+Service but not with cmd prompt
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net



On 13/06/17 21:15, Selva Nair wrote:
> On Tue, Jun 13, 2017 at 3:37 PM, Gert Doering <gert@...1296...> wrote:
> 
>> On Tue, Jun 13, 2017 at 03:33:35PM -0400, Selva Nair wrote:
>>> Right :)  But we could probably do better using Set instead of Add while
>>> the address is set using the service. I'm not that familiar with ipapi,
>> but
>>> looks like SetUnicastIpAddressEnrty instead of AddUnicastIpAddressEntry
>>> may be the right thing.
>>>
>>> The netsh command used when service is not in use does correctly do a set
>>> not add.
>>
>> Good point.  Wouldn't solve the first problem, but at least a subsequent
>> run would "magically fix it", provided the same tap interface is used
>> (which, I think, is the case in the great majority of windows
>> installations)
> 
> 
> Okay, I can say that the issue is indeed the service effectively doing an
> "add address" instead
> of "set address". Reproduced this without using an admin run:
> 
> 1. Connect to server 1 using GUI/iservice
> 2. Kill iservice using taskmanager or taskkill (do not do sc stop
> service-name.. as that will do a graceful stop)
> 3. Start the service again
> 4. Disconnect  from server 1
> At this point "netsh int ipv6 show addr" will show that v6 addres is
> retained although the connection is down
> 4. connect to server 2 using GUI/iservice
> 
> Now the adapter will have two ipv6 addresses.
> 
> On Tue, Jun 13, 2017 at 3:50 PM, Samuli Seppänen <samuli@...515...> wrote:
> 
>> I encountered the issue with the Powershell test suite
>> (openvpn-windows-test) which ran through a bunch of t_client test
>> configs and forcibly killed the OpenVPN process at the end of each test.
>> All ping6 tests except the first one would then fail, because adding a
>> default IPv6 route failed as one existed already.
> 
> 
> Probably the same issue. The real culprit here is force-killing without
> impunity. I'll be posting a PR to the GUI that allows sending connect,
> disconnect and exit commands to the running GUI, so we could use that in
> the script. That said using "set address" in the service will mitigate this
> to some extent -- looks easy to do a patch..
> 

PEBKAC's aside .. +1 to 'set not add'


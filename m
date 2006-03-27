Message-ID: <44287972.9070802@...41...>
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN for PocketPC
References: <000d01c651e6$80e420c0$1601a8c0@...576...>
In-Reply-To: <000d01c651e6$80e420c0$1601a8c0@...576...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Mar 27 15:48:03 2006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Dave wrote:
>> -----Original Message-----
>> From: James Yonan [mailto:jim@...41...] 
>>     
>
> ...
>
>   
>>> etc.  I believe the object spaces have been unified, and I know you 
>>> can take a socket and pass it to, say WaitForSingleObject 
>>>       
>> and have it 
>>     
>>> work.
>>>       
>> They sort of did that with WSAEventSelect -- if there was a way that 
>> WSAEventSelect could be used on the TAP device handle (as well as the 
>> network socket), then that would be another route towards moving away 
>> from overlapped I/O.
>>     
>
> Upon thinking about your suggestion, I think there are some problems:
>
> *  SOCKETs that go to select() can be signalled in three different ways:
> read data available, ready to accept writes, and error (more for
> WSAEventSelect).  Windows handles are either signalled or non-signalled, so
> there isn't that breakdown.  I think this is internal architecture to
> Winsock and I don't know if it could be replicated into other systems.  An
> interesting research project, though.
>   
Exactly, that's why WSAEventSelect exists -- to provide event mapping
from socket to handle space.
> I also noticed that sockets are not handles in CE, so the likelihood of
> select ever accepting HANDLEs directly is slim to none.  There might be some
> funky wrapper that could be made, though again there would be research to do
> on that.
>
>   
>>> the existing event architecture as-is, and I just had to make some 
>>> specialized versions of tun_finalize, queue_read, open, close, etc.
>>>       
>> How did you deal with getting socket.c off of overlapped I/O 
>> (or did you 
>> figure out a way that PocketPC can do overlapped I/O?).
>>     
>
> The latter, mostly.  It was a happy confluence of events that:
> *  Winsock implementations are required to support overlapped IO, at least
> through the WSA- functions,
> *  you happily were already using the WSA- functions for the waits and get
> results,
> *  the WSAEvent in CE is really a native event, and the WSAOVERLAPPED is
> defined the same as OVERLAPPED
>
> So it all fell into place.  I had to modify tun to call my emulated
> overlapped io api, but this wound up being fairly a fairly surgical (i.e.
> not gross) change.
>
>   
>>> I didn't bother
>>> doing the same with writes since they always completed immediately 
>>> anyway once handing off to NDIS.
>>>       
>> I would worry about assuming this unless the API guarantees it.  I've 
>> seen a few cases in the overall development of OpenVPN where assuming 
>> that writes always complete immediately (even when totally 
>> supported by 
>> observed behavior) introduced subtle bugs.
>>     
>
> I'm curious if you can expound.  Subtlety is not a virtue in bugs!  I was
> going by my interpretation of the existing driver code.  It seemed to me it
> went like:
>
> 1)  IRP_MJ_CREATE comes in
> 2)  packet is handed off to NDIS via NdisMEthIndicateReceive and finished
> via NdisMEthIndicateReceiveComplete
> 3)  the IoCompleteRequest() finished the IRP under all code paths
> immediately
>
> So it seemed that really it was always completing immediately.  And even if
> it wasn't, since the next time usermode queues a write it waits for the
> first to complete (via finalize) so it didn't seem to be a big loss to leave
> that call synchronous.  NDIS sends the packet up the stack asynchronously
> already.
>   
Some time back I put in some debugging code to print a status line if
WriteFile queued an overlapped action rather than an immediate return,
and I recall that WriteFile did queue sometimes -- but only when I
intentionally stress tested the machine, by having lots of apps running,
and making it come in and out of hibernation.

If it's rare enough, then it's probably okay to just do a blocked write
-- then worst-case-scenario is the event loop halts for some
milliseconds, and it's not like people are going to run OpenVPN servers
on their PocketPC (where the latency would matter).
>   
>> It's probably not essential to support control-c/keyboard 
>> signaling -- 
>> this feature is used mostly by developers who run OpenVPN in console 
>> mode.  Real-world usage of OpenVPN usually involves running 
>>     
>
> Ah!  So I'm the only one to bear the burden!  Well, good to know that -- I
> hadn't delved that far into the openvpn architecture.  Actually, the
> management interface sounds like it will make the future task of packaging
> up a PPC-relevant UI much more easy than I expected, so that's good news
> indeed.
>
>   
>> The driver has quite a bit of instrumentation code to help debug/test 
>> the DHCP handshake.
>>     
>
> Yes, now I must figure out how to interpret it.  Care to take a look at the
> output from the driver and/or openvpn?  You might can tell me immediately
> what it means where it might take me days to figure it out.  I'll stick an
> excerpt at the bottom of this message.
>
>   
>> Nobind is quite an important option, so I'm surprised that CE 
>> wouldn't 
>> support it.  If it's really not supported on UDP sockets, it might be 
>> possible to simulate nobind by binding to a dynamic port number (from 
>> 49152 through 65535) and if the bind fails, retry the next 
>> higher value.
>>     
>
> What clued me in was the docs for WSARecv which explicitly stated that the
> socket must be bound, so I suppose that technically it shouldn't work on NT
> either, but just does as a 'gift'.  Again, I should be able to emulate the
> behavior somewhat by binding a port of 0, though for some reason this
> chooses between 1024 and 5000, as opposed to the high ones.  The
> try-and-repeat you suggest should also work.
>
>
>   
If it tries a value between 1024 and 5000 then it's probably acting the
same as Win 2000/XP which I've also seen allocate from this range.
>>> Iftikhar:  I updated the source and also I fixed the problem I 
>>> mentioned previously about the driver not handling the 
>>>       
>> power-off state 
>>     
>>> correctly; you can power on and off to heart's content.
>>>   
>>>       
>> Is this fix relevant to the 2000/XP version of the driver as 
>> well?  If 
>> so, would you mind posting a patch that only addresses this fix?
>>     
>
> It's not relevant.  The stream driver part for CE has some additional power
> management stuff.  My doing debug file io at that time is apparently uncool.
> I removed that and all worked again.  The NDIS power management behaves fine
> as-is.
>
>
>   
>> Okay, a couple questions for you:
>>
>> The 2000/XP version of the driver uses the OemWin2k.inf file and 
>> tapinstall.exe (basically a clone of devcon.exe from the DDK) 
>> to install 
>> and configure the TAP device nodes.  What is the PocketPC way 
>> of doing this?
>>     
>
> Pretty easy:  registry keys are set up.  If one wishes you can then load the
> driver immediately with an ioctl you send to NDIS, or you can soft-reset
> (sortof like 'restart windows') and it will be loaded automatically.
>
> For testing, I made a little app that adds/removes the keys and
> loads/unloads the driver.  In a release situation this can be handled in the
> CAB file, and/or little app like the tapinstall.exe you mention.
>
>   
>> 2000/XP provides the netsh utility for programmatically configuring 
>> network devices.  Does PocketPC have any equivalent utility/API?
>>     
>
> Yes and no.  I'm not familiar with netsh, but understand it to have been
> created because it is fancier than the sundry other tools and more amenable
> to scripting.  There is not an equivalent to this for CE.  Now, the stuff
> like ping, route, ipconfig, etc., do exist.  They don't ship with PPC
> because it doesn't have a console out-of-box anyway.  They are findable on
> the internet and I have a set which I am using now.  Actually I think
> Microsoft releases the source available -- they're pretty much all a UI to
> the IpHelper functions.  Which, since you already have those calls in
> openvpn, it might obviate the necessity for an end user to worry about them.
>
> -Dave
>
>
> PS Oh, regarding output from my DHCP, this is what my windows box says
> during the last phase of negotiation:
>
> Sun Mar 26 17:36:30 2006 us=885461 TAP-WIN32 device [OpenVPN] opened:
> \\.\Global\{0B8E84A0-84E7-46DB-BEE7-C4B0166791E9}.tap
> Sun Mar 26 17:36:30 2006 us=885495 TAP-Win32 Driver Version 8.1 
> Sun Mar 26 17:36:30 2006 us=885512 TAP-Win32 MTU=1500
> Sun Mar 26 17:36:30 2006 us=885537 Notified TAP-Win32 driver to set a DHCP
> IP/netmask of 10.8.0.50/255.255.255.0 on interface
> {0B8E84A0-84E7-46DB-BEE7-C4B0166791E9} [DHCP-serv: 10.8.0.0, lease-time:
> 31536000]
> Sun Mar 26 17:36:30 2006 us=892848 Successful ARP Flush on interface [5]
> {0B8E84A0-84E7-46DB-BEE7-C4B0166791E9}
> Sun Mar 26 17:36:30 2006 us=901492 TEST ROUTES: 0/0 succeeded len=-1 ret=0
> a=0 u/d=down
> Sun Mar 26 17:36:30 2006 us=901537 Route: Waiting for TUN/TAP interface to
> come up...
> Sun Mar 26 17:36:32 2006 us=65631 TEST ROUTES: 0/0 succeeded len=-1 ret=0
> a=0 u/d=down
> Sun Mar 26 17:36:32 2006 us=65678 Route: Waiting for TUN/TAP interface to
> come up...
> Sun Mar 26 17:36:33 2006 us=434239 TEST ROUTES: 0/0 succeeded len=-1 ret=1
> a=0 u/d=up
> Sun Mar 26 17:36:33 2006 us=434277 Initialization Sequence Completed
>
>
> And this is what the similar section on the pocket pc says:
>
> Mon Mar 27 08:56:29 2006 us=47349 TAP-WIN32 device [TAP1:] opened: TAP1:
> Mon Mar 27 08:56:29 2006 us=48315 TAP-Win32 Driver Version 8.1 (DEBUG)
> Mon Mar 27 08:56:29 2006 us=48978 TAP-Win32 MTU=1500
> Mon Mar 27 08:56:29 2006 us=49755 Notified TAP-Win32 driver to set a DHCP
> IP/netmask of 10.8.0.51/255.255.255.0 on interface TAP1: [DHCP-serv:
> 10.8.0.0, lease-time: 31536000]
> Mon Mar 27 08:56:29 2006 us=51431 Successful ARP Flush on interface [131074]
> TAP DEVICE 1
> Mon Mar 27 08:56:29 2006 us=84761 TEST ROUTES: 0/0 succeeded len=-1 ret=0
> a=0 u/d=down
> Mon Mar 27 08:56:29 2006 us=85677 Route: Waiting for TUN/TAP interface to
> come up...
> (...12 times...)
> Mon Mar 27 08:56:58 2006 us=389816 Initialization Sequence Completed With
> Errors ( see http://openvpn.net/faq.html#dhcpclientserv )
>
>
> During that activity the driver is spewing out the following debug:
>
>
> [TAP DEVICE 1] Unhandled OID ffffff
> [TAP DEVICE 1] Unhandled OID 20214
> [TAP DEVICE 1] Unhandled OID 20215
> [TAP DEVICE 1] Unhandled OID 20215
> TAP_Open; dwData = 0x00036110, dwAccess = 0xc0000000, dwShareMode =
> 0x00000000; inst = 0x00036110
> [TAP DEVICE 1] [TAP] release [8.1] open request (m_TapOpens=0)
> AdapterTransmit ??? src=0:ff:2d:4b:be:28 dest=33:33:ff:4b:be:28 proto=0x86dd
> len=86
> AdapterTransmit ??? src=0:ff:2d:4b:be:28 dest=33:33:0:0:0:2 proto=0x86dd
> len=62
> AdapterTransmit ??? src=0:ff:2d:4b:be:28 dest=33:33:ff:4b:be:28 proto=0x86dd
> len=78
> AdapterTransmit ??? src=0:ff:2d:4b:be:28 dest=33:33:0:0:0:2 proto=0x86dd
> len=70
> AdapterTransmit ??? src=0:ff:2d:4b:be:28 dest=33:33:ff:4b:be:28 proto=0x86dd
> len=86
> AdapterTransmit ??? src=0:ff:2d:4b:be:28 dest=33:33:0:0:0:2 proto=0x86dd
> len=70
> AdapterTransmit IPv4 UDP[342] BOOTREQUEST DHCPDISCOVER
> 0.0.0.0:BOOTPC[0:ff:2d:4b:be:28] ->
> 255.255.255.255:BOOTPS[ff:ff:ff:ff:ff:ff] ch=0:ff:2d:4b:be:28 xid=0x00000ae9
> ma=0x00000383 id=0x4451 ttl=128 ic=0xf554 [0x0000] uc=0x75e6 [0x0000/60]
> OPT.53.1.1.61.7.1.0.255.45.75.190.40.55.7.1.3.6.15.44.46.47.255.0.0.0.0.0.0.
> 0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0
> DHCPMsg IPv4 UDP[304] BOOTREPLY DHCPOFFER 10.8.0.0:BOOTPS[0:ff:2f:4b:be:28]
> -> 255.255.255.255:BOOTPC[ff:ff:ff:ff:ff:ff] yi=10.8.0.51 si=10.8.0.0
> ch=0:ff:2d:4b:be:28 xid=0x00000ae9 ma=0x00000300 ttl=16 ic=0x9fc4 [0x0000]
> uc=0x311e [0x0000/22]
> OPT.53.1.2.54.4.10.8.0.0.51.4.49.0.0.0.1.4.255.255.255.0.255
>
> With the last pair repeated 12 times.
>
> In the short term I modified the client config to use:
>
> ifconfig 10.8.0.40 255.255.255.0
> ip-win32 ipapi 
>
> Which gets me further but I don't really know what I'm doing, I'm just
> hacking around.  When those configs are used, I then get the address of
> 10.8.0.51.  Hmmm.  Shouldn't I have gotten .40?  The .51 what what I
> originally was going to be assigned from DHCP!
>
>   
Are you using OpenVPN 2.0 or 2.1 (better to use 2.1 in this regard).

Basically if you see repeating cycle of TAP getting
BOOTREQUEST/DHCPDISCOVER messages from the DHCP client service and then
replying with BOOTREPLY/DHCPOFFER, it means that the DHCP client service
is not happy with the DHCPOFFER message which was returned by the TAP
driver (or perhaps it didn't receive the message).

As far as the OpenVPN configuration is concerned, see the static key
howto http://openvpn.net/static.html which includes a very barebones
configuration which should be suitable for testing purposes.

If you want to test the automatic DHCP negotiation, try using OpenVPN
2.1 and use "topology subnet".

Setting the IP/subnet (and other optional attributes) on the TAP adapter
is problematic on Windows due to the lack of a direct API call.  So the
--ip-win32 option allows multiple methods to be tried.  --ip-win32 ipapi
might work, but it's not clear to me why it used .51 in your case.  It
would help to see your config files.

Also, keep in mind that the IP helper API doesn't have the function we
really need which is "Assign IP address, netmask, and other DHCP
properties to network adapter".  Instead it has a function which "adds"
an IP/netmask to an already-configured network adapter.  That means that
you often end up with the primary IP address being the
"autoconfiguration" address, with the one you really wanted assigned as
a secondary IP/netmask.  Less than optimal, and breaks some apps.
That's why --ip-win32 dynamic is the default (which basically tells the
TAP adapter to implement its own internal DHCP server).

James




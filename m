Message-ID: <44282E12.6050109@...41...>
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN for PocketPC
References: <000001c65146$e4da2520$1601a8c0@...576...>
In-Reply-To: <000001c65146$e4da2520$1601a8c0@...576...>
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
Date: Mon Mar 27 10:26:05 2006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Dave <dev@...575...>
Cc: 'Iftikhar Qureshi' <iftikharqureshi@...109...>, openvpn-devel@lists.sourceforge.net

Dave wrote:
>> -----Original Message-----
>> From: James Yonan [mailto:jim@...41...] 
>> Sent: Sunday, March 26, 2006 3:02 PM
>> To: Dave
>> Cc: 'Iftikhar Qureshi'; openvpn-devel@lists.sourceforge.net
>> Subject: Re: [Openvpn-devel] OpenVPN for PocketPC
>>
>>
>>     
>>> *  I discovered yesterday that in the particular case of 
>>>       
>> winsock, that 
>>     
>>> overlapped io support is required, and (supposedly) has been 
>>> implemented in CE and is available via the WSA versions of those 
>>> methods (e.g. WSAGetOverlappedResult).  This is really good news 
>>> because it possibly means that all the socket.c work will 
>>>       
>> not have to 
>>     
>>> be reworked at all.  Hopefully!
>>>
>>> So I think that only the five various tun_* and *_tun 
>>>       
>> methods need to 
>>     
>>> be implemented to declare this 'feature complete' and then the 
>>> exciting phase of testing/fixing begins.
>>>
>>>   
>>>       
>> The Windows version of OpenVPN currently wants overlapped I/O to be 
>> supported by the OS.  The reason why overlapped I/O was 
>> originally used 
>> (rather than unix-style select or poll) is so that the event 
>> loop could 
>> treat TAP device events the same as network socket events, and handle 
>> network and TAP events within a single event loop.
>>
>> The root of the problem is that Windows supports two incompatible (as 
>> far as I know)  I/O wait event spaces:  there is the SOCKET 
>> type which 
>> can be used as an argument to select() and then there's the HANDLE 
>> (returned by CreateEvent) which is used as an argument to 
>> WaitForSingleObject/WaitForMultipleObjects.  Currently the Windows 
>> version of OpenVPN uses the HANDLE space which unfortunately 
>> makes the 
>> I/O code more complex than would be the case under unix.
>>
>> However if we could figure out a way to allow select() to poll on the 
>> TAP device handle as well as network sockets, then we could 
>> do away with 
>> Windows overlapped I/O -- that would move us into the SOCKET 
>> event space 
>> which is much more reasonable to deal with, and compatible with unix 
>> event I/O semantics (such as select()).
>>
>> James
>>     
>  
> It's an interesting idea and worth some thought.  The object spaces were
> separate for historical reasons (winsock came out when 16-bit was still
> quite alive) and hence the duplicated WSAOVERLAPPED, WSAEVENT, etc.  I
> believe the object spaces have been unified, and I know you can take a
> socket and pass it to, say WaitForSingleObject and have it work.
They sort of did that with WSAEventSelect -- if there was a way that 
WSAEventSelect could be used on the TAP device handle (as well as the 
network socket), then that would be another route towards moving away 
from overlapped I/O.
> Perhaps
> the converse is true (take a file handle and pass it to select(), or at
> least WSASelect()).  This assuming that winsock doesn't strap-on some
> private magic to it's socket handles that would be a problem for non-magical
> 'other' handles.  Also, the driver would have to be coded to signal the
> handle appropriately.  I think this is doable in NT, however I'm pretty sure
> it would be a challenge for CE because you don't have access to your handle
> (so what would one signal).
>
> Agreed it would be tidier to have all the platforms use the simpler select()
> mechanism.
>
> Ultimately, yesterday I gave up the ghost on trying to rework the tap
> usermode stuff to work in a polling manner, and wound up implementing the
> equivalent of overlapped IO using a custom DeviceIoControl() for the
> overlapped Read() and for the CancelIo().  This let me reuse all the
> existing event architecture as-is, and I just had to make some specialized
> versions of tun_finalize, queue_read, open, close, etc.
How did you deal with getting socket.c off of overlapped I/O (or did you 
figure out a way that PocketPC can do overlapped I/O?).
> I didn't bother
> doing the same with writes since they always completed immediately anyway
> once handing off to NDIS.
I would worry about assuming this unless the API guarantees it.  I've 
seen a few cases in the overall development of OpenVPN where assuming 
that writes always complete immediately (even when totally supported by 
observed behavior) introduced subtle bugs.

> Anyway, this re-unified the event model between
> the socket stuff and the tap stuff.
>
> Your point is timely, however, because my new challenge is similar (though
> different):  the handle returned from GetStdHandle() is _not_ suitable for
> synchronization on CE.  The WSAWaitForEvent call barfs with 'invalid
> parameter' if it is in the event set.  Eventually I figured out it was the
> console handle so at the moment I have that commented-out until I can think
> of a suitable solution.  I'll probably have to dig in the PortLib code, but
> the console driver itself is not open-source, so it might be a chore
> resolving that issue.
>   
It's probably not essential to support control-c/keyboard signaling -- 
this feature is used mostly by developers who run OpenVPN in console 
mode.  Real-world usage of OpenVPN usually involves running OpenVPN as a 
service and using the management interface (manage.c) to control the 
OpenVPN process from a GUI via a TCP socket.
> With that commented-out, I can't ctrl-c to stop the application, but I can
> start to initiate a session with the server.  Now things run happily until I
> get to the point where DHCP is happening and then it fails to get an IP
> address from the server.  Hopefully something configuration related, but,
> well, probably not -- probably a bug I introduced and will have to
> find-and-fix (sigh).
>   
The driver has quite a bit of instrumentation code to help debug/test 
the DHCP handshake.
> Question for you:  I discovered today that 'nobind' can't be used on CE.
> The socket has to go through bind() before it can be used in, say WSARecv.
> Is there an especial reason why someone would be upset about not having that
> option supported?  I haven't tried, but I might be able to emulate it by
> binding to ADDR_ANY:0.  Maybe.
>   
Nobind is quite an important option, so I'm surprised that CE wouldn't 
support it.  If it's really not supported on UDP sockets, it might be 
possible to simulate nobind by binding to a dynamic port number (from 
49152 through 65535) and if the bind fails, retry the next higher value.
> Iftikhar:  I updated the source and also I fixed the problem I mentioned
> previously about the driver not handling the power-off state correctly; you
> can power on and off to heart's content.
>   
Is this fix relevant to the 2000/XP version of the driver as well?  If 
so, would you mind posting a patch that only addresses this fix?

Okay, a couple questions for you:

The 2000/XP version of the driver uses the OemWin2k.inf file and 
tapinstall.exe (basically a clone of devcon.exe from the DDK) to install 
and configure the TAP device nodes.  What is the PocketPC way of doing this?

2000/XP provides the netsh utility for programmatically configuring 
network devices.  Does PocketPC have any equivalent utility/API?

Thanks,
James


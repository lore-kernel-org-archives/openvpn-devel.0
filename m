Message-ID: <44270158.8050206@...41...>
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN for PocketPC
References: <000001c64ebf$5b8fd230$1601a8c0@...576...>
In-Reply-To: <000001c64ebf$5b8fd230$1601a8c0@...576...>
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
Date: Sun Mar 26 13:03:05 2006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Dave <dev@...575...>
Cc: 'Iftikhar Qureshi' <iftikharqureshi@...109...>, openvpn-devel@lists.sourceforge.net

>
> *  I discovered yesterday that in the particular case of winsock, that
> overlapped io support is required, and (supposedly) has been implemented in
> CE and is available via the WSA versions of those methods (e.g.
> WSAGetOverlappedResult).  This is really good news because it possibly means
> that all the socket.c work will not have to be reworked at all.  Hopefully!
>
> So I think that only the five various tun_* and *_tun methods need to be
> implemented to declare this 'feature complete' and then the exciting phase
> of testing/fixing begins.
>
>   
The Windows version of OpenVPN currently wants overlapped I/O to be 
supported by the OS.  The reason why overlapped I/O was originally used 
(rather than unix-style select or poll) is so that the event loop could 
treat TAP device events the same as network socket events, and handle 
network and TAP events within a single event loop.

The root of the problem is that Windows supports two incompatible (as 
far as I know)  I/O wait event spaces:  there is the SOCKET type which 
can be used as an argument to select() and then there's the HANDLE 
(returned by CreateEvent) which is used as an argument to 
WaitForSingleObject/WaitForMultipleObjects.  Currently the Windows 
version of OpenVPN uses the HANDLE space which unfortunately makes the 
I/O code more complex than would be the case under unix.

However if we could figure out a way to allow select() to poll on the 
TAP device handle as well as network sockets, then we could do away with 
Windows overlapped I/O -- that would move us into the SOCKET event space 
which is much more reasonable to deal with, and compatible with unix 
event I/O semantics (such as select()).

James



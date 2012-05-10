Message-ID: <4FAB0556.50903@...1227...>
Date: Thu, 10 May 2012 02:01:26 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <4FAAE0A1.2080808@...1227...>
	<CAOazyz2wZ3n-70Pk8W_Z3OE_4_4th1PXWUOZUjOjNXetPkxc7g@...278...>
	<4FAAF152.7070508@...1227...>
	<CAOazyz35bB=q1hpdzjj_aHZ7K_0koT8pcw0csham2AOwMqGrfg@...278...>
	<4FAAF945.8070005@...1227...>
	<CAOazyz12Rw0kOSS+siU7tLP4eXO5XkhexjVLn+uC97s4K1Z8EQ@...278...>
	<4FAAFCB4.8040606@...1227...>
	<CAOazyz2wP2ms7HC31LPp3VzFRBu+S3zURZm1ozz0MzjmhQv07g@...278...>
In-Reply-To: <CAOazyz2wP2ms7HC31LPp3VzFRBu+S3zURZm1ozz0MzjmhQv07g@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Openvpn for Android 4.0 Changeset
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 10.05.12 01:39, schrieb Alon Bar-Lev:
> On Thu, May 10, 2012 at 2:24 AM, Arne Schwabe <arne@...1227...> wrote:
>>> I need a better description of the tun process... so far I did not
>>> understand why you cannot use standard approach of creating persistent
>>> tun with non root access and then use the iproute2 wrapper with suid
>>> or sudo to setup its configuration.
>>>
>>> Alon.
>> I have no root access on the telephone. But Android 4.0 provides an API
>> for VPNs
>> (http://developer.android.com/reference/android/net/VpnService.html).
>> Looking at my method at the method that opens the tun device to passed
>> over managment socket might also give an idea how it is done in Android:
>> http://code.google.com/p/ics-openvpn/source/browse/src/de/blinkt/openvpn/OpenVpnService.java#220
>>
>> Arne
> I understand.
>
> But... let's discuss another approach...
>
> Implement android-ip program that uses the Android API, and put
> "iproute2 android-ip" in configuration.
>
> Now, the interface of the program is similar to what iproute is
> receiving, but instead of netlink it does android API.
>
> So actually you can receive requests from openvpn via this interface
> without modifying openvpn...
>
> Maybe I am missing something, please bear with me.
>
The android API in this case is Java.  There is no C API that can be
used. Opening the tun device requires passing the fd of the tun device
to openvpn. Also the for sockets that should not be routed over the tun
device the Java API provides a protect(int fd) API. That means the
socket from openvpn needs to passed to the Java GUI to call the protect
method.

I see 2 way to accomplish this:

- Using the the java native interface to directly call into java from c
and vice versa. This worked but since openvpn was not really usable as a
library I got other problem (the google code repository has earlier
version of the code which uses this.)
- Keep openvpn as seperate process and pass the fd over a unix socket.
(One of the more obscure Unix apis)

The requirement that all information as ip addresses, dns and routes
must be available means that the persist-tun device cannot be used if I
also want to be to use pull.

Calling an external programs could eliminate the "ROUTE" , "DNS",
"DOMAIN" , "IFCONFIG" management commands I have introduced. But the
patched implements also two fd passing managment commands "PROTECT-FD"
(passes fd from openvpn to GUI) and "OPENTUN" (passes fd from GUI to
openvpn).

Arne



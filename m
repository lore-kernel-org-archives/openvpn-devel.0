MIME-Version: 1.0
In-Reply-To: <1CED409804E2164C8104F9E623B08B9012D1CF8AB9@...1436...>
References: <4FAAE0A1.2080808@...1227...>
	<CAOazyz2wZ3n-70Pk8W_Z3OE_4_4th1PXWUOZUjOjNXetPkxc7g@...278...>
	<4FAAF152.7070508@...1227...>
	<CAOazyz35bB=q1hpdzjj_aHZ7K_0koT8pcw0csham2AOwMqGrfg@...278...>
	<4FAAF945.8070005@...1227...>
	<CAOazyz12Rw0kOSS+siU7tLP4eXO5XkhexjVLn+uC97s4K1Z8EQ@...278...>
	<4FAAFCB4.8040606@...1227...>
	<CAOazyz2wP2ms7HC31LPp3VzFRBu+S3zURZm1ozz0MzjmhQv07g@...278...>
	<4FAB0556.50903@...1227...>
	<CAOazyz2pdJysuaEhoDL8O=S=CdEfW8XCuB6n8YrnKjOBqstTPA@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8A98@...1436...>
	<CAOazyz0Qb8xa-FUqQcMDX=w+=Vb3J8sQ2R8GAxNtfWxT-4DNkw@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8AB9@...1436...>
Date: Thu, 10 May 2012 10:17:22 +0300
Message-ID: <CAOazyz3xObLvBubo4E6vSmepj-8AkGd6P4k-6VXYpvsSm-vs3A@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Openvpn for Android 4.0 Changeset
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Adriaan de Jong <dejong@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Thank you,

Yes, I understand.

If I narrow this to "feature requests", basically we say that:
1. we want direct tun management to the management interface.
2. we want to have some logic when openvpn socket is opened.
3. Pass pre opened tun.

(1)  - direct tun management to the management interface

Until now I thought it should go to the plugin interface as in any
privilege separation model, the user will not be able to do any change
in networking.

But... I think it will be fairly simple to do so, with the new tun
interface[1] I am working of.

It introduces a tun engine, with a standard interface, it will be easy
to support several tun engines at same time selecting one by
configuration.

So we can have tun-engine-management.c to delegate all to the
management interface. It can be used if management interface is tcp as
well...

For example the linux tune engine[2] is very simple.

A management engine can be stacked overriding the tun_ifconfig, tun_init*.

BUT: I still think that currently it will be much simpler to do this
using iproute2 wrapper that uses the android API.

For (2) - custom socket creation

I still think that the plugin API is the right approach, you simply
implement openvpn-plugin-android, that opens the socket for the
openvpn process. It is not more complex than passing this via the
management interface, and can be used if management interface is not
unix domain socket...

(3) pre opened tun

This should be simple, as fd can be created and inherited by the
openvpn process.

What do you think?

Alon


[1] https://github.com/alonbl/openvpn/tree/tun
[2] https://github.com/alonbl/openvpn/blob/0205f085e8b77c6a6d49c38f20f9e49f=
41154f61/src/openvpn/tun-engine-linux.c

On Thu, May 10, 2012 at 10:00 AM, Adriaan de Jong <dejong@...1435...> wrote:
> That would be another option. In the model we were using (which might be =
different), the order is as follows:
>
> 1. openvpn is started
> 2. openvpn opens a socket to the remote host
> 2. openvpn establishes the control channel across this socket
> 3. openvpn passes socket and control channel data (IP, routing, DNS, etc)=
 through the management interface to the android app
> 4. android app passes these to the VPNService and receives an opened tun
> 5. android app passes the tun to openvpn
> 6. openvpn proceeds as usual
>
> To answer your follow up:
> There's no need for the extra complexity of a plugin here. The management=
 interface is a great tool, completely separating OpenVPN from its manageme=
nt interface.
>
> Adriaan
>
>> -----Original Message-----
>> From: Alon Bar-Lev [mailto:alon.barlev@...277...]
>> Sent: donderdag 10 mei 2012 8:49
>> To: Adriaan de Jong
>> Cc: Arne Schwabe; openvpn-devel@lists.sourceforge.net
>> Subject: Re: [Openvpn-devel] [PATCH] Openvpn for Android 4.0 Changeset
>>
>> On Thu, May 10, 2012 at 9:35 AM, Adriaan de Jong <dejong@...1435...>
>> wrote:
>> >> -----Original Message-----
>> >> From: Alon Bar-Lev [mailto:alon.barlev@...277...]
>> >> Sent: donderdag 10 mei 2012 2:10
>> >> To: Arne Schwabe
>> >> Cc: openvpn-devel@lists.sourceforge.net
>> >> Subject: Re: [Openvpn-devel] [PATCH] Openvpn for Android 4.0
>> >> Changeset
>> >>
>> >> On Thu, May 10, 2012 at 3:01 AM, Arne Schwabe <arne@...1227...>
>> wrote:
>> >> > Am 10.05.12 01:39, schrieb Alon Bar-Lev:
>> >> >> On Thu, May 10, 2012 at 2:24 AM, Arne Schwabe <arne@...1227...>
>> >> wrote:
>> >> >>>> I need a better description of the tun process... so far I did
>> >> >>>> not understand why you cannot use standard approach of creating
>> >> >>>> persistent tun with non root access and then use the iproute2
>> >> >>>> wrapper with suid or sudo to setup its configuration.
>> >> >>>>
>> >> >>>> Alon.
>> >> >>> I have no root access on the telephone. But Android 4.0 provides
>> >> >>> an API for VPNs
>> >> >>>
>> >>
>> (http://developer.android.com/reference/android/net/VpnService.html).
>> >> >>> Looking at my method at the method that opens the tun device to
>> >> >>> passed over managment socket might also give an idea how it is
>> >> >>> done
>> >> in Android:
>> >> >>> http://code.google.com/p/ics-
>> >> openvpn/source/browse/src/de/blinkt/ope
>> >> >>> nvpn/OpenVpnService.java#220
>> >> >>>
>> >> >>> Arne
>> >> >> I understand.
>> >> >>
>> >> >> But... let's discuss another approach...
>> >> >>
>> >> >> Implement android-ip program that uses the Android API, and put
>> >> >> "iproute2 android-ip" in configuration.
>> >> >>
>> >> >> Now, the interface of the program is similar to what iproute is
>> >> >> receiving, but instead of netlink it does android API.
>> >> >>
>> >> >> So actually you can receive requests from openvpn via this
>> >> >> interface without modifying openvpn...
>> >> >>
>> >> >> Maybe I am missing something, please bear with me.
>> >> >>
>> >> > The android API in this case is Java. =C2=A0There is no C API that =
can
>> >> > be used. Opening the tun device requires passing the fd of the tun
>> >> device
>> >> > to openvpn. Also the for sockets that should not be routed over
>> the
>> >> > tun device the Java API provides a protect(int fd) API. That means
>> >> the
>> >> > socket from openvpn needs to passed to the Java GUI to call the
>> >> > protect method.
>> >> >
>> >> > I see 2 way to accomplish this:
>> >> >
>> >> > - Using the the java native interface to directly call into java
>> >> > from c and vice versa. This worked but since openvpn was not
>> really
>> >> > usable as a library I got other problem (the google code
>> repository
>> >> > has earlier version of the code which uses this.)
>> >> > - Keep openvpn as seperate process and pass the fd over a unix
>> >> socket.
>> >> > (One of the more obscure Unix apis)
>> >> >
>> >> > The requirement that all information as ip addresses, dns and
>> >> > routes must be available means that the persist-tun device cannot
>> >> > be used if I also want to be to use pull.
>> >> >
>> >> > Calling an external programs could eliminate the "ROUTE" , "DNS",
>> >> > "DOMAIN" , "IFCONFIG" management commands I have introduced. But
>> >> > the patched implements also two fd passing managment commands
>> >> > "PROTECT-
>> >> FD"
>> >> > (passes fd from openvpn to GUI) and "OPENTUN" (passes fd from GUI
>> >> > to openvpn).
>> >> >
>> >> > Arne
>> >> >
>> >>
>> >> Great, so we can first shrink the patch!
>> >>
>> >> So two features you implied...
>> >>
>> >> 1. pass pre-opened tun device
>> >>
>> >> are you sure there are no alternatives to this? how does the java
>> api
>> >> receives the handle anyway?
>> >>
>> >
>> > I agree with Arne's approach of letting the tun driver be passed
>> through the management interface. This is the way things work in
>> Android VPNService land. I still need to go through the code though.
>> >
>> >> 2. the "protect" API.
>> >>
>> >> Can you please explain more about the functionality of the "protect"
>> >> API? why is this actually required? maybe there are alternatives.
>> >>
>> >
>> > About the protect API: The VPNService API routes all traffic through
>> the VPN by default. The socket used by OpenVPN needs to be "protected"
>> from this, using a special function call. Therefore, Android Java needs
>> this call.
>>
>> Thanks!
>>
>> So why can't we simply open the socket at the UI as well? similar to
>> the tun?
>>
>> Alon.


MIME-Version: 1.0
In-Reply-To: <CAP+U6tKEeXBkwQdFpRqbLiWYuQ-8H_+p84Re-ypj2+GAJuCVwQ@...278...>
References: <4FAAE0A1.2080808@...1227...> <4FAAF945.8070005@...1227...>
	<CAOazyz12Rw0kOSS+siU7tLP4eXO5XkhexjVLn+uC97s4K1Z8EQ@...278...>
	<4FAAFCB4.8040606@...1227...>
	<CAOazyz2wP2ms7HC31LPp3VzFRBu+S3zURZm1ozz0MzjmhQv07g@...278...>
	<4FAB0556.50903@...1227...>
	<CAOazyz2pdJysuaEhoDL8O=S=CdEfW8XCuB6n8YrnKjOBqstTPA@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8A98@...1436...>
	<CAOazyz0Qb8xa-FUqQcMDX=w+=Vb3J8sQ2R8GAxNtfWxT-4DNkw@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8AB9@...1436...>
	<CAOazyz3xObLvBubo4E6vSmepj-8AkGd6P4k-6VXYpvsSm-vs3A@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8AD6@...1436...>
	<4FAB8EEE.8020607@...1114...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8D08@...1436...>
	<CAOazyz1u-WhMYD5VykW2nzLyJzWr8-8wJ3pqwCMBwqggkpbLiA@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8D3E@...1436...>
	<CAOazyz30FaAPsha7hyD9cAwvRWkq_4i9Cme0mFJDpX0VdSb7=w@...278...>
	<4FABDBF7.406@...1114...>
	<CAP+U6tK5a-QFW1+=B-6AOTa3nqHheETs9mSuLMGmUQ5WS+c3vw@...278...>
	<CAOazyz0QghwU6hswGqhQ-8L4CY74xwPSNwdXBn_AzHTEtOREHQ@...278...>
	<CAP+U6tKEeXBkwQdFpRqbLiWYuQ-8H_+p84Re-ypj2+GAJuCVwQ@...278...>
Date: Fri, 11 May 2012 22:20:12 +0300
Message-ID: <CAOazyz3vHL1fatLpU2u-HMp2kS-xWSPHW9koAQMZRLwkxyO3UQ@...278...>
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
To: Fabian Knittel <fabian.knittel@...1547...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Fri, May 11, 2012 at 3:28 PM, Fabian Knittel
<fabian.knittel@...1547...> wrote:
> Hi Alon,
>
> 2012/5/11 Alon Bar-Lev <alon.barlev@...277...>:
>> On Fri, May 11, 2012 at 12:11 AM, Fabian Knittel
>> <fabian.knittel@...1547...> wrote:
>>> The main undecided points regarding the interface side of things appear=
 to be:
>>> * How to pass the fds back and forth: Special-case the management
>>> =C2=A0interface for unix domain sockets or use a dedicated unix domain
>>> =C2=A0socket for special operations. Could this potentially be the same
>>> =C2=A0interface that was discussed for some of the windows privilege
>>> =C2=A0separation approaches?
>>
>> Again, this is not the case of privileged separation as the process
>> *IS* privileged to do the networking setup.
>> People, don't get confused between running under root or not with privil=
eges!
>> Regular user can have privileges like creating tun and modify network
>> setting without being root, as in this case, this is not privilege
>> separation!
>
> To be honest, I'm not sure what you're talking about.

Sorry about that.

> My point was,
> that the ideas and approaches gathered in the wiki[0] might influence
> the interface we're discussing right now. Specifically, Heiko's
> interactive service would probably need a similar interface. (In your
> COM+-approach this would be the interface between OpenVPNUI.Network
> and OpenVPNUI.Tunnel, but as you're suggesting to use COM+, the shape
> of an advanced management interface or unix-domain-socket-like
> interface is ... of no real value.)

In the windows case I also demonstrated that a simpler solution can be
implemented without modifying the way openvpn behaves in term of
management interface.

>
> 0: https://community.openvpn.net/openvpn/wiki/PrivilegeSeparation
>
>> And again, these UI specific issues should should be modularize and
>> not go into mainline as-is.
>
> My point was, that we should agree on a stable interface first. In the
> next step, we can decide whether a specific implementation of that
> interface is worthy of inclusion.

This is good, but we cannot discuss interfaces if people role out the
possibility of different solutions.

> Unless of course, you're thinking
> about COM+ as one of the UI interfaces. But in my opinion, if Windows
> has a communication channel that is close to the semantics and
> capabilities of a UNIX domain socket, we should probably use that as
> _the_ interface and not needlessly start maintaining a separate
> interface per UI/plattform.

*YES* the COM+ approach shows that the OpenVPN-GUI project can use
*EXISTING* openvpn (maybe with minor modifications), and provide the
full *SOLUTION* for windows platform including privilege separation.

This by providing the COM+ objects and optional plugins.

This way the windows specific solution can be maintained completely
independently.

The same applies to this solution as well.
If we can do this without introducing android specific code into the
core, but reach to a state that all can be implemented in a plugin,
then the android solution will be maintained by appropriate interested
parties.

BTW: both windows and android has something in common - the need for
performing the ip setting in plugin.

in windows case, the UI may implement a plugin to call the
OpenVPNUI.Network object.
in the android case, the UI may implement a plugin to call the
management interface.
So we need this anyway.

> [...]
>> The question is do we want to make a library out of VPN with some
>> interface such as openvpn_main() or not, the JNI question is totally
>> unrelated to the mainline project.
>
> I agree that your question is more to the point.
>
> My opinion regarding the question is, that I don't yet see a need for
> a library interface. Executable + unix domain sockets seem just fine.

Right, for now it is sufficient.

>>> * The precise names of the newly introduced management commands.
>>
>> If we provide plugin interface to management interface this can be a
>> contract between the UI and the plugin, so that mainline should not be
>> changed every time there is a special UI need.
>
> If we create a contract that can be upheld by both a plugin and the
> core, then we can agree on the contract first and agree or change the
> implementation of the contract later. If we take several UI needs into
> consideration, we might not need a zoo of management-UI-plugins.

I don't think we will be able to avoid a plugin per special UI need...
But I am sure we can avoid modifying the core code every time a new
special UI appears.

>> If we provide tun engine implementation that supports the management
>> interface, all platforms can benefit from this change.
>
> Sounds great. Why not make the management interface contract of that
> tun engine the main topic of this discussion? That's what I'm aiming
> at. That way, hopefully the short-term patch can go in and the
> contract won't need to change as soon as 2.4 delivers the advanced
> modularisation.

I don't believe in short term patches... as we won't be able to remove
the implementation when the right functionality is implemented.
For now there is nothing wrong to provide out of tree patch for the
android users while we work on the proper solution.

My view of proper solution is:

1. Expose the management interface to plugins:
a. ability to send command to plugin and receive response.
b. ability of plugin to send request and get response.
c. ability of plugin to send logs.

2. Have plugin specific configuration.

3. Implement stackable tun engine to delegate tun management to plugins.

4. Implement android specific plugin to:
a. request protect of socket
a.1. send request via management interface
a.2. send the fd via separate inherited unix domain socket (if required).
b. send ip information to management.
c. request tun fd
c.1. send request via management interface
c.2. receive handle via separate inherited unix domain socket.

As far as I understand the above solves the entire issue, and makes
openvpn stronger, as the added functionality may be reused for other
implementations.

As far as the tun engine is concerned I can do that side.
I will be happy if someone else can take the management side, but I
can do this as well.
The rest should be trivial.

>
> Cheers
> Fabian

Alon.


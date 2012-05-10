From: Adriaan de Jong <dejong@...1435...>
Date: Thu, 10 May 2012 16:43:13 +0200
Message-ID: <1CED409804E2164C8104F9E623B08B9012D1CF8D3E@...1436...>
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
	<CAOazyz3xObLvBubo4E6vSmepj-8AkGd6P4k-6VXYpvsSm-vs3A@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8AD6@...1436...>
	<4FAB8EEE.8020607@...1114...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8D08@...1436...>
	<CAOazyz1u-WhMYD5VykW2nzLyJzWr8-8wJ3pqwCMBwqggkpbLiA@...278...>
In-Reply-To: <CAOazyz1u-WhMYD5VykW2nzLyJzWr8-8wJ3pqwCMBwqggkpbLiA@...278...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Openvpn for Android 4.0 Changeset
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

> -----Original Message-----
> From: Alon Bar-Lev [mailto:alon.barlev@...277...]
> Sent: donderdag 10 mei 2012 16:33
> To: Mendelt Siebenga
> Cc: openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] [PATCH] Openvpn for Android 4.0 Changeset
>=20
> Hello Mendelt,
>=20
> Thank you for taking the time to explain the process, now at least I
> can comment better.
>=20
> On Thu, May 10, 2012 at 5:03 PM, Mendelt Siebenga
> <mendelt.siebenga@...1435...> wrote:
> <snip>
>=20
> > Android has a lot of limitations on how you can get access to a TUN
> device without rooting your phone. Basically what you need to do is:
> > - Pass a file descriptor of the socket used by OpenVPN to a system
> call to protect it. This prevents traffic to this socket being routed
> over the vpn itself.
> > - Pass all routing information, dns servers etc. To a system call.
> This call sets up routing and returns a file descriptor to the TUN
> device.
>=20
> This is new!
> So you need the complete IP and routing settings *BEFORE* you open the
> tun, this was not clear from the discussion.
>=20
> <snip>
>=20
> > I'm not really sure about putting these changes off into a separate
> plugin. I personally like to modularize code as much as possible, but
> my guess is that in this case adding the hooks to the plugin interface
> that are necessary to allow this functionality to be implemented as a
> plugin will add more clutter to OpenVPN than just adding them to the
> core. I'm not sure what the plans are for the plugin interface but I
> can imagine that if it becomes more powerful over time we might be able
> to spin off these changes as a separate plugin later.
>=20
> This is exactly what I am afraid of, merge now monolithic code in a
> hope that in future someone will clean up the mess. To be able to
> provide a solution now to users an external patch may be used, nothing
> wrong with this.
>=20
> I prefer to work a little harder and implement the modular
> infrastructure required to support this scenario and other that may
> exist, this without breaking assumptions, such as management interface
> can be TCP connection.
>=20
> So what I recommend extending the tun engine interface I recently
> implemented[1] for 2.4, and add an engine to delegate calls to the
> openvpn plugin framework, the tun engine interface already supports
> opening the tun, configuring the tun etc... maybe minor changes are
> required, I will be happy to work on this.
>=20
> We also add an option for a plugin to use the management interface and
> expose something like: plugin <id> command.
>=20
> Then [[[JUST A SUGGESTION]] the UI (java) will open unix domain socket
> in addition to the management interface and put its number in
> environment ANDROID_CONTROL_FD=3DXXX.
>=20
> A special android plugin will be loaded which register to the tun
> engine notifications, it will be able to interact with the UI via the
> management interface, but for two special tasks it will use the custom
> unix domain control fd in addition, for example via the management
> interface it will forward the network details, then ask for tun fd, and
> will get the fd via the control channel.
>=20
> This way you will be able to maintain the android custom code as a
> whole, while the openvpn project will benefit from the ability to
> expose all plugins via the management interface for any task and be
> able to perform routing and networking setting via plugin (which was
> also discussed for privilege separation model).
>=20
> Alon.
>=20
> [1] https://github.com/alonbl/openvpn/compare/master...tun
>=20

Basically, what you're asking is that a reasonably simple patch is extended=
 into a revamp of the management system. While I agree that more modularisa=
tion is important for OpenVPN, stopping all progress and killing off a usef=
ul feature is not the way to achieve that. Shall we agree to discuss the te=
chnical merits of the patch, and not the grand vision of how OpenVPN should=
 look? Don't throw out the good for the perfect :).

Modularisation work is planned for 2.4, and adding a management-interface c=
ontrolled tun module would be a great idea there. I still disagree on using=
 the plugin interface for that. A modularised system is fine there.

Adriaan


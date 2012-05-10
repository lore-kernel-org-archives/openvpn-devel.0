MIME-Version: 1.0
In-Reply-To: <4FAB8EEE.8020607@...1114...>
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
Date: Thu, 10 May 2012 15:46:06 +0300
Message-ID: <CAOazyz25ecuVkwYM7OM9wUWqQYSFt-XzeA7PKdv=0-o2C+aHoA@...278...>
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Thu, May 10, 2012 at 12:48 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 10/05/12 09:28, Adriaan de Jong wrote:
>> I still prefer using the management interface. It keeps the
>> interface to the Java stuff very clean (socket-based). Further you
>> potentially allow other systems, such as Apple or Windows Phone to
>> do the same. It avoids messy JNI stuff, and fits into the spirit of
>> the management interface. It's the simplest solution.
>
> I agree. =C2=A0The plug-in approach seems a bit overkill to me. =C2=A0The
> approach using the management API makes it far simpler.

It can be either management interface or socket between UI and plugin.

The issue is monolithic vs modular.

OpenVPN is already exploded in feature that are needed by specific
installations.

For every new feature was need to add we should ask our-selves if it
can be added using modular approach and what is missing in the public
interfaces in order to do the task.

Of course adding features as #ifdefs is simpler at first, but later on
they tend to be complex to maintain and untested, moving to modular
components can delegate the maintenance and making the core product
quality higher.

If we need to allow directing custom commands to specific plugin via
the management - this I can understand.
But patching the core for these tasks is something I think we should avoid.

Alon.


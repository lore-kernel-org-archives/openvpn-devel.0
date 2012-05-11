MIME-Version: 1.0
Sender: fabian@...1547...
In-Reply-To: <CAOazyz0QghwU6hswGqhQ-8L4CY74xwPSNwdXBn_AzHTEtOREHQ@...278...>
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
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Fri, 11 May 2012 14:28:25 +0200
Message-ID: <CAP+U6tKEeXBkwQdFpRqbLiWYuQ-8H_+p84Re-ypj2+GAJuCVwQ@...278...>
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Alon,

2012/5/11 Alon Bar-Lev <alon.barlev@...277...>:
> On Fri, May 11, 2012 at 12:11 AM, Fabian Knittel
> <fabian.knittel@...1547...> wrote:
>> The main undecided points regarding the interface side of things appear =
to be:
>> * How to pass the fds back and forth: Special-case the management
>> =C2=A0interface for unix domain sockets or use a dedicated unix domain
>> =C2=A0socket for special operations. Could this potentially be the same
>> =C2=A0interface that was discussed for some of the windows privilege
>> =C2=A0separation approaches?
>
> Again, this is not the case of privileged separation as the process
> *IS* privileged to do the networking setup.
> People, don't get confused between running under root or not with privile=
ges!
> Regular user can have privileges like creating tun and modify network
> setting without being root, as in this case, this is not privilege
> separation!

To be honest, I'm not sure what you're talking about. My point was,
that the ideas and approaches gathered in the wiki[0] might influence
the interface we're discussing right now. Specifically, Heiko's
interactive service would probably need a similar interface. (In your
COM+-approach this would be the interface between OpenVPNUI.Network
and OpenVPNUI.Tunnel, but as you're suggesting to use COM+, the shape
of an advanced management interface or unix-domain-socket-like
interface is ... of no real value.)

0: https://community.openvpn.net/openvpn/wiki/PrivilegeSeparation

> And again, these UI specific issues should should be modularize and
> not go into mainline as-is.

My point was, that we should agree on a stable interface first. In the
next step, we can decide whether a specific implementation of that
interface is worthy of inclusion. Unless of course, you're thinking
about COM+ as one of the UI interfaces. But in my opinion, if Windows
has a communication channel that is close to the semantics and
capabilities of a UNIX domain socket, we should probably use that as
_the_ interface and not needlessly start maintaining a separate
interface per UI/plattform.

[...]
> The question is do we want to make a library out of VPN with some
> interface such as openvpn_main() or not, the JNI question is totally
> unrelated to the mainline project.

I agree that your question is more to the point.

My opinion regarding the question is, that I don't yet see a need for
a library interface. Executable + unix domain sockets seem just fine.

>> * The precise names of the newly introduced management commands.
>
> If we provide plugin interface to management interface this can be a
> contract between the UI and the plugin, so that mainline should not be
> changed every time there is a special UI need.

If we create a contract that can be upheld by both a plugin and the
core, then we can agree on the contract first and agree or change the
implementation of the contract later. If we take several UI needs into
consideration, we might not need a zoo of management-UI-plugins.

> If we provide tun engine implementation that supports the management
> interface, all platforms can benefit from this change.

Sounds great. Why not make the management interface contract of that
tun engine the main topic of this discussion? That's what I'm aiming
at. That way, hopefully the short-term patch can go in and the
contract won't need to change as soon as 2.4 delivers the advanced
modularisation.

Cheers
Fabian


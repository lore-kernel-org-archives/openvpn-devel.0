MIME-Version: 1.0
In-Reply-To: <4F4D1C29.5060606@...1114...>
References: <4F4CE4FE.3010009@...515...>
	<1848924920.20120228183103@...449...>
	<CAOazyz0x4hKsREcGi+9TGc+AO0d+i1d5qbmPJ2hQfCsUbVanNQ@...278...>
	<4F4D1C29.5060606@...1114...>
Date: Tue, 28 Feb 2012 20:38:57 +0200
Message-ID: <CAOazyz1Wcj8ap9niXMs5pPW=3TvfG75NW7L_eHV_9aGQNcWP6g@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
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
Cc: =?UTF-8?Q?Carsten_Kr=C3=BCger?= <C.Krueger@...448...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Tue, Feb 28, 2012 at 8:25 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
>> This is *THE* missing functionality in Windows environment. It seems
>> that nobody interested in developing proper UI using management
>> interface for Windows. Same goes to proper smartcard support.
>
> I believe Jan Just Keijser and Heiko talked about this as well at FOSDEM,
> how to provide a better integrated PKCS#11 support in the Windows GUI.
> So I would expect this to progress too. =C2=A0And of course, the new GUI =
Heiko
> writes is using the management interface too, anything else would be
> plain stupid these days.

Right. I don't know what he is writing.
Anyway, the message I sent today regarding the external key is the root.
Adding functionality to set the certificate via the management have the
potential to resolve the whole issue.

> Even though, the new communication pipe between the "helper service" and
> openvpn.exe =C2=A0might gain more features with time, which might cover m=
uch
> of what the management interface provides today too. =C2=A0But we're _not_
> trying to kill the management interface.

There is no need for the helper service.
Nobody care if the openvpn daemon is running in privilege mode.
The problem is the user interaction.
So I would have avoided to invest resources at the daemon side and invest
resources at proper UI.

>> In Linux I am using OpenVPN using unprivileged user (completely!) the
>> daemon runs under my own user, see[1].
>
> This new communication pipe should also become available for the *nix
> platform too. =C2=A0Which again should make it easier to implement someth=
ing
> which does not depend on a safe sudo setup too. =C2=A0Maybe even some
> integration against NetworkManager via DBus for the Linux platform?

dbus is way too fragile, it is good for desktop... not for core components.
And... requiring network manager (large piece of software) only for iproute2
replacement is redundant.
The management interface is great.
Again, the main problem is not the daemon but the user.
I went one step farther and wrapped the iproute2... this is optional.

> I'm at least playing with the idea that OpenVPN itself shouldn't
> necessarily need to know much about how to configure the TUN/TAP device
> and routes for all different platforms. =C2=A0Rather write platform speci=
fic
> "service helpers" which does that job via the the communication pipe.
>
> This would make the OpenVPN code base simpler and perhaps even easier to
> support more platforms, like Android - and maybe even iPhone and the new
> Windows Mobile?

Well, this can be done now, just wrap the iproute with suid program to
do whatever
you like, this is the wrapper. The tap device can be accessed using
non-privileged
user, so all that is left is the iproute2 delegation.

This does not require special code or effort.

Bottom line: the management interface is great. One missing functionality is
setting certificate.
Effort should be invested in proper UI to leverage the management interface.
Running openvpn *DAEMON* as completely unprivileged is 2nd priority.
On Linux it can be done by simply wrapping the iproute2 executable, using
sudo/dbus whatever to achieve same functionality.
On Windows a similar solution may be provided.

Alon.


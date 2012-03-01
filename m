Date: Thu, 1 Mar 2012 11:38:41 +0100
From: =?iso-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Message-ID: <1762597580.20120301113841@...449...>
In-Reply-To: <20120229213617.GD7024@...1296...>
References: <4F4CE4FE.3010009@...515...>
	<CAOazyz3hiUis_34SfbNU1kcFxS=MiA7WMv0Y6Ldr5K3CDC-Mvg@...278...>
	<329464061.20120229135141@...449...> <1858812.l6uojFg3Yp@...1526...>
	<1088564984.20120229202531@...449...>
	<20120229213617.GD7024@...1296...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
Reply-To: =?iso-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, openvpn-devel@lists.sourceforge.net

Hello Gert,

>> Dismiss the hole service starts openvpn in user context. It makes no
>> sense.

> From a pure security perspective, you're right - maximum security would
> be reached by running openvpn.exe in a completely unprivileged context
> (unix way: chroot(/var/empty), setuid(nobody)) to make sure that any
> possible bug that is network-exploitable cannot be used to gain access
> to the system.

You misunderstood me, the feature openvpn service creates openvpn
process in user context didn't "work". It creates no additional
security but instead lower it (the service has the privilege to spawn
process in all user contexts).
It has nothing to do with privilege seperation.

My idea is the following:
run openvpnhelperservice with "network operator privileges", run
openvpn.exe als "local service", advance management interface to a
point that is more usefull. Let a client run in users context that
communicates via management interface.
The execution of scripts can be done from client if it's something
like pull git or connect to share.

> Given that people have implemented all the script and plugin hooks because
> someone actually *uses* them, taking this away would not be something
> people like - so you want something that has flexibility, but does not
> have "full system access" (unix: runs as root).

Are there any plugins for windows? What do they do? Do the need to run
in openvpn-context?

greetings
Carsten



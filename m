Date: Sun, 16 Nov 2008 17:24:47 +0100
From: =?iso-8859-15?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Message-ID: <287709810.20081116172447@...449...>
In-Reply-To: <9e0cf0bf0811160800s27626f3cmfb358fee54a34ab8@...278...>
References: <48F11865.5080903@...1135...>
	<9e0cf0bf0810111522nc8062afl7e727f9d871875ec@...278...>
	<48F1AE4F.3040305@...1135...>
	<9e0cf0bf0810120211u2c8ec01ejde17ee36e5483872@...278...>
	<49204019.9080002@...1135...>
	<9e0cf0bf0811160800s27626f3cmfb358fee54a34ab8@...278...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Alternative GUI for OpenVPN
Reply-To: =?iso-8859-15?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
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
To: openvpn-devel@lists.sourceforge.net

Hello Alon,

> Also, you can let the user to write his own configuration while you
> just manage the connect/disconnect/authentication phases.
> I think this would be best for advance users.

Did the management interface allow this? That would be a security
problem.
Administrator setup two OpenVPN interfaces one with restrictive
firewall, one without.
The user could take the configuration files and exchanges the
used interfaces (change dev-node) -> bad.

I think the management interface should only allow to start/stop
preconfigured configfiles and only clients ones.
For example my computer has an openvpn server instance (should run all the
time) and one client instance.
The client one should be manageable (start, stop, ask user for auth)

Opinions?

greetings
Carsten

PS: It's great that a gui is developed!



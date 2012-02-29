MIME-Version: 1.0
Date: Wed, 29 Feb 2012 20:52:15 +0200
Message-ID: <CAOazyz0mi0WgHe8GqhSaLRKh7ABord6Q96Tb=7jMk3fxwXmm2w@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: [Openvpn-devel] [DISCUSSION] OpenVPN privilege separation (Windows)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Hello,

Following recent discussion on Windows platform, I open a new thread.
I don't think this topic is Windows specific as the security
principals are the same.

VPN client product has [at least] two different type of configuration.

1. Standalone configuration.

2. Enterprise configuration.

The main difference of these types is who control the workstation. In
standalone configuration the workstation is controlled by the
end-user, and in enterprise configuration the enterprise administrator
controlling the workstation.

These two configurations have different purpose as well, the
standalone configuration usually protects the workstation against the
remote network, and the enterprise configuration usually protects the
remote network against the workstation.

The "enemy" of the two configurations is also different, in standalone
configuration the "enemy" is the remote network administrator, while
in the enterprise configuration the "enemy" is the local workstation
user.

The "scripts" in the standalone configuration or for the sake of the
user, but within the enterprise solution it usually need to scan the
computer, disconnect device and other privileged operations.

There is no single solution for both configurations.

Please read till the end before responding.

Provided we have the following components:
1. tap device aka tap - a virtual Ethernet interface.
2. openvpn - a tunneling implementation.
3. openvpn configuration - configuration files.
3. network utilities aka utils - a set of utilities to manipulate
workstation network settings.
4. user interaction aka UI - a program that manages user interaction.

What is the security attribute for each component in each configuration?

Standalone configuration
1. tap - accessed by interactive user.
2. openvpn - runs by the interactive user.
3. openvpn configuration - read/write by interactive user.
4. network utilities - privileged user required.
5. UI - runs by interactive user.

Enterprise configuration
1. tap - access by openvpn user.
2. openvpn - runs by openvpn user.
3. openvpn configuration - read by openvpn, read/write by administrator.
4. network utilities - privileged user required.
5. UI - runs by interactive user.

Major missing openvpn functionality:
Specify certificate via the management UI - this feature is required
so that a configuration in which openvpn knows nothing of
authentication can be established.

A while back I added to openvpn the ability to create tun/tap device
with custom permissions
and the ability to wrap ip utility with custom utility.
As for now I am using the standalone Linux configuration[1], in few words:
1. tap is configured so interactive user may access it.
2. openvpn is run by the interactive user.
3. openvpn configuration and keys are located at ~/openvpn
4. network utilities - (ip utility and DNS update) are wrapped within
sudo scripts.
5. UI is run by the interactive user.

The network utilities' wrapper can do validation before actually
executing the commands.

There is no reason why we cannot achieve the same in Windows:
1. tap - configure ACL of TAP to specific permissions (Users for example).
2. openvpn - runs by the interactive user, it will have permission to
open the tap.
3. openvpn configuration - read/write by interactive user.
4. network utilities are accessed by wrapper (I will discuss this bellow).
5. UI is run by the interactive user.

So the network utilities are the only component that needs privilege
escalation in this configuration.

Let's take the enterprise configuration:
1. tap - configure ACL of TAP to openvpn user.
2. openvpn - runs by openvpn user.
3. openvpn configuration - read by openvpn, read/write by administrator.
4. network utilities are accessed by wrapper (I will discuss this bellow).
5. UI runs by the interactive user.

So in this case, network utilities needs privilege escalation, but
also the ability of the UI to start/stop the tunnel requires special
privilege.

I gave an example of how this is done in Linux... Now, what is the
simplest solution to do the same in Windows?

There was a suggestion to use named pipes, services and impersonation,
I would like to discuss another option.

Windows Component Services provide the ability to create a component
that may be run in separate security context. It already implements
the process management and security isolation.

Let's define two components:
1. OpenVPN.Tunnel component (replaces current service).
2. OpenVPN.Network component (aka network utilities wrapper).

Now, let's see what we can do with these components.

Standalone configuration
1. TAP ACL - Group Users can access.
2. OpenVPN.Tunnel - can be accessed by Users, Interactive User identity.
3. openvpn configuration - read/write by user.
4. OpenVPN.Network - can be accessed by Users, Network service identity.
5. UI - runs under the interactive user, can access the OpenVPN.Tunnel
to run openvpn, within configuration it sets the iproute utility to
own wrapper that calls the OpenVPN.Network.

Enterprise configuration
1. TAP ACL - User openvpn
2. OpenVPN.Tunnel - can be accessed by Users, openvpn user identity.
3. openvpn configuration - read by openvpn, read/write by administrator.
4. OpenVPN.Network - can be accessed by openvpn, Network service identity.
5. UI - runs under the interactive user, can access the OpenVPN.Tunnel
to run openvpn, within configuration there is a call to iproute
utility to own wrapper that calls the OpenVPN.Network.

The switch between the two configurations is simple:
1. TAP: Change permission Users<->openvpn
2. OpenVPN.Tunnel - change identity: Interactive User<->openvpn
3. OpenVPN.Network - change access: Users<->openvpn
4. openvpn configuration - specific user ACL<->openvpn read,
administrators read/write
5. UI - nothing.

As you can see the whole setup is a change in Windows configuration only!
Simple utility to select the mode can be provided.

The impact on the openvpn project is small... we only need to allow
windows network configuration replacement similar to ip utility
replacement.
The UI can implement the OpenVPN.Tunnel, OpenVPN.Network and the
network utility wrapper that calls the OpenVPN.Network.
Well, it can be done as part of the OpenVPN project as well, this is
out of scope of this discussion.

I think this implementation suggestion provides solution for the
threats and requirements without huge effort using windows best
practices.

Then we should discuss how to write a proper UI... until now the UI
was a standalone none standard VPN program while TAPI integration
(much like PPTP, L2TP) is required. This will enable users to connect
to VPN even before login. But this is a totally different discussion.

Alon.









[1] http://en.gentoo-wiki.com/wiki/OpenVPN_Non_Root


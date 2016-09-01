References: <834c4ed9-af60-1f0b-091d-da0fafa6bd96@...2080...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <e4f4eee2-56f8-ac81-2c5a-354dfd1b27be@...2080...>
Date: Thu, 1 Sep 2016 21:04:26 +0200
MIME-Version: 1.0
In-Reply-To: <834c4ed9-af60-1f0b-091d-da0fafa6bd96@...2080...>
Subject: Re: [Openvpn-devel] Modernising the management interface
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 31/08/16 20:55, David Sommerseth wrote:
>=20
> Hi,
>=20
> I have for a long time pondered on how we can make the management
> API more suitable for more modern tools and tasks.  So I am just
> giving an extremely early heads-up on on what I'm poking at ... and
> hopefully receive some feedbacks on what you think.

[...snip...]  (I'll try to respond to all feedback in this single mail)

Thank you to all of you who raised your voice, this is very helpful!

First of all, I understand the scepticism.  And I also do not want to
bloat OpenVPN needlessly.

JJK have also made a very good point, that there is a contradiction
between the need on the server and client.  In regards to splitting
client and server code, the OpenVPN 3 code base is actually far better
separated in this regards - so we are moving towards that direction.

I also understand the argument "If it ain't broken, don't fix it".
The problem is what and who defines what is broken or not.  I see a
great potential to make OpenVPN integrate better, both towards the OS
level but also towards the user interfaces.  From my point of view,
OpenVPN is still stuck in how things were done in 90s, and to enable
possibilities which is found in modern OS we need to adopt OpenVPN
likewise.  I still wouldn't call it broken, but seeing it more mature
for a real update.

Samuli's comment regarding easing the client management on the server
side, is quite spot-on.  But it won't be that much extra work at all
to add client side support in addition.  Hence, I am daring to also
consider client-side needs.

I understand that the client-side is quite happy with the situation as
it is now.  So I will therefore then focus these next steps on the
server side primarily.  If the client-side see some advantages later
on, it shouldn't be too hard adding those features later on.  And
having both the old TCP based management interface and a newer D-Bus
interface will therefore be the primary goal - with D-Bus enabling
will happen both at compile time (to allow building without extra
dependencies) and runtime (to not enforce D-Bus to be used).  And I
will not spend time adding new features to the TCP based management
interface for the time being.

So just to provide a few more examples why I'm so persistent on
providing D-Bus support ... I'll bring up both a few already mentioned
use cases, for completeness, as well as some new ones.

* Better and easier integration with modern management tools (like
  Cockpit)

* Enables a simpler way to manage OpenVPN also from shell scripts,
  by using standard D-Bus clients such as gdbus or qdbus.

* Allow multiple management tools to interact with OpenVPN at the same
  time, even allowing differentiated access controls per management
  client (more on that in a bit)

* Enable management of OpenVPN plug-ins without needing to extend
  OpenVPN core code additionally per plug-in and allow plug-ins
  full control of the API it will provide (not restricted to the
  OpenVPN capabilities the core OpenVPN code is designed for - each
  plug-in can provide its own D-Bus interface independently of others)

* Allow for PUSH notifications (in D-Bus jargon: signals) instead of
  management tools need to constantly pull for information

* Enable possibility to add (set) triggers (which uses D-Bus signals)

* Provide possibility to do user/password authentication via D-Bus
  as an alternative to plug-ins or script hooks.  Can also extend this
  to provide the TLS verification methods too.  This allows for more
  powerful authentication modules where using script hooks easily
  gets complex and writing a C plug-in is a too big challenge.

* New tools can more easily manipulate firewalls on the fly using
  more fine grained information for connected sessions at once.  Also
  considering that FirewallD is also D-Bus based can ease this
  integration too.

* Enable policy management of methods ("function calls") provided over
  D-Bus.  This can allow non-admin users to have limited power while
  admin users can be allowed to do more.  These policies can also
  be completely controlled by using user groups defined by the system.
  All user authentication is done by the OS via D-Bus (using polkit).
  This means, a non-root user can actually control much of an OpenVPN
  process if the policy allows it - including restarting OpenVPN.
  The OpenVPN process itself can run as a different user or even root.

* Enable possibility to have better understanding of the current network
  situation, as OpenVPN can through D-Bus query NetworkManager (or
  similar D-Bus interfaces for networks) for the general network
  situation.  This is probably more useful on the client side than
  server side, though.  (No need to try to reconnect every 5th second
  if the network state is "offline")

* Prepare the ground for seamless restart of the OpenVPN process without
  needing to do complete reconnect with all TLS key exchanges for all
  connected clients.  This can be done such that the new OpenVPN
  process connects to the D-Bus, signals the already running process to
  pass over all client states.  These client states can also include
  byte/packet counters as well, if that is used for accounting.

  By adding an extra "link program", it can, in theory at least, also
  be made possible to sync client states across hosts.

  This can probably be done today too, but would we enable such things
  over an unencrypted TCP link?  As it is unencrypted, I'd say that the
  management password you can set is quite moot and useless.  So to get
  the security right, the management today needs to be even further
  extended - as D-Bus provides the authentication and access control
  in the basic API.

These are just some of the possibilities I see D-Bus can more easily
enable.  As I said, OpenVPN ain't broke as it is, but it can be
improved to be better integrated with more advanced use cases which is
harder to achieve today.

As an example in the end, I'll consider up a question I've heard every
now and then on the #openvpn IRC channel.  "How can I add quotas to
VPN clients?"  Today, I would say, that can only be achieved by either
writing a plug-in and/or some tools using the management interface to
retrieve information and do the quota controls.

With D-Bus this can be done with a few simple scripts ... here as a
very simple pseudo code.  These scripts can be written in your
favourite language as long as it has D-Bus libraries available.


   * ConnectionSetup ... a script which prepares the triggers
   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   system_bus =3D dbus.connect(DBUS_SYSTEM)
   while (1) {
      # wait for a client to connect
      res =3D system_bus.wait_for_signal(dest=3D"net.openvpn.managment",
	       path=3D"/net/openvpn/management/Triggers",
	       signal=3D"sys_vpn_connect");

      # Fetch client info and log
      client =3D system_bus.call(dest=3D"net.openvpn.management",
	       path=3D"/net/openvpn/management/ClientInfo/" + res,
               method=3D"QueryClients");

      # Retrieve quota and do some logging
      quota =3D corp_function_get_quota(client.cn);
      printf("Client %s connected, used %i bytes of quota, " \
             "setting quota to %i bytes\n",
  	     client.cn, quota.used, quota.max);

      # Set the quota for this session, account for already used quota
      system_bus.call(dest=3D"net.openvpn.management",
	       path=3D"/net/openvpn/management/Triggers/" + res,
               method=3D"SetQuota"
	       quota=3D(quota.max - quota.used));
   }
   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


   * ConnectionDisconnected ... a script which logs used quota
   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   system_bus =3D dbus.connect(DBUS_SYSTEM)
   while (1) {
      # wait for a client to connect
      res =3D system_bus.wait_for_signal(dest=3D"net.openvpn.managment",
	       path=3D"/net/openvpn/management/Triggers",
	       signal=3D"sys_vpn_disconnect");

      # Fetch session info
      session =3D system_bus.call(dest=3D"net.openvpn.management",
	             path=3D"/net/openvpn/management/Sessions/" + res,
                     method=3D"QuerySession");

      # Log some statistics
      printf("Client %s disconnects, used %i bytes in this session\n",
		session.cn,
		(session.bytes_received + session.bytes_sent));

      # Update corp database with used quota
      corp_function_add_used_quota(session.cn,
              (session.bytes_received + session.bytes_sent));
   }
   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


   * QuotaControl .... a script which kicks out clients exceeding quota
   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   system_bus =3D dbus.connect(DBUS_SYSTEM)
   while (1) {
      # wait for a client who exceeds the quota
      res =3D system_bus.wait_for_signal(dest=3D"net.openvpn.managment",
	       path=3D"/net/openvpn/management/Triggers",
	       signal=3D"quota_exceed");

      # Fetch client info and log
      client =3D system_bus.call(dest=3D"net.openvpn.management",
	       path=3D"/net/openvpn/management/ClientInfo/" + res,
               method=3D"QueryClients");

      printf("Client %s exceeded quota, killing session\n",
		client.cn);

      # Kill the session
      system_bus.call(dest=3D"net.openvpn.management",
	       path=3D"/net/openvpn/management/Sessions/" + res,
               method=3D"KillClientSession");
   }
   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

   (I admit this over-simplifies the D-Bus calls, but this is in
    essence of how these calls would work)


So three individual scripts, which can be added/modified/restarted at
will outside of OpenVPN without influencing any established OpenVPN
connections.

Doing a similar thing using the TCP based management interface is
going to be considerably harder, as you need to manage everything
through a single TCP connection and it is needed to do regular polls
to the OpenVPN server as there are no push features.  Plus you need to
manage the TCP connection setup and all communication over the socket.

I'll let you all know when I have something more concrete to show; but
I am still very much open for more feedback!


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJXyHu6AAoJEIbPlEyWcf3yYYIP/1ljl24r1b+uBiBOEl1op17t
u2YFm4B0AsAhXvwLeoGEBt7Vx45Fnn6yHskLnsEuUXyZSLj7EXcKqtdY5Dpd6Qcx
k+LtPdIG19TA17GUvrWhQbclLlsm7kRe7L9iYOtYVqkUW24TrXkiu7nZ7THwteZp
Y1+afd6NRMWi2rMpn3KfOEdQepNwbpBaurC0D4ENmUtkIAPHdPjqCFReIh7++JKj
9ADp/rMMjorBNcUKlnPGg21C1FDCVCKCtHPmPb9uW/TFWMGUoO8tgFfzaaQudvQG
K28hZKDmolhDwlSWsjC/QaacNcwwjknfg1CDrL65mNklNMJCut5HlPtEBQFOEH7p
RFi6GHzWWInmAY1+mUvWKvO/DO4NJovdl6ygCbtvhNiEJacNLKYk7bpGkZQnyPxX
06DgzW/myyj+GipQCevvaGMr9cuBnneNCmeiMnDh7n2FHteoZYUf9xeIxjkM/KQI
DuVNJeLVrhdFT0NtOcLBHahSp6rWVGkUA4aYAzmzkMyEjPFYXrxV0dttpSr11Qjb
2tSKHm72fiJ5kLoMcm8ugOaIoFiTreaukUl5rY271PjxOLLfJ7A2jzVEUefQvxwN
FlEvjAJ+Nb5p57mN98IUR0QzVheLgUPENaW9oFpCizGJeQjiKk5j07YZNF1vIW2K
3EN1CDDg6Q9K1Xb5z+tu
=3DQczO
-----END PGP SIGNATURE-----


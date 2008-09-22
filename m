From: Jose Sanchez <jose.informatica@...1125...>
In-Reply-To: <48D78A6C.6010603@...1114...>
References: <1221820480.14052.2.camel@...1126...>
	<48D4AD5B.10205@...1127...>
	<1222064928.10967.17.camel@...1126...>
	<48D78A6C.6010603@...1114...>
Date: Mon, 22 Sep 2008 14:25:32 +0200
Message-Id: <1222086332.10967.26.camel@...1126...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] About making plugins for openvpn
Reply-To: jose.informatica@...1125...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: dazo@...384..., openvpn-devel@lists.sourceforge.net

Thank you very much, after printing all environment variable, here I
have the environment variable complete,  I send this for future
reference I hope this will help some other people (I have edited for
some values or even removed them for privacy reasons):

These variables are captured during OPENVPN_PLUGIN_CLIENT_CONNECT event,
I don't know if there are avaiable on other events or if some others are
missing.

Other question: Will be any problem with the use of threads and sockets
on the plugin? (I mean, can I use normal C programming techniques or are
in the plugins some functions that can't be used?).

Thanks all again for your help.

 /* Interesting environment variables
   * ---------------------------------
   *
   * ifconfig_pool_local_ip           - "local" client gateway
   * ifconfig_pool_remote_ip          - IP in the VPN
   * time_ascii                       - In format: Mon Sep 22 13:43:22
2008
   * common_name                      - Client's name
   *
   *
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   * OTHER ENVIRONMENT VARIABLES (maybe can be useful in the future)
   *
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   *
   * trusted_port
   * trusted_ip
   * untrusted_port
   * untrusted_ip
   *
   * tls_serial_0=3D3
   *
tls_id_0=3D/C=3DES/ST=3DState/O=3DCountry/CN=3Dhostname/emailAddress=3Dmy@...220...=
..1128...
   * tls_serial_1
   *
tls_id_1=3D/C=3DES/ST=3DState/L=3DOther/O=3DOther/CN=3Dhostname/emailAddres=
s=3Dmy@...1128...
   *
   * daemon_log_redirect=3D0
   * daemon=3D0
   *
   * verb=3D5
   *
   * local_port=3D1194
   * proto=3Dtcp-server
   *
   * config=3D/etc/openvpn/server.conf
   *
   * ifconfig_local=3D10.8.0.1
   * ifconfig_remote=3D10.8.0.2
   *
   * route_net_gateway=3D192.168.X.X
   * route_vpn_gateway=3D10.8.0.2
   * route_network_1=3D10.8.0.0
   * route_netmask_1=3D255.255.255.0
   * route_gateway_1=3D10.8.0.2
   *
   * script_context=3Dinit
   * tun_mtu=3D1500
   * link_mtu=3D1560
   * dev=3Dtun0
   *
   */



El lun, 22-09-2008 a las 14:07 +0200, David Sommerseth escribi=C3=B3:
> Jose Sanchez wrote:
> > Thank you, I have figured out those things (but not all of them, so
> > thanks for the detailed explanation).
> >=20
> > The problem that I have is that I have not found good examples about the
> > structure of the environment variable (I have seen the: get_env function
> > in simple.c so I will try to print that variable to the log or to the
> > stdout to study its structure and data stored on it).
>=20
> I need to take things by memory now ... but if you want the "public" IP=20
> address and the VPN ip address ... I would say you'll find them in these=
=20
> environment variables:
>=20
> * untrusted_ip
> Public IP address of the client, available before the session is properly=
=20
> authenticated
>=20
> * untrusted_port
> Port used by untrusted_ip
>=20
> * trusted_ip
> Public IP address after the session is properly authenticated, and=20
> available in the OPENVPN_PLUGIN_CLIENT_CONNECT and=20
> OPENVPN_PLUGIN_CLIENT_DISCONNECT phases.
>=20
> * trusted_port
> Port used by trusted_ip
>=20
> * ifconfig_pool_remote_ip, ifconfig_pool_netmask
> The local VPN IP address and netmask the VPN client will be using.=20
> Available during OPENVPN_PLUGIN_CLIENT_CONNECT and=20
> OPENVPN_PLUGIN_CLIENT_DISCONNECT.
>=20
>=20
> > Thanks to all for the help. As a suggestion, I would upload a mini-howto
> > about making plugins at the website, description made by David Sommerset
> > in this email can be very helpful and if it was a wiki, all people could
> > collaborate.
>=20
> If my little quick description might be helpful for other, I do not mind =
if=20
> it is published as a mini-howto, or whatever else suitable.
>=20
> > Thanks again, I will tell you about my success or not about making the
> > plugin.
>=20
> Please do!  And I am, at least, curious about what kind of work and=20
> signalling your plug-in will do.
>=20
>=20
> kind regards,
>=20
> David Sommerseth
>=20
--=20
Jose S=C3=A1nchez <jose dot informatica at centrolamilagrosa dot org>



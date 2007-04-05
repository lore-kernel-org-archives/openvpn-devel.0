From: "Thibault Le Meur" <Thibault.LeMeur@...1015...>
Date: Thu, 5 Apr 2007 12:47:27 +0200
Message-ID: <029401c7776f$d0b81a70$161ce4a0@...1015...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [RFC] OpenVPN and Radius Dictionary proposal
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net
Cc: =?iso-8859-1?Q?'Ralf_L=FCbben'?= <ralfluebben@...68...>

Hi,

I'd like to propose an "official" OpenVPN Radius Dictionnary (for use with
radiusplugin from Ralf L=FCbben for instance).

This Radius dictionary would help in enhancing
* Authentication: providing more information at authentication time to the
radius server (Common-Name, User-Name, ...) will makeit possible to build
complex access policies
* Authorization: the radius server could send the client-config parameters
to build the client-config file (IP address, iroutes, push parameters)
* Accounting: by giving as much information as possible to the accounting
server

First of all, defining a Radius dictionary with the 1.3.6.1.4.1.27340 vendor
OID requires approval by the owner of the Vendor OID (OpenVPN Solutions
LLC.). Are you rady to approve such project ?

Morover, this requires that the dictionnary is maintained by the community
(at least the official sources should contain the referenced dictionary in
the contrib directory).

What do you think about this idea ?

You'll find a a first try to define such a dictionary (in pseudo Freeradius
format for the moment, with X to be replaced by Attibutes Ids) at the end of
this email.

In order to be sure that I've read the man page correctly, do you confirm
that the following set of parameters are valid in a client-config-dir file :
--push-reset, --iroute, --ifconfig-push, --config, and "--push"

As far as the "--push" options is concerned I can read: "This is a partial
list of options which can currently be pushed: --route, --route-gateway,
--route-delay, --redirect-gateway, --ip-win32, --dhcp-option, --inactive,
--ping, --ping-exit, --ping-restart, --setenv, --persist-key, --persist-tun,
--echo, --comp-lzo, --socket-flags, --sndbuf, --rcvbuf". Are there others
(already implemented but not documented, or just planned) ? Knowing this
will help me define Radius attributes even if they are not currently
implemented (by OpenVPN or radiusplugin).

Thanks in advance for your feedback.

Best regards,
Thibault Le Meur




First Draft Proposal for the OpenVPN Dictionary:
------------------------------8<-------------------------------------
# from http://www.iana.org/assignments/enterprise-numbers

# OID 1.3.6.1.4.1.27340 is assigned to
#  OpenVPN Solutions LLC.
#    James Yonan
#      jim@...41...
VENDOR	OpenVPN	27340

BEGIN-VENDOR	OpenVPN

# Standard attributes already in use for OpenVPN (in radiusplugin)
# In Access-Requests/Accept packets:
#  User-Name
#  User-Password
#  NAS-Port
#  Calling-Station-Id
#  NAS-Identifier
#  NAS-IP-Address
#  NAS-Port-Type
#  Service-Type
#  Framed-IP-Address
#
# In Accounting packets:
#  Framed-IP-Address
#  NAS-Port
#  Calling-Station-Id
#  NAS-Identifier
#  NAS-IP-Address
#  NAS-Port-Type
#  Service-Type
#  Acct-Session-ID
#  Acct-Status-Type
#  Framed-Protocol
#  Acct-Input-Octets
#  Acct-Output-Octets
#  Acct-Session-Time
#  soon ( Acct-Terminate-Cause )

# Proposed ATTRIBUTES for Access-Request
########################################
# CN taken from the client CERT
#  May be used in Access-Request to give an hint to the radius server
ATTRIBUTE OpenVPN-Cn	X	string

#
# TLS id ??
# ATTRIBUTE OpenVPN-Tls-Id	X	string




# Proposed ATTRIBUTES for Access-Accept
########################################
# --push-reset
# SYNTAX: {TRUE|FALSE}
ATTRIBUTE OpenVPN-PushReset		X	integer
VALUE	OpenVPN-PushReset	FALSE	0
VALUE	OpenVPN-PushReset	TRUE	1

# push --route
# SYNTAX: {network|ip} [netmask] [gateway] [metric]
ATTRIBUTE OpenVPN-Push-Route		X	string

# push --route-delay
# SYNTAX: [n] [w]
ATTRIBUTE OpenVPN-Push-Route-Delay		X	string

# push --redirect-gateway
# SYNTAX: {TRUE|FALSE}
ATTRIBUTE OpenVPN-PushReset		X	integer
VALUE	OpenVPN-Push-Redirect-Gateway	FALSE	0
VALUE	OpenVPN-Push-Redirect-Gateway	TRUE	1

# push --ip-win32
# SYNTAX: {manual|dynamic [offset] [lease_time]|netsh|ipapi|adaptive}
ATTRIBUTE OpenVPN-Push-Ip-Win32		X	string

# push --dhcp-option
# SYNTAX: [parm]
# example: DNS 10.10.10.1
ATTRIBUTE OpenVPN-Push-Dhcp-Option		X	string

# push --inactive
# SYNTAX: n [bytes]
ATTRIBUTE OpenVPN-Push-Inactive	X	string

# push --ping
# SYNTAX: n
ATTRIBUTE OpenVPN-Push-Ping	X	integer

# push --ping-exit
# SYNTAX: n
ATTRIBUTE OpenVPN-Push-Ping-Exit	X	integer

# push --ping-restart
# SYNTAX: n
ATTRIBUTE OpenVPN-Push-Ping-Restart	X	integer

# push --setenv
# SYNTAX: name value
ATTRIBUTE	OpenVPN-Push-Setenv	X	string

# push --persist-key
# SYNTAX: {TRUE|FALSE}
ATTRIBUTE	OpenVPN-Push-Persist-Key	X	integer
VALUE	OpenVPN-Push-Persist-Key FALSE	0
VALUE	OpenVPN-Push-Persist-Key TRUE	1

# push --persist-tun
# SYNTAX: {TRUE|FALSE}
ATTRIBUTE	OpenVPN-Push-Persist-Tun	X	integer
VALUE	OpenVPN-Push-Persist-Key FALSE	0
VALUE	OpenVPN-Push-Persist-Key TRUE	1

# push --echo
# SYNTAX: [echo_string]
ATTRIBUTE	OpenVPN-Push-Echo	X	string

# push --comp-lzo
# SYNTAX: {yes|no|adaptive}
# implemented as a string to handle new cases in the future
ATTRIBUTE	OpenVPN-Push-Comp-Lzo	X	string

# push --socket-flags
# SYNTAX: {socket_flags}
ATTRIBUTE	OpenVPN-Push-Socket-Flags	X	string

# push --sndbuf
# SYNTAX: n
ATTRIBUTE OpenVPN-Push-Sndbuf	X	integer

# push --rcvbuf
# SYNTAX: n
ATTRIBUTE OpenVPN-Push-Rcvbuf	X	integer

# push --topology
# SYNTAX: {net30|p2p|subnet}
# implemented as string for future evolutions
ATTRIBUTE OpenVPN-Push-Topology	X	string

# --ifconfig-push is already handled by Framed-IP-Address
# no need for a specific attribute here

# --iroute is already handled by Framed-IP-Route
# no need for a specific attribute here

END-VENDOR	OpenVPN
-------------------------------8<-------------------------------------



+------------------------------------------------------------------------+
| Thibault LE MEUR                  | http://www.supelec.fr              |
| Sup=E9lec                           | e-mail: Thibault.LeMeur@...1015... |
| Computer Resources Center         | tel:     +33 [0]1 69 85 17 89      |
| Plateau de Moulon                 |                                    |
| 3 rue Joliot-Curie                | fax:     +33 [0]1 69 85 12 34      |
| 91192 Gif-sur-Yvette CEDEX, France| Supelec: +33 [0]1 69 85 12 12      |
+------------------------------------------------------------------------+=
=20=20




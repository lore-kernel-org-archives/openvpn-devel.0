content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [Openvpn-devel] autovpn 0.1
Message-ID: <B45465FD9C23D21193E90000F8D0F3DF02344181@...10...>
From: "Jean-Eric Cuendet" <Jean-Eric.Cuendet@...8...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Mon May  6 07:40:04 2002
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
To: bishop <bishop@...7...>, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

> I am interested in knowing wha tyour AutoVPN project does, but I
didn't=20
> understand after reading your letter.  Can you explain what it does?

OK. I thought I was clear... :-)

We need to let some of our users access our network from their home
through their Internet access (Modem or Cable or ADSL). So we need a VPN
for them. There is one called SecuRemote that comes with checkpoint
Firewall. But it's only for windows, not for Linux.

The goal is to have a VPN that needs only an account into one machine,
not a certificate. It's because it's easier to manage for a large bunch
of users. So we are using OpenVPN with *shared key*, not with TLS +
certificate.

The way that works:
- Open am SSH session to our gateway (inside the network)
- The user gives its password (no RSA key)
- A script is called on the server which:
  - generate a shared key
  - starts openvpn with it
  - returns this key to the client
- Then, the client starts openvpn passing the shared key
- The VPN is open.
Advatage:
- No need of certificates for every people
- No need of pre-shared key. It'changed every time a new autovpn session
is made

Understand better?
-jec




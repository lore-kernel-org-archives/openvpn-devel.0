From: Arkadiusz Patyk <areq@...104...>
Message-ID: <20040401100921.GA6102@...104...>
Mime-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.0 feature request - fixed-address
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Apr  1 02:10:17 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi

ifconfig-pool is fine, but I would need an option for IP
reservation for users.
The reservation could be realized on thebase of x509name

for example:

fixed-address 10.8.0.46 /C=PL/ST=NA/O=Dot.net/CN=Maciej.Nowak/emailAddress=m.nowak@...195...
fixed-address 10.8.0.50 /C=PL/ST=NA/O=Dot.net/CN=Zenon.Ptak/emailAddress=z.ptak@...195...

which would guarantee that user X always gets address Y
as option fixed-address in dhcpd

The possibility of IP reservation will simplify firewall configuration -
espesially if it is installed on other machine than openvpn server.

-- 
Arkadiusz Patyk [areq(at)pld-linux.org] [http://rescuecd.pld-linux.org]
[IRC:areq ICQ:16231667  GG:1383]  [AP3-6BONE] [AP14126-RIPE]


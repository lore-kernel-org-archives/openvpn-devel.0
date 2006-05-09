From: "Serge Wautier" <serge@...635...>
Message-ID: <000601c673fc$d621a5c0$0200050a@...636...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Restricted client-to-client mode
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
Date: Tue May  9 23:43:01 2006
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: OpenVPN Devel List <openvpn-devel@lists.sourceforge.net>

Hi All,

We have just finished implementing OpenVPN 2.0 into our RTUs. We advertize =
OpenVPN Server to our customers to connect their RTUs.

We've come to realize that small customers will probably not want to setup =
an OpenVPN server themselves (they are no IT specialists). That's why we'd =
want to provide server hosting to them. Since we can't afford running an Op=
enVPN server instance for each customer, we need some kind of restricted cl=
ient-to-client mode that would allow a customer's RTU to see _only_ the oth=
er RTUs of this customer. The purpose is of course to provide privacy and p=
revent a customer to access the RTUs of other customers.

The OpenVPN HOW-TO suggests a method using a firewall to restrict clients a=
ccess to parts of the network. I wonder if it will work in this case: Will =
the firewall be triggered for packets transmission over the local (VPN) sub=
net ? I don't think so.

I've looked into the source code and it looks fairly straightforward to imp=
lement such a filter:

- Each client connection would receive an extra param (stored in its multi_=
instance) : groupid. This groupid would be set e.g. by the ccd file or conn=
ect script through a new dedicated option.
- In multi_process_incoming_link(), in addition to testing enable_c2c, grou=
pid's of src and dest would be tested as well (match required) in order to =
allow packet forwarding.

Which leads me to these questions:
- Has this been discussed before ? What was the outcome ? If yes, pointers =
would be highly appreciated.
- Do you think this is something that would be worth implementing in the pr=
oduct ?
- Do you see any flaw in my reasoning ?

TIA,

Serge
http://www.apptranslator.com=20



Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Karl Mueller <ewiley@...277...>
In-Reply-To: <20170726143612.GJ70062@...1296...>
Date: Wed, 26 Jul 2017 13:28:26 -0400
Message-Id: <870CFEC0-4040-4DA0-A56B-E7CF835765A7@...277...>
References: <334D9817-7B72-4E78-B0CB-BC65EC004037@...277...>
 <20170726143612.GJ70062@...1296...>
Subject: Re: [Openvpn-devel] TAP-adapter iftype question
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net


>=20
> I have no idea what the effect would be ("will it stop doing ethernet
> framing?  no more ARP?"), but it's an interesting idea to try.
>=20

Thanks, seems OpenVPN is not the only VPN client that may recognize this as=
 an issue and change their iftype. https://quickview.cloudapps.cisco.com/qu=
ickview/bug/CSCut51057 The Cisco adapter previously used 0x6 judging by an =
old Cisco VPN installation I had access to.

Is it possible to have someone create a signed test build of the TAP adapte=
r with iftype 131 in the oemvista.inf?

Karl Mueller
ewiley@...277...



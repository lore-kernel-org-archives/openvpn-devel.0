From: "Doncho N. Gunchev" <mr700@...184...>
Reply-To: mr700@...184...
Subject: Re: [Openvpn-devel] openvpn server in client-to-client mode
References: <000f01c4e62e$4e5eb450$0200080a@...333...>
In-Reply-To: <000f01c4e62e$4e5eb450$0200080a@...333...>
MIME-Version: 1.0
Message-Id: <200412201123.57124@...187...>
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
Date: Mon Dec 20 01:25:01 2004
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net
Cc: Tor =?iso-8859-1?q?H=E5kon_Gjerde?= <thgjerde@...332...>

On 2004 12 20 (Monday) 02:43, Tor H=E5kon Gjerde wrote:
> Hi
> I would like to run an openvpn server on a shell account without root.
> A server that does only client-to-client, with no interface on the server=
=20
> itself.
> But openvpn says it needs an tun or tap device.
> I understand this might require the tun or tap device itself to be emulat=
ed.
>=20

    How from userspace you are going to access tap/tun device and insert
IP/Ethernet packets? If you run openvpn and want it to drop it's privileges
you have to use --persist-tun - it can not open the device after dropping
it's privileges. Imagine what happends if any user can create such device
and start sending packets!
    SSH can be used to pipe std{in,out,err}, forward ports and emulate
SOCKS proxy, but that's another story... maybe that's what you need?

--=20
Regards,
  Doncho N. Gunchev    Registered Linux User #291323 at counter.li.org
  GPG-Key-ID: 1024D/DA454F79                        http://pgp.mit.edu
  Key fingerprint =3D 684F 688B C508 C609 0371  5E0F A089 CB15 DA45 4F79


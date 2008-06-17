From: "Dave" <dev@...575...>
Date: Mon, 16 Jun 2008 19:29:42 -0500
Message-ID: <000201c8d011$3cc34230$16ada8c0@...576...>
MIME-Version: 1.0
In-Reply-To: <41566C7F-E780-4F7C-8E25-9BB5067F0C0B@...277...>
Subject: Re: [Openvpn-devel] Merge status of OCSP support?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: 'Davy MELINA' <davy.melina@...277...>, 'Faidon Liambotis' <paravoid@...334...>
Cc: openvpn-devel@lists.sourceforge.net

...
> > I've found that someone has actually implemented OCSP for=20
> OpenVPN[1].=20
> > Is there any specific reason that this hasn't been merged?
...
> >
> > 1: http://www.block64.net/
>=20
> Hi,
>=20
> I don't know why the OCSP support is not included in the main source=20=20
> of OpenVPN (i need to update the patch for the rc7), but i know=20=20
> something:
>=20
> - if your CRL (in flat file) is not up2date your OpenVPN will=20
> not crash
> - if you decide to use OCSP server with OpenVPN (and my=20
> patch) and if=20=20
> your OCSP server crash, your OpenVPN  will be block.
>=20
> For my experience, I build Two OCSPd behind LVS and i bypass this=20=20
> problem.
>=20
> What do you think about that ?
>=20
> Regards,
>=20
> Davy

I use it and like it, and in the builds that I have published for OpenWRT, I
have included that patch.

I don't understand Davy's first point, but to his second, I do wish that the
openvpn could be made to fall back to a local CRL when the ocspd server
cannot be reached.  I have had this happen before, and effectively the vpn
was shut down.  Then again, from a security standpoint, that's probably a
good thing....  Anyway, wish there was at least an option to have a local
crl file fallback.

-Dave



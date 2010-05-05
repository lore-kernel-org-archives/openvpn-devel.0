Message-ID: <4BE1F511.8030306@...1338...>
Date: Thu, 06 May 2010 00:45:37 +0200
From: Fabian Knittel <fabian.knittel@...1338...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3144AE1EB6304D530AA55108"
Subject: [Openvpn-devel] RFC: Strip 802.1Q priority,
	when going from tagged to untagged?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3144AE1EB6304D530AA55108
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

as we've now completed (almost) all necessary building blocks for
running OpenVPN in our intended environment, we've started testing the
feat_vlan_tagging branch in earnest.

Of course, we've immediately encountered the first problem. :)

Currently, if VLAN-tagged packets coming in on the tap device are also
priority tagged (the PCP field is !=3D 0), then OpenVPN removes the
VLAN-tag, but keeps the priority-tagging.

This may sound nice in theory, but client-support for
802.1Q-priority-tagged packets is quite lacking.  (Linux doesn't know
what to do without explicit configuration.)  So this effectively means,
that packets that are sent VLAN- and priority-tagged somewhere on the
server-side can't be understood on the client-side.


     Server A
       |
   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  Tagged net=
work
       |
     OpenVPN router
       ()
       ()
       ()
     OpenVPN client

If the OpenVPN client tries to communicate with Server A, then Server A
might know all about 802.1Q and add a priority code to the VLAN-tagged
packet.  The packet travels through the OpenVPN tunnel, where OpenVPN
strips the VLAN-tagging but leaves the priority-tagging intact. So
unfortunately, the client now recieves a priority-tagged packet and
doesn't understand it.  The communication fails.


Possible solutions I can think of:

 a) If a VLAN-tag is removed from an incoming packet, also always
    remove the priority tagging.  Effectively this means, that the
    ports operate in "untagged" mode instead of "untagged-or-priority"
    mode.  (Although strictly speaking, the priority-tagged packets
    aren't dropped, just translated.)

 a1) Same as a), but add a global option to switch between the
    current behaviour and the behaviour described in a).

 b) Same as a), but also remove the priority-tagging from packets
    where we haven't removed the VLAN-tag before.  This means
    completely untagging both VLAN-tagged and priority-tagged packets.

 b1) Make b) optional (similar to a1) ).

 c) Do b1), with a per-port setting.

Option a) would have the problem of asymmetry:  Clients could send
priority-tagged packets through OpenVPN and out through the tap device.
 Priority-tagged packets coming back in from the tap device would be
stripped though.

Option b) might be a bit too strict, in case clients indeed support
priority tagging.

Option c) on the other hand, might involve too much work for little
benefit ...


Soo ... I'd be especially interested in how typical switches with
tagging support behave regarding this stuff and what kinds of settings
they provide... maybe our Cisco certified admins may want to pitch in
here? :)

Cheers
Fabian


--------------enig3144AE1EB6304D530AA55108
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkvh9REACgkQARH1aMTipzOxGACghqcV/trAjURTWJxtrXeqOrQI
JdQAn3SNZftHWBplPo76dFE2Ht9arRld
=jX3s
-----END PGP SIGNATURE-----

--------------enig3144AE1EB6304D530AA55108--


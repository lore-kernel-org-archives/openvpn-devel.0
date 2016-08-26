Date: Fri, 26 Aug 2016 21:08:45 +0200
From: Simon Ruderich <simon@...2161...>
Message-ID: <20160826190845.fzhfzortt2ty3ys5@...2161...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="=_zucker.schokokeks.org-6882-1472238525-0001-2"
Content-Disposition: inline
Subject: [Openvpn-devel] --link-mtu and other MTU confusions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_zucker.schokokeks.org-6882-1472238525-0001-2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

I asked about --link-mtu in #openvpn on Freenode and was sent
here.

The documentation states "Sets an upper bound on the size of UDP
packets which are sent between OpenVPN peers." and it isn't
entirely clear if this is the UDP payload or the entire packet.
So assuming a link (path) MTU of 1500 do I need to use --link-mtu
1500 or --link-mtu 1472 to prevent fragmentation? It would be
nice if the documentation could be enhanced to make that clear (I
could write a patch when I know which interpretation is correct).


The default MTU on the tun interface also has me confused. Why is
it 1500 which will definitely cause fragmentation on a link with
default MTU 1500. Shouldn't it default to the result of
--link-dest 1500 (or 1472, see above) which seems to subtract
~100 for OpenVPN overhead?

OpenVPN seems to adapt MSS for TCP traffic to circumvent MTU
problems (not sure how the correct MSS is calculated, but it
seems to work fine), but this doesn't help when tunneling UDP
traffic which caused fragmentation in my case.


And lastly, how does path MTU discovery work with OpenVPN? The
--mtu-disc seems not to work as expected. =3Dyes sets the DF-flag
which then just drops all packets > PMTU, breaking PMTUD for all
traffic over the tunnel. The other two options seem to have no
effect. I only found [1]. How is --mtu-disc supposed to work and
when and how should it be used?

Shouldn't PMTUD be used to detect the link MTU and then set the
corresponding MTU (minus overhead) of the tun interface to
prevent fragmentation automatically? Or is this not possible?

Regards
Simon

[1]: https://community.openvpn.net/openvpn/ticket/375
--=20
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9

--=_zucker.schokokeks.org-6882-1472238525-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJXwJOzAAoJEJL+/bfkTDL5DQAQAJlhWLgc5uz3HO+7054azbDN
Sbamc7hcRDlwM9tGhn0pF87U9Zi27a/itbAB5SdN6bA+FheU3B+ppEBitihlspaC
j0ccJF9c26KOOnqKMSspZ1wKRRSczHO5C0/k9kuRz5SHIIQozkby74VAtpPXZyTJ
p+upihOTHnsMm3RR+1cnsVytyZWOSI8Jie0EOkg8CMLaXXScgt1jnnxYmfCrxuOW
EP5Rdp+zNMBCuVbYQv3u8sLSvd4b+EDI2VKTKNz7Xr1XXSGbfkyTxXoCsp6qHWYD
2tR8GLOdT7WFB6XAlDSpZkakvRvn9exp2NjiL9jG2LKOSEoeaSWni2xBkZPnXwZL
o1l/fdHlRdsOSHzNkkiFl1fxkE6M6Z9FeasB0lo4bc/nrjguMTFoPejpHQ2Ptl3n
IfnlupX+HMcjMBj5vBtgdz3zn7TNDPspCWR15TQ2uvaZztvpsAbXog2VliBCpsCd
FeWBMYTK1S3MOZ5svT5/4J3G53vtDEwy3qHX/rQY9Zuf33uqjh0HTVVX/XtvDwOD
qwB7SKRd50F204pJMKopxB6l9pHFYzm+Txu7dFr3y1Fc1GxMrIoc3ATQL+4ffP7f
9gRbhbsMcGCqndeDm5mU1etk8UZ/IU8pZ/qnokEy6wdaFJjkk+80DBzapIl/DatG
zYlR4afOk+aTVX60vxgy
=8C4c
-----END PGP SIGNATURE-----

--=_zucker.schokokeks.org-6882-1472238525-0001-2--


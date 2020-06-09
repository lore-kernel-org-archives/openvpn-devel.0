Date: Tue, 9 Jun 2020 19:55:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200609175503.GU1431@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="KznFLIaq3GcgvPrz"
Content-Disposition: inline
Subject: [Openvpn-devel] async plugin-auth-pam
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--KznFLIaq3GcgvPrz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I ran into a problem at a customer installation recently, where=20
plugin-auth-pam was blocking for some extended time (~30 seconds?)
due to pam_radius not receiving answers due to problems in the backend.

Now, maybe I should use radiusplugin in the first place, but since=20
the pam_radius setup on this machine is shared between sshd and OpenVPN,
I actually *like* using plugin-auth-pam -> pam_radius ("test one service,
know that radius very likely works for both").

That said, I'm considering modifying the plugin-auth-pam plugin to
add async authentication - which is supposedly not so hard=20
("sample-plugins/defer/simple.c").

Has one of you already done this, and just forgot to send in patches? :-)

Any particular caveats?

thanks,

gert


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--KznFLIaq3GcgvPrz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe38z2AAoJEB2Cnv7KVigS3isL/2FztXKqMoV1WuyEyAMvc610
nbhWaU3XqmMj8y351quJv+6USL4VxKT6VoBG5xDfrexYQ7t7o4TviVunjEyljkh0
hs1I+kb/xsLsI7pkepR/x9QbWzTHfG1RyfHG8Zxq+wc5/nT12GfxhYW50IEQ/4Gi
Qbvhn8qFxcFtA0/opoMPY06z4TtdoMzTVbM8kujIf4fnqtYcmOr7cpm4fMEO2Ciw
Hz4e0s1g89SClnqd3PgI3QikjCDoijGw4tRoFYtRLgX3JD7wjpoKvYhe7isKEAo+
R3ZMAMLwpAQFmUtV09IAtVHqZY397n1VxfuoLxHN9ejKc3XYTvw4QLqHlHu8JQlt
Mz/DW9Zdiii5Kk5I4ePwSMWEFCLcXnoL9P4QM+WE5c1ZhuJbXGBfoeAOlyOKLUJb
dimabtDYbIF7c0BwznW2KrmydsrOh1I8PfG+CChSn6ROyEnUq8H7/qQao3b2cNFt
24tRfkNvr4ru4EbiNNyj+f+6Kay/+3K8rgebxZxDHg==
=0Q1k
-----END PGP SIGNATURE-----

--KznFLIaq3GcgvPrz--


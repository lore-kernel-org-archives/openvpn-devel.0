Date: Wed, 6 Jul 2022 11:07:37 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YsVQ2clqGF73f+b0@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="zW06mXr5Rwu8GCpA"
Content-Disposition: inline
Subject: [Openvpn-devel] HEADS UP: removal of --mktun and --rmtun in 2.6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

--zW06mXr5Rwu8GCpA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

we are discussing to remove support for openvpn --mktun / --rmtun options
in the upcoming 2.6 release - because it complicates the code, and we
think there is no actual *need* for it anymore (and it's Linux only, etc).

With "ip", there is a submode "ip tuntap", which does the same thing,
so=20

  # openvpn --mktun --dev tun4

becomes

  # ip tuntap add mode tun name tun4

and similar for tap stuff, "user / group" settings, etc.


So, this message is intended to do two things

 - raise awareness "this will come in 2.6!"
 - and also gather feedback: *if* you use openvpn --mktun today, please
   test "ip tuntap..." and let us know if it gets the job done properly,
   or of something is missing.

The code is not removed yet, but will be, unless there are strong reasons
to keep it.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--zW06mXr5Rwu8GCpA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJixVDZAAoJEB2Cnv7KVigSRLAMAJ/YOIyOOMU1+yvsLFw2J+Sb
VH2d9IH3Uct+2sDikJFdLdB/XL+hGP8nFJufiz2xznj7yZuLnlEdyZsYnRsPldF3
OtlHIw+1Z9AIYrs6Mervin/yGYlffmXaFPc4vV/ZE6nc6KGjq5ZCUDXDN7MNoYMU
R862uqToUgQfbWG/BYsEe1EnLYlOP/In4ju6HvsDRj2BmlSe7v/fFtUmqpVoTJ4P
jTqkIVZIKl+U8zT9MqmZDDJlgzShhoguQyPr1oCr/aaxomPCinI5ZefPYawiGuoI
ziyClkL0AWMYEF+hoWXOtIJm6Hl7oLsdMoOBt1S3pfGHdN2Y0g3dBMtyLJ6zz/J2
JsMhlVNdecHmmY9iNU6NOMsuqeT8drjU3M1N4mmbQSQwF7TLJ8+kUH+3EhJlP9Ql
szciMiKwmQczurmnZilRBzLTcleVB57mcOUW1ESgY00IjzbXtN/KklfapinYete+
3RxkjfV5vbQZcxnsp/gimZIDYyhXfB+OQwfW5IeGYA==
=f9DR
-----END PGP SIGNATURE-----

--zW06mXr5Rwu8GCpA--


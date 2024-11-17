Date: Sun, 17 Nov 2024 16:51:10 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZzoQ7jXbImL56HL6@...1296...>
References: <CAC8x_z10PT_ToTzVUKQENA5ZJgJ4EMvBJARphDR5_wdytA2JSw@...278...>
 <b7c9a1ac-3322-4eeb-befd-e19c7f72da6b@...1227...>
 <CAC8x_z3Fwf0r-BuvuOo+Vg0708fsaPGWjg-2pnY3xgM+e4QxDg@...278...>
 <Zzm_gUxTAmFZjm_h@...1296...>
 <CAC8x_z1OtkMeuRCHNOHfg-rcJ3Kcj2uHua3pzK5ZqKJDjPvBjQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="EL8zQnK2+QMfSJn/"
Content-Disposition: inline
In-Reply-To: <CAC8x_z1OtkMeuRCHNOHfg-rcJ3Kcj2uHua3pzK5ZqKJDjPvBjQ@...278...>
Subject: Re: [Openvpn-devel] Subject: Potential OpenVPN Vulnerability
 Report: Repeated TLS Handshake Failures Leading to Denial-of-Service
 Conditions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ?????? ???????? <nsh531@...277...>
Cc: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>, Antonio Quartulli <antonio@...515...>, openvpn-devel@lists.sourceforge.net, SECURITY@...515...

--EL8zQnK2+QMfSJn/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Nov 17, 2024 at 03:50:18PM +0200, ?????? ???????? wrote:
> I think there is an option for DoS and therefore there is an option to cve
> or to write a patch..........

What you *think* is only relevant if you can actually *demonstrate* this.

Show the DoS - in a way relevant to OpenVPN - "I broke the network so
OpenVPN is no longer connecting" is only interesting if it leads to
further problems, like "the client starts looping and fills all disk
space with meaningless log lines" or "the server process can no longer
handle other clients either".

We've had all of this in some form or the other (mostly related to
Linux DCO desynchronization between OpenVPN and kernel), but you have
not given us any material that demonstrates anything interesting.

I will now stop answering your e-mails.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--EL8zQnK2+QMfSJn/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJnOhDuAAoJEB2Cnv7KVigSDkgMAIxK40EydHUP2VaP6LqyrTS4
hla4HZgEzR9SpKlT2jujDsp3zF7j4kB1HyjIyyOhW78bI+Izurcga4bvCFKF8RTs
+Wd6t925TA01XFeJfS3ZfX80yQTd3SSjSv0ptybKx/CRY16hNpg189sBqQfoxWoJ
rERfDwqHAan9Rqb8VQ/8xgay2qYJzKgktThgzZeNHHV6jKx1NHCSCUuZGRBdmx1m
BefKGAIVZphJOEyY7pJJIwHmrpoDLvApGJuvHBoSJ+fbdrpM1u37JTbLnRMDF6ZG
xS9+8jO2CA+FJ3EpApR5nw4+eUfT9iHtKtflD4QlJtuMoHdoF1xtCPhebfDUU4Su
f3MQbOMYtF+0ttcCnaYIFicjTRsebmR02zX0rZUN/VXnoFxOzPaA8rdHfmQUWi/N
DNWxszTDJD13nN0eegLg9Y/6IwKaWSgZdOzg2/vL8b8bDtAZL7SPOEoqaosCuySx
JPixAZlinpKHDtnB/P0gTVSIsfcHt6Aoj7KdyOgebQ==
=Va/G
-----END PGP SIGNATURE-----

--EL8zQnK2+QMfSJn/--


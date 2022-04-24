Date: Sun, 24 Apr 2022 20:10:49 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YmWSqYVdVNI9e+WX@...1296...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422134038.3801239-5-arne@...1227...>
 <YmL8fpKi2/MqE/+s@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="LMk4qdgSWD2Iq/0c"
Content-Disposition: inline
In-Reply-To: <YmL8fpKi2/MqE/+s@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 04/28] Add documentation for swap_hmac
 function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--LMk4qdgSWD2Iq/0c
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Apr 22, 2022 at 09:05:34PM +0200, Gert Doering wrote:
> I was about to merge this as "it is easy, and does not change code", but
> if we add documentation, it should be correct :-) - and this schematic
> does not match my understanding of the actual code - which seems to
> swap
>=20
>   [opcode + session id] [hmac + packet id]
>=20
> could you double check that?  The size of the "things it swaps" is

Ah, found it.  This comment gets changed in 05/28, to the values I=20
also figured out.

So, ACK on this one, will merge together with 05/ ASAPish (maybe I'll
move the "fix comment hunk" from 05 to 04).

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--LMk4qdgSWD2Iq/0c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiZZKpAAoJEB2Cnv7KVigSwQQL/iPVKiX+hqGf5Wd1fd95u5T1
iec4WToOMQc8AsbrIBpv5PJkGqc/c/OmtR/ypdW7X7vqwqH6PDe+x/6DHE901RQt
JrmZmCY/1HMNBlSKgPyKjqacun2aLLiAtpFWRngFPrO0uqDQem7me63F+Igi6GPS
FKRiuPhSMpTY78PN3XQ1nnrRGCU29eNmkfU9exziHdSo/V+f2hEHKDtiFeypH309
c5jGzWAyi3RmVhBNW75PTp/5GYdSVAZwenb3FoBN8b8xIzGDUTLI10v/MMyBg3x9
AQfruCdkCJoyy3u7Bote0tDsx8uO/UKXclKsGI71FpfzIMsldzXicWAY6LgWGJzG
uURG3DQS2T0NLbmgktV4X4YNv859kIb8y3dnJGkhwYWnSlj1uysWgmnPuvg4nLr0
u6LAdm9V8ddhJlVT+ogWiiz9g0dmu99VJDFkJDyFgPYoGDw5894127w7cJMGTQEM
74tNYYxbUMbIRH9c0+yU04sBKxoKOKGfTkmsbEVYtQ==
=Wsva
-----END PGP SIGNATURE-----

--LMk4qdgSWD2Iq/0c--


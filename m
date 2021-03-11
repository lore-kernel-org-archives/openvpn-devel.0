Date: Thu, 11 Mar 2021 19:42:37 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210311184237.GQ976@...1296...>
References: <20210310124808.14741-1-gert@...1296...>
 <202103111723.12BHNAYE012156@...2054...>
 <CAKuzo_g4xteFB=tAbTaZ94F3mRieJmmzvDRV7bhxzNC99q-LUw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="l+gHxWmLq9QeSbuB"
Content-Disposition: inline
In-Reply-To: <CAKuzo_g4xteFB=tAbTaZ94F3mRieJmmzvDRV7bhxzNC99q-LUw@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Require at least 100MB of
 mlock()-able memory if --mlock is used.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--l+gHxWmLq9QeSbuB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

On Thu, Mar 11, 2021 at 01:12:04PM -0500, Selva Nair wrote:
> prlimit on Linux is handy as it can change the limits of a running process
> as well.

Yes :-) - my week is full of exciting discoveries.

> On FreeBSD probably "limits -P pid ... " can do the same?

Indeed!  Thanks, didn't follow the right references, it seems...

gert@...2054...:/tmp$ limits -P 13222
Resource limits (current):
[..]
  memorylocked           102400 kB

... so, the claim of OpenVPN pid 13222 "I have set this to 100M" is true :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--l+gHxWmLq9QeSbuB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgSmScAAoJEB2Cnv7KVigSh6IL/2WWw0buEFkrnLE1dM6+9LpS
QGjSudWG+brhDKTGCu78jJPMWlvZhRLaubuC3rlK1Tg0Uo6eqaaP9+zX2xxWh0qG
/kaQ9v8JBHA0L+z59LFC46rbKfVW15h+EeQrBDzRxTATLqp4k5cf5tSyflYAeAzz
CrZIo8oCjqFmVje7vDk7aikPngWhyPzWjUFwW1sbAr7/SfHyAPSYyJYMoUY0leJo
stw2BthRl11TXIySBPPEvSUSP5WpPavDLJ1e72BdQyk0HCQY3aNbsgwo+s38PO5V
p05LMBYW1CuR6EdoeO3fL8jb7Bv6ZW7/4ldNxqKTzT1KTpXd9FbyJfzDdVQnb9le
7JYeUkBXo7nGsx7PAri4mWL60gosLFHOEauaXaj+UPuqs7Ds9/0D9gnsNCkzT3Ne
eoGXq01onaNiIAK/jZYNyxHsa7XWzz5/yQdh220AbJoEyQOWD/HW9JbZISk3dwQC
3LP19tNKR+bVHvuUdgD8+weL6OvFHlFqXbqrIwKdwg==
=sE69
-----END PGP SIGNATURE-----

--l+gHxWmLq9QeSbuB--


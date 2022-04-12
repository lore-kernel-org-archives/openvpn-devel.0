Date: Tue, 12 Apr 2022 18:19:04 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YlWmeJW0zJ21L+ss@...1296...>
References: <20220402070902.30282-5-a@...2181...>
 <20220411133528.27279-1-a@...2181...>
 <2078542256.353074.1649759630031@...2642...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+yCXsXUDxBTTcvYn"
Content-Disposition: inline
In-Reply-To: <2078542256.353074.1649759630031@...2642...>
Subject: Re: [Openvpn-devel] [PATCH v2 4/7] ovpn-dco: introduce linux
 data-channel offload support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

--+yCXsXUDxBTTcvYn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Apr 12, 2022 at 12:33:50PM +0200, Frank Lichtenheld wrote:
> Honestly still not sure one would start reviewing the actual code but here
> are at least a few minor things I noticed while browsing through it:

Well, now's the time for the code review - I have *tested* it in=20
client and server scenarios, but not actually looked into the code
much further than "uncrustify will not like this" :-)

Plan to do a more in-depth code review after next weekend.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--+yCXsXUDxBTTcvYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiVaZ4AAoJEB2Cnv7KVigSxIsL/1XwugfFPLQiXJut8gPd/A9V
7JmyJv35T2b5HzCx80MoBfcg7GK00mQnHF6n/kwHad7QW2R9OlWXTI62OK7j3soF
Irgm8CZVWP/9YP3m90aGpdozNBvIzMlfW4Pu/wI4b9V61cn+lTFrFDDIbIzAh+Cl
aLOOILSUv98QRbw4luz+EpVYPe/RMMVOrdy5HfI4KA1LsARnipoL7bK9ZzSr53zp
01srxlo3MwQD/p7J6zabAtZ5amxLFaXbA4U3SjfIZ6qK6tfqAHWvnKMcLvfh4De4
hjVjxHXk1fdvNZKHY1H/rIfvhYgch8ZLB+Mrx/LtVyiokDLyuLFJRFiMRi7TiAL+
e/fzo1wwzkbkK3fvTGDKUd9DsXbZ1JCgclxanTBOy11d+pJZqqkyC5+5vWqtmsia
0v4rfXdCXHxI2P86RXFRQJhx07Jv8XJ35RLh/DcneQyUZFqd4HhA2idjHymlXAsz
a1fYQx1qNv0MecElR5bVAl5k2N0sHD7lPU2qjvjNBw==
=/DpS
-----END PGP SIGNATURE-----

--+yCXsXUDxBTTcvYn--


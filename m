Date: Sun, 5 Aug 2018 20:45:15 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180805184515.GB55859@...1296...>
References: <B09CA954-FCB8-4362-912F-F43DDD7DC59C@...438...>
 <20180723173923.GJ55859@...1296...>
 <E6871949-4FF9-4C5A-975D-12CB177BF29B@...1031...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="PCQTdKZ3LJr0gNcz"
Content-Disposition: inline
In-Reply-To: <E6871949-4FF9-4C5A-975D-12CB177BF29B@...1031...>
Subject: Re: [Openvpn-devel] Fix for NetBSD with subnet topology
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Adam <adam@...1031...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--PCQTdKZ3LJr0gNcz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 02, 2018 at 04:26:30PM +0200, Adam wrote:
> Here it is, against the current master branch.

Thanks for re-sending.  Unfortunately, it's not complete - it adds
"remote_end", but never initializes it in the TARGET_FREEBSD branch.

So it sort of works because it happens to puts 0.0.0.0 (or even random=20
stack data) into "remote_end" which is then used as gateway address...=20=20

Sun Aug  5 21:01:38 2018 /sbin/ifconfig tun1 10.194.3.14 0.0.0.0 mtu 1500 n=
etmask 255.255.255.0 up
Sun Aug  5 21:01:38 2018 /sbin/route add -net 10.194.3.0 0.0.0.0 -netmask 2=
55.255.255.0
add net 10.194.3.0: gateway 0.0.0.0

(Actually, it looks like it could work, but pinging 10.194.3.1 is=20
subsequently failing)


All other platforms have a

  remote_end =3D create_arbitrary_remote( tt );

in there, to make it look less... accidential.  I assume this just got
lost on rebasing (blame it on Antonio :-) ).

Could you send us a v2?  thanks :)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--PCQTdKZ3LJr0gNcz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbZ0W7AAoJEB2Cnv7KVigSob4MAJ/z6Ju3yzdLKkqfvCqdodar
fS4mbHgCwN1kDzkeTFUJGv7OFKWudjBeTlTdgE42FG7OjUPUgg9qVrQYlkhicsUl
6xDBTOdt64YobavseglkNgJf/bKRcNsTfn7wUwrY4DB1EJSddzOA7Q9z7mv3frva
0FlL6Hlrg5zWjRogY3Wbuzen4wafd2jmMImZYrfygoM6sr3osKjU2VlT4Pqz4KsU
6tfoUFmJbgJHkcfRiQnLiBg1CalvFreKFdETw6S9ap5lgS2mXB1Uqo4igX5YD/hy
ggDcZ1MbNNqDiXnKjALRdyeU/YHFDlv1fE7gqepbuedgOZ9ZisfNp/yWkp6uAu2q
DsisQQuEoXE8a9OxpHDSSyJ7txmfb+3LGNLuB37BgagONbrS/0WHs+JAkxlZMqiJ
GEMaoU+7kMbRNxpzDxLa3GigMKZlrHtH/OGCn5nxa1Txd0LKngLFg0pmccQLBwto
iql4Nes9jTJ8A6VtOOB9DKaF4q31fN8UuYdeClDvaQ==
=6NGI
-----END PGP SIGNATURE-----

--PCQTdKZ3LJr0gNcz--


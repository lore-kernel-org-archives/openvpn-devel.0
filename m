Date: Thu, 21 Jan 2021 12:11:16 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210121111116.GS976@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+ZVqm/XpfIo49T/Z"
Content-Disposition: inline
Subject: [Openvpn-devel] HEADS UP: fate of the built-in packet filter (PF)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--+ZVqm/XpfIo49T/Z
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

OpenVPN has a built-in packet filter, which has a couple of issues

 - it is IPv4 only (though IPv6 patches existed at some point, but nobody
   reviewed them, so they did not get merged)

 - it can only be configured by a plugin or the management interface
   (so actually *using* it is not very straightforward)

 - it is not tested in any automated way today

 - none of the core developers uses it, or knows any deployment where it
   is used - so if we break it, we might not even notice

   (this was actually what brought up the discussion today - if a plugin=20
    returns OPENVPN_PLUGIN_FUNC_ERROR on OPENVPN_PLUGIN_ENABLE_PF, openvpn
    will crash with a NULL pointer access...)

 - not even OpenVPN AS, which usually uses "those interesting features that
   nobody else knows about" uses PF (compiles with --disable-pf)


Based on this, we consider ripping all the PF stuff *out* of OpenVPN
for the 2.6 release ("hopefully later this year").


This is your chance to speak up and tell us "I use OpenVPN pf for this
totally cool thing, and there is no way to do this with the firewalling
layer the operating system provides, because..." :-)

So - surprise us!

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--+ZVqm/XpfIo49T/Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgCWFTAAoJEB2Cnv7KVigSG6oL/36lPOGCFyFjnAFHKC8+4az/
FH+JIcOFdvcoslYJt5NNl9mnwNIii0gEYqj3FQ/Vf6zM3ovIHvp1hEUrgwJtdU/e
BNKDrNvvsRQ/EPIx5X/cOv8lu/awMPEBhC5DAvoePyrUXR+S+4GLbwfJK7eA3zbk
oIwzmx9ZLqc6teg5LONt3ig+0FkOofzm7IQTU6Bye/26Fy9tVvSQ1D5PrWbd8eBS
t1gKlqhqgwA+QKxhDPZUglUYarqfVta06I5Uq0DZLrXKtQ3QBTB2zaU8z/+Ziiuk
L3fvZPc9fslNF+yecGfcboHUw7NVkNrz3pKCOKq1zmiIWWKrCqTIG2ru8EiVOXwj
fbmQUJ7PTeynR+ZQzgPMm/yIGrsWycBKkDYcXFMaZHQLVNDeYvNzdOptLgd0TNGs
qwtX9afzGr2ZoPogI3Ds18rVOPEZdBPbGEIFO7LhfyRhgHcXTycnr42GaZKDDEGY
ViLePYLW9uPkcDYXXhfkthMJVZeja5P+UgWPyZoX5g==
=EWIE
-----END PGP SIGNATURE-----

--+ZVqm/XpfIo49T/Z--


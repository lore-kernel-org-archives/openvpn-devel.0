Date: Sat, 29 Aug 2020 21:47:28 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200829194728.GU75094@...1296...>
References: <20200814080619.2108-1-arne@...1227...>
 <CAAWBBYM2+4FqN-HyV9W19fJfAHKd9K4KHhnQFz2_5f3tzdvMFA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="p51eBkY87UC7w4vh"
Content-Disposition: inline
In-Reply-To: <CAAWBBYM2+4FqN-HyV9W19fJfAHKd9K4KHhnQFz2_5f3tzdvMFA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix client's poor man NCP fallback
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Rafael Gava <gava100@...277...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--p51eBkY87UC7w4vh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Aug 29, 2020 at 04:19:07PM -0300, Rafael Gava wrote:
> This thread has a could days but I'm testing the version 2.5-beta2 and I'm
> getting the following error:
>=20
> 2020-08-29 16:02:53 us=3D643016 OPTIONS ERROR: failed to negotiate cipher
> with server.  Add the server's cipher ('BF-CBC') to --data-ciphers
> (currently 'BF-CBC') if you want to connect to this server.

Which combination of client/server is this exactly?  2.5-beta2 on
the client, what is on the server?  Can we have some more log file,
including the "PUSH_REPLY", please?

And, if this is on windows, please make sure it's really "beta2" - the
installer will not replace openvpn.exe when going from beta1 to beta2,
so you might run an 2.5_beta1 openvpn.exe.

[..]
> I know that you guys are trying to get rid of the BF-CBC but my question
> is, should it still work if we set these parameters in the config file or
> am I missing or doing something wrong? :-)

It definitely should work.

It does work for my test bed, but I am not testing "2.5 client against
'some old server'" yet - only the other way round, 2.2/2.3/2.4/2.5 client
against 2.5 server.  It needs "data-ciphers BF-CBC" (or "cipher BF-CBC")
to be added to the config for non-NCP combinations, but afterwards=20
it works.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--p51eBkY87UC7w4vh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfSrDPAAoJEB2Cnv7KVigS/ikMAKm4dAj4GRm2mStVoZIZdmJb
XnWK8+gyuz/FRoeoQal2yVnZOx/9xNQsWjiDFmvcjPlvInF+5PWM/RQ640uLj8SV
WBGgcRbuXi/GfrTc19IFrgdDO1g/DPh2sOIHp03itaLUiWIqpizFQ1wYHSLvBJIn
dVfi+Mwv1PXAww31gzVUBl2/rijJEBviQ1rWVT7tGBfQQL5GAZhHUFveTzRO8V0o
pHgamwjU4KAi6zVGIjsmVX8P1AbhHLz3XMGo8nHa7rTz5nnlrp2QE+eSmVCbExFm
Q9GQhrL04nVOtIOo3oPUIlGINRmqj60N/pbjwiAvuwnVQ/9VyAEoL7DlbZzamVJp
MiRey3ZNwnsaByr3dniAZsE/CrT+MVwDwiMZc+y0Nw0KZLbx59V3hh/KTXIdrAdM
yNK3A+7+Kvu3rVAUSAiXt5I4dI4q1HizLXZS6VHewvZkFv+NI/KtZ+4v2Cez3xkL
yfBVw+y7NL+PUP5+XyzL3hBuPIsOHHY1fs59DLYmhA==
=rcut
-----END PGP SIGNATURE-----

--p51eBkY87UC7w4vh--


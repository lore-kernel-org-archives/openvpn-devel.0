Date: Fri, 15 Sep 2017 17:35:47 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170915153547.GL70062@...1296...>
References: <CABMULtJc_dvbLPwmVTP9Y4+Y6bGPnCT+nmCjk38fDQC4OaK9Uw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="KwgAcZnBnwoMp5TU"
Content-Disposition: inline
In-Reply-To: <CABMULtJc_dvbLPwmVTP9Y4+Y6bGPnCT+nmCjk38fDQC4OaK9Uw@...278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN per client cipher
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alex K <rightkicktech@...277...>
Cc: "openvpn users list (openvpn-users@lists.sourceforge.net)" <openvpn-users@lists.sourceforge.net>, openvpn-devel@lists.sourceforge.net

--KwgAcZnBnwoMp5TU
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

(taking this over to openvpn-devel, as this is not so much a "user"
question if it concerns ongoing development patches :) )

On Fri, Sep 15, 2017 at 06:04:27PM +0300, Alex K wrote:
> I built openvpn 2.4.3-1 on server using patch also to allow for per client
> cipher through ccd file.
> I took the patch from https://community.openvpn.net/openvpn/ticket/845.
[..]
> When connecting with clients having the same openvpn version as the server
> (2.4.3-1) and using the same configs, it seems that the server ignores the
> "cipher none" at ccd file and logs the following:

Seems NCP ("per-client cipher negotiation") trumps ccd/ here.=20=20

If you configure "--disable-ncp" on the client side, it should work.

[..]
> Is there something that is causing this behavior?

Cipher negotiation :-)

Thanks for testing the per-client ccd cipher patch - this is definitely
useful.  Interaction with NCP needs a bit more thought, it seems.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--KwgAcZnBnwoMp5TU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZu/NTAAoJEB2Cnv7KVigSWfIMALHigWqyf9igsVlMInympiaf
7WcJAsZnnildMX8gHFIvNWMTAxFS7gS/ah18Z1RRkMEz+hLrx5zefnsq52Ko1LB9
+/OlSEDFXwqu+9IyIubAmiP3hmfnkCizY4habuWaUAjQXGPVqjaaPe5o0EkZ+gwr
op+kjopvsltiCdKQ3EYjRD8vXQ2hdU723sjzWvPU2VxUiQQRs7L2Slik4oCcZXlZ
qb/ul5DvwhNDUfaPfBLAx65M7xphXvqLHN72OwnzBzPZYLXTpzctR7FMOUwtGaRx
Ejs7Xlks5Gf9imFBeWHNm4s0wuDQ5X+kHeRVE69y07dqwCfhPx0gOnnSHOr+N4NR
U+Jh6OqNNFgi47enHqHQ3EL/nLGKKC7w4j8KXsPlLKmvmK8h0cFjW49HhsOltmsV
L7f8UbyPsGmFadpps2LR+VkYz9VhpTbJSz9yhJlbxmiflq8uM2eEW0JsUpGIihWr
6EAGiRZIcATeScRfZMVbT1DvmVYHTWl7LoX77VXoQA==
=ANps
-----END PGP SIGNATURE-----

--KwgAcZnBnwoMp5TU--


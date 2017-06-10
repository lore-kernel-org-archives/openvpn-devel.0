From: Jeremie Courreges-Anglas <jca@...2272...>
References: <8737brk7vm.fsf@...2274...>
	<20170526165606.GQ97029@...1296...>
	<CADxRZqwYw0RLxCDB-u3NmrLUBONng5DyT-1e9q-37HDHPpnCrQ@...278...>
	<877f0jvmwi.fsf@...2274...>
	<20170610174642.GK97029@...1296...>
	<8760g3u3m2.fsf@...2274...>
	<20170610181126.GN97029@...1296...>
	<87ink3slpm.fsf@...2274...>
Date: Sat, 10 Jun 2017 22:10:34 +0200
In-Reply-To: <87ink3slpm.fsf@...2274...> (Jeremie Courreges-Anglas's
	message of "Sat, 10 Jun 2017 21:10:13 +0200")
Message-ID: <87a85fsix1.fsf@...2274...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] Alignement crash on sparc64
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--=-=-=
Content-Type: text/plain

Jeremie Courreges-Anglas <jca@...2272...> writes:

> Gert Doering <gert@...1296...> writes:
>
>> Hi,
>>
>> On Sat, Jun 10, 2017 at 07:58:13PM +0200, Jeremie Courreges-Anglas wrote:
>>> OpenBSD:
>>> 
>>> struct ip {
>>> #if _BYTE_ORDER == _LITTLE_ENDIAN
>>> 	u_int     ip_hl:4,		/* header length */
>>> 		  ip_v:4;		/* version */
>>> #endif
>>> #if _BYTE_ORDER == _BIG_ENDIAN
>>> 	u_int     ip_v:4,		/* version */
>>> 		  ip_hl:4;		/* header length */
>>> #endif
>>> ...
>>> 
>>> u_char -> u_int.  Dunno if it matters to the compiler, I can take a look
>>> later.
>>
>> I'm fairly sure it does matter.  An int is likely to be at least 16 bit, 
>> maybe 32 bit, so the compiler can assume "word aligned" - and *boom*.
>
> It doesn't seem to matter that much.  Which aligns well with the
> "bit fields are nasty" experience people seem to have.  From a quick
> glance at the c99 standard, I couldn't find language about this.

Appendix J.1 mentions this: "The alignment of the addressable storage
unit allocated to hold a bit-field (6.7.2.1)." as unspecified behavior.

-- 
jca | PGP : 0x1524E7EE / 5135 92C1 AD36 5293 2BDF  DDCC 0DFA 74AE 1524 E7EE

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEUTWSwa02UpMr393MDfp0rhUk5+4FAlk8UjoACgkQDfp0rhUk
5+4LFA/+N42XymLhIr/J7I+a0Y56ijg0NNbdgNb+BfqsDZWYCKMyfFBErYn7zqg3
/HBwSmlV3h0UcWr7+hCGFYsfTwwl7R1fuXM1N0i80iAHjy6FoyMucFfVbbJAoWCi
Y+8D3DeuirKVVPGWJDeFLmCDQi4aQrYHmyaGrD1rEUReY8RSki0QRcpzg2JR1JFk
wKdZU/Vfa91vbPKAOKn122CZ7B4HY7JT7EpbVti8Ye/ANp/rEIAPXtNY04yJv2No
P16F6Hts6L9TDG9xJhccs+pntU4kWdKfs17bKg2vp0+7O7JPTf6+CbgpvZ7Pdhk7
YxDnbFJjFx9kVtb3VVC3/6rN6eifhQOkWoIs6pi2FEnewsYI8uDynu2fmd1R+sIp
zXBPKJOyiOnXrGstoplzKasUlJWG2cilnPa55r6xSrM+WNpyV/8wSWn/nzNlQ4/U
Kh2b0suSL72Gdk1dbu4aLStt4TfMsqOYgOjXZVlHirbd6jLXBQOCweGlDy98R/pt
bs4+WW2dx8ArWSYOSH+6vXdvjOFZI9Crm/PaYfAddFgQe+jfhS81qa3sdGQ34MlG
0jJxW7nrsn6Y26j6/8OUvKnBXmzgpyrtdHaCSLxURdFqzMxeCb7nvMVuXgoekQpM
GjlMdQL9vJyR0kLcf2BTgLCK10iJO/7XLpuLvpir04WBjSV7oCc=
=8JsP
-----END PGP SIGNATURE-----
--=-=-=--


References: <1476996158-5390-1-git-send-email-davids@...515...>
	<88fab532-d93c-e65b-a604-eacfb888da74@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <196da459-e0aa-6ee9-b14e-786398ebd928@...2080...>
Date: Tue, 8 Nov 2016 21:27:20 +0100
MIME-Version: 1.0
In-Reply-To: <88fab532-d93c-e65b-a604-eacfb888da74@...277...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="6a6HBqcTn6KkBVwaWxkSlSErBg0DwbRnb"
Subject: Re: [Openvpn-devel] [PATCH] systemd: Improve the systemd unit files
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6a6HBqcTn6KkBVwaWxkSlSErBg0DwbRnb
Content-Type: multipart/mixed; boundary="7FKg8jS5f4o4bSkPtOk1sOAq0BRsvnAHi";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <196da459-e0aa-6ee9-b14e-786398ebd928@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Improve the systemd unit files
References: <1476996158-5390-1-git-send-email-davids@...515...>
	<88fab532-d93c-e65b-a604-eacfb888da74@...277...>
In-Reply-To: <88fab532-d93c-e65b-a604-eacfb888da74@...277...>

--7FKg8jS5f4o4bSkPtOk1sOAq0BRsvnAHi
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 08/11/16 16:40, debbie10t wrote:
> Hi,
>=20
> I now have these unit files working on all my test VMS.
>=20
> The only problem before was that on debian 8 these services failed to
> start after reboot. (systemctl enable openvpn-{client/server}@config
> was enabled) The error message was:
> main process exited, code=3Dexited, status=3D233/RUNTIME_DIRECTORY

It sounds like there's a conflict with a pre-existing directory.

Do you have a chance to check if the stock openvpn version you had
installed ships with a pre-created /var/run/openvpn directory?  (or
/run/openvpn, or whatever Debian uses as the runtime directory)

Otherwise, great testing!

--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--7FKg8jS5f4o4bSkPtOk1sOAq0BRsvnAHi--

--6a6HBqcTn6KkBVwaWxkSlSErBg0DwbRnb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYIjUoAAoJEIbPlEyWcf3y3L0QAML9zYBVQKWvc823TgL58vor
QVoWoOR4fxznO1u5TXzQinkiCG/2qEWfh//vttGtGr3TjuSotBL/KTJEgurrDqfS
e9CbL36EStuUx0cZyY2ysLEBMvse7yu9LcTx/28AR4OXEvoGjHbxWiyze8pSUWIb
0YIXZMkgKEExo9gecAks109UjiV6jv5ykK79dRTG8JTE0It5nUmsnhx/hMl2T9he
w+RvUbGGTsfbs1kbCmfSKwPBpQq2bJPkPrpim0X8vLgCEl4rSAunUdvoptiZRrVE
12PEBeimub2PqvRMpT4TbaOD1HtxW6S5y7R/dcbzAzKgn4g190+//GFX3y2gAOvx
OTJUG6PKV4zigKswpblbcssGQxLn8F4UURc59wuSTPMP4TlqyR0CQp/MU/fJrQCs
hDGBxxFnUTrPMNXTIjPJaHeJMWrSKQeUNhIm8eIAyLohMbVZiC6NxxAh35+JOOWd
TZIXM4f/40XqpnPbsf/9A24MVUmzd1L2F50HCOcWAB7SdGMCFZxrmw7uDCTH1JXg
rv4OachSuAjvNe+qQapxXR7S97tVc4HLsi+sf+voUL0SrGL2JNWSG+dEePZeZ0br
CiPgcLugnOZMNLUyKkIh/nr/+i9gns7fgAy/TH2iuor/ykvttLIW5OJFGpKnw2uk
htGxXyempcCGho3c4QRM
=N54y
-----END PGP SIGNATURE-----

--6a6HBqcTn6KkBVwaWxkSlSErBg0DwbRnb--


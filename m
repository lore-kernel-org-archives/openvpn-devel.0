References: <20170411173133.18060-1-davids@...515...>
	<429bda10-5a65-785f-661e-f4ae2708349f@...1435...>
	<050f70e9-1558-a354-ea36-8b786f0af086@...2080...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <e834186a-1a43-061f-2acb-ab126822013b@...1435...>
Date: Wed, 12 Apr 2017 11:45:09 +0200
MIME-Version: 1.0
In-Reply-To: <050f70e9-1558-a354-ea36-8b786f0af086@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="G07kqn0KGqul4HNNgDuj73kHvEMDtgiAV"
Subject: Re: [Openvpn-devel] [PATCH] Require minimum OpenSSL 1.0.1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--G07kqn0KGqul4HNNgDuj73kHvEMDtgiAV
Content-Type: multipart/mixed; boundary="qWRCKmrDuPsrCKI736O3PFbpUgtOD2iLA";
	protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <e834186a-1a43-061f-2acb-ab126822013b@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Require minimum OpenSSL 1.0.1
References: <20170411173133.18060-1-davids@...515...>
	<429bda10-5a65-785f-661e-f4ae2708349f@...1435...>
	<050f70e9-1558-a354-ea36-8b786f0af086@...2080...>
In-Reply-To: <050f70e9-1558-a354-ea36-8b786f0af086@...2080...>

--qWRCKmrDuPsrCKI736O3PFbpUgtOD2iLA
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 11-04-17 23:56, David Sommerseth wrote:
> On 11/04/17 23:20, Steffan Karger wrote:
>> On 11-04-17 19:31, David Sommerseth wrote:
>>> As RHEL 5 has reached EOL, we no longer need to support OpenSSL v0.9.8.
>>> This also makes it possible to remove a few workaronds which was
>>> needed earlier, as well as some left overs from v0.9.6.
>>>
>>> This also makes ./configure really stop running unless a new enough
>>> OpenSSL library is found.
>>>
>>> Compile tested on RHEL7.3 and RHEL6.7 (mock chroot build), both shipping
>>> openssl-1.0.1e.
>>>
>>> Signed-off-by: David Sommerseth <davids@...515...>
>>> ---
>>>  configure.ac                                                  |  6 +++=
---
>>>  doc/openvpn.8                                                 |  1 -
>>>  .../keying-material-exporter-demo/keyingmaterialexporter.c    |  3 +--
>>>  sample/sample-plugins/log/log_v3.c                            |  3 +--
>>>  src/openvpn/ssl_openssl.c                                     |  3 ---
>>>  src/openvpn/ssl_openssl.h                                     | 11 ---=
--------
>>>  src/openvpn/ssl_verify_openssl.c                              |  6 ++-=
---
>>>  7 files changed, 7 insertions(+), 26 deletions(-)
>>>
> [...snip...]
>>
>> For master: ACK.
>>
>> For release/2.4: I wonder whether we need to keep 0.9.8 support, as
>> SLES11 still ships with 0.9.8h, and has general support until 31 Mar 201=
9.
>=20
> While it is James who insisted on RHEL being the oldest supported distro
> many years ago, I have no issues with keeping SLES *or* RHEL as the
> oldest supported distro, in regards to package dependencies.
>=20
> Do we know if we have a large group of SLES 11 users?  Initially I
> thought it was related to OpenVPN-NL ... until I recalled that
> OPenVPN-NL should be built against mbed TLS :)

Well, I don't care much for legacy support (and for OpenVPN-NL, I don't
care at all, indeed).  I consider you to be our authority on what Linux
platforms we want to support.  Just wanted to point this out so you
could decide on what to do for 2.4.  I'm fine with whatever you decide here.

-Steffan


--qWRCKmrDuPsrCKI736O3PFbpUgtOD2iLA--

--G07kqn0KGqul4HNNgDuj73kHvEMDtgiAV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJY7fcpAAoJEEEwndWOY1w5IXgIAI26k8AJc1pl6NNqNmUwelDe
XQFy0C72/B4VDHtmOkVb/Jybhua7UDVq3J/U/nCwupdZy71Gwiw511+Fs88MlyDs
RgSTtx2Mtzo9e6AChuTJoOGeQEBis88aGTAwYb51iTDtuD8lI2IY2phjKXiJWG7u
iUGU8agBtQD+XscjxYvgSFccTSU4DHWd348JJ6Y3sjTpVocImoYRelhMIaknsqES
F9spG+aRm61/jIzZtVItPIXBnioF3ZRE8Mwl3rE59ikPH81KZfcugxzEccOQRGBa
C9fno/3G+hpEV1ct6a4xQCv2nvTl0Q8k4zzIjvMmCbEbWT8jWo9anglY4osWpCc=
=Gaxk
-----END PGP SIGNATURE-----

--G07kqn0KGqul4HNNgDuj73kHvEMDtgiAV--


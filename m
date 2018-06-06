References: <CAJY0qZKNO_aamQfi56BG_XK2vrOCyPAQf-My1N56qqV7TsUG7A@...278...>
 <eaae68e6-e30d-f63b-59c5-64515c8f8bcd@...1147...>
 <e4a2d28a-ff8d-4797-e0af-3bcf98828cb3@...1856...>
 <CAJY0qZKw+HgQ1vS-W13nw2=gj8d-uxeOqyZia4-gEbaGNTyFLQ@...278...>
 <03a13b39-7b85-0b67-cc94-7b219e6b209f@...1147...>
 <49b53be0-a301-8447-2a0e-0534435e5e87@...1147...>
 <CAJY0qZ+_kEVS_41oOHNX=Wp47LnNhL0HKRZvR75eg7JNW3tLkQ@...278...>
 <20180605184024.GO57262@...1296...>
 <CAJY0qZ+r_fHPW-+BAmj2=2qS=k7vQS+Bto0aHE7EDwcgtdaniA@...278...>
 <20180606070035.GW57262@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <c4cad624-a7e9-6a9f-583f-9de9ade92cfc@...2181...>
Date: Wed, 6 Jun 2018 15:18:03 +0800
MIME-Version: 1.0
In-Reply-To: <20180606070035.GW57262@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FPTr7Y0B57lJAWc4hgjKujyPX8TkrpBGz"
Subject: Re: [Openvpn-devel] Does the OpenVPN protocol itself handle
 windowing?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Derek Zimmer <derek@...2095...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FPTr7Y0B57lJAWc4hgjKujyPX8TkrpBGz
Content-Type: multipart/mixed; boundary="4Afrnq7n9RGujnciEo0rG7T5HCWLya2L6";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>, Derek Zimmer <derek@...2095...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <c4cad624-a7e9-6a9f-583f-9de9ade92cfc@...2181...>
Subject: Re: [Openvpn-devel] Does the OpenVPN protocol itself handle
 windowing?
References: <CAJY0qZKNO_aamQfi56BG_XK2vrOCyPAQf-My1N56qqV7TsUG7A@...278...>
 <eaae68e6-e30d-f63b-59c5-64515c8f8bcd@...1147...>
 <e4a2d28a-ff8d-4797-e0af-3bcf98828cb3@...1856...>
 <CAJY0qZKw+HgQ1vS-W13nw2=gj8d-uxeOqyZia4-gEbaGNTyFLQ@...278...>
 <03a13b39-7b85-0b67-cc94-7b219e6b209f@...1147...>
 <49b53be0-a301-8447-2a0e-0534435e5e87@...1147...>
 <CAJY0qZ+_kEVS_41oOHNX=Wp47LnNhL0HKRZvR75eg7JNW3tLkQ@...278...>
 <20180605184024.GO57262@...1296...>
 <CAJY0qZ+r_fHPW-+BAmj2=2qS=k7vQS+Bto0aHE7EDwcgtdaniA@...278...>
 <20180606070035.GW57262@...1296...>
In-Reply-To: <20180606070035.GW57262@...1296...>

--4Afrnq7n9RGujnciEo0rG7T5HCWLya2L6
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 06/06/18 15:00, Gert Doering wrote:
> For Data mode ("tun -> openvpn -> network -> openvpn -> tun"), we do
> error checking.  As in "if the packet does not pass authentication,
> complain and drop it".  (We *might* do a sequence number check to drop
> out of order packets

I think we only do replay attack checks (ssl.c:crypto_check_replay())
and dropped packets are logged with verb 6.

However, JJ has shown that by adding latency with netem in a LAN he can
emulate the throughput drop, therefore I hardly believe this is the
result of re-ordering and consequent drops.


Cheers,


--=20
Antonio Quartulli


--4Afrnq7n9RGujnciEo0rG7T5HCWLya2L6--

--FPTr7Y0B57lJAWc4hgjKujyPX8TkrpBGz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlsXiqsACgkQB6U8WA7y
zXS5hxAAvn/Yk3klfhu4v1pon5d6N+MI+5iy33BqVybsM2z/Utl0XJlsc/Cb/oeD
7p8ByJh+bEKMczKp+QHGK9f+q2+1x/R3rZHkDJWpxEgKPdcfXBL4spktyzEZnHtb
PVbvjP7t7nbkYP/hOgi0VNZcMD3i5LNJg+qza7Tg9lyCVbhQxY3b0NYTU+fG+AcX
XXu+26vkYDfH6k5g6Y2sEI9/B9iCpY2FP9APx1+3siJiXCHVumBCZPQMMLUwdKrr
84BW60oACsfOpEw+B+iSiqYJIDZOmjSrMhCGtlLc/qMT5E3olrn6nLa4+npbL66X
Fi9CAH/365DPDCPyBDVS7k0UZFbDrdYYSG4l0Vwd3j/rWhmpytpWjHjQrZWIKoEE
zyOSzKHnwHB/kETC8o8UAm1OcWCzVcswSFEGrcGBA/OJbu72ACH7cF7TJLCgzfqu
P+xhkOxMdLx5eMIkdOz2jaLKli8f04yrKNZiJtVjLDuEeWKR2HIp3YKIo3E8uUIl
PceBxw6ehVdw7lDcJeHjxxlyImh54xYLcaQiDvXIFbUtVLBXayWvlmmrjFc+XnsO
TyTompTGAKoI/AuKDf6wg3JSvIJ7AzHT/VW7uTX8uq0fukdHO5IMDKhyiGliCUrJ
zONYGbfZspn6prTJ5fgIIp9pipaW0hR/Hadvbz2la485rqDNwvs=
=BGRf
-----END PGP SIGNATURE-----

--FPTr7Y0B57lJAWc4hgjKujyPX8TkrpBGz--


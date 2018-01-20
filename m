References: <1516423647-21932-1-git-send-email-selva.nair@...277...>
 <201801201336.w0KDajf8027638@...2054...>
 <CAKuzo_hnkVLOLi1sxs_7kbcCKZ6=kbbV+a6njKh4=5LX=R5srA@...278...>
 <20180120165200.GN69387@...1296...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <5fa43bce-203f-1470-d66c-c7739dc8aa6a@...1856...>
Date: Sat, 20 Jan 2018 18:09:13 +0100
MIME-Version: 1.0
In-Reply-To: <20180120165200.GN69387@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vA1i6Ad19PcW2RkabVPWup7ng9lJcDTIi"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add
 SSL_CTX_get_max_proto_version() not in openssl 1.0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vA1i6Ad19PcW2RkabVPWup7ng9lJcDTIi
Content-Type: multipart/mixed; boundary="cul8va6gjsnm2fOcA3gvmXSaC9HhqcfS0";
 protected-headers="v1"
From: Steffan Karger <steffan@...1856...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <5fa43bce-203f-1470-d66c-c7739dc8aa6a@...1856...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add
 SSL_CTX_get_max_proto_version() not in openssl 1.0
References: <1516423647-21932-1-git-send-email-selva.nair@...277...>
 <201801201336.w0KDajf8027638@...2054...>
 <CAKuzo_hnkVLOLi1sxs_7kbcCKZ6=kbbV+a6njKh4=5LX=R5srA@...278...>
 <20180120165200.GN69387@...1296...>
In-Reply-To: <20180120165200.GN69387@...1296...>

--cul8va6gjsnm2fOcA3gvmXSaC9HhqcfS0
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 20-01-18 17:52, Gert Doering wrote:
> On Sat, Jan 20, 2018 at 09:05:50AM -0500, Selva Nair wrote:
>> If/when the TLS1.2+ support for cryptoapicert is ready for merge, is
>> it a candidate for 2.4? Technically its a new feature but considering
>> the "popular belief" that TLS1.1 needs to be shunned, and 2.5 is still
>> far away, its worth considering..
>>
>> In that case this patch would need to be backported to 2.4, so good to
>> know what's the general consensus.
>=20
> I would argue that TLS 1.2 is officially supported by 2.4, and as such
> it's a bug if cryptoapicert doesn't :-)
>=20
> Given that the changes are fairly well localized and will not affect
> other platforms, and are likely to not affect users that do not use
> cryptoapicert, I would tend to "make sure that all we offer works with
> TLS 1.2" -> include in 2.4

Completely agree.  I would like to see this backported to 2.4.

-Steffan


--cul8va6gjsnm2fOcA3gvmXSaC9HhqcfS0--

--vA1i6Ad19PcW2RkabVPWup7ng9lJcDTIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEvBAEBCAAZBQJaY3e9EhxzdGVmZmFuQGthcmdlci5tZQAKCRCYAso9AH7SiPGO
B/9wfVufutk6udFw4jgkjajiu6JzU2nhE2vwZxfmynXtTrwhmDpDWs1x6QPBCz6r
ZqoDZu7/8tslzDYaO6taa4ov2HjPpW9s6GJTHIrhEUZk7Wh+TCjFsAm7ugmFGEi+
E5NCOYnh/j50s/auZwCe4idWmyGnvJ5+wYepi7tYkjow9ntcEh4k1maj6KJAPXgf
AIOxcgQ4TTS0+Pz5XYuuxwbuS/KmDy9SdiOP1Yynvogg3lPX41yT7cyn6mnK8TJn
xORRiietiKgKj3/pU8y/C3ClTbzZ011faBrOCxfGBMjBsevU81ux9W27namKfPYn
I7coX/NI6MbpgmnuiTXkmN0/
=VJAu
-----END PGP SIGNATURE-----

--vA1i6Ad19PcW2RkabVPWup7ng9lJcDTIi--


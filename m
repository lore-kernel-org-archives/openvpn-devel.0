References: <8a2c220c-e169-0cb1-c8b4-3c8af5fab82a@...515...>
 <c573880b-af3b-0876-d00f-70e7a06c69fa@...515...>
 <003a7779-3f07-5335-4fd4-8f62aadf6134@...1918...>
 <20180412082603.GT69387@...1296...>
 <CAKuzo_g9Pabn1JSCXJxTse2u9-Laj+Ejc3mG94xQk=UOT4GUNw@...278...>
 <20180412145052.GC69387@...1296...>
 <e06e75c5-06fb-000f-f5c6-4d1949cf1b45@...1147...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <9ff9a0fd-e5ca-2c53-6094-560caa316aa3@...2181...>
Date: Fri, 13 Apr 2018 09:10:21 +0800
MIME-Version: 1.0
In-Reply-To: <e06e75c5-06fb-000f-f5c6-4d1949cf1b45@...1147...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EkD8UAxvQEXWD37e6TmfQFd2Uc8S6pWHE"
Subject: Re: [Openvpn-devel] Viscosity patch to TAP driver
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>, Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EkD8UAxvQEXWD37e6TmfQFd2Uc8S6pWHE
Content-Type: multipart/mixed; boundary="8fPOFvaaz3wmX2xQoesdLSYGwUJm7IaBu";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Jan Just Keijser <janjust@...1147...>, Gert Doering <gert@...1296...>,
 Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <9ff9a0fd-e5ca-2c53-6094-560caa316aa3@...2181...>
Subject: Re: [Openvpn-devel] Viscosity patch to TAP driver
References: <8a2c220c-e169-0cb1-c8b4-3c8af5fab82a@...515...>
 <c573880b-af3b-0876-d00f-70e7a06c69fa@...515...>
 <003a7779-3f07-5335-4fd4-8f62aadf6134@...1918...>
 <20180412082603.GT69387@...1296...>
 <CAKuzo_g9Pabn1JSCXJxTse2u9-Laj+Ejc3mG94xQk=UOT4GUNw@...278...>
 <20180412145052.GC69387@...1296...>
 <e06e75c5-06fb-000f-f5c6-4d1949cf1b45@...1147...>
In-Reply-To: <e06e75c5-06fb-000f-f5c6-4d1949cf1b45@...1147...>

--8fPOFvaaz3wmX2xQoesdLSYGwUJm7IaBu
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 13/04/18 04:22, Jan Just Keijser wrote:
> Hi,
>=20
> On 12/04/18 16:50, Gert Doering wrote:
>> Hi,
>>
>> On Thu, Apr 12, 2018 at 10:27:08AM -0400, Selva Nair wrote:
>>>>> This change was made not because of any actual performance gains, but
>>>>> because of user reports that certain firewall or AV software tries to
>>>>> QoS the adapter based on its reported adapter speed, which is of
>>>>> course
>>>>> a problem if the VPN connection is capable of more than 100 Mbit.
>> [..]
>>> Or am I mistaken -- does this setting really affect the max throughput?
>> Not normally, but when certain 'helpful' software is around...
>>
>>
> as a side note: there is one thing to keep in mind when changing this:
> Windows calculates its automatic routing metrics based on the adapter
> speed. So if we increase the speed then there are scenarios possible
> where the tun adapter route will take precedence over a lan route : in
> most cases that is what a user would want, but there are (rare)
> scenarios where that could have nasty side effects (including the
> "biting your own tail" problem)

Can't we come up with a reasonable default that works for 99.9% of the
users (i.e. 1Gbps) and allow experts to tweak that? or tweak the metric
(I think this is already possible, given what Selva said)?


Cheers,



--=20
Antonio Quartulli


--8fPOFvaaz3wmX2xQoesdLSYGwUJm7IaBu--

--EkD8UAxvQEXWD37e6TmfQFd2Uc8S6pWHE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlrQA30ACgkQB6U8WA7y
zXQbqA/9EXuvBsCa8r8EL2b18ppwVTSQVuWx31kMxpvXDFdge45XNgR0+9OhkhLF
9RAK5xXHeyCCH0BeHX4p/LfY9Pt73w6XE7bkfdesZd58wk4ubkqz1llxnlR/y6pb
rxd3i/Zt2aR1hF7ZN3RRKYbC3DRfdbR1o3pFsS57nGa4prx6qkquu1JNFIxUpulx
nhhWcdGQWGDSSQqBfCxWsXzI8DPWJzopa+y+kz09RCy8di0Pi+UmiMMUzng/Uw0C
8RFGzoIASXJIIbj3CxrYjip8zHHbZT1XzIUKy7RZP9kc/eu5pYttNevHpZchNRp5
9Bj6h5ZlCFivEdjYE1r1nqbAFU6Ts/WO/JoWuMjuv68oMdGRRN8PgJT6X6lueD3v
4gpWGQhN1ZAuxoSqeTvDRpzWM65RbHusIuewMtCNUjF3/i99XMqPG/4K16LAKSSM
U5YYXGLT3lHYq2PS/LdZjJYbHHDJ4S+CXCA9yNxxvKG0ALhzhCJcB87k+/rbRwPj
1Bt+6h9mttCklJ5N7tH3zJvi5EcABazcZI+Q25AH92XHe9K6A++dHAdS3nf92a1Y
kjaqyCRF2iW0Djhf2bEHFjA+VkFURA81Dhe5Uak60ely6S0hLTuEqele5uFiqQSp
/eEPvQITdOaHGxAW6rGkkCrR+9LTsVVOmuhs7w5vn207oev8ghM=
=1uKD
-----END PGP SIGNATURE-----

--EkD8UAxvQEXWD37e6TmfQFd2Uc8S6pWHE--


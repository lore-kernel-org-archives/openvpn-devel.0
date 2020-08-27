References: <20200813072923.24385-1-eric@...1918...>
 <1fb10dd1-8ddf-c467-21a5-a93e21e6a8ac@...1227...>
 <0a634481-cf3b-de2f-5e34-8f5c5ef16fdc@...1918...>
 <CAKuzo_h_xWf-Jbkow=H3sL_CQw5CC23pw3DxH0Nsydj2f57usg@...278...>
 <dc800745-efe3-0f10-d08f-046fc041c96a@...1918...>
 <CAKuzo_heHMcpRd31Lc=ZHDjPAb3GsQoBQB4iQvXCd7EPTnGEug@...278...>
 <294d779c-44a1-7f4c-c506-5f21dc76e8ac@...1918...>
 <9e1e0324-45a1-d6ab-068a-eff8bb75aef1@...1227...>
 <6d416208-e6f6-a0d9-e7e8-ef757f8893ba@...1918...>
 <4f554f9d-cc69-6ba1-7f99-b3368d68f7ab@...1227...>
 <3beb853d-5fe0-4d32-c013-d2af92f151e9@...1918...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <da8746cc-9415-4668-36b2-f619d05e8525@...1227...>
Date: Thu, 27 Aug 2020 10:46:18 +0200
MIME-Version: 1.0
In-Reply-To: <3beb853d-5fe0-4d32-c013-d2af92f151e9@...1918...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="L8MkyR6B829o0aURM65QxS0ZgVRjuhNGE"
Subject: Re: [Openvpn-devel] [PATCH 1/2] Send auth-fail messages to clients
 on renegotiation failures via auth-token or user-pass expiry
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Eric Thorpe <eric@...1918...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L8MkyR6B829o0aURM65QxS0ZgVRjuhNGE
Content-Type: multipart/mixed; boundary="PoWKIY1Qnk86ATi6JTJIESn5j90g51xI9"

--PoWKIY1Qnk86ATi6JTJIESn5j90g51xI9
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 27.08.20 um 01:57 schrieb Eric Thorpe:
> Hi Arne,
>=20
>> That code/commit message is explicitly talking about renegotiation. So
>> if that is also broken, there seems to be something else wrong.
> You are quite correct, I've muddled this up with a different issue I've
> been working through with Deferred Auth, management should not be a part
> of this discussion.
>=20
>> - Do we send the AUTH_FAILED over the new or the old tls session?
> The AUTH_FAILED is sent in the old (current) tls session, that is of
> course assuming that it is still active at the time of reneg. Normally
> if reneg is done with only keys or an auth-token, there isn't the risk
> of authentication being too slow. If a user takes too long to enter a
> password, or deferred auth is in use, the server can sigterm the user on
> it's end before authentication is complete and we have the same result.
> With this said though, the configuration can be adjusted to give the
> user a grace period on the server, so that specific scenario isn't
> something that needs to be handled in my opinion as it can be tuned in
> the configuration.
>=20
>> - Do we establish the data channel (key_method_2_write) before writing
>> the key?
> This is the question I specifically ignored as I'm not sure why it's
> relevant to plugin/script authentication. key_method_2_write, unless I'm
> mistaken (and I'm happy to be corrected here),

client starts with key_method2_write, then server does _read and then
_write again and after that client does _read. See also
(https://github.com/OpenVPN/openvpn/blob/master/doc/doxygen/doc_key_generat=
ion.h)

After the write2 from the server and read2 from client is done, the
client can assume that the keys from that TLS session are valid.

> is client side. The
> client knows it's time to renegotiate as part of it's regular wake up
> routines or server trigger, of which key_method_2_write is called and
> queries for the user/pass (either by management, file, terminal, etc),
> and then pushes it all to the server. Unlike the initial connection
> process however, a push_request does not follow this information push,
> so if authentication fails at the server end, there is no indication of
> such and we end up with desync.

Yeah, that sounds about right.

>> understand the implications and whether the patch is really
>> fixing the root cause or just band aiding the symptoms.
> This I can't answer. I don't think it's a band aid, however there are
> still scenarios this will not cover as mentioned above. Someone with
> more in depth knowledge will need to help review this patch to determine
> if this is a fix, or indeed a band aid to a deeper problem that needs to
> be reviewed.
>=20
> With this in mind, I'm afraid I have spent enough time on this. We will
> continue to maintain this patch in our fork. In the mean time, we've
> tried to do the right thing by submitting a patch for an issue we've
> discovered and brought to the mailing lists attention a long time ago
> now, and then do the right thing again updating it when requested. I
> will leave the conversation here and leave it to the repo maintainers
> from here whether they wish to use this patch as is, modify it to their
> needs or NAK it for a better future solution. I will keep an eye out for
> a new patch and assist in it's testing if someone wishes to improve upon
> this.
I will put this on my TODO list. Maybe I can also cleanup the code to
make this a litte bit less of a mess.

Arne


--PoWKIY1Qnk86ATi6JTJIESn5j90g51xI9--

--L8MkyR6B829o0aURM65QxS0ZgVRjuhNGE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl9HctoACgkQFRhsZwKx
RFR0jw/+Id6dfRNk3InZePry0fvHth2/NVk3fR2WuSBNnlAEWh080nJzJxoggcVQ
0eRReJGktkhfFQyi6GNRB/Mp1Y6STnnCF9KGE+tR3rERpbMmQQhEduy/VPq0PgEi
ubz0aByUXKjVocP0JjTYDKSwZXpdp3hGBp21n0lV+QcxoFs87QW03qncAMC5CdWt
Du78WyYnoHzz0YWO7n97iE007KK3j4ayl3jKlp6NsAACOxlZmCYJVLfrkc+gPhr8
uxNBXSUviUyiTmKhRiNxoHLzTYqCwZwuhOIzTFlRWq7dEVijpj129ueeKzBLIIZH
PX8BEyrSy5VKpJonHtfA5UDCli/ZS/KoMKv0DYFcs7/TCzNVzEb49ktOTECyCM5f
FX38yEfZrC82iQFx5/9ULV2xnf5Tquq4Oo1wYrfC8sG6jkQjbDViYrprBytKiC4H
lk9g4CI1qUMYmC1xLBs62zlHaNu9AaB2l+KHFzDCWz8rT3rIM3hbNSn8yanfZruB
ecincBsC5LZ9vdk/GZ1ni9koFCV4t/n9AcISMXHa0F9zeiBaHiZ04QnGl1WtuBEV
ogtSdixByWIzlXyzdd/fVlCp/LcTFXx0avgSzZkHZ0OKaiKNRCNnAcQnv9rDfS0p
7H6TUewPD+Yd48+Z5rDEvh4qwVyiFWI65Kt+SJh9s78yHFKJEYk=
=9Mke
-----END PGP SIGNATURE-----

--L8MkyR6B829o0aURM65QxS0ZgVRjuhNGE--


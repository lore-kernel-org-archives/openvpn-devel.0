References: <20181121101019.1801-1-arne@...1227...>
 <20181121101019.1801-2-arne@...1227...>
 <0d26a044-711f-ed55-0755-cbea2ab9da54@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <78e9d738-4139-c3c2-b575-6d7ed563f5da@...1227...>
Date: Mon, 17 Feb 2020 14:22:54 +0100
MIME-Version: 1.0
In-Reply-To: <0d26a044-711f-ed55-0755-cbea2ab9da54@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AGwN9b15iO8P9wEK64rJN7f5vsgTyfgCU"
Subject: Re: [Openvpn-devel] [PATCH v4 01/13] client-connect: Split
 multi_connection_established into separate functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AGwN9b15iO8P9wEK64rJN7f5vsgTyfgCU
Content-Type: multipart/mixed; boundary="5sBGCg2EETzoD9dyPUFfnVfeumMJ9Qnu7"

--5sBGCg2EETzoD9dyPUFfnVfeumMJ9Qnu7
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

>> This elimininates and the big reformatting done before eliminates the fo=
llow
>> up patch with indentation changes.
>>
>> The original patch already replaces some instances of option_permission_=
mask
>> with CLIENT_CONNECT_OPT_MASK. The V3 version does this more consequently.
>>
>=20
> Did you mean "more consistently" ?

Hm both work I think. Can change it to cosistently.


>>          options_server_import(&mi->context.options,
>>                                dc_file,
>>                                D_IMPORT_ERRORS|M_OPTERR,
>> -                              option_permissions_mask,
>> +                              CLIENT_CONNECT_OPT_MASK,
>=20
> every invocation of options_server_import() gets CLIENT_CONNECT_OPT_MASK
> as parameter. Do we really need it to be a parameter?


The call in init.c does gets OPT_P_DEFAULT & ~OPT_P_PLUGIN instead.

               mi->context.c2.es);
>>              }
>> @@ -1716,21 +1714,19 @@ multi_client_connect_post_plugin(struct multi_co=
ntext *m,
>>  static void
>>  multi_client_connect_mda(struct multi_context *m,
>>                           struct multi_instance *mi,
>> -                         const struct buffer_list *config,
>> -                         unsigned int option_permissions_mask,
>>                           unsigned int *option_types_found)
>>  {
>> -    if (config)
>> +    if (mi->cc_config)
>=20
> Also getting rid of config and using mi->cc_config looks like something
> that could go in its own patch, as it is quite unrelated.
>=20

Okay. That will be a tiny patch.



>> -
>> +#define CLIENT_CONNECT_OPT_MASK (OPT_P_INSTANCE | OPT_P_INHERIT   \
>> +                                 |OPT_P_PUSH | OPT_P_TIMER | OPT_P_CONF=
IG   \
>> +                                 |OPT_P_ECHO | OPT_P_COMP | OPT_P_SOCKF=
LAGS)
>>=20=20
>>  static inline bool
>>  multi_process_outgoing_link_dowork(struct multi_context *m, struct mult=
i_instance *mi, const unsigned int mpp_flags)
>>
>=20
>=20
> other than those few comments the change "looks" reasonable. However, do
> we have a way to test the code being changed? I mean all the code being
> changed (not just the part used by the deferred connect logic)
>=20
> Because even though it all looks sane, we might be breaking something els=
e.
>

I am not aware of a test suite other than manually testing the changes
what I did with the whole patch set but not with individual commits.

Arne


--5sBGCg2EETzoD9dyPUFfnVfeumMJ9Qnu7--

--AGwN9b15iO8P9wEK64rJN7f5vsgTyfgCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl5Kk64ACgkQFRhsZwKx
RFQCCQ/8Dr7R8ioVUWGv6wzUkktSF1/rkMslmMNnSsNrqWBKXh3k1Yo3iAPIO261
gexwaV7WoSG5DJ8q0imHKBCHbxACsum6eyaDGJnid2xdMkg3qEE5La8AeXEAh7av
bmDGW2UJFDv6lyDCjZAd1Z3iePj8T+a62/XmkwyLyGeexCbM8XxJQpSrq9cTTPo5
1nGevYwSJKllS6nj382MMjov/XY5fN//7BLCndhV2hYWoreU65OhbE8CV95t80h7
BGwe49jtldY9CYKYt8rrkMpHzbHL0hHkmPbdtLNYU3jnt/ahZqSdTgwc8Qgc2/Uy
YLgUKRh9Mt5SP8hwM6YyD+AfHUCD1bDfpsvjVJVqN9EBL9H7BXtjak6K8UWwW8GD
OJJoNxOc0c5jwXueM8Gkn84s8d/wDpPBm7l+z47Kz+jPAUydazqnHjsT805fMZT9
DgpjDtfINdGVCL78FZJjBKhMPSoMx3KnwrP7WhwOu8RnNFTDhoYHictmL+vCv4nd
qW/LRFe9WmrbB2uO9hCiTf5rIgpUrs5Dq2eWOyIENk7lv+IJqAPP9xbVg0nqvJqv
U41Yxk+cuFHnb4E3ZnRPDJroO6g3HS44YtuIreMf5fW+QwPVSBo3pZBRJHmR6ZQS
RpJoRR3hfr6d/O/YUAMNcjxtTTTF1JQDwjEgy5/GDXiJF+bAkGI=
=yi53
-----END PGP SIGNATURE-----

--AGwN9b15iO8P9wEK64rJN7f5vsgTyfgCU--


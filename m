References: <20190510121114.30468-1-arne@...1227...>
 <8a5f5265-f1fe-35e6-32dc-085dbeb039bc@...1147...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <009b7240-24eb-c35c-d820-14a777f1075e@...1227...>
Date: Fri, 10 May 2019 17:19:34 +0200
MIME-Version: 1.0
In-Reply-To: <8a5f5265-f1fe-35e6-32dc-085dbeb039bc@...1147...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Kx6GfbbeIKJqEx6y7cFZ8pUFtBMVAIhoy"
Subject: Re: [Openvpn-devel] [PATCH v3 0/7] Auth token patches v3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Kx6GfbbeIKJqEx6y7cFZ8pUFtBMVAIhoy
Content-Type: multipart/mixed; boundary="FB6yYVYIKlMa3egLJh1EO27beBvRqm2DA";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Jan Just Keijser <janjust@...1147...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <009b7240-24eb-c35c-d820-14a777f1075e@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3 0/7] Auth token patches v3
References: <20190510121114.30468-1-arne@...1227...>
 <8a5f5265-f1fe-35e6-32dc-085dbeb039bc@...1147...>
In-Reply-To: <8a5f5265-f1fe-35e6-32dc-085dbeb039bc@...1147...>

--FB6yYVYIKlMa3egLJh1EO27beBvRqm2DA
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 10.05.19 um 17:14 schrieb Jan Just Keijser:
> Hi Arne,
>=20
> On 10/05/19 14:11, Arne Schwabe wrote:
>> This is the v3 of the patch series. I choose to resend all of the patches
>> so they all cleanly apply. Since the patches depend on the changes
>> suggested
>> to --genkey, I made them part of the patch series. The other patches have
>> been updated to incoperate the feedback.
>>
>> Arne Schwabe (7):
>> =C2=A0=C2=A0 Write key to stdout if filename is not given
>> =C2=A0=C2=A0 Implement --genkey type keyfile syntax and migrate tls-cryp=
t-v2
>> =C2=A0=C2=A0 Add pem_read_key_file variant that allows a random key
>> =C2=A0=C2=A0 Rewrite auth-token-gen to be based on HMAC based tokens
>> =C2=A0=C2=A0 Implement a permanent session id in auth-token
>> =C2=A0=C2=A0 Sent indication that a session is expired to clients
>> =C2=A0=C2=A0 Implement unit tests for auth-gen-token
>>
>>
> I 've been busy with the --genkey patch and was wondering how/when to
> include any auth-token stuff; should I wait for this patch to be ACKed
> and then do a git clone again?=C2=A0 or can I include your patch beforeha=
nd
> (if so, which git magic is needed for that?)

Sorry that, I missed from your last mail that you also wanted to prepare
a patch and basically implemented what I think you proposed in your last
email to get a an updated patch set of auth-token :(

That was bad coordination from my part. Personally I don't care which
way around we do this. Either you send your patch too and I review that
one or you review my patch and then eitehr accept it, force my to redo
it or declare it so ppor that you have to send your patch anyway.

Arne


--FB6yYVYIKlMa3egLJh1EO27beBvRqm2DA--

--Kx6GfbbeIKJqEx6y7cFZ8pUFtBMVAIhoy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlzVloYACgkQFRhsZwKx
RFRoZRAApeiRHkVl17PHvXH+yBmV181YZLtlq3j055S4YHAjC7B+bBODgXFHmWb5
kN4uIMPOcl8vjAhgqvmDMugbZFxBCJ/ZCsDTqP67HK4GJM2y2j1f2DgLIlgddRnG
hoQK+o6koz+BAyBgspyKYNOY9+ENZIo6oAu/t/c69d7UJG+v8MiYmX2zCjnbLQq4
68/FMYQkBHxh3qd+Re8A0XoPgA0Pm68WJUePo2LwIoJ8BlbVZ9zvkaboKBpFSImb
swTmdOUYesL9IDZYkvB1sOXBObZDgWdH5Yvbgkp05GiEqrc810/GhUdGQYN+Fs9i
qUibRUp6OfkidmyIlY+ZZxgKmlS512apa6JsR5sI8mtWPjmiJMEYPVtOtTAzHYiW
LNkH/PrBL62Vr6BqecsOODemheOnvRzoeDd4xCDpeLubB44e2kbIHpm+vWTA3MEO
4uXPV6x0lZbzCuDmiYnKt9FnpnR0reRHZji8A5RBvoNiXIaKXmhBWwHm+EsLCavw
LnzKST5WVPTfZOjxaZFRBOuQKd23H2/WxwgUS/+ym/EqA7J5CyPD5UYH1iB91fKJ
2bQENSg4Ed3KQFzmW2bkIuysLz9k5ChLb+8+yvE4X3z1wYeDXfv23UAvDbo9zb52
Y+bOCmfc3dMWnqjoEokvlIjXbF1AGFjEtFK7K0IlLHILXSM2EY0=
=FYPA
-----END PGP SIGNATURE-----

--Kx6GfbbeIKJqEx6y7cFZ8pUFtBMVAIhoy--


Message-ID: <eaaa8190-3418-c155-4459-a12e853c9eda@...68...>
Date: Sun, 7 Nov 2021 13:24:55 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20211107090138.3150187-1-arne@...1227...>
 <5fa04cf3-c7b7-7e26-db95-ee734b0001ea@...68...>
 <9ab3a55c-062a-d849-0434-0df90bea4224@...1227...>
From: Matthias Andree <matthias.andree@...68...>
In-Reply-To: <9ab3a55c-062a-d849-0434-0df90bea4224@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Completely remove DES checks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 07.11.21 um 13:13 schrieb Arne Schwabe:
> Am 07.11.21 um 12:57 schrieb Matthias Andree:
>> Am 07.11.21 um 10:01 schrieb Arne Schwabe:
>>> We already removed the check in d67658fee for OpenSSL 3.0. This
>>> removes the
>>> checks entirely for all crypto libraries.
>>>
>>> Signed-off-by: Arne Schwabe <arne@...1227...>
>>> ---
>>> =C2=A0 src/openvpn/crypto.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 15 --------
>>> =C2=A0 src/openvpn/crypto_backend.h | 28 ---------------
>>> =C2=A0 src/openvpn/crypto_mbedtls.c | 56 ------------------------------
>>> =C2=A0 src/openvpn/crypto_openssl.c | 66
>>> ------------------------------------
>>> =C2=A0 4 files changed, 165 deletions(-)
>>> -=C2=A0=C2=A0=C2=A0 /* DES is deprecated and the method to even check t=
he keys is
>>> deprecated
>>> -=C2=A0=C2=A0=C2=A0=C2=A0 * in OpenSSL 3.0. Instead of checking for the=
 16
>>> weak/semi-weak keys
>>> -=C2=A0=C2=A0=C2=A0=C2=A0 * we just accept them in OpenSSL 3.0 since th=
e risk of
>>> randomly getting
>>> -=C2=A0=C2=A0=C2=A0=C2=A0 * these is pretty low (and "all DES keys are =
weak" anyway) */
>>> -=C2=A0=C2=A0=C2=A0 return true;
>>
>> Should not we nuke DES altogether in that case? Or am I misunderstanding
>> the patch?
>
>
> The patch removes checking for weak keys and making DES just like any
> other CBC cipher and not doing extra checks for this. It basically
> removes the special treatment of DES.


After this, do we have any DES functionality left in OpenVPN? If so, we
should remove it.



MIME-Version: 1.0
In-Reply-To: <CAFHpkQG9UOK7U+=-dh8EVmeo141iYZMx4JdTNVLz_fssrjWkKg@...278...>
References: <1515378076-5774-1-git-send-email-selva.nair@...277...>
 <CAFHpkQG9UOK7U+=-dh8EVmeo141iYZMx4JdTNVLz_fssrjWkKg@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 10 Jan 2018 14:40:07 -0500
Message-ID: <CAKuzo_hsH5yU6mCTP0+gvODPj=SCJh4aJ_bn--k4bSRzMquOnA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 0/2] Make cryptoapicert work with TLS 1.2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Tue, Jan 9, 2018 at 1:00 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:
>
>
>
> 2018-01-08 7:21 GMT+05:00 <selva.nair@...277...>:
>>
>> From: Selva Nair <selva.nair@...277...>
>>
>> Hi,
>>
>> I am not sure how receptive the crypto maintaineres are to the
>> idea of adding more code into cryptoapi.c, but here goes:
>>
>> I've been wanting to add TLS 1.2 support for certs in the
>> Windows cert store using management external key. But that's
>> a lot more work than extending cryptoapicert support. And,
>> rather surprsingly, it turns out that the CNG API for signing is
>> easy to use (well after some groping in the dark..) and doesn't
>> take much to implement.
>>
>> So these patches..
>>
>> The first patch is not really related and to make the existing code
>> "openssl-1.1 ready" (missed by past patches as no one probably builds
>> Windows binary with 1.1..).
>
>
> there was an agreement on one of the recent community meetings to
> gracefully deprecate both libressl and openssl-1.0.X in favour of
> openssl-1.1.X
>
> so, we should learn how to build windows binary with 1.1.X :)

I had tested the patch with 1.1 and needed only minor changes to build
script. See https://github.com/selvanair/openvpn-build

pkcs11-helper build showed some warnings but I did not check further
as I usually disable it.

Selva


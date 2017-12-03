References: <20171202085438.2393-1-a@...2181...>
 <CAKuzo_hgmFaE8ygqJ18YfP+WL+gaVh8yjnNCU0P0zQ=meOPeTg@...278...>
 <e0935209-c578-aa2c-a236-e1fee8452345@...2181...>
 <CAKuzo_h3Kq7A+ETd-GOsx_Mhv-LHBP-z8sb8OqD0nJBED6y5AQ@...278...>
 <CAKuzo_gCcxfr7jC27E=pymP04bYiPUSMhXkWF=qHte4DpwJ+ow@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <ab2b6226-677b-ea26-64c3-43c0599c4cfb@...2181...>
Date: Sun, 3 Dec 2017 11:46:37 +0800
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gCcxfr7jC27E=pymP04bYiPUSMhXkWF=qHte4DpwJ+ow@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7LmeW3pclc9uD7ABQ9WJanH3ca82vwQ5N"
Subject: Re: [Openvpn-devel] Fwd: [PATCH v2] ifconfig-ipv6(-push): allow
 using hostnames
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7LmeW3pclc9uD7ABQ9WJanH3ca82vwQ5N
Content-Type: multipart/mixed; boundary="BjAnsdKMpdDT32okw9RoRNAX7Ft2M966L";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Selva Nair <selva.nair@...277...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <ab2b6226-677b-ea26-64c3-43c0599c4cfb@...2181...>
Subject: Re: [Openvpn-devel] Fwd: [PATCH v2] ifconfig-ipv6(-push): allow using
 hostnames
References: <20171202085438.2393-1-a@...2181...>
 <CAKuzo_hgmFaE8ygqJ18YfP+WL+gaVh8yjnNCU0P0zQ=meOPeTg@...278...>
 <e0935209-c578-aa2c-a236-e1fee8452345@...2181...>
 <CAKuzo_h3Kq7A+ETd-GOsx_Mhv-LHBP-z8sb8OqD0nJBED6y5AQ@...278...>
 <CAKuzo_gCcxfr7jC27E=pymP04bYiPUSMhXkWF=qHte4DpwJ+ow@...278...>
In-Reply-To: <CAKuzo_gCcxfr7jC27E=pymP04bYiPUSMhXkWF=qHte4DpwJ+ow@...278...>

--BjAnsdKMpdDT32okw9RoRNAX7Ft2M966L
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 03/12/17 11:39, Selva Nair wrote:
> oops forgot to cc the list..
>=20
> ---------- Forwarded message ----------
> From: Selva Nair <selva.nair@...277...>
> Date: Sat, Dec 2, 2017 at 10:16 PM
> Subject: Re: [Openvpn-devel] [PATCH v2] ifconfig-ipv6(-push): allow using
> hostnames
> To: Antonio Quartulli <a@...2181...>
>=20
>=20
> Hi,
>=20
> On Sat, Dec 2, 2017 at 9:25 PM, Antonio Quartulli <a@...2181...> wrote:
>=20
>> Hi,
>>
>> On 03/12/17 04:27, Selva Nair wrote:
>>
>>>> +    /* we need to modify the hostname received as input, but we don't
>>>> want to
>>>> +     * touch it directly as it might be a constant string.
>>>> +     *
>>>> +     * Therefore, we clone the string here and free it at the end of
>> the
>>>> +     * function */
>>>> +    var_host =3D strdup(hostname);
>>>> +    ASSERT(var_host);
>>>>
>>>
>>> I think ASSERT should be used only to catch errors in coding logic,
>>> not for plausible runtime errors like this. Especially since this happe=
ns
>>> on the server, no reason to terminate the process here.
>>>
>>> Instead, log an error (M_NONFTAL|M_ERRNO will do nicely) and return -1
>>> or goto out. The option parser will log a generic warning, but still
>> useful
>>> to log here using M_ERRNO for more specific info.
>>>
>>
>> I agree. I am also not a big fan of ASSERT(). I think I had copy/pasted
>> this chunk of code from somewhere else (and consider that this patch is
>> quite old even though I have re-sent it now).
>>
>> I will get rid of the ASSERTs.
>>
>>> Alternatively one could use a buffer on the stack --  easy to do as good
>>> old dns names are limited in size (255 octets max?) and the current
>> option
>>> parser also limits the argument passed here to < 255 bytes. But if we
>>> support
>>> internationalized domain names (currently we do not, do we?) and if the
>> line
>>> length in option parser is ever increased, a much larger buffer would be
>>> needed.
>>
>> Are you sure we have a limit of 255 octects? I am not so sure. Anyway,
>> this is not extremely important for now.
>>
>=20
> Yes, not important for this patch and stdup is anyway fine as long as we =
do
> not
> ASSERT.
>=20
> The 255 byte limit comes from the config file or option parser which reads
> the
> input from ccd or client-connect script output. The length of a line is
> limited
> to  #define OPTION_LINE_SIZE 256 in options.h

oh ok. thanks for showing this.


>=20
>=20
>>>
>>>
>>>> +
>>>> +    /* check if this hostname has a /bits suffix */
>>>> +    sep =3D strchr(var_host , '/');
>>>> +    if (sep)
>>>> +    {
>>>> +        bits =3D strtoul(sep + 1, &endp, 10);
>>>
>>>
>>> There are a number of such type coercions in the patch
>>> (ulong to uint8_t, size_t  to unit8_t etc.) that some compilers (aka
>> MSVC:)
>>> may warn about, but I do not personally care. All are safe and delibera=
te
>>> except for the nitpicking below.
>>>
>>> +        if ((*endp !=3D '\0') || (bits > max_bits))
>>>
>>>
>>> That (bits > max_bits) check will not catch many input errors, as the
>>> input is  already truncated to uint8_t. For example, /255 will be flagg=
ed
>>> as an error, but /256 will pass as 0.
>>>
>>
>> These are probably all copy/paste from other parts of the code. So the
>> logic here is also used in other parts of the code. If we believe this
>> is not the proper way to handle these cases, I'd suggest to take a note
>> and fix these behaviors with a dedicated patch.
>>
>=20
> Please bear with me: Quoting from the patch:
>=20
> -    char *sep, *endp;
> -    int bits;
> -    struct in6_addr t_network;
>=20
> So, the original code had bits defined as int, so why change to unit8_t?
> Changing the original int to unsigned int would've made sense
> as we are parsing using strtoul and returning the result in an unsigned i=
nt.
> But uint8_t brings in hardly any gain and causes all those regressions and
> type conversions I pointed out..

right. I am converting bits to unsigned long (which is what is returned
by strtoul()) and left max_bits as uint8_t.


Cheers,


--=20
Antonio Quartulli


--BjAnsdKMpdDT32okw9RoRNAX7Ft2M966L--

--7LmeW3pclc9uD7ABQ9WJanH3ca82vwQ5N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlojc50ACgkQB6U8WA7y
zXRUow//fpC7S8lXsFnDM38mz79iHoXUhy1HuRT82k/Cm7Rph6C498v9b2yUpzEm
92Wg42vZHVn3pdQBWWFXnrksEV4+64yAXrM+y1uf28KciDDOGcNKim47R6dG2/JV
jVaFM5ffOND8JATIIQAGNFOd0cGC3YFeB+ywhIHEx+Nhg9ZWtDarPikDBqhj+0yj
31o4oFtD5lo3RVErxk6C7v4OD4o4WBCbpN9ZDcvj67aZbJ0yk66j0FhsQluNkJ+s
vKHB7uCZV3r030EyWX725XVFiSXiPULQ7o+ufBtYEeWoko4LRht8utzGFjhwbpUs
uRrFN03fK5F67IL01FDKsnmutMu40EncSaAVD//ByMP+2lx7YUKTV2FDJfROYuR8
/VxvChPI+I+qiYrUtKIl0t/JJdJvKsX757EJnLnyxf2LvRhTdRxqkcnUvpl2iD91
kQLbDY3mUI57SnZF7go8qHupyMsGhUfKqoQMdAD7nL1WLJ2gPvWBFCIGQIp0qfKt
RfX2UdhzbvbK4AemxdoW1MXmiPUW/2hMFgmo+JaFPaLPXQGxPIUAJPg0gZF2U8x3
/AOTMa6FJvvfeBURXD/MrSFOuwKfWP1JCrX/YGUyKdoPfzATi4Om/EBbMduUuEjN
e5E38IrHpXnokTqiVWrJYatMq/rOzd40Scm1EJ6gFZzJEWrD3jc=
=mpvk
-----END PGP SIGNATURE-----

--7LmeW3pclc9uD7ABQ9WJanH3ca82vwQ5N--


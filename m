MIME-Version: 1.0
In-Reply-To: <CA+kHd+cWb7AxjFjXMTnZOQ9v44GmVo1U7-qM+CfFW-vKiukCsw@...278...>
References: <CA+kHd+cXMJoy3yc=Z=8SM=gf75FDUXVuTWDUMiVZ9WAuA3bjyA@...278...>
	<CAOazyz3UGaFto=MySJY=hqCRzu9UR19bpZbEUJH+XA-osXij=w@...278...>
	<CA+kHd+cWb7AxjFjXMTnZOQ9v44GmVo1U7-qM+CfFW-vKiukCsw@...278...>
Date: Sun, 17 Jun 2012 14:12:11 +0300
Message-ID: <CAOazyz3_+_df91FpF59O566qq2sqK5h+ObZ3MpXg-fDmH7fZxg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] PATCH: SSL Engine support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Thomas Habets <thomas@...1731...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

Why do we need to crypto_init_lib_engine() twice? Can you please take
a look at init_crypto_pre:: init_crypto_pre()?

I also think crypto_init_lib_engine() should not return the engine...
as won't it simpler to use ENGINE_by_id() at
ssl_openssl.c::tls_ctx_load_priv_file()?

Alon.

On Sun, Jun 17, 2012 at 1:02 PM, Thomas Habets <thomas@...1731...> wrote:
> Hi.
>
> Ah yes, I first made the patch to an older version where some of these
> things don't apply, and then forward-ported it.
>
> How about this?
> ---------
> Add support for SSL engine loading the private key.
>
> Option 'engine' is used to specify the name of the engine that
> will load the private key.
>
> For example this can be "tpm" to use the OpenSSL TPM engine module
> (libengine-tpm-openssl in Debian).
>
> It defaults to the built-in UI methods because openssl-tpm-engine
> doesn't yet support user data being sent to the callback functions.
> A patch for that on its way to them.
>
> Some more details:
> http://blog.habets.pp.se/2012/02/TPM-backed-SSL
>
> Signed-off-by: Thomas Habets <habets@...410...>
>
>
>
> On 17 June 2012 01:11, Alon Bar-Lev <alon.barlev@...277...> wrote:
>> Hello,
>>
>> It is a good idea.
>> But first, please remove the emacs stuff.
>>
>> Now, I see that the ENGINE_load_builtin_engines() is already called at
>> crypto_openssl.c::crypto_init_lib_engine, is there any require to
>> duplicate this?
>>
>> There is already "engine" option, available only to polarssl, it can
>> easily and correct way be used also for openssl, instead of having
>> another option.
>>
>> What do you think?
>> Alon.
>>
>>
>> On Sun, Jun 17, 2012 at 2:50 AM, Thomas Habets <thomas@...1731...> wrote:
>>> Patch attached.
>>>
>>> Add support for SSL engine loading the private key.
>>>
>>> Added option 'key-engine' specifying the name of the engine that
>>> will load the private key.
>>>
>>> For example this can be "tpm" to use the OpenSSL TPM engine module
>>> (libengine-tpm-openssl in Debian).
>>>
>>> It defaults to the built-in UI methods because openssl-tpm-engine
>>> doesn't yet support user data being sent to the callback functions.
>>> A patch for that on its way to them.
>>>
>>> Some more details:
>>> http://blog.habets.pp.se/2012/02/TPM-backed-SSL
>>>
>>> Signed-off-by: Thomas Habets <habets@...410...>
>>>
>>> --
>>> typedef struct me_s {
>>> =C2=A0char name[] =C2=A0 =C2=A0 =C2=A0=3D { "Thomas Habets" };
>>> =C2=A0char email[] =C2=A0 =C2=A0 =3D { "thomas@...1732..." };
>>> =C2=A0char kernel[] =C2=A0 =C2=A0=3D { "Linux" };
>>> =C2=A0char *pgpKey[] =C2=A0 =3D { "http://www.habets.pp.se/pubkey.txt" =
};
>>> =C2=A0char pgp[] =3D { "A8A3 D1DD 4AE0 8467 7FDE =C2=A00945 286A E90A A=
D48 E854" };
>>> =C2=A0char coolcmd[] =C2=A0 =3D { "echo '. ./_&. ./_'>_;. ./_" };
>>> } me_t;
>>>
>>> -----------------------------------------------------------------------=
-------
>>> Live Security Virtual Conference
>>> Exclusive live event will cover all the ways today's security and
>>> threat landscape has changed and how IT managers can respond. Discussio=
ns
>>> will include endpoint security, mobile security and the latest in malwa=
re
>>> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
>>> _______________________________________________
>>> Openvpn-devel mailing list
>>> Openvpn-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>>
>
>
>
> --
> typedef struct me_s {
> =C2=A0char name[] =C2=A0 =C2=A0 =C2=A0=3D { "Thomas Habets" };
> =C2=A0char email[] =C2=A0 =C2=A0 =3D { "thomas@...1732..." };
> =C2=A0char kernel[] =C2=A0 =C2=A0=3D { "Linux" };
> =C2=A0char *pgpKey[] =C2=A0 =3D { "http://www.habets.pp.se/pubkey.txt" };
> =C2=A0char pgp[] =3D { "A8A3 D1DD 4AE0 8467 7FDE =C2=A00945 286A E90A AD4=
8 E854" };
> =C2=A0char coolcmd[] =C2=A0 =3D { "echo '. ./_&. ./_'>_;. ./_" };
> } me_t;


MIME-Version: 1.0
In-Reply-To: <CAOazyz1ecBaD7RGKK7KgH+qufkOdg-1+-Vs8waQyF++VEh4ong@...278...>
References: <CA+kHd+cXMJoy3yc=Z=8SM=gf75FDUXVuTWDUMiVZ9WAuA3bjyA@...278...>
	<CAOazyz3UGaFto=MySJY=hqCRzu9UR19bpZbEUJH+XA-osXij=w@...278...>
	<CA+kHd+cWb7AxjFjXMTnZOQ9v44GmVo1U7-qM+CfFW-vKiukCsw@...278...>
	<CAOazyz3_+_df91FpF59O566qq2sqK5h+ObZ3MpXg-fDmH7fZxg@...278...>
	<CA+kHd+fSgXENX_wvK=majBUs5ZumYkyHbKjrhrRSZyvDUMO6yQ@...278...>
	<CAOazyz1ecBaD7RGKK7KgH+qufkOdg-1+-Vs8waQyF++VEh4ong@...278...>
From: Thomas Habets <thomas@...1731...>
Date: Sun, 17 Jun 2012 22:45:10 +0100
Message-ID: <CA+kHd+d+0UEYNoudn41svdVZ_KeqNjAfPtX7D34WB7br1QB7bw@...278...>
Content-Type: multipart/mixed; boundary=f46d043c8132f969ac04c2b1f7b0
Subject: Re: [Openvpn-devel] PATCH: SSL Engine support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

--f46d043c8132f969ac04c2b1f7b0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Those questions are why I'd prefer to reuse the already loaded ENGINE
(engine_persist in crypto_openssl), but it didn't appear to be
exported from the crypto backend (crypto_backend.h), which is why my
previous patch added exporting of it (by means of the init function).

All versions of the patch works with non-static modules. The TPM one
I'm using is a .so file.
http://packages.debian.org/squeeze/amd64/libengine-tpm-openssl/filelist

Do you want a separate ENGINE struct or not?
If same, how should it be exported from crypto_openssl to ssl_openssl?
I don't see any non-static accessor.
If different, call setup_engine() from ssl_openssl.c (meaning turning
setup_engine() non-static)?

I was hesitant to create new non-statics in crypto_openssl, but one
easy solution is of course to just make
crypto_openssl.c::engine_persist non-static and use it directly, as
seen in attached patch.

Seems I don't need to call ENGINE_init() at all. The attached patch
works, at least.

I appreciate the code discipline. Really I do. :-)

Regards,
Thomas

On 17 June 2012 22:04, Alon Bar-Lev <alon.barlev@...277...> wrote:
> Yes, almost :)
>
> Won't it better to call ENGINE_init at setup_engine() or at
> try_load_engine() instead of at tls_ctx_load_priv_file()? It is just
> that tls_ctx_load_priv_file() can be called more than once, while the
> init should be called once, right?
> Are you sure all works well if engine is not statically linked?
> What about ENGINE_finish() at proper place?
>
> Thank you for your patience,
> Alon Bar-Lev.
>
>
> On Sun, Jun 17, 2012 at 11:53 PM, Thomas Habets <thomas@...1731...> wrote:
>> Hi.
>>
>> Need? No. I thought you preferred reusing the loaded/inited ENGINE
>> struct cached by existing code instead of creating a new one.
>>
>> Is the attached patch what you had in mind?
>>
>> (same description/sign-off)
>>
>> Regards,
>> Thomas
>>
>>
>> On 17 June 2012 12:12, Alon Bar-Lev <alon.barlev@...277...> wrote:
>>> Hi,
>>>
>>> Why do we need to crypto_init_lib_engine() twice? Can you please take
>>> a look at init_crypto_pre:: init_crypto_pre()?
>>>
>>> I also think crypto_init_lib_engine() should not return the engine...
>>> as won't it simpler to use ENGINE_by_id() at
>>> ssl_openssl.c::tls_ctx_load_priv_file()?
>>>
>>> Alon.
>>>
>>> On Sun, Jun 17, 2012 at 1:02 PM, Thomas Habets <thomas@...1731...> wrot=
e:
>>>> Hi.
>>>>
>>>> Ah yes, I first made the patch to an older version where some of these
>>>> things don't apply, and then forward-ported it.
>>>>
>>>> How about this?
>>>> ---------
>>>> Add support for SSL engine loading the private key.
>>>>
>>>> Option 'engine' is used to specify the name of the engine that
>>>> will load the private key.
>>>>
>>>> For example this can be "tpm" to use the OpenSSL TPM engine module
>>>> (libengine-tpm-openssl in Debian).
>>>>
>>>> It defaults to the built-in UI methods because openssl-tpm-engine
>>>> doesn't yet support user data being sent to the callback functions.
>>>> A patch for that on its way to them.
>>>>
>>>> Some more details:
>>>> http://blog.habets.pp.se/2012/02/TPM-backed-SSL
>>>>
>>>> Signed-off-by: Thomas Habets <habets@...410...>
>>>>
>>>>
>>>>
>>>> On 17 June 2012 01:11, Alon Bar-Lev <alon.barlev@...277...> wrote:
>>>>> Hello,
>>>>>
>>>>> It is a good idea.
>>>>> But first, please remove the emacs stuff.
>>>>>
>>>>> Now, I see that the ENGINE_load_builtin_engines() is already called at
>>>>> crypto_openssl.c::crypto_init_lib_engine, is there any require to
>>>>> duplicate this?
>>>>>
>>>>> There is already "engine" option, available only to polarssl, it can
>>>>> easily and correct way be used also for openssl, instead of having
>>>>> another option.
>>>>>
>>>>> What do you think?
>>>>> Alon.
>>>>>
>>>>>
>>>>> On Sun, Jun 17, 2012 at 2:50 AM, Thomas Habets <thomas@...1731...> wr=
ote:
>>>>>> Patch attached.
>>>>>>
>>>>>> Add support for SSL engine loading the private key.
>>>>>>
>>>>>> Added option 'key-engine' specifying the name of the engine that
>>>>>> will load the private key.
>>>>>>
>>>>>> For example this can be "tpm" to use the OpenSSL TPM engine module
>>>>>> (libengine-tpm-openssl in Debian).
>>>>>>
>>>>>> It defaults to the built-in UI methods because openssl-tpm-engine
>>>>>> doesn't yet support user data being sent to the callback functions.
>>>>>> A patch for that on its way to them.
>>>>>>
>>>>>> Some more details:
>>>>>> http://blog.habets.pp.se/2012/02/TPM-backed-SSL
>>>>>>
>>>>>> Signed-off-by: Thomas Habets <habets@...410...>
>>>>>>
>>>>>> --
>>>>>> typedef struct me_s {
>>>>>> =C2=A0char name[] =C2=A0 =C2=A0 =C2=A0=3D { "Thomas Habets" };
>>>>>> =C2=A0char email[] =C2=A0 =C2=A0 =3D { "thomas@...1732..." };
>>>>>> =C2=A0char kernel[] =C2=A0 =C2=A0=3D { "Linux" };
>>>>>> =C2=A0char *pgpKey[] =C2=A0 =3D { "http://www.habets.pp.se/pubkey.tx=
t" };
>>>>>> =C2=A0char pgp[] =3D { "A8A3 D1DD 4AE0 8467 7FDE =C2=A00945 286A E90=
A AD48 E854" };
>>>>>> =C2=A0char coolcmd[] =C2=A0 =3D { "echo '. ./_&. ./_'>_;. ./_" };
>>>>>> } me_t;
>>>>>>
>>>>>> --------------------------------------------------------------------=
----------
>>>>>> Live Security Virtual Conference
>>>>>> Exclusive live event will cover all the ways today's security and
>>>>>> threat landscape has changed and how IT managers can respond. Discus=
sions
>>>>>> will include endpoint security, mobile security and the latest in ma=
lware
>>>>>> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
>>>>>> _______________________________________________
>>>>>> Openvpn-devel mailing list
>>>>>> Openvpn-devel@lists.sourceforge.net
>>>>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>>>>>
>>>>
>>>>
>>>>
>>>> --
>>>> typedef struct me_s {
>>>> =C2=A0char name[] =C2=A0 =C2=A0 =C2=A0=3D { "Thomas Habets" };
>>>> =C2=A0char email[] =C2=A0 =C2=A0 =3D { "thomas@...1732..." };
>>>> =C2=A0char kernel[] =C2=A0 =C2=A0=3D { "Linux" };
>>>> =C2=A0char *pgpKey[] =C2=A0 =3D { "http://www.habets.pp.se/pubkey.txt"=
 };
>>>> =C2=A0char pgp[] =3D { "A8A3 D1DD 4AE0 8467 7FDE =C2=A00945 286A E90A =
AD48 E854" };
>>>> =C2=A0char coolcmd[] =C2=A0 =3D { "echo '. ./_&. ./_'>_;. ./_" };
>>>> } me_t;



--=20
typedef struct me_s {
=C2=A0char name[] =C2=A0 =C2=A0 =C2=A0=3D { "Thomas Habets" };
=C2=A0char email[] =C2=A0 =C2=A0 =3D { "thomas@...1732..." };
=C2=A0char kernel[] =C2=A0 =C2=A0=3D { "Linux" };
=C2=A0char *pgpKey[] =C2=A0 =3D { "http://www.habets.pp.se/pubkey.txt" };
=C2=A0char pgp[] =3D { "A8A3 D1DD 4AE0 8467 7FDE =C2=A00945 286A E90A AD48 =
E854" };
=C2=A0char coolcmd[] =C2=A0 =3D { "echo '. ./_&. ./_'>_;. ./_" };
} me_t;

--f46d043c8132f969ac04c2b1f7b0
Content-Type: application/octet-stream; name="engine-patch-4.patch"
Content-Disposition: attachment; filename="engine-patch-4.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h3kn6ei30

ZGlmZiAtLWdpdCBhL3NyYy9vcGVudnBuL2NyeXB0b19vcGVuc3NsLmMgYi9zcmMvb3BlbnZwbi9j
cnlwdG9fb3BlbnNzbC5jCmluZGV4IDUzNDI1MDIuLjQwOTk5ZmUgMTAwNjQ0Ci0tLSBhL3NyYy9v
cGVudnBuL2NyeXB0b19vcGVuc3NsLmMKKysrIGIvc3JjL29wZW52cG4vY3J5cHRvX29wZW5zc2wu
YwpAQCAtMTE1LDcgKzExNSw3IEBAIGNpcGhlcl9vayAoY29uc3QgY2hhciogbmFtZSkKIAogc3Rh
dGljIGJvb2wgZW5naW5lX2luaXRpYWxpemVkID0gZmFsc2U7IC8qIEdMT0JBTCAqLwogCi1zdGF0
aWMgRU5HSU5FICplbmdpbmVfcGVyc2lzdCA9IE5VTEw7ICAgLyogR0xPQkFMICovCitFTkdJTkUg
KmVuZ2luZV9wZXJzaXN0ID0gTlVMTDsgICAvKiBHTE9CQUwgKi8KIAogLyogVHJ5IHRvIGxvYWQg
YW4gZW5naW5lIGluIGEgc2hhcmVhYmxlIGxpYnJhcnkgKi8KIHN0YXRpYyBFTkdJTkUgKgpkaWZm
IC0tZ2l0IGEvc3JjL29wZW52cG4vc3NsX29wZW5zc2wuYyBiL3NyYy9vcGVudnBuL3NzbF9vcGVu
c3NsLmMKaW5kZXggOGYzNTMyNS4uMzIwZmQyMCAxMDA2NDQKLS0tIGEvc3JjL29wZW52cG4vc3Ns
X29wZW5zc2wuYworKysgYi9zcmMvb3BlbnZwbi9zc2xfb3BlbnNzbC5jCkBAIC00NjMsOSArNDYz
LDE5IEBAIHRsc19jdHhfbG9hZF9wcml2X2ZpbGUgKHN0cnVjdCB0bHNfcm9vdF9jdHggKmN0eCwg
Y29uc3QgY2hhciAqcHJpdl9rZXlfZmlsZQogICBpZiAoIWluKQogICAgIGdvdG8gZW5kOwogCi0g
IHBrZXkgPSBQRU1fcmVhZF9iaW9fUHJpdmF0ZUtleSAoaW4sIE5VTEwsCi0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3NsX2N0eC0+ZGVmYXVsdF9wYXNzd2RfY2FsbGJhY2ssCi0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3NsX2N0eC0+ZGVmYXVsdF9wYXNzd2Rf
Y2FsbGJhY2tfdXNlcmRhdGEpOworI2lmZGVmIEhBVkVfT1BFTlNTTF9FTkdJTkUKKyAgaWYgKGVu
Z2luZV9wZXJzaXN0KSB7CisgICAgcGtleSA9IEVOR0lORV9sb2FkX3ByaXZhdGVfa2V5KGVuZ2lu
ZV9wZXJzaXN0LCBwcml2X2tleV9maWxlLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBVSV9PcGVuU1NMKCksIE5VTEwpOworICB9IGVsc2UgeworI2Vsc2UKKyAgeworI2VuZGlm
IC8qIEhBVkVfT1BFTlNTTF9FTkdJTkUgKi8KKyAgICBwa2V5ID0gUEVNX3JlYWRfYmlvX1ByaXZh
dGVLZXkgKGluLCBOVUxMLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Ns
X2N0eC0+ZGVmYXVsdF9wYXNzd2RfY2FsbGJhY2ssCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzc2xfY3R4LT5kZWZhdWx0X3Bhc3N3ZF9jYWxsYmFja191c2VyZGF0YSk7Cisg
IH0KKwogICBpZiAoIXBrZXkpCiAgICAgZ290byBlbmQ7CiAKZGlmZiAtLWdpdCBhL3NyYy9vcGVu
dnBuL3NzbF9vcGVuc3NsLmggYi9zcmMvb3BlbnZwbi9zc2xfb3BlbnNzbC5oCmluZGV4IGZjMjA1
MmMuLjU5YTFlNDcgMTAwNjQ0Ci0tLSBhL3NyYy9vcGVudnBuL3NzbF9vcGVuc3NsLmgKKysrIGIv
c3JjL29wZW52cG4vc3NsX29wZW5zc2wuaApAQCAtMzIsNiArMzIsMTAgQEAKIAogI2luY2x1ZGUg
PG9wZW5zc2wvc3NsLmg+CiAKKyNpZiBIQVZFX09QRU5TU0xfRU5HSU5FCisjaW5jbHVkZSA8b3Bl
bnNzbC9lbmdpbmUuaD4KKyNlbmRpZgorCiAvKioKICAqIFN0cnVjdHVyZSB0aGF0IHdyYXBzIHRo
ZSBUTFMgY29udGV4dC4gQ29udGVudHMgZGlmZmVyIGRlcGVuZGluZyBvbiB0aGUKICAqIFNTTCBs
aWJyYXJ5IHVzZWQuCkBAIC01Miw2ICs1Niw5IEBAIHN0cnVjdCBrZXlfc3RhdGVfc3NsIHsKICAq
IHBvaW50ZXIgYmFjayB0byBwYXJlbnQuCiAgKi8KIGV4dGVybiBpbnQgbXlkYXRhX2luZGV4OyAv
KiBHTE9CQUwgKi8KKyNpZmRlZiBIQVZFX09QRU5TU0xfRU5HSU5FCitleHRlcm4gRU5HSU5FICpl
bmdpbmVfcGVyc2lzdDsgLyogR0xPQkFMICovCisjZW5kaWYKIAogdm9pZCBvcGVuc3NsX3NldF9t
eWRhdGFfaW5kZXggKHZvaWQpOwogCg==
--f46d043c8132f969ac04c2b1f7b0--


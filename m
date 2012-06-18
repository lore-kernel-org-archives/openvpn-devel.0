MIME-Version: 1.0
In-Reply-To: <CAOazyz3OhsY_98+6+oU3NCqZm7xAfhkAMoYg3q-UJS2rx=r2vQ@...278...>
References: <CA+kHd+cXMJoy3yc=Z=8SM=gf75FDUXVuTWDUMiVZ9WAuA3bjyA@...278...>
	<CAOazyz3UGaFto=MySJY=hqCRzu9UR19bpZbEUJH+XA-osXij=w@...278...>
	<CA+kHd+cWb7AxjFjXMTnZOQ9v44GmVo1U7-qM+CfFW-vKiukCsw@...278...>
	<CAOazyz3_+_df91FpF59O566qq2sqK5h+ObZ3MpXg-fDmH7fZxg@...278...>
	<CA+kHd+fSgXENX_wvK=majBUs5ZumYkyHbKjrhrRSZyvDUMO6yQ@...278...>
	<CAOazyz1ecBaD7RGKK7KgH+qufkOdg-1+-Vs8waQyF++VEh4ong@...278...>
	<CA+kHd+d+0UEYNoudn41svdVZ_KeqNjAfPtX7D34WB7br1QB7bw@...278...>
	<CAOazyz2_WdWTwd-iA2PCyU+8+J1tDUkbOAovv2nFgtPuc6UXqw@...278...>
	<CAOazyz3OhsY_98+6+oU3NCqZm7xAfhkAMoYg3q-UJS2rx=r2vQ@...278...>
From: Thomas Habets <thomas@...1731...>
Date: Mon, 18 Jun 2012 20:12:09 +0100
Message-ID: <CA+kHd+ev-=AxSnx0e278b-ViD_tnWUpSicuHCVe-26=hviUv=Q@...278...>
Content-Type: multipart/mixed; boundary=f46d04428eee7cf15b04c2c3f287
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

--f46d04428eee7cf15b04c2c3f287
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I can confirm that it works. I need to specify both engine and
engine-pvk in the config though. If "engine" is not specified then
ENGINE_load_builtin_engines() is never called. If you had this in mind
then I think "engine-pvk" should require "engine". (just putting
"engine" in the config file is enough, without parameter)

Other nits:
The call to ENGINE_load_private_key() should probably be surrounded by
#ifdef HAVE_OPENSSL_ENGINE.

Presumably without HAVE_OPENSSL_ENGINE the ENGINE struct and
openssl/engine.h doesn't exist, so they should be #ifdeffed too.

Fixed this, and added SRK password option, in attached patch to be
applied on top of your engine branch. If option is not given then the
default UI functions are called (for linux at console that means
prompt the user).

(the SRK password is not really a secret. If you have it then you're
allowed to do operations  with the TPM chip. But you have to supply
the tpm-sealed data when doing the operation. I've seen several
recommendations to just leave it blank)

On 18 June 2012 15:22, Alon Bar-Lev <alon.barlev@...277...> wrote:
> Oh...
> And I forgot mentioning that the UI method should be solved, using the
> default is not something that is usable for openvpn.
> Can you please take care of this?
>
> Alon.
>
> On Mon, Jun 18, 2012 at 3:25 PM, Alon Bar-Lev <alon.barlev@...277...> wro=
te:
>> Hello Thomas,
>>
>> I did not have the global variable in mind :)
>>
>> I thought about your initial suggestion of specific private key
>> engine, and it has value, so I added a new option.
>>
>> I propose the following [1], the problem is that I cannot test this out.
>>
>> While looking on the current engine implementation, there is a need to
>> pass the pre/post strings, so there is more work to be done here, I
>> will do this later.
>>
>> I also don't understand the need of using the dynamic in
>> try_load_engine, but this will be resolved by supporting pre/post
>> strings.
>>
>> Please review and test, should reach the same functionality as you requi=
re.
>>
>> Regards,
>> Alon.
>>
>> [1] https://github.com/alonbl/openvpn/compare/master...engine
>>
>> On Mon, Jun 18, 2012 at 12:45 AM, Thomas Habets <thomas@...1731...> wrot=
e:
>>> Those questions are why I'd prefer to reuse the already loaded ENGINE
>>> (engine_persist in crypto_openssl), but it didn't appear to be
>>> exported from the crypto backend (crypto_backend.h), which is why my
>>> previous patch added exporting of it (by means of the init function).
>>>
>>> All versions of the patch works with non-static modules. The TPM one
>>> I'm using is a .so file.
>>> http://packages.debian.org/squeeze/amd64/libengine-tpm-openssl/filelist
>>>
>>> Do you want a separate ENGINE struct or not?
>>> If same, how should it be exported from crypto_openssl to ssl_openssl?
>>> I don't see any non-static accessor.
>>> If different, call setup_engine() from ssl_openssl.c (meaning turning
>>> setup_engine() non-static)?
>>>
>>> I was hesitant to create new non-statics in crypto_openssl, but one
>>> easy solution is of course to just make
>>> crypto_openssl.c::engine_persist non-static and use it directly, as
>>> seen in attached patch.
>>>
>>> Seems I don't need to call ENGINE_init() at all. The attached patch
>>> works, at least.
>>>
>>> I appreciate the code discipline. Really I do. :-)
>>>
>>> Regards,
>>> Thomas
>>>
>>> On 17 June 2012 22:04, Alon Bar-Lev <alon.barlev@...277...> wrote:
>>>> Yes, almost :)
>>>>
>>>> Won't it better to call ENGINE_init at setup_engine() or at
>>>> try_load_engine() instead of at tls_ctx_load_priv_file()? It is just
>>>> that tls_ctx_load_priv_file() can be called more than once, while the
>>>> init should be called once, right?
>>>> Are you sure all works well if engine is not statically linked?
>>>> What about ENGINE_finish() at proper place?
>>>>
>>>> Thank you for your patience,
>>>> Alon Bar-Lev.
>>>>
>>>>
>>>> On Sun, Jun 17, 2012 at 11:53 PM, Thomas Habets <thomas@...1731...> wr=
ote:
>>>>> Hi.
>>>>>
>>>>> Need? No. I thought you preferred reusing the loaded/inited ENGINE
>>>>> struct cached by existing code instead of creating a new one.
>>>>>
>>>>> Is the attached patch what you had in mind?
>>>>>
>>>>> (same description/sign-off)
>>>>>
>>>>> Regards,
>>>>> Thomas
>>>>>
>>>>>
>>>>> On 17 June 2012 12:12, Alon Bar-Lev <alon.barlev@...277...> wrote:
>>>>>> Hi,
>>>>>>
>>>>>> Why do we need to crypto_init_lib_engine() twice? Can you please take
>>>>>> a look at init_crypto_pre:: init_crypto_pre()?
>>>>>>
>>>>>> I also think crypto_init_lib_engine() should not return the engine...
>>>>>> as won't it simpler to use ENGINE_by_id() at
>>>>>> ssl_openssl.c::tls_ctx_load_priv_file()?
>>>>>>
>>>>>> Alon.
>>>>>>
>>>>>> On Sun, Jun 17, 2012 at 1:02 PM, Thomas Habets <thomas@...1731...> w=
rote:
>>>>>>> Hi.
>>>>>>>
>>>>>>> Ah yes, I first made the patch to an older version where some of th=
ese
>>>>>>> things don't apply, and then forward-ported it.
>>>>>>>
>>>>>>> How about this?
>>>>>>> ---------
>>>>>>> Add support for SSL engine loading the private key.
>>>>>>>
>>>>>>> Option 'engine' is used to specify the name of the engine that
>>>>>>> will load the private key.
>>>>>>>
>>>>>>> For example this can be "tpm" to use the OpenSSL TPM engine module
>>>>>>> (libengine-tpm-openssl in Debian).
>>>>>>>
>>>>>>> It defaults to the built-in UI methods because openssl-tpm-engine
>>>>>>> doesn't yet support user data being sent to the callback functions.
>>>>>>> A patch for that on its way to them.
>>>>>>>
>>>>>>> Some more details:
>>>>>>> http://blog.habets.pp.se/2012/02/TPM-backed-SSL
>>>>>>>
>>>>>>> Signed-off-by: Thomas Habets <habets@...410...>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 17 June 2012 01:11, Alon Bar-Lev <alon.barlev@...277...> wrote:
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> It is a good idea.
>>>>>>>> But first, please remove the emacs stuff.
>>>>>>>>
>>>>>>>> Now, I see that the ENGINE_load_builtin_engines() is already calle=
d at
>>>>>>>> crypto_openssl.c::crypto_init_lib_engine, is there any require to
>>>>>>>> duplicate this?
>>>>>>>>
>>>>>>>> There is already "engine" option, available only to polarssl, it c=
an
>>>>>>>> easily and correct way be used also for openssl, instead of having
>>>>>>>> another option.
>>>>>>>>
>>>>>>>> What do you think?
>>>>>>>> Alon.
>>>>>>>>
>>>>>>>>
>>>>>>>> On Sun, Jun 17, 2012 at 2:50 AM, Thomas Habets <thomas@...1731...>=
 wrote:
>>>>>>>>> Patch attached.
>>>>>>>>>
>>>>>>>>> Add support for SSL engine loading the private key.
>>>>>>>>>
>>>>>>>>> Added option 'key-engine' specifying the name of the engine that
>>>>>>>>> will load the private key.
>>>>>>>>>
>>>>>>>>> For example this can be "tpm" to use the OpenSSL TPM engine module
>>>>>>>>> (libengine-tpm-openssl in Debian).
>>>>>>>>>
>>>>>>>>> It defaults to the built-in UI methods because openssl-tpm-engine
>>>>>>>>> doesn't yet support user data being sent to the callback function=
s.
>>>>>>>>> A patch for that on its way to them.
>>>>>>>>>
>>>>>>>>> Some more details:
>>>>>>>>> http://blog.habets.pp.se/2012/02/TPM-backed-SSL
>>>>>>>>>
>>>>>>>>> Signed-off-by: Thomas Habets <habets@...410...>
>>>>>>>>>
>>>>>>>>> --
>>>>>>>>> typedef struct me_s {
>>>>>>>>> =C2=A0char name[] =C2=A0 =C2=A0 =C2=A0=3D { "Thomas Habets" };
>>>>>>>>> =C2=A0char email[] =C2=A0 =C2=A0 =3D { "thomas@...1732..." };
>>>>>>>>> =C2=A0char kernel[] =C2=A0 =C2=A0=3D { "Linux" };
>>>>>>>>> =C2=A0char *pgpKey[] =C2=A0 =3D { "http://www.habets.pp.se/pubkey=
.txt" };
>>>>>>>>> =C2=A0char pgp[] =3D { "A8A3 D1DD 4AE0 8467 7FDE =C2=A00945 286A =
E90A AD48 E854" };
>>>>>>>>> =C2=A0char coolcmd[] =C2=A0 =3D { "echo '. ./_&. ./_'>_;. ./_" };
>>>>>>>>> } me_t;
>>>>>>>>>
>>>>>>>>> -----------------------------------------------------------------=
-------------
>>>>>>>>> Live Security Virtual Conference
>>>>>>>>> Exclusive live event will cover all the ways today's security and
>>>>>>>>> threat landscape has changed and how IT managers can respond. Dis=
cussions
>>>>>>>>> will include endpoint security, mobile security and the latest in=
 malware
>>>>>>>>> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
>>>>>>>>> _______________________________________________
>>>>>>>>> Openvpn-devel mailing list
>>>>>>>>> Openvpn-devel@lists.sourceforge.net
>>>>>>>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> typedef struct me_s {
>>>>>>> =C2=A0char name[] =C2=A0 =C2=A0 =C2=A0=3D { "Thomas Habets" };
>>>>>>> =C2=A0char email[] =C2=A0 =C2=A0 =3D { "thomas@...1732..." };
>>>>>>> =C2=A0char kernel[] =C2=A0 =C2=A0=3D { "Linux" };
>>>>>>> =C2=A0char *pgpKey[] =C2=A0 =3D { "http://www.habets.pp.se/pubkey.t=
xt" };
>>>>>>> =C2=A0char pgp[] =3D { "A8A3 D1DD 4AE0 8467 7FDE =C2=A00945 286A E9=
0A AD48 E854" };
>>>>>>> =C2=A0char coolcmd[] =C2=A0 =3D { "echo '. ./_&. ./_'>_;. ./_" };
>>>>>>> } me_t;
>>>
>>>
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

--f46d04428eee7cf15b04c2c3f287
Content-Type: application/octet-stream; name="engine-patch-engine-1.patch"
Content-Disposition: attachment; filename="engine-patch-engine-1.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h3lx73yt0

ZGlmZiAtLWdpdCBhL2RvYy9vcGVudnBuLjggYi9kb2Mvb3BlbnZwbi44CmluZGV4IGQ1NzQyNDku
LjY4YzQ5MmEgMTAwNjQ0Ci0tLSBhL2RvYy9vcGVudnBuLjgKKysrIGIvZG9jL29wZW52cG4uOApA
QCAtMzcyNyw2ICszNzI3LDEwIEBAIHN0YW5kYWxvbmUgb3B0aW9uIHRvIGxpc3QgdGhlIGNyeXB0
byBlbmdpbmVzIHdoaWNoIGFyZQogc3VwcG9ydGVkIGJ5IE9wZW5TU0wuCiAuXCIqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioKIC5UUAorLkIg
XC1cLWVuZ2luZS1wdmstcGFzc3dvcmQgcGFzc3dvcmQKK1Bhc3N3b3JkIGZvciBPcGVuU1NMIGhh
cmR3YXJlIGNyeXB0byBlbmdpbmUgcHJpdmF0ZSBrZXkgb3BlcmF0aW9ucy4KKy5cIioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgorLlRQCiAu
QiBcLVwtbm8tcmVwbGF5CiAoQWR2YW5jZWQpIERpc2FibGUgT3BlblZQTidzIHByb3RlY3Rpb24g
YWdhaW5zdCByZXBsYXkgYXR0YWNrcy4KIERvbid0IHVzZSB0aGlzIG9wdGlvbiB1bmxlc3MgeW91
IGFyZSBwcmVwYXJlZCB0byBtYWtlCmRpZmYgLS1naXQgYS9zcmMvb3BlbnZwbi9vcHRpb25zLmMg
Yi9zcmMvb3BlbnZwbi9vcHRpb25zLmMKaW5kZXggMTdlZGJmNS4uMjE0YzQ4NiAxMDA2NDQKLS0t
IGEvc3JjL29wZW52cG4vb3B0aW9ucy5jCisrKyBiL3NyYy9vcGVudnBuL29wdGlvbnMuYwpAQCAt
NTM0LDggKzUzNCwxMCBAQCBzdGF0aWMgY29uc3QgY2hhciB1c2FnZV9tZXNzYWdlW10gPQogI2lm
ZGVmIEVOQUJMRV9DUllQVE9fT1BFTlNTTAogICAiLS1lbmdpbmUgW25hbWVdICAgICA6IEVuYWJs
ZSBPcGVuU1NMIGhhcmR3YXJlIGNyeXB0byBlbmdpbmUgZnVuY3Rpb25hbGl0eVxuIgogICAiICAg
ICAgICAgICAgICAgICAgICAgIGFzIGRlZmF1bHQuXG4iCi0gICItLWVuZ2luZV9wdmsgW25hbWVd
IDogRW5hYmxlIE9wZW5TU0wgaGFyZHdhcmUgY3J5cHRvIGVuZ2luZSBmdW5jdGlvbmFsaXR5XG4i
CisgICItLWVuZ2luZS1wdmsgW25hbWVdIDogRW5hYmxlIE9wZW5TU0wgaGFyZHdhcmUgY3J5cHRv
IGVuZ2luZSBmdW5jdGlvbmFsaXR5XG4iCiAgICIgICAgICAgICAgICAgICAgICAgICAgZm9yIHBy
aXZhdGUga2V5IG9wZXJhdGlvbnMuXG4iCisgICItLWVuZ2luZS1wdmstcGFzc3dvcmQgcGFzc3dv
cmQgOiBQYXNzd29yZCBmb3IgT3BlblNTTCBoYXJkd2FyZSBjcnlwdG9cbiIKKyAgIiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGVuZ2luZSBwcml2YXRlIGtleSBvcGVyYXRpb25zLlxu
IgogI2VuZGlmCiAgICItLW5vLXJlcGxheSAgICAgOiBEaXNhYmxlIHJlcGxheSBwcm90ZWN0aW9u
LlxuIgogICAiLS1tdXRlLXJlcGxheS13YXJuaW5ncyA6IFNpbGVuY2UgdGhlIG91dHB1dCBvZiBy
ZXBsYXkgd2FybmluZ3MgdG8gbG9nIGZpbGUuXG4iCkBAIC0xNTY3LDYgKzE1NjksNyBAQCBzaG93
X3NldHRpbmdzIChjb25zdCBzdHJ1Y3Qgb3B0aW9ucyAqbykKICNpZmRlZiBFTkFCTEVfQ1JZUFRP
X09QRU5TU0wKICAgU0hPV19TVFIgKGVuZ2luZSk7CiAgIFNIT1dfU1RSIChlbmdpbmVfcHZrKTsK
KyAgU0hPV19TVFIgKGVuZ2luZV9wdmtfcGFzc3dvcmQpOwogI2VuZGlmIC8qIEVOQUJMRV9DUllQ
VE9fT1BFTlNTTCAqLwogICBTSE9XX0JPT0wgKHJlcGxheSk7CiAgIFNIT1dfQk9PTCAobXV0ZV9y
ZXBsYXlfd2FybmluZ3MpOwpAQCAtNjQzMyw2ICs2NDM2LDExIEBAIGFkZF9vcHRpb24gKHN0cnVj
dCBvcHRpb25zICpvcHRpb25zLAogICAgICAgVkVSSUZZX1BFUk1JU1NJT04gKE9QVF9QX0dFTkVS
QUwpOwogICAgICAgb3B0aW9ucy0+ZW5naW5lX3B2ayA9IHBbMV07CiAgICAgfSAgCisgIGVsc2Ug
aWYgKHN0cmVxIChwWzBdLCAiZW5naW5lLXB2ay1wYXNzd29yZCIpICYmIHBbMV0pCisgICAgewor
ICAgICAgVkVSSUZZX1BFUk1JU1NJT04gKE9QVF9QX0dFTkVSQUwpOworICAgICAgb3B0aW9ucy0+
ZW5naW5lX3B2a19wYXNzd29yZCA9IHBbMV07CisgICAgfQogI2VuZGlmIC8qIEVOQUJMRV9DUllQ
VE9fT1BFTlNTTCAqLwogI2lmZGVmIEhBVkVfRVZQX0NJUEhFUl9DVFhfU0VUX0tFWV9MRU5HVEgK
ICAgZWxzZSBpZiAoc3RyZXEgKHBbMF0sICJrZXlzaXplIikgJiYgcFsxXSkKZGlmZiAtLWdpdCBh
L3NyYy9vcGVudnBuL29wdGlvbnMuaCBiL3NyYy9vcGVudnBuL29wdGlvbnMuaAppbmRleCBhYWFj
NjM3Li5kN2ExZWRjIDEwMDY0NAotLS0gYS9zcmMvb3BlbnZwbi9vcHRpb25zLmgKKysrIGIvc3Jj
L29wZW52cG4vb3B0aW9ucy5oCkBAIC01MTAsNiArNTEwLDcgQEAgc3RydWN0IG9wdGlvbnMKICAg
aW50IHBybmdfbm9uY2Vfc2VjcmV0X2xlbjsKICAgY29uc3QgY2hhciAqZW5naW5lOwogICBjb25z
dCBjaGFyICplbmdpbmVfcHZrOworICBjb25zdCBjaGFyICplbmdpbmVfcHZrX3Bhc3N3b3JkOwog
ICBib29sIHJlcGxheTsKICAgYm9vbCBtdXRlX3JlcGxheV93YXJuaW5nczsKICAgaW50IHJlcGxh
eV93aW5kb3c7CmRpZmYgLS1naXQgYS9zcmMvb3BlbnZwbi9zc2wuYyBiL3NyYy9vcGVudnBuL3Nz
bC5jCmluZGV4IDhmMGQyYWUuLjQ1NmNkODQgMTAwNjQ0Ci0tLSBhL3NyYy9vcGVudnBuL3NzbC5j
CisrKyBiL3NyYy9vcGVudnBuL3NzbC5jCkBAIC0zNjcsNyArMzY3LDcgQEAgaW5pdF9zc2wgKGNv
bnN0IHN0cnVjdCBvcHRpb25zICpvcHRpb25zLCBzdHJ1Y3QgdGxzX3Jvb3RfY3R4ICpuZXdfY3R4
KQogICAgICAgLyogTG9hZCBQcml2YXRlIEtleSAqLwogICAgICAgaWYgKG9wdGlvbnMtPnByaXZf
a2V5X2ZpbGUpCiAJewotICAgICAgICAgIGlmICgwICE9IHRsc19jdHhfbG9hZF9wcml2X2ZpbGUo
bmV3X2N0eCwgb3B0aW9ucy0+cHJpdl9rZXlfZmlsZSwgb3B0aW9ucy0+cHJpdl9rZXlfZmlsZV9p
bmxpbmUpKQorICAgICAgICAgIGlmICgwICE9IHRsc19jdHhfbG9hZF9wcml2X2ZpbGUobmV3X2N0
eCwgb3B0aW9ucy0+cHJpdl9rZXlfZmlsZSwgb3B0aW9ucy0+ZW5naW5lX3B2a19wYXNzd29yZCwg
b3B0aW9ucy0+cHJpdl9rZXlfZmlsZV9pbmxpbmUpKQogICAgICAgICAgICAgZ290byBlcnI7CiAJ
fQogICAgIH0KZGlmZiAtLWdpdCBhL3NyYy9vcGVudnBuL3NzbF9iYWNrZW5kLmggYi9zcmMvb3Bl
bnZwbi9zc2xfYmFja2VuZC5oCmluZGV4IGQyOGQxYzQuLjc3MzkzYTcgMTAwNjQ0Ci0tLSBhL3Ny
Yy9vcGVudnBuL3NzbF9iYWNrZW5kLmgKKysrIGIvc3JjL29wZW52cG4vc3NsX2JhY2tlbmQuaApA
QCAtMjE1LDcgKzIxNSw5IEBAIHZvaWQgdGxzX2N0eF9mcmVlX2NlcnRfZmlsZSAob3BlbnZwbl94
NTA5X2NlcnRfdCAqeDUwOSk7CiAgKiBAcmV0dXJuIAkJCTEgaWYgYW4gZXJyb3Igb2NjdXJyZWQs
IDAgaWYgcGFyc2luZyB3YXMKICAqIAkJCQlzdWNjZXNzZnVsLgogICovCi1pbnQgdGxzX2N0eF9s
b2FkX3ByaXZfZmlsZSAoc3RydWN0IHRsc19yb290X2N0eCAqY3R4LCBjb25zdCBjaGFyICpwcml2
X2tleV9maWxlCitpbnQgdGxzX2N0eF9sb2FkX3ByaXZfZmlsZSAoc3RydWN0IHRsc19yb290X2N0
eCAqY3R4LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKnByaXZfa2V5
X2ZpbGUsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqZW5naW5lX3B2
a19wYXNzd29yZAogI2lmIEVOQUJMRV9JTkxJTkVfRklMRVMKICAgICAsIGNvbnN0IGNoYXIgKnBy
aXZfa2V5X2ZpbGVfaW5saW5lCiAjZW5kaWYKZGlmZiAtLWdpdCBhL3NyYy9vcGVudnBuL3NzbF9v
cGVuc3NsLmMgYi9zcmMvb3BlbnZwbi9zc2xfb3BlbnNzbC5jCmluZGV4IDBhNzhkNTIuLmY4YWEw
MDUgMTAwNjQ0Ci0tLSBhL3NyYy9vcGVudnBuL3NzbF9vcGVuc3NsLmMKKysrIGIvc3JjL29wZW52
cG4vc3NsX29wZW5zc2wuYwpAQCAtMTM3LDExICsxMzcsMTMgQEAgdm9pZAogdGxzX2N0eF9mcmVl
KHN0cnVjdCB0bHNfcm9vdF9jdHggKmN0eCkKIHsKICAgQVNTRVJUKE5VTEwgIT0gY3R4KTsKKyNp
ZmRlZiBIQVZFX09QRU5TU0xfRU5HSU5FCiAgIGlmIChOVUxMICE9IGN0eC0+ZW5naW5lX3B2aykK
ICAgICB7CiAgICAgICBFTkdJTkVfZnJlZShjdHgtPmVuZ2luZV9wdmspOwogICAgICAgY3R4LT5l
bmdpbmVfcHZrID0gTlVMTDsKICAgICB9CisjZW5kaWYKICAgaWYgKE5VTEwgIT0gY3R4LT5jdHgp
CiAgICAgU1NMX0NUWF9mcmVlIChjdHgtPmN0eCk7CiAgIGN0eC0+Y3R4ID0gTlVMTDsKQEAgLTE5
MSw2ICsxOTMsNyBAQCB0bHNfY3R4X3NldF9vcHRpb25zIChzdHJ1Y3QgdGxzX3Jvb3RfY3R4ICpj
dHgsIGNvbnN0IHN0cnVjdCBvcHRpb25zICpvcHRpb25zKQogI2lmZGVmIEhBVkVfT1BFTlNTTF9F
TkdJTkUKICAgaWYgKG9wdGlvbnMtPmVuZ2luZV9wdmsgIT0gTlVMTCkKICAgICB7CisgICAgICBF
TkdJTkVfbG9hZF9idWlsdGluX2VuZ2luZXMoKTsKICAgICAgIGN0eC0+ZW5naW5lX3B2ayA9IEVO
R0lORV9ieV9pZChvcHRpb25zLT5lbmdpbmVfcHZrKTsKICAgICAgIGlmIChjdHgtPmVuZ2luZV9w
dmsgPT0gTlVMTCkKIAltc2coTV9TU0xFUlIsICJGYWlsZWQgdG8gbG9hZCBwcml2YXRlIGtleSBl
bmdpbmUgJXMiLCBvcHRpb25zLT5lbmdpbmVfcHZrKTsKQEAgLTQ1Myw4ICs0NTYsMTYgQEAgdGxz
X2N0eF9mcmVlX2NlcnRfZmlsZSAoWDUwOSAqeDUwOSkKICAgWDUwOV9mcmVlKHg1MDkpOwogfQog
CitzdGF0aWMgaW50Cit1aV9yZWFkKFVJICp1aSwgVUlfU1RSSU5HICp1aXMpCit7CisgIFVJX3Nl
dF9yZXN1bHQodWksIHVpcywgVUlfZ2V0MF91c2VyX2RhdGEodWkpKTsKKyAgcmV0dXJuIDE7Cit9
CisKIGludAotdGxzX2N0eF9sb2FkX3ByaXZfZmlsZSAoc3RydWN0IHRsc19yb290X2N0eCAqY3R4
LCBjb25zdCBjaGFyICpwcml2X2tleV9maWxlCit0bHNfY3R4X2xvYWRfcHJpdl9maWxlIChzdHJ1
Y3QgdGxzX3Jvb3RfY3R4ICpjdHgsIGNvbnN0IGNoYXIgKnByaXZfa2V5X2ZpbGUsCisgICAgICAg
ICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICplbmdpbmVfcHZrX3Bhc3N3b3JkCiAjaWYgRU5B
QkxFX0lOTElORV9GSUxFUwogICAgICwgY29uc3QgY2hhciAqcHJpdl9rZXlfZmlsZV9pbmxpbmUK
ICNlbmRpZgpAQCAtNDgwLDExICs0OTEsMTkgQEAgdGxzX2N0eF9sb2FkX3ByaXZfZmlsZSAoc3Ry
dWN0IHRsc19yb290X2N0eCAqY3R4LCBjb25zdCBjaGFyICpwcml2X2tleV9maWxlCiAgIGlmICgh
aW4pCiAgICAgZ290byBlbmQ7CiAKKyNpZmRlZiBIQVZFX09QRU5TU0xfRU5HSU5FCiAgIGlmIChj
dHgtPmVuZ2luZV9wdmsgIT0gTlVMTCkKICAgICB7Ci0gICAgICBwa2V5ID0gRU5HSU5FX2xvYWRf
cHJpdmF0ZV9rZXkoY3R4LT5lbmdpbmVfcHZrLCBwcml2X2tleV9maWxlLCBVSV9PcGVuU1NMKCks
IE5VTEwpOworICAgICAgVUlfTUVUSE9EICp1aV9tZXRob2QgPSBVSV9PcGVuU1NMKCk7CisgICAg
ICBpZiAoZW5naW5lX3B2a19wYXNzd29yZCkKKyAgICAgICAgeworICAgICAgICAgIHVpX21ldGhv
ZCA9IFVJX2NyZWF0ZV9tZXRob2QoKGNoYXIqKSJGaXhlZCBlbmdpbmUgcHJpdmtleSBwYXNzd29y
ZCIpOworICAgICAgICAgIFVJX21ldGhvZF9zZXRfcmVhZGVyKHVpX21ldGhvZCwgdWlfcmVhZCk7
CisgICAgICAgIH0KKyAgICAgIHBrZXkgPSBFTkdJTkVfbG9hZF9wcml2YXRlX2tleShjdHgtPmVu
Z2luZV9wdmssIHByaXZfa2V5X2ZpbGUsIHVpX21ldGhvZCwgKHZvaWQqKWVuZ2luZV9wdmtfcGFz
c3dvcmQpOwogICAgIH0KICAgZWxzZQorI2VuZGlmCiAgICAgewogICAgICAgcGtleSA9IFBFTV9y
ZWFkX2Jpb19Qcml2YXRlS2V5IChpbiwgTlVMTCwKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzc2xfY3R4LT5kZWZhdWx0X3Bhc3N3ZF9jYWxsYmFjaywKZGlmZiAtLWdpdCBhL3Ny
Yy9vcGVudnBuL3NzbF9vcGVuc3NsLmggYi9zcmMvb3BlbnZwbi9zc2xfb3BlbnNzbC5oCmluZGV4
IDBhZDNmMjUuLmQ3ZTE5ZTMgMTAwNjQ0Ci0tLSBhL3NyYy9vcGVudnBuL3NzbF9vcGVuc3NsLmgK
KysrIGIvc3JjL29wZW52cG4vc3NsX29wZW5zc2wuaApAQCAtMzEsNyArMzEsOSBAQAogI2RlZmlu
ZSBTU0xfT1BFTlNTTF9IXwogCiAjaW5jbHVkZSA8b3BlbnNzbC9zc2wuaD4KKyNpZmRlZiBIQVZF
X09QRU5TU0xfRU5HSU5FCiAjaW5jbHVkZSA8b3BlbnNzbC9lbmdpbmUuaD4KKyNlbmRpZgogCiAv
KioKICAqIFN0cnVjdHVyZSB0aGF0IHdyYXBzIHRoZSBUTFMgY29udGV4dC4gQ29udGVudHMgZGlm
ZmVyIGRlcGVuZGluZyBvbiB0aGUKQEAgLTM5LDcgKzQxLDkgQEAKICAqLwogc3RydWN0IHRsc19y
b290X2N0eCB7CiAgICAgU1NMX0NUWCAqY3R4OworI2lmZGVmIEhBVkVfT1BFTlNTTF9FTkdJTkUK
ICAgICBFTkdJTkUgKmVuZ2luZV9wdms7CisjZW5kaWYKIH07CiAKIHN0cnVjdCBrZXlfc3RhdGVf
c3NsIHsKZGlmZiAtLWdpdCBhL3NyYy9vcGVudnBuL3NzbF9wb2xhcnNzbC5jIGIvc3JjL29wZW52
cG4vc3NsX3BvbGFyc3NsLmMKaW5kZXggODVjYTdhZC4uNWYyNGEyNCAxMDA2NDQKLS0tIGEvc3Jj
L29wZW52cG4vc3NsX3BvbGFyc3NsLmMKKysrIGIvc3JjL29wZW52cG4vc3NsX3BvbGFyc3NsLmMK
QEAgLTI3Niw3ICsyNzYsOCBAQCB0bHNfY3R4X2ZyZWVfY2VydF9maWxlIChvcGVudnBuX3g1MDlf
Y2VydF90ICp4NTA5KQogfQogCiBpbnQKLXRsc19jdHhfbG9hZF9wcml2X2ZpbGUgKHN0cnVjdCB0
bHNfcm9vdF9jdHggKmN0eCwgY29uc3QgY2hhciAqcHJpdl9rZXlfZmlsZQordGxzX2N0eF9sb2Fk
X3ByaXZfZmlsZSAoc3RydWN0IHRsc19yb290X2N0eCAqY3R4LCBjb25zdCBjaGFyICpwcml2X2tl
eV9maWxlLAorICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqZW5naW5lX3B2a19w
YXNzd29yZAogI2lmIEVOQUJMRV9JTkxJTkVfRklMRVMKICAgICAsIGNvbnN0IGNoYXIgKnByaXZf
a2V5X2ZpbGVfaW5saW5lCiAjZW5kaWYgLyogRU5BQkxFX0lOTElORV9GSUxFUyAqLwo=
--f46d04428eee7cf15b04c2c3f287--


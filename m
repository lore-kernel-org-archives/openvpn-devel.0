MIME-Version: 1.0
In-Reply-To: <CAOazyz3UGaFto=MySJY=hqCRzu9UR19bpZbEUJH+XA-osXij=w@...278...>
References: <CA+kHd+cXMJoy3yc=Z=8SM=gf75FDUXVuTWDUMiVZ9WAuA3bjyA@...278...>
	<CAOazyz3UGaFto=MySJY=hqCRzu9UR19bpZbEUJH+XA-osXij=w@...278...>
From: Thomas Habets <thomas@...1731...>
Date: Sun, 17 Jun 2012 11:02:15 +0100
Message-ID: <CA+kHd+cWb7AxjFjXMTnZOQ9v44GmVo1U7-qM+CfFW-vKiukCsw@...278...>
Content-Type: multipart/mixed; boundary=f46d04428b501f493704c2a826f2
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
Cc: openvpn-devel@lists.sourceforge.net

--f46d04428b501f493704c2a826f2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi.

Ah yes, I first made the patch to an older version where some of these
things don't apply, and then forward-ported it.

How about this?
---------
Add support for SSL engine loading the private key.

Option 'engine' is used to specify the name of the engine that
will load the private key.

For example this can be "tpm" to use the OpenSSL TPM engine module
(libengine-tpm-openssl in Debian).

It defaults to the built-in UI methods because openssl-tpm-engine
doesn't yet support user data being sent to the callback functions.
A patch for that on its way to them.

Some more details:
http://blog.habets.pp.se/2012/02/TPM-backed-SSL

Signed-off-by: Thomas Habets <habets@...410...>



On 17 June 2012 01:11, Alon Bar-Lev <alon.barlev@...277...> wrote:
> Hello,
>
> It is a good idea.
> But first, please remove the emacs stuff.
>
> Now, I see that the ENGINE_load_builtin_engines() is already called at
> crypto_openssl.c::crypto_init_lib_engine, is there any require to
> duplicate this?
>
> There is already "engine" option, available only to polarssl, it can
> easily and correct way be used also for openssl, instead of having
> another option.
>
> What do you think?
> Alon.
>
>
> On Sun, Jun 17, 2012 at 2:50 AM, Thomas Habets <thomas@...1731...> wrote:
>> Patch attached.
>>
>> Add support for SSL engine loading the private key.
>>
>> Added option 'key-engine' specifying the name of the engine that
>> will load the private key.
>>
>> For example this can be "tpm" to use the OpenSSL TPM engine module
>> (libengine-tpm-openssl in Debian).
>>
>> It defaults to the built-in UI methods because openssl-tpm-engine
>> doesn't yet support user data being sent to the callback functions.
>> A patch for that on its way to them.
>>
>> Some more details:
>> http://blog.habets.pp.se/2012/02/TPM-backed-SSL
>>
>> Signed-off-by: Thomas Habets <habets@...410...>
>>
>> --
>> typedef struct me_s {
>> =C2=A0char name[] =C2=A0 =C2=A0 =C2=A0=3D { "Thomas Habets" };
>> =C2=A0char email[] =C2=A0 =C2=A0 =3D { "thomas@...1732..." };
>> =C2=A0char kernel[] =C2=A0 =C2=A0=3D { "Linux" };
>> =C2=A0char *pgpKey[] =C2=A0 =3D { "http://www.habets.pp.se/pubkey.txt" };
>> =C2=A0char pgp[] =3D { "A8A3 D1DD 4AE0 8467 7FDE =C2=A00945 286A E90A AD=
48 E854" };
>> =C2=A0char coolcmd[] =C2=A0 =3D { "echo '. ./_&. ./_'>_;. ./_" };
>> } me_t;
>>
>> ------------------------------------------------------------------------=
------
>> Live Security Virtual Conference
>> Exclusive live event will cover all the ways today's security and
>> threat landscape has changed and how IT managers can respond. Discussions
>> will include endpoint security, mobile security and the latest in malware
>> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>



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

--f46d04428b501f493704c2a826f2
Content-Type: application/octet-stream; name="engine-patch-2.patch"
Content-Disposition: attachment; filename="engine-patch-2.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h3jy1ra20

ZGlmZiAtLWdpdCBhL3NyYy9vcGVudnBuL2NyeXB0b19iYWNrZW5kLmggYi9zcmMvb3BlbnZwbi9j
cnlwdG9fYmFja2VuZC5oCmluZGV4IDFlYWM2MTEuLmQ0OTM0NGUgMTAwNjQ0Ci0tLSBhL3NyYy9v
cGVudnBuL2NyeXB0b19iYWNrZW5kLmgKKysrIGIvc3JjL29wZW52cG4vY3J5cHRvX2JhY2tlbmQu
aApAQCAtNTIsNyArNTIsNyBAQCB2b2lkIGNyeXB0b19jbGVhcl9lcnJvciAodm9pZCk7CiAvKgog
ICogSW5pdGlhbGlzZSB0aGUgZ2l2ZW4gbmFtZWQgY3J5cHRvIGVuZ2luZS4KICAqLwotdm9pZCBj
cnlwdG9faW5pdF9saWJfZW5naW5lIChjb25zdCBjaGFyICplbmdpbmVfbmFtZSk7Cit2b2lkKiBj
cnlwdG9faW5pdF9saWJfZW5naW5lIChjb25zdCBjaGFyICplbmdpbmVfbmFtZSk7CiAKICNpZmRl
ZiBETUFMTE9DCiAvKgpkaWZmIC0tZ2l0IGEvc3JjL29wZW52cG4vY3J5cHRvX29wZW5zc2wuYyBi
L3NyYy9vcGVudnBuL2NyeXB0b19vcGVuc3NsLmMKaW5kZXggNTM0MjUwMi4uN2U5NjE3YyAxMDA2
NDQKLS0tIGEvc3JjL29wZW52cG4vY3J5cHRvX29wZW5zc2wuYworKysgYi9zcmMvb3BlbnZwbi9j
cnlwdG9fb3BlbnNzbC5jCkBAIC0xNjksNyArMTY5LDcgQEAgc2V0dXBfZW5naW5lIChjb25zdCBj
aGFyICplbmdpbmUpCiAKICNlbmRpZiAvKiBIQVZFX09QRU5TU0xfRU5HSU5FICovCiAKLXZvaWQK
K3ZvaWQgKgogY3J5cHRvX2luaXRfbGliX2VuZ2luZSAoY29uc3QgY2hhciAqZW5naW5lX25hbWUp
CiB7CiAjaWYgSEFWRV9PUEVOU1NMX0VOR0lORQpAQCAtMTgzLDYgKzE4Myw3IEBAIGNyeXB0b19p
bml0X2xpYl9lbmdpbmUgKGNvbnN0IGNoYXIgKmVuZ2luZV9uYW1lKQogI2Vsc2UKICAgbXNnIChN
X1dBUk4sICJOb3RlOiBPcGVuU1NMIGhhcmR3YXJlIGNyeXB0byBlbmdpbmUgZnVuY3Rpb25hbGl0
eSBpcyBub3QgYXZhaWxhYmxlIik7CiAjZW5kaWYKKyAgcmV0dXJuICh2b2lkKillbmdpbmVfcGVy
c2lzdDsKIH0KIAogLyoKZGlmZiAtLWdpdCBhL3NyYy9vcGVudnBuL2NyeXB0b19wb2xhcnNzbC5j
IGIvc3JjL29wZW52cG4vY3J5cHRvX3BvbGFyc3NsLmMKaW5kZXggMzk3OGEzYy4uZTUzNzYyMCAx
MDA2NDQKLS0tIGEvc3JjL29wZW52cG4vY3J5cHRvX3BvbGFyc3NsLmMKKysrIGIvc3JjL29wZW52
cG4vY3J5cHRvX3BvbGFyc3NsLmMKQEAgLTU4LDExICs1OCwxMiBAQAogICoKICAqLwogCi12b2lk
Cit2b2lkICoKIGNyeXB0b19pbml0X2xpYl9lbmdpbmUgKGNvbnN0IGNoYXIgKmVuZ2luZV9uYW1l
KQogewogICBtc2cgKE1fV0FSTiwgIk5vdGU6IFBvbGFyU1NMIGhhcmR3YXJlIGNyeXB0byBlbmdp
bmUgZnVuY3Rpb25hbGl0eSBpcyBub3QgIgogICAgICAgImF2YWlsYWJsZSIpOworICByZXR1cm4g
TlVMTDsKIH0KIAogLyoKZGlmZiAtLWdpdCBhL3NyYy9vcGVudnBuL3NzbC5jIGIvc3JjL29wZW52
cG4vc3NsLmMKaW5kZXggMTk1MTJjMC4uYmViYTc4YyAxMDA2NDQKLS0tIGEvc3JjL29wZW52cG4v
c3NsLmMKKysrIGIvc3JjL29wZW52cG4vc3NsLmMKQEAgLTM2Nyw3ICszNjcsNyBAQCBpbml0X3Nz
bCAoY29uc3Qgc3RydWN0IG9wdGlvbnMgKm9wdGlvbnMsIHN0cnVjdCB0bHNfcm9vdF9jdHggKm5l
d19jdHgpCiAgICAgICAvKiBMb2FkIFByaXZhdGUgS2V5ICovCiAgICAgICBpZiAob3B0aW9ucy0+
cHJpdl9rZXlfZmlsZSkKIAl7Ci0gICAgICAgICAgaWYgKDAgIT0gdGxzX2N0eF9sb2FkX3ByaXZf
ZmlsZShuZXdfY3R4LCBvcHRpb25zLT5wcml2X2tleV9maWxlLCBvcHRpb25zLT5wcml2X2tleV9m
aWxlX2lubGluZSkpCisgICAgICAgICAgICBpZiAoMCAhPSB0bHNfY3R4X2xvYWRfcHJpdl9maWxl
KG5ld19jdHgsIG9wdGlvbnMtPmVuZ2luZSwgb3B0aW9ucy0+cHJpdl9rZXlfZmlsZSwgb3B0aW9u
cy0+cHJpdl9rZXlfZmlsZV9pbmxpbmUpKQogICAgICAgICAgICAgZ290byBlcnI7CiAJfQogICAg
IH0KZGlmZiAtLWdpdCBhL3NyYy9vcGVudnBuL3NzbF9iYWNrZW5kLmggYi9zcmMvb3BlbnZwbi9z
c2xfYmFja2VuZC5oCmluZGV4IGYzZTY5ZGQuLjQ3YjUwMjYgMTAwNjQ0Ci0tLSBhL3NyYy9vcGVu
dnBuL3NzbF9iYWNrZW5kLmgKKysrIGIvc3JjL29wZW52cG4vc3NsX2JhY2tlbmQuaApAQCAtMjE0
LDcgKzIxNCw5IEBAIHZvaWQgdGxzX2N0eF9mcmVlX2NlcnRfZmlsZSAob3BlbnZwbl94NTA5X2Nl
cnRfdCAqeDUwOSk7CiAgKiBAcmV0dXJuIAkJCTEgaWYgYW4gZXJyb3Igb2NjdXJyZWQsIDAgaWYg
cGFyc2luZyB3YXMKICAqIAkJCQlzdWNjZXNzZnVsLgogICovCi1pbnQgdGxzX2N0eF9sb2FkX3By
aXZfZmlsZSAoc3RydWN0IHRsc19yb290X2N0eCAqY3R4LCBjb25zdCBjaGFyICpwcml2X2tleV9m
aWxlCitpbnQgdGxzX2N0eF9sb2FkX3ByaXZfZmlsZSAoc3RydWN0IHRsc19yb290X2N0eCAqY3R4
LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKnByaXZfa2V5X2VuZ2lu
ZSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpwcml2X2tleV9maWxl
CiAjaWYgRU5BQkxFX0lOTElORV9GSUxFUwogICAgICwgY29uc3QgY2hhciAqcHJpdl9rZXlfZmls
ZV9pbmxpbmUKICNlbmRpZgpkaWZmIC0tZ2l0IGEvc3JjL29wZW52cG4vc3NsX29wZW5zc2wuYyBi
L3NyYy9vcGVudnBuL3NzbF9vcGVuc3NsLmMKaW5kZXggOGYzNTMyNS4uZDc1NGYwMyAxMDA2NDQK
LS0tIGEvc3JjL29wZW52cG4vc3NsX29wZW5zc2wuYworKysgYi9zcmMvb3BlbnZwbi9zc2xfb3Bl
bnNzbC5jCkBAIC00MzcsNyArNDM3LDggQEAgdGxzX2N0eF9mcmVlX2NlcnRfZmlsZSAoWDUwOSAq
eDUwOSkKIH0KIAogaW50Ci10bHNfY3R4X2xvYWRfcHJpdl9maWxlIChzdHJ1Y3QgdGxzX3Jvb3Rf
Y3R4ICpjdHgsIGNvbnN0IGNoYXIgKnByaXZfa2V5X2ZpbGUKK3Rsc19jdHhfbG9hZF9wcml2X2Zp
bGUgKHN0cnVjdCB0bHNfcm9vdF9jdHggKmN0eCwgY29uc3QgY2hhciAqcHJpdl9rZXlfZW5naW5l
LAorICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqcHJpdl9rZXlfZmlsZQogI2lm
IEVOQUJMRV9JTkxJTkVfRklMRVMKICAgICAsIGNvbnN0IGNoYXIgKnByaXZfa2V5X2ZpbGVfaW5s
aW5lCiAjZW5kaWYKQEAgLTQ2Myw5ICs0NjQsMjcgQEAgdGxzX2N0eF9sb2FkX3ByaXZfZmlsZSAo
c3RydWN0IHRsc19yb290X2N0eCAqY3R4LCBjb25zdCBjaGFyICpwcml2X2tleV9maWxlCiAgIGlm
ICghaW4pCiAgICAgZ290byBlbmQ7CiAKLSAgcGtleSA9IFBFTV9yZWFkX2Jpb19Qcml2YXRlS2V5
IChpbiwgTlVMTCwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzc2xfY3R4LT5k
ZWZhdWx0X3Bhc3N3ZF9jYWxsYmFjaywKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBzc2xfY3R4LT5kZWZhdWx0X3Bhc3N3ZF9jYWxsYmFja191c2VyZGF0YSk7CisgIGlmIChwcml2
X2tleV9lbmdpbmUpIHsKKyNpZmRlZiBIQVZFX09QRU5TU0xfRU5HSU5FCisgICAgRU5HSU5FICpl
bmdpbmU7CisKKyAgICBlbmdpbmUgPSBjcnlwdG9faW5pdF9saWJfZW5naW5lKHByaXZfa2V5X2Vu
Z2luZSk7CisgICAgaWYgKCFlbmdpbmUpIHsKKyAgICAgIG1zZyAoTV9XQVJOfE1fU1NMLCAiQ2Fu
bm90IGluaXQgZW5naW5lICVzIiwgcHJpdl9rZXlfZW5naW5lKTsKKyAgICAgIGdvdG8gZW5kOwor
ICAgIH0KKyAgICBwa2V5ID0gRU5HSU5FX2xvYWRfcHJpdmF0ZV9rZXkoZW5naW5lLCBwcml2X2tl
eV9maWxlLCBVSV9PcGVuU1NMKCksIE5VTEwpOworI2Vsc2UKKyAgICBtc2cgKE1fV0FSTiwgIk5v
dGU6IEhhcmR3YXJlIGNyeXB0byBlbmdpbmUgZnVuY3Rpb25hbGl0eSBpcyBub3QgIgorICAgICAg
ICAgImF2YWlsYWJsZSIpOworICAgIGdvdG8gZW5kOworI2VuZGlmIC8qIEhBVkVfT1BFTlNTTF9F
TkdJTkUgKi8KKyAgfSBlbHNlIHsKKyAgICBwa2V5ID0gUEVNX3JlYWRfYmlvX1ByaXZhdGVLZXkg
KGluLCBOVUxMLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3NsX2N0eC0+
ZGVmYXVsdF9wYXNzd2RfY2FsbGJhY2ssCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzc2xfY3R4LT5kZWZhdWx0X3Bhc3N3ZF9jYWxsYmFja191c2VyZGF0YSk7CisgIH0KKwog
ICBpZiAoIXBrZXkpCiAgICAgZ290byBlbmQ7CiAKZGlmZiAtLWdpdCBhL3NyYy9vcGVudnBuL3Nz
bF9vcGVuc3NsLmggYi9zcmMvb3BlbnZwbi9zc2xfb3BlbnNzbC5oCmluZGV4IGZjMjA1MmMuLmJm
YzU3MTUgMTAwNjQ0Ci0tLSBhL3NyYy9vcGVudnBuL3NzbF9vcGVuc3NsLmgKKysrIGIvc3JjL29w
ZW52cG4vc3NsX29wZW5zc2wuaApAQCAtMzIsNiArMzIsMTAgQEAKIAogI2luY2x1ZGUgPG9wZW5z
c2wvc3NsLmg+CiAKKyNpZiBIQVZFX09QRU5TU0xfRU5HSU5FCisjaW5jbHVkZSA8b3BlbnNzbC9l
bmdpbmUuaD4KKyNlbmRpZgorCiAvKioKICAqIFN0cnVjdHVyZSB0aGF0IHdyYXBzIHRoZSBUTFMg
Y29udGV4dC4gQ29udGVudHMgZGlmZmVyIGRlcGVuZGluZyBvbiB0aGUKICAqIFNTTCBsaWJyYXJ5
IHVzZWQuCmRpZmYgLS1naXQgYS9zcmMvb3BlbnZwbi9zc2xfcG9sYXJzc2wuYyBiL3NyYy9vcGVu
dnBuL3NzbF9wb2xhcnNzbC5jCmluZGV4IGZjOGZhNmUuLjQ1OTYwZDAgMTAwNjQ0Ci0tLSBhL3Ny
Yy9vcGVudnBuL3NzbF9wb2xhcnNzbC5jCisrKyBiL3NyYy9vcGVudnBuL3NzbF9wb2xhcnNzbC5j
CkBAIC0yNzYsNyArMjc2LDggQEAgdGxzX2N0eF9mcmVlX2NlcnRfZmlsZSAob3BlbnZwbl94NTA5
X2NlcnRfdCAqeDUwOSkKIH0KIAogaW50Ci10bHNfY3R4X2xvYWRfcHJpdl9maWxlIChzdHJ1Y3Qg
dGxzX3Jvb3RfY3R4ICpjdHgsIGNvbnN0IGNoYXIgKnByaXZfa2V5X2ZpbGUKK3Rsc19jdHhfbG9h
ZF9wcml2X2ZpbGUgKHN0cnVjdCB0bHNfcm9vdF9jdHggKmN0eCwgY29uc3QgY2hhciAqcHJpdl9r
ZXlfZW5naW5lLAorICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqcHJpdl9rZXlf
ZmlsZQogI2lmIEVOQUJMRV9JTkxJTkVfRklMRVMKICAgICAsIGNvbnN0IGNoYXIgKnByaXZfa2V5
X2ZpbGVfaW5saW5lCiAjZW5kaWYgLyogRU5BQkxFX0lOTElORV9GSUxFUyAqLwo=
--f46d04428b501f493704c2a826f2--


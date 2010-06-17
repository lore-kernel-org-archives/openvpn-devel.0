Message-ID: <4C1A1AE1.5090305@...1380...>
Date: Thu, 17 Jun 2010 14:53:53 +0200
From: Emilien Mantel <emilien.mantel@...1380...>
MIME-Version: 1.0
References: <4C19ED93.50202@...1380...>	<4C1A0941.5000808@...515...>
	<AANLkTinkGgRbX7tY0QZzoC-ru5jhKFdpiEgn-proJecI@...278...>
In-Reply-To: <AANLkTinkGgRbX7tY0QZzoC-ru5jhKFdpiEgn-proJecI@...278...>
Content-Type: multipart/mixed; boundary="------------070903080409020904070807"
Subject: Re: [Openvpn-devel] [PATCH] Choose a different field in X509 to be
 username
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------070903080409020904070807
X-MIME-Autoconverted: from 8bit to quoted-printable by
	edd-bd-mesg-ldap-01.eolas-services.com id o5HCrVOc003328
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

I added toupper() + #include <ctype.h> in options.c

See attached.

--
Emilien Mantel

Le 17/06/2010 14:02, Alon Bar-Lev a =C3=A9crit :
> This is good idea.
>
> In order to upper case toupper() should be used and not manual guessing.
>
> +  else if (streq (p[0], "x509-username-field")&&  p[1])
> +    {
> +      VERIFY_PERMISSION (OPT_P_GENERAL);
> +      /* Uppercase if necessary */
> +      {
> +       char *s =3D p[1];
> +       int c, flag =3D 0;
> +
> +       while ((c =3D *s) !=3D '\0')
> +          {
> +           if (c>=3D 'a'&&  c<=3D 'z')
> +              {
> +                c =3D c + 'A' - 'a';
> +               flag++;
> +              }
> +            *s =3D (char) c;
> +            s++;
> +         }
> +      }
> +      options->x509_username_field =3D p[1];
> +    }
>
> 2010/6/17 Samuli Sepp=C3=A4nen<samuli@...515...>:
>=20=20=20=20
>>=20=20=20=20=20=20
>>> Hi,
>>>
>>> For my company, we use a PKI (linked to a LDAP) with OpenVPN. We can't
>>> use "CN" to be username (few people can have the same "CN"). In our
>>> case, we only use the UID.
>>>
>>> With my patch, you can choose another field to be username with a new
>>> option called "x509-username-field", the default value is "CN".
>>>
>>> Best regards
>>>
>>> --
>>> Emilien Mantel
>>>=20=20=20=20=20=20=20=20
>> Hi Emilien,
>>
>> Thanks for the patch! Could somebody with better C skills take a look
>> and see if it needs modifications?
>>
>> --
>> Samuli Sepp=C3=A4nen
>> Community Manager
>> OpenVPN Technologies, Inc
>>
>> irc freenode net: mattock
>>
>>
>> ------------------------------------------------------------------------=
------
>> ThinkGeek and WIRED's GeekDad team up for the Ultimate
>> GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the
>> lucky parental unit.  See the prize list and enter to win:
>> http://p.sf.net/sfu/thinkgeek-promo
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
>>=20=20=20=20=20=20
> -------------------------------------------------------------------------=
-----
> ThinkGeek and WIRED's GeekDad team up for the Ultimate
> GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the
> lucky parental unit.  See the prize list and enter to win:
> http://p.sf.net/sfu/thinkgeek-promo
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20=20=20=20


--------------070903080409020904070807
Content-Type: text/plain;
 name="openvpn.patch2"
Content-Disposition: attachment;
 filename="openvpn.patch2"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL29wdGlvbnMuYyBiL29wdGlvbnMuYwppbmRleCAzNWYzZjEzLi5mMzll
NmEyIDEwMDY0NAotLS0gYS9vcHRpb25zLmMKKysrIGIvb3B0aW9ucy5jCkBAIC00OSw2ICs0
OSw3IEBACiAjaW5jbHVkZSAiaGVscGVyLmgiCiAjaW5jbHVkZSAibWFuYWdlLmgiCiAjaW5j
bHVkZSAiY29uZmlndXJlLmgiCisjaW5jbHVkZSA8Y3R5cGUuaD4KIAogI2luY2x1ZGUgIm1l
bWRiZy5oIgogCkBAIC01MzMsNiArNTM0LDggQEAgc3RhdGljIGNvbnN0IGNoYXIgdXNhZ2Vf
bWVzc2FnZVtdID0KICAgIi0ta2V5IGZpbGUgICAgICA6IExvY2FsIHByaXZhdGUga2V5IGlu
IC5wZW0gZm9ybWF0LlxuIgogICAiLS1wa2NzMTIgZmlsZSAgIDogUEtDUyMxMiBmaWxlIGNv
bnRhaW5pbmcgbG9jYWwgcHJpdmF0ZSBrZXksIGxvY2FsIGNlcnRpZmljYXRlXG4iCiAgICIg
ICAgICAgICAgICAgICAgICBhbmQgb3B0aW9uYWxseSB0aGUgcm9vdCBDQSBjZXJ0aWZpY2F0
ZS5cbiIKKyAgIi0teDUwOS11c2VybmFtZS1maWVsZCA6IEZpZWxkIHVzZWQgaW4geDUwOSBj
ZXJ0aWZpY2F0IHRvIGJlIHVzZXJuYW1lLlxuIgorICAiICAgICAgICAgICAgICAgICAgICAg
ICAgRGVmYXVsdCBpcyBDTi5cbiIKICNpZmRlZiBXSU4zMgogICAiLS1jcnlwdG9hcGljZXJ0
IHNlbGVjdC1zdHJpbmcgOiBMb2FkIHRoZSBjZXJ0aWZpY2F0ZSBhbmQgcHJpdmF0ZSBrZXkg
ZnJvbSB0aGVcbiIKICAgIiAgICAgICAgICAgICAgICAgIFdpbmRvd3MgQ2VydGlmaWNhdGUg
U3lzdGVtIFN0b3JlLlxuIgpAQCAtNzg2LDYgKzc4OSw3IEBAIGluaXRfb3B0aW9ucyAoc3Ry
dWN0IG9wdGlvbnMgKm8sIGNvbnN0IGJvb2wgaW5pdF9nYykKICAgby0+cmVuZWdvdGlhdGVf
c2Vjb25kcyA9IDM2MDA7CiAgIG8tPmhhbmRzaGFrZV93aW5kb3cgPSA2MDsKICAgby0+dHJh
bnNpdGlvbl93aW5kb3cgPSAzNjAwOworICBvLT54NTA5X3VzZXJuYW1lX2ZpZWxkID0gWDUw
OV9VU0VSTkFNRV9GSUVMRF9ERUZBVUxUOwogI2VuZGlmCiAjZW5kaWYKICNpZmRlZiBFTkFC
TEVfUEtDUzExCkBAIC02MTkxLDYgKzYxOTUsMjIgQEAgYWRkX29wdGlvbiAoc3RydWN0IG9w
dGlvbnMgKm9wdGlvbnMsCiAJfQogICAgICAgb3B0aW9ucy0+a2V5X21ldGhvZCA9IGtleV9t
ZXRob2Q7CiAgICAgfQorICBlbHNlIGlmIChzdHJlcSAocFswXSwgIng1MDktdXNlcm5hbWUt
ZmllbGQiKSAmJiBwWzFdKQorICAgIHsKKyAgICAgIFZFUklGWV9QRVJNSVNTSU9OIChPUFRf
UF9HRU5FUkFMKTsKKyAgICAgIC8qIFVwcGVyY2FzZSBpZiBuZWNlc3NhcnkgKi8gCisgICAg
ICAgIHsKKwkgIGNoYXIgKnMgPSBwWzFdOworCSAgaW50IGM7CisKKwkgIHdoaWxlICgoYyA9
ICpzKSAhPSAnXDAnKSAKKyAgICAgICAgICAgIHsKKyAgICAgICAgICAgICAgKnMgPSAoY2hh
cikgdG91cHBlcihjKTsKKyAgICAgICAgICAgICAgcysrOworCSAgICB9CisgICAgICAgIH0g
ICAgIAorICAgICAgb3B0aW9ucy0+eDUwOV91c2VybmFtZV9maWVsZCA9IHBbMV07CisgICAg
fQogI2VuZGlmIC8qIFVTRV9TU0wgKi8KICNlbmRpZiAvKiBVU0VfQ1JZUFRPICovCiAjaWZk
ZWYgRU5BQkxFX1BLQ1MxMQpkaWZmIC0tZ2l0IGEvb3B0aW9ucy5oIGIvb3B0aW9ucy5oCmlu
ZGV4IGNjYzAzZGYuLjFhOTBmODYgMTAwNjQ0Ci0tLSBhL29wdGlvbnMuaAorKysgYi9vcHRp
b25zLmgKQEAgLTUyNiw2ICs1MjYsOSBAQCBzdHJ1Y3Qgb3B0aW9ucwogICAgICB3aXRoaW4g
biBzZWNvbmRzIG9mIGhhbmRzaGFrZSBpbml0aWF0aW9uLiAqLwogICBpbnQgaGFuZHNoYWtl
X3dpbmRvdzsKIAorICAvKiBGaWVsZCB1c2VkIHRvIGJlIHRoZSB1c2VybmFtZSBpbiBYNTA5
IGNlcnQuICovCisgIGNoYXIgKng1MDlfdXNlcm5hbWVfZmllbGQ7CisKICAgLyogT2xkIGtl
eSBhbGxvd2VkIHRvIGxpdmUgbiBzZWNvbmRzIGFmdGVyIG5ldyBrZXkgZ29lcyBhY3RpdmUg
Ki8KICAgaW50IHRyYW5zaXRpb25fd2luZG93OwogCmRpZmYgLS1naXQgYS9zc2wuYyBiL3Nz
bC5jCmluZGV4IGIwZmI2ZTQuLmY2ZTI0MTAgMTAwNjQ0Ci0tLSBhL3NzbC5jCisrKyBiL3Nz
bC5jCkBAIC03MzQsNiArNzM0LDggQEAgZ2V0X3BlZXJfY2VydChYNTA5X1NUT1JFX0NUWCAq
Y3R4LCBjb25zdCBjaGFyICp0bXBfZGlyLCBzdHJ1Y3QgZ2NfYXJlbmEgKmdjKQogICByZXR1
cm4gcGVlcmNlcnRfZmlsZW5hbWU7CiB9CiAKK2NoYXIgKiB4NTA5X3VzZXJuYW1lX2ZpZWxk
OyAvKiBHTE9CQUwgKi8KKwogLyoKICAqIE91ciB2ZXJpZnkgY2FsbGJhY2sgZnVuY3Rpb24g
LS0gY2hlY2sKICAqIHRoYXQgYW4gaW5jb21pbmcgcGVlciBjZXJ0aWZpY2F0ZSBpcyBnb29k
LgpAQCAtNzQ0LDcgKzc0Niw3IEBAIHZlcmlmeV9jYWxsYmFjayAoaW50IHByZXZlcmlmeV9v
aywgWDUwOV9TVE9SRV9DVFggKiBjdHgpCiB7CiAgIGNoYXIgKnN1YmplY3QgPSBOVUxMOwog
ICBjaGFyIGVudm5hbWVbNjRdOwotICBjaGFyIGNvbW1vbl9uYW1lW1RMU19DTl9MRU5dOwor
ICBjaGFyIGNvbW1vbl9uYW1lW1RMU19VU0VSTkFNRV9MRU5dOwogICBTU0wgKnNzbDsKICAg
c3RydWN0IHRsc19zZXNzaW9uICpzZXNzaW9uOwogICBjb25zdCBzdHJ1Y3QgdGxzX29wdGlv
bnMgKm9wdDsKQEAgLTc3NiwxOCArNzc4LDIwIEBAIHZlcmlmeV9jYWxsYmFjayAoaW50IHBy
ZXZlcmlmeV9vaywgWDUwOV9TVE9SRV9DVFggKiBjdHgpCiAgIHN0cmluZ19tb2Rfc3NsbmFt
ZSAoc3ViamVjdCwgWDUwOV9OQU1FX0NIQVJfQ0xBU1MsIG9wdC0+c3NsX2ZsYWdzKTsKICAg
c3RyaW5nX3JlcGxhY2VfbGVhZGluZyAoc3ViamVjdCwgJy0nLCAnXycpOwogCi0gIC8qIGV4
dHJhY3QgdGhlIGNvbW1vbiBuYW1lICovCi0gIGlmICghZXh0cmFjdF94NTA5X2ZpZWxkX3Nz
bCAoWDUwOV9nZXRfc3ViamVjdF9uYW1lIChjdHgtPmN1cnJlbnRfY2VydCksICJDTiIsIGNv
bW1vbl9uYW1lLCBUTFNfQ05fTEVOKSkKKyAgLyogZXh0cmFjdCB0aGUgdXNlcm5hbWUgKGRl
ZmF1bHQgaXMgQ04pICovCisgIGlmICghZXh0cmFjdF94NTA5X2ZpZWxkX3NzbCAoWDUwOV9n
ZXRfc3ViamVjdF9uYW1lIChjdHgtPmN1cnJlbnRfY2VydCksIHg1MDlfdXNlcm5hbWVfZmll
bGQsIGNvbW1vbl9uYW1lLCBUTFNfVVNFUk5BTUVfTEVOKSkKICAgICB7CiAgICAgICBpZiAo
IWN0eC0+ZXJyb3JfZGVwdGgpCi0JewotCSAgbXNnIChEX1RMU19FUlJPUlMsICJWRVJJRlkg
RVJST1I6IGNvdWxkIG5vdCBleHRyYWN0IENvbW1vbiBOYW1lIGZyb20gWDUwOSBzdWJqZWN0
IHN0cmluZyAoJyVzJykgLS0gbm90ZSB0aGF0IHRoZSBDb21tb24gTmFtZSBsZW5ndGggaXMg
bGltaXRlZCB0byAlZCBjaGFyYWN0ZXJzIiwKLQkgICAgICAgc3ViamVjdCwKLQkgICAgICAg
VExTX0NOX0xFTik7Ci0JICBnb3RvIGVycjsKLQl9CisgICAgICAgIHsKKyAgICAgICAgICBt
c2cgKERfVExTX0VSUk9SUywgIlZFUklGWSBFUlJPUjogY291bGQgbm90IGV4dHJhY3QgJXMg
ZnJvbSBYNTA5IHN1YmplY3Qgc3RyaW5nICgnJXMnKSAtLSBub3RlIHRoYXQgdGhlIHVzZXJu
YW1lIGxlbmd0aCBpcyBsaW1pdGVkIHRvICVkIGNoYXJhY3RlcnMiLAorICAgICAgICAgICAg
ICAgICB4NTA5X3VzZXJuYW1lX2ZpZWxkLAorICAgICAgICAgICAgICAgICBzdWJqZWN0LAor
ICAgICAgICAgICAgICAgICBUTFNfVVNFUk5BTUVfTEVOKTsKKyAgICAgICAgICBnb3RvIGVy
cjsKKyAgICAgICAgfQogICAgIH0KIAorCiAgIHN0cmluZ19tb2Rfc3NsbmFtZSAoY29tbW9u
X25hbWUsIENPTU1PTl9OQU1FX0NIQVJfQ0xBU1MsIG9wdC0+c3NsX2ZsYWdzKTsKIAogICBj
ZXJ0X2hhc2hfcmVtZW1iZXIgKHNlc3Npb24sIGN0eC0+ZXJyb3JfZGVwdGgsIGN0eC0+Y3Vy
cmVudF9jZXJ0LT5zaGExX2hhc2gpOwpAQCAtMTgyMiw3ICsxODI2LDggQEAgaW5pdF9zc2wg
KGNvbnN0IHN0cnVjdCBvcHRpb25zICpvcHRpb25zKQogICAgIH0KICAgZWxzZQogI2VuZGlm
Ci0gICAgU1NMX0NUWF9zZXRfdmVyaWZ5IChjdHgsIFNTTF9WRVJJRllfUEVFUiB8IFNTTF9W
RVJJRllfRkFJTF9JRl9OT19QRUVSX0NFUlQsCisgIHg1MDlfdXNlcm5hbWVfZmllbGQgPSAo
Y2hhciAqKSBvcHRpb25zLT54NTA5X3VzZXJuYW1lX2ZpZWxkOworICBTU0xfQ1RYX3NldF92
ZXJpZnkgKGN0eCwgU1NMX1ZFUklGWV9QRUVSIHwgU1NMX1ZFUklGWV9GQUlMX0lGX05PX1BF
RVJfQ0VSVCwKIAkJCXZlcmlmeV9jYWxsYmFjayk7CiAKICAgLyogQ29ubmVjdGlvbiBpbmZv
cm1hdGlvbiBjYWxsYmFjayAqLwpAQCAtMzc1NSw5ICszNzYwLDkgQEAga2V5X21ldGhvZF8y
X3JlYWQgKHN0cnVjdCBidWZmZXIgKmJ1Ziwgc3RydWN0IHRsc19tdWx0aSAqbXVsdGksIHN0
cnVjdCB0bHNfc2Vzc2kKIAlzMiA9IHZlcmlmeV91c2VyX3Bhc3Nfc2NyaXB0IChzZXNzaW9u
LCB1cCk7CiAKICAgICAgIC8qIGNoZWNrIHNpemluZyBvZiB1c2VybmFtZSBpZiBpdCB3aWxs
IGJlY29tZSBvdXIgY29tbW9uIG5hbWUgKi8KLSAgICAgIGlmICgoc2Vzc2lvbi0+b3B0LT5z
c2xfZmxhZ3MgJiBTU0xGX1VTRVJOQU1FX0FTX0NPTU1PTl9OQU1FKSAmJiBzdHJsZW4gKHVw
LT51c2VybmFtZSkgPj0gVExTX0NOX0xFTikKKyAgICAgIGlmICgoc2Vzc2lvbi0+b3B0LT5z
c2xfZmxhZ3MgJiBTU0xGX1VTRVJOQU1FX0FTX0NPTU1PTl9OQU1FKSAmJiBzdHJsZW4gKHVw
LT51c2VybmFtZSkgPj0gVExTX1VTRVJOQU1FX0xFTikKIAl7Ci0JICBtc2cgKERfVExTX0VS
Uk9SUywgIlRMUyBBdXRoIEVycm9yOiAtLXVzZXJuYW1lLWFzLWNvbW1vbiBuYW1lIHNwZWNp
ZmllZCBhbmQgdXNlcm5hbWUgaXMgbG9uZ2VyIHRoYW4gdGhlIG1heGltdW0gcGVybWl0dGVk
IENvbW1vbiBOYW1lIGxlbmd0aCBvZiAlZCBjaGFyYWN0ZXJzIiwgVExTX0NOX0xFTik7CisJ
ICBtc2cgKERfVExTX0VSUk9SUywgIlRMUyBBdXRoIEVycm9yOiAtLXVzZXJuYW1lLWFzLWNv
bW1vbiBuYW1lIHNwZWNpZmllZCBhbmQgdXNlcm5hbWUgaXMgbG9uZ2VyIHRoYW4gdGhlIG1h
eGltdW0gcGVybWl0dGVkIENvbW1vbiBOYW1lIGxlbmd0aCBvZiAlZCBjaGFyYWN0ZXJzIiwg
VExTX1VTRVJOQU1FX0xFTik7CiAJICBzMSA9IE9QRU5WUE5fUExVR0lOX0ZVTkNfRVJST1I7
CiAJfQogCmRpZmYgLS1naXQgYS9zc2wuaCBiL3NzbC5oCmluZGV4IDM0YzY5ODguLjAyMjM0
YzMgMTAwNjQ0Ci0tLSBhL3NzbC5oCisrKyBiL3NzbC5oCkBAIC0yNzgsOCArMjc4LDggQEAK
ICAqIEJ1ZmZlciBzaXplcyAoYWxzbyBzZWUgbXR1LmgpLgogICovCiAKLS8qIE1heGltdW0g
bGVuZ3RoIG9mIGNvbW1vbiBuYW1lICovCi0jZGVmaW5lIFRMU19DTl9MRU4gNjQKKy8qIE1h
eGltdW0gbGVuZ3RoIG9mIHRoZSB1c2VybmFtZSBpbiBjZXJ0ICovCisjZGVmaW5lIFRMU19V
U0VSTkFNRV9MRU4gNjQKIAogLyogTGVnYWwgY2hhcmFjdGVycyBpbiBhbiBYNTA5IG9yIGNv
bW1vbiBuYW1lICovCiAjZGVmaW5lIFg1MDlfTkFNRV9DSEFSX0NMQVNTICAgKENDX0FMTlVN
fENDX1VOREVSQkFSfENDX0RBU0h8Q0NfRE9UfENDX0FUfENDX0NPTE9OfENDX1NMQVNIfEND
X0VRVUFMKQpAQCAtMjg4LDYgKzI4OCw5IEBACiAvKiBNYXhpbXVtIGxlbmd0aCBvZiBPQ0Mg
b3B0aW9ucyBzdHJpbmcgcGFzc2VkIGFzIHBhcnQgb2YgYXV0aCBoYW5kc2hha2UgKi8KICNk
ZWZpbmUgVExTX09QVElPTlNfTEVOIDUxMgogCisvKiBEZWZhdWx0IGZpZWxkIGluIFg1MDkg
dG8gYmUgdXNlcm5hbWUgKi8KKyNkZWZpbmUgWDUwOV9VU0VSTkFNRV9GSUVMRF9ERUZBVUxU
ICJDTiIKKwogLyoKICAqIFJhbmdlIG9mIGtleSBleGNoYW5nZSBtZXRob2RzCiAgKi8K
--------------070903080409020904070807--


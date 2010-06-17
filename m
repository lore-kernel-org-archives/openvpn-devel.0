Message-ID: <4C1A3658.6090501@...1380...>
Date: Thu, 17 Jun 2010 16:51:04 +0200
From: Emilien Mantel <emilien.mantel@...1380...>
MIME-Version: 1.0
References: <4C19ED93.50202@...1380...>	<4C1A0941.5000808@...515...>	<AANLkTinkGgRbX7tY0QZzoC-ru5jhKFdpiEgn-proJecI@...278...>	<4C1A1AE1.5090305@...1380...>
	<AANLkTimpz7YASaTfmQ5DItwiMrplAx_G93ez2vHxAWW5@...278...>
In-Reply-To: <AANLkTimpz7YASaTfmQ5DItwiMrplAx_G93ez2vHxAWW5@...278...>
Content-Type: multipart/mixed; boundary="------------060507070204060009010606"
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------060507070204060009010606
X-MIME-Autoconverted: from 8bit to quoted-printable by
	edd-bd-mesg-ldap-01.eolas-services.com id o5HEogbN007413
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

1) Done

2) Done

3) "sizeof(common_name)" is useless... Line 745: char=20
common_name[TLS_USERNAME_LEN]; we can use directly TLS_USERNAME_LEN.

4)
I note "common_name" is used everwhere in OpenVPN code... I can rename=20
it with a big sed :)
But substitute all "common_name" is very heavy :
emilienm@...1381...:~/dev/openvpn-testing$ grep -i common_name * | wc -l
165
Are you sure it's a good idea? If I do that, are you agree to rename it=20
"username"?

--
Emilien Mantel

Le 17/06/2010 15:57, Alon Bar-Lev a =C3=A9crit :
> Great.
>
> Few more:
>
> 1. To upper:
> char *s =3D p[1];
> while ((*s =3D toupper(*s)) !=3D '\0') s++;
> 2. Remove compound {} at this place, move the char *s before the
> VERIFY_PERMISSION.
> 3. I think:
> """
> extract_x509_field_ssl (X509_get_subject_name (ctx->current_cert),
> x509_username_field, common_name, TLS_USERNAME_LEN)
> """
> TLS_USERNAME_LEN ->  sizeof(common_name)
> 4. Maybe rename common_name ->  x509_field or something to make it
> clearer that it isn't actually common_name.
>
> Thanks.
>
> On Thu, Jun 17, 2010 at 3:53 PM, Emilien Mantel
> <emilien.mantel@...1380...>  wrote:
>=20=20=20=20
>> I added toupper() + #include<ctype.h>  in options.c
>>
>> See attached.
>>
>> --
>> Emilien Mantel
>>
>> Le 17/06/2010 14:02, Alon Bar-Lev a =C3=A9crit :
>>=20=20=20=20=20=20
>>> This is good idea.
>>>
>>> In order to upper case toupper() should be used and not manual guessing.
>>>
>>> +  else if (streq (p[0], "x509-username-field")&&    p[1])
>>> +    {
>>> +      VERIFY_PERMISSION (OPT_P_GENERAL);
>>> +      /* Uppercase if necessary */
>>> +      {
>>> +       char *s =3D p[1];
>>> +       int c, flag =3D 0;
>>> +
>>> +       while ((c =3D *s) !=3D '\0')
>>> +          {
>>> +           if (c>=3D 'a'&&    c<=3D 'z')
>>> +              {
>>> +                c =3D c + 'A' - 'a';
>>> +               flag++;
>>> +              }
>>> +            *s =3D (char) c;
>>> +            s++;
>>> +         }
>>> +      }
>>> +      options->x509_username_field =3D p[1];
>>> +    }
>>>
>>> 2010/6/17 Samuli Sepp=C3=A4nen<samuli@...515...>:
>>>
>>>=20=20=20=20=20=20=20=20
>>>>
>>>>=20=20=20=20=20=20=20=20=20=20
>>>>> Hi,
>>>>>
>>>>> For my company, we use a PKI (linked to a LDAP) with OpenVPN. We can't
>>>>> use "CN" to be username (few people can have the same "CN"). In our
>>>>> case, we only use the UID.
>>>>>
>>>>> With my patch, you can choose another field to be username with a new
>>>>> option called "x509-username-field", the default value is "CN".
>>>>>
>>>>> Best regards
>>>>>
>>>>> --
>>>>> Emilien Mantel
>>>>>
>>>>>=20=20=20=20=20=20=20=20=20=20=20=20
>>>> Hi Emilien,
>>>>
>>>> Thanks for the patch! Could somebody with better C skills take a look
>>>> and see if it needs modifications?
>>>>
>>>> --
>>>> Samuli Sepp=C3=A4nen
>>>> Community Manager
>>>> OpenVPN Technologies, Inc
>>>>
>>>> irc freenode net: mattock
>>>>
>>>>
>>>>
>>>> ----------------------------------------------------------------------=
--------
>>>> ThinkGeek and WIRED's GeekDad team up for the Ultimate
>>>> GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the
>>>> lucky parental unit.  See the prize list and enter to win:
>>>> http://p.sf.net/sfu/thinkgeek-promo
>>>> _______________________________________________
>>>> Openvpn-devel mailing list
>>>> Openvpn-devel@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>>>
>>>>
>>>>=20=20=20=20=20=20=20=20=20=20
>>>
>>> -----------------------------------------------------------------------=
-------
>>> ThinkGeek and WIRED's GeekDad team up for the Ultimate
>>> GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the
>>> lucky parental unit.  See the prize list and enter to win:
>>> http://p.sf.net/sfu/thinkgeek-promo
>>> _______________________________________________
>>> Openvpn-devel mailing list
>>> Openvpn-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>>
>>>=20=20=20=20=20=20=20=20
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
>>
>>=20=20=20=20=20=20


--------------060507070204060009010606
Content-Type: text/plain;
 name="openvpn.patch3"
Content-Disposition: attachment;
 filename="openvpn.patch3"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL29wdGlvbnMuYyBiL29wdGlvbnMuYwppbmRleCAzNWYzZjEzLi5hMDc4
MzcyIDEwMDY0NAotLS0gYS9vcHRpb25zLmMKKysrIGIvb3B0aW9ucy5jCkBAIC00OSw2ICs0
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
TEVfUEtDUzExCkBAIC02MTkxLDYgKzYxOTUsMTMgQEAgYWRkX29wdGlvbiAoc3RydWN0IG9w
dGlvbnMgKm9wdGlvbnMsCiAJfQogICAgICAgb3B0aW9ucy0+a2V5X21ldGhvZCA9IGtleV9t
ZXRob2Q7CiAgICAgfQorICBlbHNlIGlmIChzdHJlcSAocFswXSwgIng1MDktdXNlcm5hbWUt
ZmllbGQiKSAmJiBwWzFdKQorICAgIHsKKyAgICAgIGNoYXIgKnMgPSBwWzFdOworICAgICAg
VkVSSUZZX1BFUk1JU1NJT04gKE9QVF9QX0dFTkVSQUwpOworICAgICAgd2hpbGUgKCgqcyA9
IHRvdXBwZXIoKnMpKSAhPSAnXDAnKSBzKys7IC8qIFVwcGVyY2FzZSBpZiBuZWNlc3Nhcnkg
Ki8KKyAgICAgIG9wdGlvbnMtPng1MDlfdXNlcm5hbWVfZmllbGQgPSBwWzFdOworICAgIH0K
ICNlbmRpZiAvKiBVU0VfU1NMICovCiAjZW5kaWYgLyogVVNFX0NSWVBUTyAqLwogI2lmZGVm
IEVOQUJMRV9QS0NTMTEKZGlmZiAtLWdpdCBhL29wdGlvbnMuaCBiL29wdGlvbnMuaAppbmRl
eCBjY2MwM2RmLi4xYTkwZjg2IDEwMDY0NAotLS0gYS9vcHRpb25zLmgKKysrIGIvb3B0aW9u
cy5oCkBAIC01MjYsNiArNTI2LDkgQEAgc3RydWN0IG9wdGlvbnMKICAgICAgd2l0aGluIG4g
c2Vjb25kcyBvZiBoYW5kc2hha2UgaW5pdGlhdGlvbi4gKi8KICAgaW50IGhhbmRzaGFrZV93
aW5kb3c7CiAKKyAgLyogRmllbGQgdXNlZCB0byBiZSB0aGUgdXNlcm5hbWUgaW4gWDUwOSBj
ZXJ0LiAqLworICBjaGFyICp4NTA5X3VzZXJuYW1lX2ZpZWxkOworCiAgIC8qIE9sZCBrZXkg
YWxsb3dlZCB0byBsaXZlIG4gc2Vjb25kcyBhZnRlciBuZXcga2V5IGdvZXMgYWN0aXZlICov
CiAgIGludCB0cmFuc2l0aW9uX3dpbmRvdzsKIApkaWZmIC0tZ2l0IGEvc3NsLmMgYi9zc2wu
YwppbmRleCBiMGZiNmU0Li5mNmUyNDEwIDEwMDY0NAotLS0gYS9zc2wuYworKysgYi9zc2wu
YwpAQCAtNzM0LDYgKzczNCw4IEBAIGdldF9wZWVyX2NlcnQoWDUwOV9TVE9SRV9DVFggKmN0
eCwgY29uc3QgY2hhciAqdG1wX2Rpciwgc3RydWN0IGdjX2FyZW5hICpnYykKICAgcmV0dXJu
IHBlZXJjZXJ0X2ZpbGVuYW1lOwogfQogCitjaGFyICogeDUwOV91c2VybmFtZV9maWVsZDsg
LyogR0xPQkFMICovCisKIC8qCiAgKiBPdXIgdmVyaWZ5IGNhbGxiYWNrIGZ1bmN0aW9uIC0t
IGNoZWNrCiAgKiB0aGF0IGFuIGluY29taW5nIHBlZXIgY2VydGlmaWNhdGUgaXMgZ29vZC4K
QEAgLTc0NCw3ICs3NDYsNyBAQCB2ZXJpZnlfY2FsbGJhY2sgKGludCBwcmV2ZXJpZnlfb2ss
IFg1MDlfU1RPUkVfQ1RYICogY3R4KQogewogICBjaGFyICpzdWJqZWN0ID0gTlVMTDsKICAg
Y2hhciBlbnZuYW1lWzY0XTsKLSAgY2hhciBjb21tb25fbmFtZVtUTFNfQ05fTEVOXTsKKyAg
Y2hhciBjb21tb25fbmFtZVtUTFNfVVNFUk5BTUVfTEVOXTsKICAgU1NMICpzc2w7CiAgIHN0
cnVjdCB0bHNfc2Vzc2lvbiAqc2Vzc2lvbjsKICAgY29uc3Qgc3RydWN0IHRsc19vcHRpb25z
ICpvcHQ7CkBAIC03NzYsMTggKzc3OCwyMCBAQCB2ZXJpZnlfY2FsbGJhY2sgKGludCBwcmV2
ZXJpZnlfb2ssIFg1MDlfU1RPUkVfQ1RYICogY3R4KQogICBzdHJpbmdfbW9kX3NzbG5hbWUg
KHN1YmplY3QsIFg1MDlfTkFNRV9DSEFSX0NMQVNTLCBvcHQtPnNzbF9mbGFncyk7CiAgIHN0
cmluZ19yZXBsYWNlX2xlYWRpbmcgKHN1YmplY3QsICctJywgJ18nKTsKIAotICAvKiBleHRy
YWN0IHRoZSBjb21tb24gbmFtZSAqLwotICBpZiAoIWV4dHJhY3RfeDUwOV9maWVsZF9zc2wg
KFg1MDlfZ2V0X3N1YmplY3RfbmFtZSAoY3R4LT5jdXJyZW50X2NlcnQpLCAiQ04iLCBjb21t
b25fbmFtZSwgVExTX0NOX0xFTikpCisgIC8qIGV4dHJhY3QgdGhlIHVzZXJuYW1lIChkZWZh
dWx0IGlzIENOKSAqLworICBpZiAoIWV4dHJhY3RfeDUwOV9maWVsZF9zc2wgKFg1MDlfZ2V0
X3N1YmplY3RfbmFtZSAoY3R4LT5jdXJyZW50X2NlcnQpLCB4NTA5X3VzZXJuYW1lX2ZpZWxk
LCBjb21tb25fbmFtZSwgVExTX1VTRVJOQU1FX0xFTikpCiAgICAgewogICAgICAgaWYgKCFj
dHgtPmVycm9yX2RlcHRoKQotCXsKLQkgIG1zZyAoRF9UTFNfRVJST1JTLCAiVkVSSUZZIEVS
Uk9SOiBjb3VsZCBub3QgZXh0cmFjdCBDb21tb24gTmFtZSBmcm9tIFg1MDkgc3ViamVjdCBz
dHJpbmcgKCclcycpIC0tIG5vdGUgdGhhdCB0aGUgQ29tbW9uIE5hbWUgbGVuZ3RoIGlzIGxp
bWl0ZWQgdG8gJWQgY2hhcmFjdGVycyIsCi0JICAgICAgIHN1YmplY3QsCi0JICAgICAgIFRM
U19DTl9MRU4pOwotCSAgZ290byBlcnI7Ci0JfQorICAgICAgICB7CisgICAgICAgICAgbXNn
IChEX1RMU19FUlJPUlMsICJWRVJJRlkgRVJST1I6IGNvdWxkIG5vdCBleHRyYWN0ICVzIGZy
b20gWDUwOSBzdWJqZWN0IHN0cmluZyAoJyVzJykgLS0gbm90ZSB0aGF0IHRoZSB1c2VybmFt
ZSBsZW5ndGggaXMgbGltaXRlZCB0byAlZCBjaGFyYWN0ZXJzIiwKKyAgICAgICAgICAgICAg
ICAgeDUwOV91c2VybmFtZV9maWVsZCwKKyAgICAgICAgICAgICAgICAgc3ViamVjdCwKKyAg
ICAgICAgICAgICAgICAgVExTX1VTRVJOQU1FX0xFTik7CisgICAgICAgICAgZ290byBlcnI7
CisgICAgICAgIH0KICAgICB9CiAKKwogICBzdHJpbmdfbW9kX3NzbG5hbWUgKGNvbW1vbl9u
YW1lLCBDT01NT05fTkFNRV9DSEFSX0NMQVNTLCBvcHQtPnNzbF9mbGFncyk7CiAKICAgY2Vy
dF9oYXNoX3JlbWVtYmVyIChzZXNzaW9uLCBjdHgtPmVycm9yX2RlcHRoLCBjdHgtPmN1cnJl
bnRfY2VydC0+c2hhMV9oYXNoKTsKQEAgLTE4MjIsNyArMTgyNiw4IEBAIGluaXRfc3NsIChj
b25zdCBzdHJ1Y3Qgb3B0aW9ucyAqb3B0aW9ucykKICAgICB9CiAgIGVsc2UKICNlbmRpZgot
ICAgIFNTTF9DVFhfc2V0X3ZlcmlmeSAoY3R4LCBTU0xfVkVSSUZZX1BFRVIgfCBTU0xfVkVS
SUZZX0ZBSUxfSUZfTk9fUEVFUl9DRVJULAorICB4NTA5X3VzZXJuYW1lX2ZpZWxkID0gKGNo
YXIgKikgb3B0aW9ucy0+eDUwOV91c2VybmFtZV9maWVsZDsKKyAgU1NMX0NUWF9zZXRfdmVy
aWZ5IChjdHgsIFNTTF9WRVJJRllfUEVFUiB8IFNTTF9WRVJJRllfRkFJTF9JRl9OT19QRUVS
X0NFUlQsCiAJCQl2ZXJpZnlfY2FsbGJhY2spOwogCiAgIC8qIENvbm5lY3Rpb24gaW5mb3Jt
YXRpb24gY2FsbGJhY2sgKi8KQEAgLTM3NTUsOSArMzc2MCw5IEBAIGtleV9tZXRob2RfMl9y
ZWFkIChzdHJ1Y3QgYnVmZmVyICpidWYsIHN0cnVjdCB0bHNfbXVsdGkgKm11bHRpLCBzdHJ1
Y3QgdGxzX3Nlc3NpCiAJczIgPSB2ZXJpZnlfdXNlcl9wYXNzX3NjcmlwdCAoc2Vzc2lvbiwg
dXApOwogCiAgICAgICAvKiBjaGVjayBzaXppbmcgb2YgdXNlcm5hbWUgaWYgaXQgd2lsbCBi
ZWNvbWUgb3VyIGNvbW1vbiBuYW1lICovCi0gICAgICBpZiAoKHNlc3Npb24tPm9wdC0+c3Ns
X2ZsYWdzICYgU1NMRl9VU0VSTkFNRV9BU19DT01NT05fTkFNRSkgJiYgc3RybGVuICh1cC0+
dXNlcm5hbWUpID49IFRMU19DTl9MRU4pCisgICAgICBpZiAoKHNlc3Npb24tPm9wdC0+c3Ns
X2ZsYWdzICYgU1NMRl9VU0VSTkFNRV9BU19DT01NT05fTkFNRSkgJiYgc3RybGVuICh1cC0+
dXNlcm5hbWUpID49IFRMU19VU0VSTkFNRV9MRU4pCiAJewotCSAgbXNnIChEX1RMU19FUlJP
UlMsICJUTFMgQXV0aCBFcnJvcjogLS11c2VybmFtZS1hcy1jb21tb24gbmFtZSBzcGVjaWZp
ZWQgYW5kIHVzZXJuYW1lIGlzIGxvbmdlciB0aGFuIHRoZSBtYXhpbXVtIHBlcm1pdHRlZCBD
b21tb24gTmFtZSBsZW5ndGggb2YgJWQgY2hhcmFjdGVycyIsIFRMU19DTl9MRU4pOworCSAg
bXNnIChEX1RMU19FUlJPUlMsICJUTFMgQXV0aCBFcnJvcjogLS11c2VybmFtZS1hcy1jb21t
b24gbmFtZSBzcGVjaWZpZWQgYW5kIHVzZXJuYW1lIGlzIGxvbmdlciB0aGFuIHRoZSBtYXhp
bXVtIHBlcm1pdHRlZCBDb21tb24gTmFtZSBsZW5ndGggb2YgJWQgY2hhcmFjdGVycyIsIFRM
U19VU0VSTkFNRV9MRU4pOwogCSAgczEgPSBPUEVOVlBOX1BMVUdJTl9GVU5DX0VSUk9SOwog
CX0KIApkaWZmIC0tZ2l0IGEvc3NsLmggYi9zc2wuaAppbmRleCAzNGM2OTg4Li4wMjIzNGMz
IDEwMDY0NAotLS0gYS9zc2wuaAorKysgYi9zc2wuaApAQCAtMjc4LDggKzI3OCw4IEBACiAg
KiBCdWZmZXIgc2l6ZXMgKGFsc28gc2VlIG10dS5oKS4KICAqLwogCi0vKiBNYXhpbXVtIGxl
bmd0aCBvZiBjb21tb24gbmFtZSAqLwotI2RlZmluZSBUTFNfQ05fTEVOIDY0CisvKiBNYXhp
bXVtIGxlbmd0aCBvZiB0aGUgdXNlcm5hbWUgaW4gY2VydCAqLworI2RlZmluZSBUTFNfVVNF
Uk5BTUVfTEVOIDY0CiAKIC8qIExlZ2FsIGNoYXJhY3RlcnMgaW4gYW4gWDUwOSBvciBjb21t
b24gbmFtZSAqLwogI2RlZmluZSBYNTA5X05BTUVfQ0hBUl9DTEFTUyAgIChDQ19BTE5VTXxD
Q19VTkRFUkJBUnxDQ19EQVNIfENDX0RPVHxDQ19BVHxDQ19DT0xPTnxDQ19TTEFTSHxDQ19F
UVVBTCkKQEAgLTI4OCw2ICsyODgsOSBAQAogLyogTWF4aW11bSBsZW5ndGggb2YgT0NDIG9w
dGlvbnMgc3RyaW5nIHBhc3NlZCBhcyBwYXJ0IG9mIGF1dGggaGFuZHNoYWtlICovCiAjZGVm
aW5lIFRMU19PUFRJT05TX0xFTiA1MTIKIAorLyogRGVmYXVsdCBmaWVsZCBpbiBYNTA5IHRv
IGJlIHVzZXJuYW1lICovCisjZGVmaW5lIFg1MDlfVVNFUk5BTUVfRklFTERfREVGQVVMVCAi
Q04iCisKIC8qCiAgKiBSYW5nZSBvZiBrZXkgZXhjaGFuZ2UgbWV0aG9kcwogICovCg==
--------------060507070204060009010606--


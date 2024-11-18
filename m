MIME-Version: 1.0
References: <CAC8x_z10PT_ToTzVUKQENA5ZJgJ4EMvBJARphDR5_wdytA2JSw@...278...>
 <b7c9a1ac-3322-4eeb-befd-e19c7f72da6b@...1227...>
 <CAC8x_z3Fwf0r-BuvuOo+Vg0708fsaPGWjg-2pnY3xgM+e4QxDg@...278...>
 <Zzm_gUxTAmFZjm_h@...1296...>
 <CAC8x_z1OtkMeuRCHNOHfg-rcJ3Kcj2uHua3pzK5ZqKJDjPvBjQ@...278...>
 <ZzoQ7jXbImL56HL6@...1296...>
 <CAC8x_z2=DL=t2V5oN_hBMLbYcVMH78XqbTLguxFifjDco+zWyQ@...278...>
 <2dae1148-45d8-4f82-8b65-973b81a18645@...1227...>
 <CAC8x_z25-XQEyk0O34nKFMMj-mXNR2r+WbbaseX70mzzZKT+QA@...278...>
 <CAFHpkQHu_Mdt8e-0qpRwJaUAODqsodGUpAGXAwjgh7-9SZbuLA@...278...>
In-Reply-To: <CAFHpkQHu_Mdt8e-0qpRwJaUAODqsodGUpAGXAwjgh7-9SZbuLA@...278...>
From: =?UTF-8?B?16DXqteZINep15jXqNef?= <nsh531@...277...>
Date: Mon, 18 Nov 2024 09:30:58 +0200
Message-ID: <CAC8x_z3HhCYZES5zMBMZOH-MN6wQVS91nqDaVkxTr2TF2UeNDQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000008685da06272ae6ce"
Subject: Re: [Openvpn-devel] Subject: Potential OpenVPN Vulnerability
 Report: Repeated TLS Handshake Failures Leading to Denial-of-Service
 Conditions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, Gert Doering <gert@...1296...>, Antonio Quartulli <antonio@...515...>, SECURITY@...515...

--0000000000008685da06272ae6ce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

this is configuration:


client
nobind
dev tun
remote-cert-tls server

remote 103.6.170.21 1194 udp

<key>
-----BEGIN PRIVATE KEY-----
MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDHcRa93/VAJxQ7
ZvAKTfWgmnBavFPMCxpf19alf6wMcFfJ4bln8U2MIwAciLkmsBNnSmV+I17A26re
C05nodgjY7AUJ4BBS+AE4wqSl8C3fgjOTSkbE5eZiZIjRfwei8tCy6x03he3S3B8
nvSK5ochSkh6owQVu1ktGjRdU8Ltk25/2NK8oaQo/+eEFRenvI+W4y19PxZdwe2P
3tTR2skyvK5dG8jZ1Gz61JbqQ12L4UlKMePcnbncqAwfAQaUEYUIdaHAtj+e6OlE
JyoxEOOHtJu9lShb3vd6t0PfQ0XDl9WgcKOn6bhbx0yNdHolwkaCzDHwxCSbT2UC
2UEARdPBAgMBAAECggEAKos5Kq/HhTPQ4QsIUWpn5yaKqRBbX79OlPtZ0lv1u4GL
eIkqH74dqLMepveTZ2lP+kyoccvhvoodXNhUlU606Heva90xQryIwQIdkz/D4GCG
SFu1VQ1M3Xe3MMcRDQMNDOadlyB5NqRlDnBqAedDFBrgcyirCme4kiJw4SepATx8
7ALd5mCIILQ0ugR/2drjzmkhm8nGd1ABteeINsnvbtx4cnM/V84BS3LIvAXG9Aql
PeblwoHwqGmOS9dQnyi1hM/ALCI35wfTBYICGgze/N8zW2Q7SxUHzHDAX6pJoTQF
JGQof6gfInnWQn4Q39ISyeP8ygv9bDW2svmDTBJTcQKBgQD8XnSIC9xiXUeP5b38
GKqrNphClB7rIlj6wq/yX6X540oHrQctcFAfPkI1MG7WaaMZlkdNsJJ0g3CPCE5J
wcuD2sofVjCJmiQdLUW2bEzWpUz+YrX1/+XG1x/s2ZZW700X9ZkvSkKLYa2Gt1f9
QTQXewPIffoOsSubTmhZL9TPBwKBgQDKT7AkI7l91gq4MPWUvYgoCHOkk4K3/mw5
0QrhmQ+0tPh8qdwsdaa1uLAwrAN/jlOylgdhCrjPOv+NGrKCZdfBNJrv/xkC1Rbx
fpSMq/QnqTtLtbTPfNsIU3LGRwlrub8D1Lci2EILBAtnHw9QneQOJJdu+lsy1/1/
29gklKRM9wKBgHIiKaOJca8OrpmWdlh3s1/hPfUGVgFTNFicCcScm0yrDUTxbMiQ
/btThc/WSpovhjLBMxggneuRsisNv5I90dOc9EI90Y+5pVGIsvlwe0Or2GlHrTFG
/NzzV53fPc2tRflq+k9Xz0aH81l0u5dukKd529klmBxi5ezEBg8nwZ+rAoGAPGTF
hERV30bCNHIJHbnmp2y+eObAIwUEcc4BnY7/rUZI144td+g3OBBGKIFxGeb2/Vzk
HwgAW3yVRR4vI9YbLkXx6qsQYFQUYUsUNVovrJdMaDF6JGZ1TGr83EvgeBQe/ZnG
gdRlArzWWpZfEAXSSpaJzktWZjssJbsPLvxgf8kCgYBXfi3jGHf8zLN+6MKHnlfn
i0qCoYf5yo1LXKaUEER6v6zZ7JKrCqC23wurawTJcg+pImRVZ+3Kyjay0Kj7c3MU
AhH4Bzd8BO9+VcJc5DPxi4ZSxiUJZUqDb87PrZuGOJemj0gzxJTqw4qBhB4GAIvy
GM/49Q/PG5ZJbjxW9vlerg=3D=3D
-----END PRIVATE KEY-----
</key>
<cert>
-----BEGIN CERTIFICATE-----
MIIDVjCCAj6gAwIBAgIRAN337cep9V2XeeYXWF2fnvAwDQYJKoZIhvcNAQELBQAw
FjEUMBIGA1UEAwwLRWFzeS1SU0EgQ0EwHhcNMjQxMTE3MDQyMDMwWhcNMjcwMjIw
MDQyMDMwWjASMRAwDgYDVQQDDAdjbGllbnQxMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAx3EWvd/1QCcUO2bwCk31oJpwWrxTzAsaX9fWpX+sDHBXyeG5
Z/FNjCMAHIi5JrATZ0plfiNewNuq3gtOZ6HYI2OwFCeAQUvgBOMKkpfAt34Izk0p
GxOXmYmSI0X8HovLQsusdN4Xt0twfJ70iuaHIUpIeqMEFbtZLRo0XVPC7ZNuf9jS
vKGkKP/nhBUXp7yPluMtfT8WXcHtj97U0drJMryuXRvI2dRs+tSW6kNdi+FJSjHj
3J253KgMHwEGlBGFCHWhwLY/nujpRCcqMRDjh7SbvZUoW973erdD30NFw5fVoHCj
p+m4W8dMjXR6JcJGgswx8MQkm09lAtlBAEXTwQIDAQABo4GiMIGfMAkGA1UdEwQC
MAAwHQYDVR0OBBYEFD2d6hxKSgVE6IiivIH8sTlblwdlMFEGA1UdIwRKMEiAFCcz
2FBZReYg+fwhVdbI0iGjYM1KoRqkGDAWMRQwEgYDVQQDDAtFYXN5LVJTQSBDQYIU
EkzQbbp3EDAwIKfb1HyU5VWMWPswEwYDVR0lBAwwCgYIKwYBBQUHAwIwCwYDVR0P
BAQDAgeAMA0GCSqGSIb3DQEBCwUAA4IBAQBD4Ongiy24hB5UuYvFhTwta5UmOyij
/L7I48LJBoFX+HKFYSFdWUxuQZEtmTyxZZYMZjucDyZgmmdpmQx7XPstnQx46Rvh
gpvukDr3sTQeoBdIRkIJKMMSYbah7cWUMZSGWGISD2LeU4+qD9HPIiVcEJtZ+bQj
O799wpqguh4QZ/+zV2EP9v/Vr5QuXIpvHj0aKPmehPQmdC36WyN0yE8HaeRVCqV7
HeAAFq7oOv9RFNYABXLSVxB6hdD9P768xlrVSrR2Z4SKA14aI88xv1aUYB/pdcFR
L5Qyof+SPg+Ey3ySTJ8MEcDiPrHqq2gdDIev+vH3H9evD75kESI6tyL6
-----END CERTIFICATE-----
</cert>
<ca>
-----BEGIN CERTIFICATE-----
MIIDSzCCAjOgAwIBAgIUEkzQbbp3EDAwIKfb1HyU5VWMWPswDQYJKoZIhvcNAQEL
BQAwFjEUMBIGA1UEAwwLRWFzeS1SU0EgQ0EwHhcNMjQxMTE3MDQxNzM3WhcNMzQx
MTE1MDQxNzM3WjAWMRQwEgYDVQQDDAtFYXN5LVJTQSBDQTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAJkQ6h8+LudptnikgbOJ+jZxHj7lO64so5OBZZb2
XHLzAfOy/MyCpwVhEGF1StlSgTSb537+mHr0ovcpXYuDlKVA0QpcQHfPScEHFOEF
zM/Fh2TYTnQutSZxEWidFcHGRkxfEG6ogfqWVAcdlN9q2m2XU3W5BkgzWrPyYRX4
+sgGTUFYRewfjYwUEO0tHhPdkbAhxcIYkMgKf7eqjG91ZgIIZUaeGb19DVR5YwVR
ZmADGccFKmyOtZlBlUtDuPTxdx2Jq1nYjqI3SV/Uf7kmUSeTRJp80Uclc7tZqgHz
sSfKCJTmn7nCIEdl9dKzhycA35BsbAtIChCJ7KTvvgdLI4UCAwEAAaOBkDCBjTAd
BgNVHQ4EFgQUJzPYUFlF5iD5/CFV1sjSIaNgzUowUQYDVR0jBEowSIAUJzPYUFlF
5iD5/CFV1sjSIaNgzUqhGqQYMBYxFDASBgNVBAMMC0Vhc3ktUlNBIENBghQSTNBt
uncQMDAgp9vUfJTlVYxY+zAMBgNVHRMEBTADAQH/MAsGA1UdDwQEAwIBBjANBgkq
hkiG9w0BAQsFAAOCAQEAioxSqfWqYw1Gnd5EhzUaT10adIQ63+VyNzSsQrqC7lPs
bPX8+99QSyxouESCLSd6UCR3rfWFTRUxxuoV314AM3fbxBws7A56o4nw4JhYwToi
+DPVGH8bdiBe/65dv8TNoh1g95OM/+hKT2Bwwt5rJuNZ7stzgRkul+Xp8Tet8REn
QkIJBJ+BbRhlvtvDkPbk1G5qGvbXGOnNLb0bW33H3TlW2jGXWqRd66wLH2k+uGQE
SeFU4Lr55f+tW6srJogtmtLI+580gYWvJEZC/MgFx3OlqZepYzTakqqav+jJE7mH
etn+5+8kbeEQhVyC0VezpFg2JyKxhlnbyKqlIDkQqA=3D=3D
-----END CERTIFICATE-----
</ca>
key-direction 1
<tls-auth>
#
# 2048 bit OpenVPN static key
#
-----BEGIN OpenVPN Static key V1-----
1e54b4a61b91a4abc09fa8d5829e0973
e37ba2081b86cf55a76756245e489890
9388ee247381e36a35d2a4a14f812a5b
4ec96ff336bac2557539ad4860c7ccc1
7fbc1820e0fe5c1136c350b961e934aa
6a165d5b810f93a9acc62e69e0f4d873
eaae2fefc4dce042506c023e1203e8a5
5db314ef747aba013128bae175b903be
7be79ad92e1846c8d87369a0b868fe2a
0e6f363b75814e5a3333c657a96bb296
542682ac59711a9bacd3efc2a2f6cc40
d239057492e79a4bb794d347713da273
c06173d5517040bb5c39472e240cc6a1
f65f0fa0a833f7f6254dfc4726eddda3
192efd195941dcae6cd34f9cdf4fce2a
fd321f51c35edc2c6721a658b09a9f01
-----END OpenVPN Static key V1-----
</tls-auth>

redirect-gateway def1


verb 9


What's your opinion on this ?

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=D7=
=B3, 18 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-9:26 =D7=9E=D7=90=D7=AA =
=E2=80=AA=D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=
=BD=E2=80=AC=E2=80=8F <=E2=80=AA
chipitsine@...277...=E2=80=AC=E2=80=8F>:=E2=80=AC

> That must be investigated together with server side logs.
>
> Generally, some packet lost can lead to this, I see similar issues from
> time to time.
>
> On Mon, Nov 18, 2024, 08:11 =D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=D7=9F <=
nsh531@...277...> wrote:
>
>> Hello,
>> I don't have access to server logs, I sent you the client logs as well as
>> the line pointing to the DoS:
>> TLS Error: TLS key negotiation failed to occur within 5 seconds
>> SIGUSR1[soft,tls-error] received, process restarting
>>
>> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=90=
=D7=B3, 17 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-21:09 =D7=9E=D7=90=D7=
=AA =E2=80=AAArne Schwabe=E2=80=AC=E2=80=8F <=E2=80=AA
>> arne@...1227...=E2=80=AC=E2=80=8F>:=E2=80=AC
>>
>>> We asked you for many things in the past mails. We expect to do ALL
>>> these things to properly report the issue. Not just one of them. E.g. l=
ogs
>>> of server, usage of a modern version, a description what the DoS
>>> vulnerability actually is and so on are still missing. Just sending the
>>> client is just not enough.
>>> Am 17.11.2024 um 17:16 schrieb =D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=D7=
=9F:
>>>
>>> i attached logs
>>>
>>> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=90=
=D7=B3, 17 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-17:51 =D7=9E=D7=90=D7=
=AA =E2=80=AAGert Doering=E2=80=AC=E2=80=8F <=E2=80=AA
>>> gert@...1296...=E2=80=AC=E2=80=8F>:=E2=80=AC
>>>
>>>
>>
>> --
>> <https://netanel.ml>
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
>

--=20
<https://netanel.ml>

--0000000000008685da06272ae6ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"rtl"><div dir=3D"ltr">this is configuration:</div><div dir=3D"l=
tr"><br></div><div dir=3D"ltr"><br></div><div dir=3D"ltr">client<br>nobind<=
br>dev tun<br>remote-cert-tls server<br><br>remote 103.6.170.21 1194 udp<br=
><br>&lt;key&gt;<br>-----BEGIN PRIVATE KEY-----<br>MIIEvAIBADANBgkqhkiG9w0B=
AQEFAASCBKYwggSiAgEAAoIBAQDHcRa93/VAJxQ7<br>ZvAKTfWgmnBavFPMCxpf19alf6wMcFf=
J4bln8U2MIwAciLkmsBNnSmV+I17A26re<br>C05nodgjY7AUJ4BBS+AE4wqSl8C3fgjOTSkbE5=
eZiZIjRfwei8tCy6x03he3S3B8<br>nvSK5ochSkh6owQVu1ktGjRdU8Ltk25/2NK8oaQo/+eEF=
RenvI+W4y19PxZdwe2P<br>3tTR2skyvK5dG8jZ1Gz61JbqQ12L4UlKMePcnbncqAwfAQaUEYUI=
daHAtj+e6OlE<br>JyoxEOOHtJu9lShb3vd6t0PfQ0XDl9WgcKOn6bhbx0yNdHolwkaCzDHwxCS=
bT2UC<br>2UEARdPBAgMBAAECggEAKos5Kq/HhTPQ4QsIUWpn5yaKqRBbX79OlPtZ0lv1u4GL<b=
r>eIkqH74dqLMepveTZ2lP+kyoccvhvoodXNhUlU606Heva90xQryIwQIdkz/D4GCG<br>SFu1V=
Q1M3Xe3MMcRDQMNDOadlyB5NqRlDnBqAedDFBrgcyirCme4kiJw4SepATx8<br>7ALd5mCIILQ0=
ugR/2drjzmkhm8nGd1ABteeINsnvbtx4cnM/V84BS3LIvAXG9Aql<br>PeblwoHwqGmOS9dQnyi=
1hM/ALCI35wfTBYICGgze/N8zW2Q7SxUHzHDAX6pJoTQF<br>JGQof6gfInnWQn4Q39ISyeP8yg=
v9bDW2svmDTBJTcQKBgQD8XnSIC9xiXUeP5b38<br>GKqrNphClB7rIlj6wq/yX6X540oHrQctc=
FAfPkI1MG7WaaMZlkdNsJJ0g3CPCE5J<br>wcuD2sofVjCJmiQdLUW2bEzWpUz+YrX1/+XG1x/s=
2ZZW700X9ZkvSkKLYa2Gt1f9<br>QTQXewPIffoOsSubTmhZL9TPBwKBgQDKT7AkI7l91gq4MPW=
UvYgoCHOkk4K3/mw5<br>0QrhmQ+0tPh8qdwsdaa1uLAwrAN/jlOylgdhCrjPOv+NGrKCZdfBNJ=
rv/xkC1Rbx<br>fpSMq/QnqTtLtbTPfNsIU3LGRwlrub8D1Lci2EILBAtnHw9QneQOJJdu+lsy1=
/1/<br>29gklKRM9wKBgHIiKaOJca8OrpmWdlh3s1/hPfUGVgFTNFicCcScm0yrDUTxbMiQ<br>=
/btThc/WSpovhjLBMxggneuRsisNv5I90dOc9EI90Y+5pVGIsvlwe0Or2GlHrTFG<br>/NzzV53=
fPc2tRflq+k9Xz0aH81l0u5dukKd529klmBxi5ezEBg8nwZ+rAoGAPGTF<br>hERV30bCNHIJHb=
nmp2y+eObAIwUEcc4BnY7/rUZI144td+g3OBBGKIFxGeb2/Vzk<br>HwgAW3yVRR4vI9YbLkXx6=
qsQYFQUYUsUNVovrJdMaDF6JGZ1TGr83EvgeBQe/ZnG<br>gdRlArzWWpZfEAXSSpaJzktWZjss=
JbsPLvxgf8kCgYBXfi3jGHf8zLN+6MKHnlfn<br>i0qCoYf5yo1LXKaUEER6v6zZ7JKrCqC23wu=
rawTJcg+pImRVZ+3Kyjay0Kj7c3MU<br>AhH4Bzd8BO9+VcJc5DPxi4ZSxiUJZUqDb87PrZuGOJ=
emj0gzxJTqw4qBhB4GAIvy<br>GM/49Q/PG5ZJbjxW9vlerg=3D=3D<br>-----END PRIVATE =
KEY-----<br>&lt;/key&gt;<br>&lt;cert&gt;<br>-----BEGIN CERTIFICATE-----<br>=
MIIDVjCCAj6gAwIBAgIRAN337cep9V2XeeYXWF2fnvAwDQYJKoZIhvcNAQELBQAw<br>FjEUMBI=
GA1UEAwwLRWFzeS1SU0EgQ0EwHhcNMjQxMTE3MDQyMDMwWhcNMjcwMjIw<br>MDQyMDMwWjASMR=
AwDgYDVQQDDAdjbGllbnQxMIIBIjANBgkqhkiG9w0BAQEFAAOC<br>AQ8AMIIBCgKCAQEAx3EWv=
d/1QCcUO2bwCk31oJpwWrxTzAsaX9fWpX+sDHBXyeG5<br>Z/FNjCMAHIi5JrATZ0plfiNewNuq=
3gtOZ6HYI2OwFCeAQUvgBOMKkpfAt34Izk0p<br>GxOXmYmSI0X8HovLQsusdN4Xt0twfJ70iua=
HIUpIeqMEFbtZLRo0XVPC7ZNuf9jS<br>vKGkKP/nhBUXp7yPluMtfT8WXcHtj97U0drJMryuXR=
vI2dRs+tSW6kNdi+FJSjHj<br>3J253KgMHwEGlBGFCHWhwLY/nujpRCcqMRDjh7SbvZUoW973e=
rdD30NFw5fVoHCj<br>p+m4W8dMjXR6JcJGgswx8MQkm09lAtlBAEXTwQIDAQABo4GiMIGfMAkG=
A1UdEwQC<br>MAAwHQYDVR0OBBYEFD2d6hxKSgVE6IiivIH8sTlblwdlMFEGA1UdIwRKMEiAFCc=
z<br>2FBZReYg+fwhVdbI0iGjYM1KoRqkGDAWMRQwEgYDVQQDDAtFYXN5LVJTQSBDQYIU<br>Ek=
zQbbp3EDAwIKfb1HyU5VWMWPswEwYDVR0lBAwwCgYIKwYBBQUHAwIwCwYDVR0P<br>BAQDAgeAM=
A0GCSqGSIb3DQEBCwUAA4IBAQBD4Ongiy24hB5UuYvFhTwta5UmOyij<br>/L7I48LJBoFX+HKF=
YSFdWUxuQZEtmTyxZZYMZjucDyZgmmdpmQx7XPstnQx46Rvh<br>gpvukDr3sTQeoBdIRkIJKMM=
SYbah7cWUMZSGWGISD2LeU4+qD9HPIiVcEJtZ+bQj<br>O799wpqguh4QZ/+zV2EP9v/Vr5QuXI=
pvHj0aKPmehPQmdC36WyN0yE8HaeRVCqV7<br>HeAAFq7oOv9RFNYABXLSVxB6hdD9P768xlrVS=
rR2Z4SKA14aI88xv1aUYB/pdcFR<br>L5Qyof+SPg+Ey3ySTJ8MEcDiPrHqq2gdDIev+vH3H9ev=
D75kESI6tyL6<br>-----END CERTIFICATE-----<br>&lt;/cert&gt;<br>&lt;ca&gt;<br=
>-----BEGIN CERTIFICATE-----<br>MIIDSzCCAjOgAwIBAgIUEkzQbbp3EDAwIKfb1HyU5VW=
MWPswDQYJKoZIhvcNAQEL<br>BQAwFjEUMBIGA1UEAwwLRWFzeS1SU0EgQ0EwHhcNMjQxMTE3MD=
QxNzM3WhcNMzQx<br>MTE1MDQxNzM3WjAWMRQwEgYDVQQDDAtFYXN5LVJTQSBDQTCCASIwDQYJK=
oZIhvcN<br>AQEBBQADggEPADCCAQoCggEBAJkQ6h8+LudptnikgbOJ+jZxHj7lO64so5OBZZb2=
<br>XHLzAfOy/MyCpwVhEGF1StlSgTSb537+mHr0ovcpXYuDlKVA0QpcQHfPScEHFOEF<br>zM/=
Fh2TYTnQutSZxEWidFcHGRkxfEG6ogfqWVAcdlN9q2m2XU3W5BkgzWrPyYRX4<br>+sgGTUFYRe=
wfjYwUEO0tHhPdkbAhxcIYkMgKf7eqjG91ZgIIZUaeGb19DVR5YwVR<br>ZmADGccFKmyOtZlBl=
UtDuPTxdx2Jq1nYjqI3SV/Uf7kmUSeTRJp80Uclc7tZqgHz<br>sSfKCJTmn7nCIEdl9dKzhycA=
35BsbAtIChCJ7KTvvgdLI4UCAwEAAaOBkDCBjTAd<br>BgNVHQ4EFgQUJzPYUFlF5iD5/CFV1sj=
SIaNgzUowUQYDVR0jBEowSIAUJzPYUFlF<br>5iD5/CFV1sjSIaNgzUqhGqQYMBYxFDASBgNVBA=
MMC0Vhc3ktUlNBIENBghQSTNBt<br>uncQMDAgp9vUfJTlVYxY+zAMBgNVHRMEBTADAQH/MAsGA=
1UdDwQEAwIBBjANBgkq<br>hkiG9w0BAQsFAAOCAQEAioxSqfWqYw1Gnd5EhzUaT10adIQ63+Vy=
NzSsQrqC7lPs<br>bPX8+99QSyxouESCLSd6UCR3rfWFTRUxxuoV314AM3fbxBws7A56o4nw4Jh=
YwToi<br>+DPVGH8bdiBe/65dv8TNoh1g95OM/+hKT2Bwwt5rJuNZ7stzgRkul+Xp8Tet8REn<b=
r>QkIJBJ+BbRhlvtvDkPbk1G5qGvbXGOnNLb0bW33H3TlW2jGXWqRd66wLH2k+uGQE<br>SeFU4=
Lr55f+tW6srJogtmtLI+580gYWvJEZC/MgFx3OlqZepYzTakqqav+jJE7mH<br>etn+5+8kbeEQ=
hVyC0VezpFg2JyKxhlnbyKqlIDkQqA=3D=3D<br>-----END CERTIFICATE-----<br>&lt;/c=
a&gt;<br>key-direction 1<br>&lt;tls-auth&gt;<br>#<br># 2048 bit OpenVPN sta=
tic key<br>#<br>-----BEGIN OpenVPN Static key V1-----<br>1e54b4a61b91a4abc0=
9fa8d5829e0973<br>e37ba2081b86cf55a76756245e489890<br>9388ee247381e36a35d2a=
4a14f812a5b<br>4ec96ff336bac2557539ad4860c7ccc1<br>7fbc1820e0fe5c1136c350b9=
61e934aa<br>6a165d5b810f93a9acc62e69e0f4d873<br>eaae2fefc4dce042506c023e120=
3e8a5<br>5db314ef747aba013128bae175b903be<br>7be79ad92e1846c8d87369a0b868fe=
2a<br>0e6f363b75814e5a3333c657a96bb296<br>542682ac59711a9bacd3efc2a2f6cc40<=
br>d239057492e79a4bb794d347713da273<br>c06173d5517040bb5c39472e240cc6a1<br>=
f65f0fa0a833f7f6254dfc4726eddda3<br>192efd195941dcae6cd34f9cdf4fce2a<br>fd3=
21f51c35edc2c6721a658b09a9f01<br>-----END OpenVPN Static key V1-----<br>&lt=
;/tls-auth&gt;<br><br>redirect-gateway def1<br><br><br>verb 9<br></div><div=
><br></div><div><br></div><div dir=3D"ltr">What&#39;s your opinion on=C2=A0=
this ?<br></div><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><div =
dir=3D"rtl" class=3D"gmail_attr">=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=
=9A =D7=99=D7=95=D7=9D =D7=91=D7=B3, 18 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024=
 =D7=91-9:26 =D7=9E=D7=90=D7=AA =E2=80=AA=D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=
=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD=E2=80=AC=E2=80=8F &lt;=E2=80=AA<a href=3D=
"mailto:chipitsine@...277...">chipitsine@...277...</a>=E2=80=AC=E2=80=8F&gt=
;:=E2=80=AC<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div=
 dir=3D"auto">That must be investigated together with server side logs.<div=
 dir=3D"auto"><br></div><div dir=3D"auto">Generally, some packet lost can l=
ead to this, I see similar issues from time=C2=A0to time.=C2=A0</div></div>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon=
, Nov 18, 2024, 08:11 =D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=D7=9F &lt;<a hr=
ef=3D"mailto:nsh531@...277..." target=3D"_blank">nsh531@...277...</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"rtl"><div dir=3D"rtl"><div style=3D"direction:ltr">Hello,</div><div sty=
le=3D"direction:ltr">I don&#39;t have access to server logs, I sent you the=
 client logs as well as the line pointing to the DoS:</div><div style=3D"di=
rection:ltr">TLS Error: TLS key negotiation failed to occur within 5 second=
s</div><div style=3D"direction:ltr">SIGUSR1[soft,tls-error] received, proce=
ss restarting</div></div><div style=3D"direction:ltr"><br></div><div class=
=3D"gmail_quote"><div dir=3D"rtl" class=3D"gmail_attr" style=3D"direction:l=
tr">=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=90=
=D7=B3, 17 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-21:09 =D7=9E=D7=90=D7=
=AA =E2=80=AAArne Schwabe=E2=80=AC=E2=80=8F &lt;=E2=80=AA<a href=3D"mailto:=
arne@...1227..." rel=3D"noreferrer" target=3D"_blank">arne@...1227...</a>=
=E2=80=AC=E2=80=8F&gt;:=E2=80=AC<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex"><u></u>

=20=20
=20=20=20=20
=20=20
  <div>
    <p style=3D"direction:ltr">We asked you for many things in the past mai=
ls. We expect to do
      ALL these things to properly report the issue. Not just one of
      them. E.g. logs of server, usage of a modern version, a
      description what the DoS vulnerability actually is and so on are
      still missing. Just sending the client is just not enough. <br>
    </p>
    <div style=3D"direction:ltr">Am 17.11.2024 um 17:16 schrieb =D7=A0=D7=
=AA=D7=99
      =D7=A9=D7=98=D7=A8=D7=9F:<br>
    </div>
    <blockquote type=3D"cite">
=20=20=20=20=20=20
      <div dir=3D"rtl">
        <div dir=3D"ltr">i attached logs <br>
        </div>
      </div>
      <div style=3D"direction:ltr"><br></div>
      <div class=3D"gmail_quote">
        <div dir=3D"rtl" class=3D"gmail_attr" style=3D"direction:ltr">=E2=
=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=90=D7=B3,=
 17 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024
          =D7=91-17:51 =D7=9E=D7=90=D7=AA =E2=80=AAGert Doering=E2=80=AC=E2=
=80=8F &lt;=E2=80=AA<a href=3D"mailto:gert@...1296..." rel=3D"noreferrer" t=
arget=3D"_blank">gert@...1296...</a>=E2=80=AC=E2=80=8F&gt;:=E2=80=AC</div>
      </div>
    </blockquote>
  </div>

</blockquote></div><div style=3D"direction:ltr"><br clear=3D"all"></div><di=
v style=3D"direction:ltr"><br></div><span class=3D"gmail_signature_prefix">=
<div style=3D"direction:ltr">--</div></span><div dir=3D"rtl" class=3D"gmail=
_signature"><div dir=3D"rtl" style=3D"direction:ltr"><a href=3D"https://net=
anel.ml" rel=3D"noreferrer" target=3D"_blank"><img width=3D"200" height=3D"=
51" src=3D"https://ci3.googleusercontent.com/mail-sig/AIorK4y1ahZg0mqH5UnDC=
jKIkW6FTSni5R5bezS1idSRECO6GXQ1uH3RgELXk8RqqCoNk3985_jsnIQnnclo"></a></div>=
</div></div>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" rel=3D"noreferrer" t=
arget=3D"_blank">Openvpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://lists.sourceforge.net/=
lists/listinfo/openvpn-devel</a><br>
</blockquote></div>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"rtl" class=3D"gmail_s=
ignature"><div dir=3D"rtl"><a href=3D"https://netanel.ml" target=3D"_blank"=
><img width=3D"200" height=3D"51" src=3D"https://ci3.googleusercontent.com/=
mail-sig/AIorK4y1ahZg0mqH5UnDCjKIkW6FTSni5R5bezS1idSRECO6GXQ1uH3RgELXk8RqqC=
oNk3985_jsnIQnnclo"></a></div></div></div>

--0000000000008685da06272ae6ce--


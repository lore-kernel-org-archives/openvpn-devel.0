Message-ID: <53585929.306@...1901...>
Date: Wed, 23 Apr 2014 20:22:01 -0400
From: Timothe Litt <litt@...1901...>
MIME-Version: 1.0
References: <53572C4E.7010701@...1901...>	<20140423081058.GJ16637@...1296...>	<53579C5D.5000902@...1435...>	<5357DDFC.2010401@...1901...>	<53581D43.6060501@...1856...>
	<53584B0C.8020209@...1901...> <53585356.8020602@...515...>
In-Reply-To: <53585356.8020602@...515...>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
	micalg=sha1; boundary="------------ms010909070103070700080807"
Subject: Re: [Openvpn-devel] Progress on Version negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Yonan <james@...515...>, Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is a cryptographically signed message in MIME format.

--------------ms010909070103070700080807
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable

> I don't see that cryptoapi.c has been updated to work with TLS 1.2.=20
Yes, just came to the same conclusion.

Long-term the key-loaders need to get updated.

Maybe short-term the options that invoke them could force NO_TLSv_1_2...

That would make things work for most people in the short term.

On 23-Apr-14 19:57, James Yonan wrote:
> On 23/04/2014 17:21, Timothe Litt wrote:
>> On 23-Apr-14 16:06, Steffan Karger wrote:
>>> I generated a matching pair of traces of the failure (client and=20
>>> server)
>>> & posted a summary.
>>>
>>> Let me know if you would like the full traces.
>> Sent off-list.
>>>
>>> I've been trying to reproduce the error. I grabbed my spare pi from the
>>> desk drawer and built 2.3.3 from sources like you describe in #385. I
>>> fired up a Windows 8.1 VM, and installed OpenVPN 2.3.3-I002 (x64). This
>>> setup however happily connects with TLSv1.2. It's hard to get a hold on
>>> this one...
>> My windows client is XP, 32-bit.  It's a physical machine (old=20
>> notebook).
>>
>> Although the problem first surfaced on 2.3.3, I'm now running off
>> git-master (of a few days back).  How I did that is in #385 too.
>>
>> For those on the list:
>>
>> With a hint from Steffan,
>>
>> I have established that the client certificate is not being sent.  I
>> believe this is a client issue.
>>
>> It appears that including the cert/key in the conf file, rather than
>> from the crypto API makes 1.2 work.
>>
>> We suspect there's some issue due to 1.2's larger hashes/message size.
>> Not clear whether the cryptoapi interface is the cause or a victim.
>>
>> As I can't build the windows client (it's really annoying that it
>> requires commercial tools), further debug will need help from folks who
>> can.
>>
>> As always, let me know if I can do anything more to help.
>
> I don't see that cryptoapi.c has been updated to work with TLS 1.2.=20
> Note the comment in rsa_priv_enc that says "For now, we only support=20
> NID_md5_sha1".  But TLS 1.2 appears to require the support of=20
> additional hash algorithms.
>
> See section 4.7. "Cryptographic Attributes" in TLS 1.2 RFC.
>
> Note that the signature algorithm is now specified along with the=20
> signature:
>
>       struct {
>          SignatureAndHashAlgorithm algorithm;
>          opaque signature<0..2^16-1>;
>       } DigitallySigned;
>
> So it would appear that any client-side private key offloading (such=20
> as Crypto API, PKCS#11, OS-level KeyChains, etc. would need to be=20
> aware of this feature so as to take into account the hash algorithm.
>
> James



--------------ms010909070103070700080807
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIPDzCC
BjQwggQcoAMCAQICASAwDQYJKoZIhvcNAQEFBQAwfTELMAkGA1UEBhMCSUwxFjAUBgNVBAoT
DVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNp
Z25pbmcxKTAnBgNVBAMTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTA3
MTAyNDIxMDI1NVoXDTE3MTAyNDIxMDI1NVowgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1T
dGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWdu
aW5nMTgwNgYDVQQDEy9TdGFydENvbSBDbGFzcyAyIFByaW1hcnkgSW50ZXJtZWRpYXRlIENs
aWVudCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMsohUWcASz7GfKrpTOM
KqANy9BV7V0igWdGxA8IU77L3aTxErQ+fcxtDYZ36Z6GH0YFn7fq5RADteP0AYzrCA+EQTfi
8q1+kA3m0nwtwXG94M5sIqsvs7lRP1aycBke/s5g9hJHryZ2acScnzczjBCAo7X1v5G3yw8M
DP2m2RCye0KfgZ4nODerZJVzhAlOD9YejvAXZqHksw56HzElVIoYSZ3q4+RJuPXXfIoyby+Y
2m1E+YzX5iCZXBx05gk6MKAW1vaw4/v2OOLy6FZH3XHHtOkzUreG//CsFnB9+uaYSlR65cdG
zTsmoIK8WH1ygoXhRBm98SD7Hf/r3FELNvUCAwEAAaOCAa0wggGpMA8GA1UdEwEB/wQFMAMB
Af8wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBSuVYNv7DHKufcd+q9rMfPIHeOsuzAfBgNV
HSMEGDAWgBROC+8apEBbpRdphzDKNGhD0EGu8jBmBggrBgEFBQcBAQRaMFgwJwYIKwYBBQUH
MAGGG2h0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9jYTAtBggrBgEFBQcwAoYhaHR0cDovL3d3
dy5zdGFydHNzbC5jb20vc2ZzY2EuY3J0MFsGA1UdHwRUMFIwJ6AloCOGIWh0dHA6Ly93d3cu
c3RhcnRzc2wuY29tL3Nmc2NhLmNybDAnoCWgI4YhaHR0cDovL2NybC5zdGFydHNzbC5jb20v
c2ZzY2EuY3JsMIGABgNVHSAEeTB3MHUGCysGAQQBgbU3AQIBMGYwLgYIKwYBBQUHAgEWImh0
dHA6Ly93d3cuc3RhcnRzc2wuY29tL3BvbGljeS5wZGYwNAYIKwYBBQUHAgEWKGh0dHA6Ly93
d3cuc3RhcnRzc2wuY29tL2ludGVybWVkaWF0ZS5wZGYwDQYJKoZIhvcNAQEFBQADggIBADqp
Jw3I07QWke9plNBpxUxcffc7nUrIQpJHDci91DFG7fVhHRkMZ1J+BKg5UNUxIFJ2Z9B90Mic
c/NXcs7kPBRdn6XGO/vPc87Y6R+cWS9Nc9+fp3Enmsm94OxOwI9wn8qnr/6o3mD4noP9Jphw
UPTXwHovjavRnhUQHLfo/i2NG0XXgTHXS2Xm0kVUozXqpYpAdumMiB/vezj1QHQJDmUdPYMc
p+reg9901zkyT3fDW/ivJVv6pWtkh6Pw2ytZT7mvg7YhX3V50Nv860cV11mocUVcqBLv0gcT
+HBDYtbuvexNftwNQKD5193A7zN4vG7CTYkXxytSjKuXrpEatEiFPxWgb84nVj25SU5q/r1X
hwby6mLhkbaXslkVtwEWT3Van49rKjlK4XrUKYYWtnfzq6aSak5u0Vpxd1rY79tWhD3EdCvO
hNz/QplNa+VkIsrcp7+8ZhP1l1b2U6MaxIVteuVMD3X0vziIwr7jxYae9FZjbxlpUemqXjcC
0QaFfN7qI0JsQMALL7iGRBg7K0CoOBzECdD3fuZil5kU/LP9cr1BK31U0Uy651bFnAMMMkqh
AChIbn0ei72VnbpSsrrSdF0BAGYQ8vyHae5aCg+H75dVCV33K6FuxZrf09yTz+Vx/PkdRUYk
XmZz/OTfyJXsUOUXrym6KvI2rYpccSk5MIII0zCCB7ugAwIBAgICJtUwDQYJKoZIhvcNAQEF
BQAwgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJT
ZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFydENvbSBD
bGFzcyAyIFByaW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQTAeFw0xMjA5MjUxODQyMTha
Fw0xNDA5MjcxOTIyNDJaMIGQMRkwFwYDVQQNExBPZ3RBNVhZZXZheGFkbGtKMQswCQYDVQQG
EwJVUzEWMBQGA1UECBMNTWFzc2FjaHVzZXR0czEVMBMGA1UEBxMMU291dGhib3JvdWdoMRUw
EwYDVQQDEwxUaW1vdGhlIExpdHQxIDAeBgkqhkiG9w0BCQEWEXRpbW90aGVAbGl0dHMubmV0
MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA38JrSHJ7GVdQiTppuafIBrhphuLL
HAmpeAFNvUBuUUh4X8Nx4Ag03hrC/B7OWYpUJI1HgWCK/eMtKEWF7UMwFhkMeqWSdrZyb4uk
EqTf46SyyAghF6BGuuVTiptED63FwzQY2PTXCmAJviuRXoJMzlhAwzUFpsWTFhswigFLrMCn
kJ9nndqnxQmMFpD7pjJ6kFkxKz/5k1CEzAfSerWHkIOBuXFyYpDDgDFXN1+qF25HsVVw+4xT
1/tNvCEVQ9WAleUznLvWgT5sV8tTewsUiYOgSqyoHiuJCOc9YJF2pUHGZVV+WzS8YIb95ax5
5yoS+C3D3FFzl6CbcI3nc6csqkP4bNBqm96Z/WdfTV4ouoycI4N9AJ86l6/Ygjz3/juFI9ni
as8nE051hksnyCon87fyP3/NezZ9NcUYVUnki1cVhfh2cN+s79fGWbUJePjT0fmso0FVcSRp
ddLyeZladbifFG+TiQO9BFt97e16OwyFpXRIzZWnfEiG2ss51Vpv9au8RrLgBD07aKE3mzZp
xZzoZ8c/jgb1YcUyAyaVmdOk4A3eGe7c8Loa+eYIRwkbjoE6H/PKcoRNIqnYQ44zvOOONRDI
S3vBpzofVK5Ndx0NVDIvsbWEPb9ntR32taUUZ334SPN447UO3sjvItFg1oOuC1i6kL6l1vRM
GNouPvECAwEAAaOCBDcwggQzMAkGA1UdEwQCMAAwCwYDVR0PBAQDAgSwMB0GA1UdJQQWMBQG
CCsGAQUFBwMCBggrBgEFBQcDBDAdBgNVHQ4EFgQUJZNwH8x9MtxbZmI9AK6Jj+IELcowHwYD
VR0jBBgwFoAUrlWDb+wxyrn3HfqvazHzyB3jrLswgaYGA1UdEQSBnjCBm4ERdGltb3RoZUBs
aXR0cy5uZXSBEXRpbW90aGVAbGl0dHMubmV0gQxsaXR0QGFjbS5vcmeBDWxpdHRAaWVlZS5v
cmeBFGhvc3RtYXN0ZXJAbGl0dHMubmV0gRdsaXR0c25ldGFkbWluQGxpdHRzLm5ldIETd2lr
aWFkbWluQGxpdHRzLm5ldIESc2VjdXJpdHlAbGl0dHMubmV0MIICIQYDVR0gBIICGDCCAhQw
ggIQBgsrBgEEAYG1NwECAjCCAf8wLgYIKwYBBQUHAgEWImh0dHA6Ly93d3cuc3RhcnRzc2wu
Y29tL3BvbGljeS5wZGYwNAYIKwYBBQUHAgEWKGh0dHA6Ly93d3cuc3RhcnRzc2wuY29tL2lu
dGVybWVkaWF0ZS5wZGYwgfcGCCsGAQUFBwICMIHqMCcWIFN0YXJ0Q29tIENlcnRpZmljYXRp
b24gQXV0aG9yaXR5MAMCAQEagb5UaGlzIGNlcnRpZmljYXRlIHdhcyBpc3N1ZWQgYWNjb3Jk
aW5nIHRvIHRoZSBDbGFzcyAyIFZhbGlkYXRpb24gcmVxdWlyZW1lbnRzIG9mIHRoZSBTdGFy
dENvbSBDQSBwb2xpY3ksIHJlbGlhbmNlIG9ubHkgZm9yIHRoZSBpbnRlbmRlZCBwdXJwb3Nl
IGluIGNvbXBsaWFuY2Ugb2YgdGhlIHJlbHlpbmcgcGFydHkgb2JsaWdhdGlvbnMuMIGcBggr
BgEFBQcCAjCBjzAnFiBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTADAgECGmRM
aWFiaWxpdHkgYW5kIHdhcnJhbnRpZXMgYXJlIGxpbWl0ZWQhIFNlZSBzZWN0aW9uICJMZWdh
bCBhbmQgTGltaXRhdGlvbnMiIG9mIHRoZSBTdGFydENvbSBDQSBwb2xpY3kuMDYGA1UdHwQv
MC0wK6ApoCeGJWh0dHA6Ly9jcmwuc3RhcnRzc2wuY29tL2NydHUyLWNybC5jcmwwgY4GCCsG
AQUFBwEBBIGBMH8wOQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9zdWIv
Y2xhc3MyL2NsaWVudC9jYTBCBggrBgEFBQcwAoY2aHR0cDovL2FpYS5zdGFydHNzbC5jb20v
Y2VydHMvc3ViLmNsYXNzMi5jbGllbnQuY2EuY3J0MCMGA1UdEgQcMBqGGGh0dHA6Ly93d3cu
c3RhcnRzc2wuY29tLzANBgkqhkiG9w0BAQUFAAOCAQEAXJ5dj2hKDwAh3aPsYWSJdC6PE7O2
u4pZz4H1mucRf3ZLoLjrAMhtINAqrWkvfiOTWQruNpQAXL+Gb6pk5sDoSXwISbPraVMb4uCS
g++F/XTCvqfsCitXd6Jhl5dyV0pi2MwmHyrBsjsER1EwA+39av+cfoL0gKuJy5y92wRt0It8
Eu77N5HaMlDlxEXXTQWP5Q2g7IZy+/ZeeG8FjrUM/bmwyvdb3mBreKgL2mZHnG+mf09IDACG
9ogoV2xJNQ0lRHxH5NJ/XGSztQACboxl3wK/t86Vhh6i1JeaLMcJ5oaemxdATK0NZVk/hIK0
hXGzTMVw1xoP/9LSYyoRD6yypzGCBNowggTWAgEBMIGTMIGMMQswCQYDVQQGEwJJTDEWMBQG
A1UEChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNh
dGUgU2lnbmluZzE4MDYGA1UEAxMvU3RhcnRDb20gQ2xhc3MgMiBQcmltYXJ5IEludGVybWVk
aWF0ZSBDbGllbnQgQ0ECAibVMAkGBSsOAwIaBQCgggIbMBgGCSqGSIb3DQEJAzELBgkqhkiG
9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE0MDQyNDAwMjIwMVowIwYJKoZIhvcNAQkEMRYEFD1P
FP7p6mCniFoY+0msm3W95kljMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYF
Kw4DAgcwDQYIKoZIhvcNAwICASgwgaQGCSsGAQQBgjcQBDGBljCBkzCBjDELMAkGA1UEBhMC
SUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENl
cnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDIgUHJpbWFyeSBJ
bnRlcm1lZGlhdGUgQ2xpZW50IENBAgIm1TCBpgYLKoZIhvcNAQkQAgsxgZaggZMwgYwxCzAJ
BgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGln
aXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFydENvbSBDbGFzcyAyIFBy
aW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQQICJtUwDQYJKoZIhvcNAQEBBQAEggIAIwME
LvTtvfQYDUWg3B80pZRXmRWf9Swtou7E7d2k/zJsYlKTrFeL3N+tLJHWELVqd0dAANUkiflb
LPt5vHgj3Uqe3ZbWRZT1tXqpyyPyQ6u/H0KmevAMbhAjf2oY6HYWX0pWgZCrI7/F3lscbZw4
x64pDEak8OSroWj53yhHC6RnxsKkyylMMf+oTYKNq3/8gr/QUYpsIuoAuiUuY819W+xkmm35
c0F9Oox6NZs2qulOyu7VAecYdEmiK9ghYXWfxcZtc5lgSPLrpDsYwdv5M0lfdOeagS9ouLlh
FXQ7lfVtEwnQqh1y4IcbZDJa6YvDPYlPG204zvAzPgGjxri+Mt1ppd/rqR2ySlgdhGPYTjsj
S7tszXggw8KxNJgiwn1L6i5iSDjYB/2brsAdQHVquifqaqpUjgg0n09ohFfmMon79UDGDhW+
zBVSfngY9+dkNbAuWy+5hQ86P2ERqGqyyLGSvfYa3SGoBuTCAVLdbiYXEPZNTI8eH+L9NsOw
oHrzKZI38ICR5FS3jKdZfPGBeZ7aEnaAWfMyIHuS6A5v/tVpzf42uhaEYKFdEHIyzclDunbv
u1RHYW8XiVHhI+LRQdfcZKkEUiZFdlSb3vW8HdMAAWePshqnVNsMqDoNSlzR+IQZ+NT69qrc
b5hth41Gxw2FZABt7MMMMSMx5Jay/eQAAAAAAAA=
--------------ms010909070103070700080807--


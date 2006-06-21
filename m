From: "Dave" <dev@...575...>
Date: Wed, 21 Jun 2006 09:40:15 -0500
Message-ID: <001d01c69540$a8d86f80$1601a8c0@...576...>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_0018_01C69516.B22DC140"
In-Reply-To: <Pine.LNX.4.64.0606211002070.31137@...210...>
Subject: Re: [Openvpn-devel] DHCP on PocketPC port
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: 'Mathias Sundman' <mathias@...454...>
Cc: 'Christer Lindell' <christer.lindell@...341...>, 'Kenneth Karlsson' <kenneth.karlsson@...341...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_0018_01C69516.B22DC140
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Mathias Sundman [mailto:mathias@...454...] 

...
>> When pushing an IP to an OpenVPN client and using the DHCP feature in 
>> the TAP-Win32 driver to have it assigned to the windows client, I 
>> believe OpenVPN or the TAP-Win32 driver is blocking the DHCP requests 
>> from traversing the VPN tunnel. This is the behavior I'd expect as 
>> well.
>>
>> Now, while testing the PocketPC port, I just realized that I recieved 
>> two IP addresses! One from the TAP-Win32 driver, pushed from the 
>> OpenVPN server, the correct one, but also one from my real DHCP 
>> server on the remote network. We're using TAP and bridging... So 
>> obviously the PocketPC
>> port does not block these packets, even though the build-in
>> DHCP server in
>> the TAP driver is replying to the DHCP requests.
...

> > What device are you using?
> 
> Qtek 2020i with Windows Mobile PocketPC 2003 SE.
> 
> > Also, how are you determining that there are two addresses 
> on the TAP 
> > device?
> 
> Viewing the "Net" tab on the TAP device.
> 
> I just realized we're not using the latest version of your 
> port. Have you 
> done any changes in the code that could/should affect this in 
> the latest 
> relases? We'll update anyway and let you know if it makes any 
> difference.

...

It would have to be a really old one that you are using for it to
potentially matter; the TAP driver was the first thing that I worked on,
and the last significant fix (which was indeed in the DHCP area) was done
in early May.

It's entirely possible that I broke this as I did have to make
modifications throughout to accommodate PocketPC's driver model.


------=_NextPart_000_0018_01C69516.B22DC140
Content-Type: application/x-pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIORjCCBHAw
ggNYoAMCAQICEB+0zZj6uUmxQ2K5VZ1P12EwDQYJKoZIhvcNAQEFBQAwga4xCzAJBgNVBAYTAlVT
MQswCQYDVQQIEwJVVDEXMBUGA1UEBxMOU2FsdCBMYWtlIENpdHkxHjAcBgNVBAoTFVRoZSBVU0VS
VFJVU1QgTmV0d29yazEhMB8GA1UECxMYaHR0cDovL3d3dy51c2VydHJ1c3QuY29tMTYwNAYDVQQD
Ey1VVE4tVVNFUkZpcnN0LUNsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgRW1haWwwHhcNMDUwNjA3
MDgwOTEwWhcNMTkwNzA5MTczNjU4WjBlMQswCQYDVQQGEwJTRTEUMBIGA1UEChMLQWRkVHJ1c3Qg
QUIxHTAbBgNVBAsTFEFkZFRydXN0IFRUUCBOZXR3b3JrMSEwHwYDVQQDExhBZGRUcnVzdCBDbGFz
cyAxIENBIFJvb3QwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCWltQhSWDia+hBBwze
xODcEyPNwTXH+9ZOEQpnXvUGW2ulCDtbKRY654eyNAbFvAWlA3yCyykQruGIgb3WntP+LVbBFc7j
Jp0VLhD7Bo8wBN6ntGO0/7Gcrjyvd7ZWxbWroulpOj0OM3kyP3CCkplhbY0wCI9xP6ZIVxn4JdxL
ZlyldI+Yrsj5wAYi56xz36Uu+1LcsRVlIPo1Zmne3yzxbrww2ywkEtvrNTVokMsAsJchPXQhI2U0
K7t4WaPW4XY5mqRJjox0r26kmqPZm9I4XJuiGMx1I4S+6+JNM3GOGvDC+Mcdoq0Dlyz4zyXG9rgk
MbFjXZJ/Y/AlyVMuH79NAgMBAAGjgdEwgc4wHwYDVR0jBBgwFoAUiYJnfcSdJnAAS7RQSHzePa4E
bn0wHQYDVR0OBBYEFJWxtPCUtr3H2tERCSG+wa9J/RB7MA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMB
Af8EBTADAQH/MBEGCWCGSAGG+EIBAQQEAwIAATBYBgNVHR8EUTBPME2gS6BJhkdodHRwOi8vY3Js
LnVzZXJ0cnVzdC5jb20vVVROLVVTRVJGaXJzdC1DbGllbnRBdXRoZW50aWNhdGlvbmFuZEVtYWls
LmNybDANBgkqhkiG9w0BAQUFAAOCAQEAaenDt4Gwt0ps0AgcIC5PrbDFLtmGHU116Z2Ok+MEWh9p
Lgv/mvP50iMHmRqHMGGiIngTqsioHxNL64GxQF6EfG7tEpPCUr6dj4iW4XZvYFF0nT7/3AoLtP27
1e7/k+Dh7/LJxMN9flJEjrQZF5vTiDM1G5g5EMXVLk31lpzXfbxMV6X2iD9BrSNLmk7bZ69/EsDz
W7Y44lu6XPYCWRWdZAuSfoopDa0AdQxf1MzGzSfdlSTlOEV9Y81qezrb2rXVR4y3DQPhCxjzImQo
KXoyoBzj+hY78e3nhaNU4eI8IfyjqXjrzFTM9B8aFinNgbqmbMWOnmDn/WFJQN50NCXR9TCCBKIw
ggOKoAMCAQICEES+DItQACS0EdM2JSVnyYkwDQYJKoZIhvcNAQEFBQAwga4xCzAJBgNVBAYTAlVT
MQswCQYDVQQIEwJVVDEXMBUGA1UEBxMOU2FsdCBMYWtlIENpdHkxHjAcBgNVBAoTFVRoZSBVU0VS
VFJVU1QgTmV0d29yazEhMB8GA1UECxMYaHR0cDovL3d3dy51c2VydHJ1c3QuY29tMTYwNAYDVQQD
Ey1VVE4tVVNFUkZpcnN0LUNsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgRW1haWwwHhcNOTkwNzA5
MTcyODUwWhcNMTkwNzA5MTczNjU4WjCBrjELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAlVUMRcwFQYD
VQQHEw5TYWx0IExha2UgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3JrMSEwHwYD
VQQLExhodHRwOi8vd3d3LnVzZXJ0cnVzdC5jb20xNjA0BgNVBAMTLVVUTi1VU0VSRmlyc3QtQ2xp
ZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBFbWFpbDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBALI5haTyfatBO2JGN67NwWB1vDll+UoaR6K5zEjMapjVTTUZuaRC5c5J4oovHnzSMQfHTrSD
ZJ0uKdWiZMSFvYVRNXmkTmiQexx6pJKoF/KYFfKTzMmkMpW7DE8wvZigC4vlbhuiRvp4vKJvq1le
pS/Pytptqi/rrKGzaqq3Lmc1i3nhHmmI4uZGzaCl6r4LznY6eg6b6vzaJ1s9cx8i5khhxkzzabGo
Lhu21DEgLLyCio6kDqXXiUP8FlqvHXHXEVnauocNr/rz4cLwpMVnjNbWVDreCqS6A3ezZcj9HtN0
YqoYymiTHqGFfvVHZcv4TVcodNI0/zC27vZiMBSMLOsCAwEAAaOBuTCBtjALBgNVHQ8EBAMCAcYw
DwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUiYJnfcSdJnAAS7RQSHzePa4Ebn0wWAYDVR0fBFEw
TzBNoEugSYZHaHR0cDovL2NybC51c2VydHJ1c3QuY29tL1VUTi1VU0VSRmlyc3QtQ2xpZW50QXV0
aGVudGljYXRpb25hbmRFbWFpbC5jcmwwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMA0G
CSqGSIb3DQEBBQUAA4IBAQCxbWFdphp/fKtK5DD8U28lJMbK7eIxXCsO7u5hVW8EPs853sUbSZTk
6yBMtOaeUC5y2Y31qqOzStpWHGCXgNyCoq1KvYor/wsJtMbXIARF5M2AAbq6K27OqteS/uSv6/Qm
HRYqf2wwlTcvMxKsf93H0RGMUZiy0KOR0K32n56Dkx4dQrhGr2tm8Jt/6uMDAuUCUcGq1TWdckAD
iboxHcUQaFKe36KFxVwIpnjmU0+x6LfTFJ6TpsNk46x+cc28n+kDG8z76awxwa98FXQCmcOyR6bC
MmHXx29IJFEnodWHVfJ7j5g9Fp7udbb40I7y88auKFun8PM2F/zDBdPKA0pUMIIFKDCCBBCgAwIB
AgIRAMG8RE3S9dJ/og75uCywV7UwDQYJKoZIhvcNAQEFBQAwZTELMAkGA1UEBhMCU0UxFDASBgNV
BAoTC0FkZFRydXN0IEFCMR0wGwYDVQQLExRBZGRUcnVzdCBUVFAgTmV0d29yazEhMB8GA1UEAxMY
QWRkVHJ1c3QgQ2xhc3MgMSBDQSBSb290MB4XDTA2MDQwNDAwMDAwMFoXDTA3MDQwNDIzNTk1OVow
gdoxNTAzBgNVBAsTLENvbW9kbyBUcnVzdCBOZXR3b3JrIC0gUEVSU09OQSBOT1QgVkFMSURBVEVE
MUYwRAYDVQQLEz1UZXJtcyBhbmQgQ29uZGl0aW9ucyBvZiB1c2U6IGh0dHA6Ly93d3cuY29tb2Rv
Lm5ldC9yZXBvc2l0b3J5MR8wHQYDVQQLExYoYykyMDAzIENvbW9kbyBMaW1pdGVkMRUwEwYDVQQD
EwxEYXZpZCBMZW1sZXkxITAfBgkqhkiG9w0BCQEWEmRldkB6aWdndXJhdDI5LmNvbTCBnzANBgkq
hkiG9w0BAQEFAAOBjQAwgYkCgYEAtrXbIaDGSLg2sPMFfJva/5mxeVed9ru1+qRM7L/uY+Uc/wII
DqDVQlk9SQHTzMS8QPNelPvPeM9tucHou9QVsLVdbtslheWVmOUWlZxs2QWHMn4jatSni0xdQ3oN
F1D99+ZRoGdoWhmA437/jKa7c66T8Il4weagkjp3sc+6cH8CAwEAAaOCAd8wggHbMB0GA1UdDgQW
BBTHFuRlq1bxmiJjz6BFhcl7iRWVhDAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAgBgNV
HSUEGTAXBggrBgEFBQcDBAYLKwYBBAGyMQEDBQIwEQYJYIZIAYb4QgEBBAQDAgUgMEYGA1UdIAQ/
MD0wOwYMKwYBBAGyMQECAQEBMCswKQYIKwYBBQUHAgEWHWh0dHBzOi8vc2VjdXJlLmNvbW9kby5u
ZXQvQ1BTMHcGA1UdHwRwMG4wNqA0oDKGMGh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0FkZFRydXN0
Q2xhc3MxQ0FSb290LmNybDA0oDKgMIYuaHR0cDovL2NybC5jb21vZG8ubmV0L0FkZFRydXN0Q2xh
c3MxQ0FSb290LmNybDCBhgYIKwYBBQUHAQEEejB4MDsGCCsGAQUFBzAChi9odHRwOi8vY3J0LmNv
bW9kb2NhLmNvbS9BZGRUcnVzdFVUTkNsaWVudENBLmNydDA5BggrBgEFBQcwAoYtaHR0cDovL2Ny
dC5jb21vZG8ubmV0L0FkZFRydXN0VVROQ2xpZW50Q0EuY3J0MB0GA1UdEQQWMBSBEmRldkB6aWdn
dXJhdDI5LmNvbTANBgkqhkiG9w0BAQUFAAOCAQEAX0YHky/KnTJyfx744x0g3UMjkRBbLShe37oD
VAJXUgICeJZlvdO50qM/Wr7AFNM+mdN0WZBbnH4vtGgULvJqHPUCvmEy/LKPZt8DH0hmiSH2naUl
h7NVvqvv4qIr+WTStb/huyALe2AgnFzV5eOOQHsXK3yo3puXzw1vGlhvN2bj7+UJPDdU+D61uQeW
xRND3SBTPGpM0dIDGKyNzbzYN2zVKqw1MHFB79dhTw4ZMmAKbtoL2GiMeugo0DTbh1cFWwNs8Jhw
ONTjqY5I/jSGgTwKxTM5bmuwmhu6MF7X0bc/7hGoh46PjGzQKqMg7jIO0p27ilrFfCuvkXSVhYHw
nDGCAwQwggMAAgEBMHowZTELMAkGA1UEBhMCU0UxFDASBgNVBAoTC0FkZFRydXN0IEFCMR0wGwYD
VQQLExRBZGRUcnVzdCBUVFAgTmV0d29yazEhMB8GA1UEAxMYQWRkVHJ1c3QgQ2xhc3MgMSBDQSBS
b290AhEAwbxETdL10n+iDvm4LLBXtTAJBgUrDgMCGgUAoIIB4DAYBgkqhkiG9w0BCQMxCwYJKoZI
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNjA2MjExNDQwMTNaMCMGCSqGSIb3DQEJBDEWBBSksbtt
R9XVJMHHM6unWTiIGPVvBDBnBgkqhkiG9w0BCQ8xWjBYMAoGCCqGSIb3DQMHMAcGBSsOAwIaMA4G
CCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDAKBggq
hkiG9w0CBTCBiQYJKwYBBAGCNxAEMXwwejBlMQswCQYDVQQGEwJTRTEUMBIGA1UEChMLQWRkVHJ1
c3QgQUIxHTAbBgNVBAsTFEFkZFRydXN0IFRUUCBOZXR3b3JrMSEwHwYDVQQDExhBZGRUcnVzdCBD
bGFzcyAxIENBIFJvb3QCEQDBvERN0vXSf6IO+bgssFe1MIGLBgsqhkiG9w0BCRACCzF8oHowZTEL
MAkGA1UEBhMCU0UxFDASBgNVBAoTC0FkZFRydXN0IEFCMR0wGwYDVQQLExRBZGRUcnVzdCBUVFAg
TmV0d29yazEhMB8GA1UEAxMYQWRkVHJ1c3QgQ2xhc3MgMSBDQSBSb290AhEAwbxETdL10n+iDvm4
LLBXtTANBgkqhkiG9w0BAQEFAASBgKlEE6MQxJ7A//2JhqczkIgAc+4XI2S5X+KVpOTMpwkpJ/XE
9C8UuE/3PIa66agIU+PA+fyJAAZfjNWo9ZvOLIz2hJsE+4sXTPd2DwCJ//ozzgboLpNYku6XtMJy
vwx19h4HoxZICJFKH7dYix60gRznDKY5LUDd8aXbG86FBYAoAAAAAAAA

------=_NextPart_000_0018_01C69516.B22DC140--



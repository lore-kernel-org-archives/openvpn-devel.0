Message-ID: <40F129CE.8050708@...83...>
From: Jan Kiszka <jan.kiszka@...83...>
MIME-Version: 1.0
References: <40E18559.8020407@...244...> <40EA6CFD.2030603@...83...> <Pine.LNX.4.60.0407061112170.372@...210...> <200407071803.14060.jim@...41...>
In-Reply-To: <200407071803.14060.jim@...41...>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms070205060300060209020901"
Subject: [Openvpn-devel] Re: Interface with GUI agent
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun Jul 11 04:53:23 2004
To: James Yonan <jim@...41...>
Cc: Mathias Sundman <mathias@...209...>, openvpn-devel@lists.sourceforge.net

This is a cryptographically signed message in MIME format.

--------------ms070205060300060209020901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

James Yonan wrote:
> 
> I'm not sure that we really need a wrapper for unix, because most unix users 
> will control OpenVPN by:
> 
> (1) editing config files and starting from /etc/init.d, or
> (2) using some sort of GUI-based admin tool such as YaST
> 
> and both of these methods are traditionally done as root.
> 

You consider the typical openvpn user in a client scenario under unix as 
a command line freak - might be still true for the moment, but certainly 
not in the future. An increasing number of gui-oriented users are 
switching over to unix, in particular linux. And what would be better 
for a smooth switch-over than finding a similar gui on both platforms? 
Command line freaks already have anything the need with what openvpn now 
provides, so this is not the audience we should target.

> ...
>>>Yes, this will work. But I'm afraid - maybe I'm wrong - that the GUI will
>>>then have to be implemented quite differently on Windows and Unix. On
>>>Windows, we would open a socket and both send the commands over it and
>>>receive the status. On Unix, we would first start the process and then
>>>connect to a socket for status information (BTW, which socket would then
>>>be used when multiple instances of openvpn are running?).
> 
> 
> Should the unix GUI be written for generic X, or should we develop admin 
> modules for specific distros such as YaST?
> 
> I would go for the latter, because it will make the interface fit more 
> seamlessly into a distribution's existing admin infrastructure.
> 

I would not think about an admin gui at the moment. Maybe this will 
never be needed as configuration files are much easier to handle. I'm 
personally not looking for gui dialogs where I can select and combine 
graphically any option the openvpn service provides - in case this is 
the impression you got of my feature request. If SuSE, any other 
distributor, or projects like webmin are interested in providing some 
gui for creating the config file, let them do this. But we should first 
concentrate on an interface for *using* openvpn in daily work!

Jan

--------------ms070205060300060209020901
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIO2TCC
A+8wggLXoAMCAQICBAKZUF0wDQYJKoZIhvcNAQEEBQAwgaAxCzAJBgNVBAYTAkRFMRIwEAYD
VQQKEwlXRUIuREUgQUcxFTATBgNVBAsTDFRydXN0IENlbnRlcjEaMBgGA1UEBxMRRC03NjIy
NyBLYXJsc3J1aGUxLTArBgNVBAMTJFdFQi5ERSBUcnVzdENlbnRlciBFTWFpbC1aZXJ0aWZp
a2F0ZTEbMBkGCSqGSIb3DQEJARYMdHJ1c3RAd2ViLmRlMB4XDTA0MDYxMzE1MTQyM1oXDTA1
MDYxMzE1MTQyM1owczELMAkGA1UEBhMCREUxFDASBgNVBAgTC0RldXRzY2hsYW5kMRcwFQYD
VQQHEw4zMDE2OSBIYW5ub3ZlcjETMBEGA1UEAxMKSmFuIEtpc3prYTEgMB4GCSqGSIb3DQEJ
ARYRamFuLmtpc3prYUB3ZWIuZGUwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBANozkUHk
x2pHAdiEX50PQZLRfCk3V1zfCxnVpXKLLsM2IdkrhJMuF5ZneV4NP349hZAs4cM1jGaIKgJy
RptQynJlcInQ+EeTR07kpPZpt0V3ID731rJEbvlWWPo3tLAAfFd6GXLkpfVX4bsmHzdzW0Zw
iUw2PC9mo4SDpxAL210FAgMBAAGjgeAwgd0wLAYJYIZIAYb4QgEEBB8WHWh0dHBzOi8vdHJ1
c3Qud2ViLmRlL3J2Q0EvP3M9MCMGCWCGSAGG+EIBAgQWFhRodHRwczovL3RydXN0LndlYi5k
ZTAWBglghkgBhvhCAQMECRYHL3J2Lz9zPTAWBglghkgBhvhCAQcECRYHL3JuLz9zPTAaBglg
hkgBhvhCAQgEDRYLL0hpbGZlL0FHQi8wKQYJYIZIAYb4QgENBBwWGkZyZWVtYWlsIEVtYWls
IGNlcnRpZmljYXRlMBEGCWCGSAGG+EIBAQQEAwIAsDANBgkqhkiG9w0BAQQFAAOCAQEApl9u
RxoFZa0gpY3uCD0jUVzlHKU22AjtxhFoPnJT1sEdz0cG+xfBZuOSFGw/QjFV9WPNNe7FlGjK
x960xb4hlA1EAnnrw/QFefhsNHvMvazEom731JHR5Caf67MQR5ZyDwidXTFx6Hhvf+hMyRxB
IIpisFPWrz3WjlGa0GEmLjZwKb8/0BOTpuyMIKDzglTgm+xawmjoTau48hnukkAgH5/MMDjN
lp3j+QwHbdOJN32j5uOuhIVXC63PdWtW+rzBYv7+fzyc7rWIlYLuR4mz0aQEb93Lwuf1w7XA
BI/Rrf2WANEEXW7OkR8YenDn6ibQYSZaHTRfUVr8A4+rVxiy8TCCA+8wggLXoAMCAQICBAKZ
UF0wDQYJKoZIhvcNAQEEBQAwgaAxCzAJBgNVBAYTAkRFMRIwEAYDVQQKEwlXRUIuREUgQUcx
FTATBgNVBAsTDFRydXN0IENlbnRlcjEaMBgGA1UEBxMRRC03NjIyNyBLYXJsc3J1aGUxLTAr
BgNVBAMTJFdFQi5ERSBUcnVzdENlbnRlciBFTWFpbC1aZXJ0aWZpa2F0ZTEbMBkGCSqGSIb3
DQEJARYMdHJ1c3RAd2ViLmRlMB4XDTA0MDYxMzE1MTQyM1oXDTA1MDYxMzE1MTQyM1owczEL
MAkGA1UEBhMCREUxFDASBgNVBAgTC0RldXRzY2hsYW5kMRcwFQYDVQQHEw4zMDE2OSBIYW5u
b3ZlcjETMBEGA1UEAxMKSmFuIEtpc3prYTEgMB4GCSqGSIb3DQEJARYRamFuLmtpc3prYUB3
ZWIuZGUwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBANozkUHkx2pHAdiEX50PQZLRfCk3
V1zfCxnVpXKLLsM2IdkrhJMuF5ZneV4NP349hZAs4cM1jGaIKgJyRptQynJlcInQ+EeTR07k
pPZpt0V3ID731rJEbvlWWPo3tLAAfFd6GXLkpfVX4bsmHzdzW0ZwiUw2PC9mo4SDpxAL210F
AgMBAAGjgeAwgd0wLAYJYIZIAYb4QgEEBB8WHWh0dHBzOi8vdHJ1c3Qud2ViLmRlL3J2Q0Ev
P3M9MCMGCWCGSAGG+EIBAgQWFhRodHRwczovL3RydXN0LndlYi5kZTAWBglghkgBhvhCAQME
CRYHL3J2Lz9zPTAWBglghkgBhvhCAQcECRYHL3JuLz9zPTAaBglghkgBhvhCAQgEDRYLL0hp
bGZlL0FHQi8wKQYJYIZIAYb4QgENBBwWGkZyZWVtYWlsIEVtYWlsIGNlcnRpZmljYXRlMBEG
CWCGSAGG+EIBAQQEAwIAsDANBgkqhkiG9w0BAQQFAAOCAQEApl9uRxoFZa0gpY3uCD0jUVzl
HKU22AjtxhFoPnJT1sEdz0cG+xfBZuOSFGw/QjFV9WPNNe7FlGjKx960xb4hlA1EAnnrw/QF
efhsNHvMvazEom731JHR5Caf67MQR5ZyDwidXTFx6Hhvf+hMyRxBIIpisFPWrz3WjlGa0GEm
LjZwKb8/0BOTpuyMIKDzglTgm+xawmjoTau48hnukkAgH5/MMDjNlp3j+QwHbdOJN32j5uOu
hIVXC63PdWtW+rzBYv7+fzyc7rWIlYLuR4mz0aQEb93Lwuf1w7XABI/Rrf2WANEEXW7OkR8Y
enDn6ibQYSZaHTRfUVr8A4+rVxiy8TCCBu8wggTXoAMCAQICAQQwDQYJKoZIhvcNAQEEBQAw
gY0xCzAJBgNVBAYTAkRFMRowGAYDVQQHExFELTc2MjI3IEthcmxzcnVoZTESMBAGA1UEChMJ
V0VCLkRFIEFHMRQwEgYDVQQLEwtUcnVzdENlbnRlcjEbMBkGA1UEAxMSV0VCLkRFIFRydXN0
Q2VudGVyMRswGQYJKoZIhvcNAQkBFgx0cnVzdEB3ZWIuZGUwHhcNMDIxMjAxMDAwMDAwWhcN
MDkwNjE5MjM1OTU5WjCBoDELMAkGA1UEBhMCREUxEjAQBgNVBAoTCVdFQi5ERSBBRzEVMBMG
A1UECxMMVHJ1c3QgQ2VudGVyMRowGAYDVQQHExFELTc2MjI3IEthcmxzcnVoZTEtMCsGA1UE
AxMkV0VCLkRFIFRydXN0Q2VudGVyIEVNYWlsLVplcnRpZmlrYXRlMRswGQYJKoZIhvcNAQkB
Fgx0cnVzdEB3ZWIuZGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDvSMwjmwx/
6m/VNtPHL8e6C4CMyHpkj3Fb+OtVRp6ARU2giHdrQ6YRweVuHhzMRPi/2WKl8Ucd3tinS8G6
8HZoySafhkYfQtWZ5pumYf1QqEilf45n/BSe0S3jXHX6ksj1E55Y5FQTn6kF4q92IIC7eFAO
mXnF2aso1Evk1oZwP4kybqulJOtzmMAxhQD5mAeoFcjxcEWZB9a3gWUourcPX5S9AFylkRMi
Kb9cPwLfQRgzBol755aEd9jipin7S2ri/589JXTtqHwSvfQ8Q/RPfMebbgVAC7CPLlbn3yCy
334I5feq4pB/Eg8o9t8fZ9rAXHOcl6zYkXnCKU1uyDCLAgMBAAGjggJDMIICPzAMBgNVHRME
BTADAQH/MDEGA1UdHwQqMCgwJqAkoCKGIGh0dHA6Ly90cnVzdC53ZWIuZGUvY3JsL2NhMDEu
Y3JsMBEGCWCGSAGG+EIBAQQEAwIABzAjBglghkgBhvhCAQIEFhYUaHR0cHM6Ly90cnVzdC53
ZWIuZGUwGgYJYIZIAYb4QgEIBA0WCy9IaWxmZS9BR0IvMBYGCWCGSAGG+EIBAwQJFgcvcnYv
P3M9MBYGCWCGSAGG+EIBBwQJFgcvcm4vP3M9MIIBKwYJYIZIAYb4QgENBIIBHBaCARhUcnVz
dENlbnRlciB2b24gV0VCLkRFIC0gRU1haWwtWmVydGlmaWthdGUKCkRpZSBOdXR6dW5nIGRp
ZXNlcyBaZXJ0aWZpa2F0ZXMgd2lyZCB2b24gZGVuIEFsbGdlbWVpbmVuIEdlc2No5GZ0c2Jl
ZGluZ3VuZ2VuIChBR0IpIC8gWmVydGlmaXppZXJ1bmdzcmljaHRsaW5pZW4gZGVzIFdFQi5E
RSBUcnVzdENlbnRlcnMgZ2VyZWdlbHQuCkRpZSBBR0JzIHVuZCBaZXJ0aWZpemllcnVuZ3Ny
aWNodGxpbmllbiBzaW5kIHVudGVyIGh0dHA6Ly90cnVzdC53ZWIuZGUvSGlsZmUvIGVpbnNl
aGJhci4KMEkGA1UdIARCMEAwPgYLYIZIAYb4RQEHAQEwLzAtBggrBgEFBQcCARYhaHR0cDov
L3RydXN0LndlYi5kZS9IaWxmZS9Qb2xpY3kvMA0GCSqGSIb3DQEBBAUAA4ICAQAPQ+WZE2G4
egtLpo1g3lJ2VqNOB+gtBMD1nNfjE6l48j2BTI4GMLc5fTyZKKctApdLI9n2Ln2TBAXD7PJb
n8siboz1XRo01Dh9LVAZP7SAyRq9W9xfTIKCdFiUmK6SSJHsuDEPfBKW3rN4NvwY7CU9ySVP
c4aLL1czpTPIkJacsIE+ZxdkB291wY7A8goKMCoFdWAgcnge5c3dkAivBKlYp8otU/vM/lCN
oZ+Z1UlxzT1Wao0lVJ1AEqNNXscOu7DyVzmwFssC3wcCihyTzpkee1jNUyV0mMbtJOUKp88d
BocWhkOoJni57wcITGjQYvl6L888XeED0L84zzSc82R/Rgw2LBs4eiXEaafbGqXJ2GBIS9/8
TNb2DzkqzRehJ8ikr+enJxK5m/hJB30yxp1n7FPS7O0VrUzUShphDqDKRdcpVUkHGEHlqC+f
GrEibYhJ9Z/XmMHGyl36qxaT+R3cr7JPMdD+/YnyOVgiqXxuWwpEFF8NDhGwb9QV+bA1KAep
epMAZ3DoCl57uj6glalAWJSMBo17vm1LuqXVXHarBUqAS8k2IRc5DPvEyLLjEJqsRCe1hqQH
b/c2dGGdGgP1S0V6dsAsSBxdHqadRKd7JKPfw4D5tRJRRSduyAk5ipP1/+EqKngAnDZf5x/h
NYZMZd0cnlCn2x1JpZjN9YIBBjGCA4EwggN9AgEBMIGpMIGgMQswCQYDVQQGEwJERTESMBAG
A1UEChMJV0VCLkRFIEFHMRUwEwYDVQQLEwxUcnVzdCBDZW50ZXIxGjAYBgNVBAcTEUQtNzYy
MjcgS2FybHNydWhlMS0wKwYDVQQDEyRXRUIuREUgVHJ1c3RDZW50ZXIgRU1haWwtWmVydGlm
aWthdGUxGzAZBgkqhkiG9w0BCQEWDHRydXN0QHdlYi5kZQIEAplQXTAJBgUrDgMCGgUAoIIC
LTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNDA3MTExMTUx
NDJaMCMGCSqGSIb3DQEJBDEWBBSNg63CVu7wF8hqs42pWKRKsMAs0zBSBgkqhkiG9w0BCQ8x
RTBDMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMC
BzANBggqhkiG9w0DAgIBKDCBugYJKwYBBAGCNxAEMYGsMIGpMIGgMQswCQYDVQQGEwJERTES
MBAGA1UEChMJV0VCLkRFIEFHMRUwEwYDVQQLEwxUcnVzdCBDZW50ZXIxGjAYBgNVBAcTEUQt
NzYyMjcgS2FybHNydWhlMS0wKwYDVQQDEyRXRUIuREUgVHJ1c3RDZW50ZXIgRU1haWwtWmVy
dGlmaWthdGUxGzAZBgkqhkiG9w0BCQEWDHRydXN0QHdlYi5kZQIEAplQXTCBvAYLKoZIhvcN
AQkQAgsxgayggakwgaAxCzAJBgNVBAYTAkRFMRIwEAYDVQQKEwlXRUIuREUgQUcxFTATBgNV
BAsTDFRydXN0IENlbnRlcjEaMBgGA1UEBxMRRC03NjIyNyBLYXJsc3J1aGUxLTArBgNVBAMT
JFdFQi5ERSBUcnVzdENlbnRlciBFTWFpbC1aZXJ0aWZpa2F0ZTEbMBkGCSqGSIb3DQEJARYM
dHJ1c3RAd2ViLmRlAgQCmVBdMA0GCSqGSIb3DQEBAQUABIGATeTPr2/nUgsxyOKNaCdqm2vT
8aL6BR5HuS6shAoqAhMk2pz6ehQBo9EuEjD/Opl6lpkrBbXJ7iSVPTpgMEf486Chs0zJqCgm
NRVyIRxjjDNVcNMUCw4ehXIf+7sJuVZr3lVwTgagVAgag8hyH/0p6RMa4bov6eTtgvBJtvnf
HkEAAAAAAAA=
--------------ms070205060300060209020901--


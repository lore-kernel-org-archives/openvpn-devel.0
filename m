Message-ID: <4CD277AE.5000104@...1147...>
Date: Thu, 04 Nov 2010 10:06:54 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <mailman.25039.1288190128.5007.openvpn-devel@lists.sourceforge.net>
	<000c01cb7bfa$dcad0c80$96072580$@soto@...1413...>
In-Reply-To: <000c01cb7bfa$dcad0c80$96072580$@soto@...1413...>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="------------ms030200000904080209050002"
Subject: Re: [Openvpn-devel] Problem with client reconnect when
 using	username-as-common-name and username is blank
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Carlos Soto <carlos.soto@...1413...>
Cc: openvpn-devel@lists.sourceforge.net

This is a cryptographically signed message in MIME format.

--------------ms030200000904080209050002
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Carlos,

this looks like a repeat of something reported on March 1st :

in multi.c the function multi_client_connect_setenv contains

1410   /* setenv incoming cert common name for script */
1411   setenv_str (mi->context.c2.es, "common_name", tls_common_name=20
(mi->context.c2.tls_multi, true));

this is missing from the corresponding multi_client_disconnect_setenv=20
function....

Unfortunately the openvpn-devel folks were unable to reproduce this=20
error and hence no patch was not included. Can you try adding these two=20
lines to "multi_client_disconnect_setenv" , rebuild openvpn and see if=20
the problem goes away?

HTH,

JJK

Carlos Soto wrote:
> I have been having a very strange behavior with openvpn and I have finally
> found the source. I do not know if it is a bug or not so I will explain it
> and let the experts decide.
>
> I am using OpenVPN 2.1.3 in several openwrt routers connected with ADSL w=
ith
> dynamic IPs. Every once in a client reconnects (normally because there is=
 a
> change in the IP). As I do not use the cn-duplicate, when the client
> reconnects, it first calls the client-disconnect script and then the clie=
nt
> connect. See log:
>
> Thu Nov  4 07:55:16 2010 XX.148.40.117:42335 [javier] Peer Connection
> Initiated with XX.148.40.117:42335
> Thu Nov 04 07:55:16 2010 XX.148.40.117:45483 openvpn_scripts:
> (CN=3Djavier/cn=3Djavier) start client-disconnect
> Thu Nov  4 07:55:16 2010 javier/XX.148.40.117:42335 TCP/UDP: Closing sock=
et
> Thu Nov  4 07:55:16 2010 MULTI: new connection by client 'javier' will ca=
use
> previous active sessions by this client to be dropped.  Remember to use t=
he
> --duplicate-cn option if you want multiple clients using the same
> certificate or username to concurrently connect.
> Thu Nov 04 07:55:16 2010 XX.148.40.117:42335 openvpn_scripts:
> (CN=3Djavier/cn=3Djavier) start client-connect
>
> openvpn_scripts are the log entries from my custom scripts that setup the
> iptables and routes. This is all the expected behavior.
>
> The problem comes when I activate the username-as-common-name option. When
> the client reconnects, the client-disconnect script does not get called a=
nd
> only the client connect script gets called. The username is always blank =
for
> this particular connection and CN. After the reconnection is done, there =
is
> a timeout of the first connection because of the ping-restart option and =
the
> client-disconnect script gets called. Here is the log
>
> Thu Nov  4 08:24:29 2010 XX.148.40.117:39056 TLS: Initial packet from
> XX.148.40.117:39056, sid=3D2b306f61 c6c30e51
> Thu Nov  4 08:24:33 2010 XX.148.40.117:39056 VERIFY OK: depth=3D1,
> /C=3DES/ST=3DMAD/L=3DMadrid/O=3DCS/CN=3DCS_CA/emailAddress=3Dxx@...1383...
> Thu Nov  4 08:24:33 2010 XX.148.40.117:39056 VERIFY OK: depth=3D0,
> /C=3DES/ST=3DMAD/L=3DMadrid/O=3DCS/CN=3Djavier/emailAddress=3Dxx@...1428...=
..
> Thu Nov 04 08:24:34 2010 XX.148.40.117:39056 openvpn_scripts:
> (CN=3Djavier/cn=3Djavier) start user-pass-verify
> Thu Nov  4 08:24:34 2010 XX.148.40.117:39056 TLS: Username/Password
> authentication succeeded for username '' [CN SET]
> Thu Nov  4 08:24:34 2010 XX.148.40.117:39056 Data Channel Encrypt: Cipher
> 'BF-CBC' initialized with 128 bit key
> Thu Nov  4 08:24:34 2010 XX.148.40.117:39056 Data Channel Encrypt: Using =
160
> bit message hash 'SHA1' for HMAC authentication
> Thu Nov  4 08:24:34 2010 XX.148.40.117:39056 Data Channel Decrypt: Cipher
> 'BF-CBC' initialized with 128 bit key
> Thu Nov  4 08:24:34 2010 XX.148.40.117:39056 Data Channel Decrypt: Using =
160
> bit message hash 'SHA1' for HMAC authentication
> Thu Nov  4 08:24:35 2010 XX.148.40.117:39056 Control Channel: TLSv1, ciph=
er
> TLSv1/SSLv3 DHE-RSA-AES256-SHA, 1024 bit RSA
> Thu Nov  4 08:24:35 2010 XX.148.40.117:39056 [] Peer Connection Initiated
> with XX.148.40.117:39056
> Thu Nov 04 08:24:35 2010 XX.148.40.117:39056 openvpn_scripts: (CN=3Djavie=
r)
> start client-connect
> route: SIOCADDRT: File exists
> Thu Nov  4 08:24:35 2010 XX.148.40.117:39056 OPTIONS IMPORT: reading clie=
nt
> specific options from: /tmp//openvpn_cc_9448a5143bd3e6786d2b8060da752fe5.=
tmp
> Thu Nov  4 08:24:35 2010 XX.148.40.117:39056 MULTI: Learn: 10.1.16.18 ->
> XX.148.40.117:39056
> Thu Nov  4 08:24:35 2010 XX.148.40.117:39056 MULTI: primary virtual IP for
> XX.148.40.117:39056: 10.1.16.18
> Thu Nov  4 08:24:35 2010 XX.148.40.117:39056 MULTI: internal route
> 10.2.0.0/16 -> XX.148.40.117:39056
> Thu Nov  4 08:24:35 2010 XX.148.40.117:39056 MULTI: Learn: 10.2.0.0/16 ->
> XX.148.40.117:39056
> Thu Nov  4 08:24:37 2010 XX.148.40.117:39056 PUSH: Received control messa=
ge:
> 'PUSH_REQUEST'
> Thu Nov  4 08:24:37 2010 XX.148.40.117:39056 SENT CONTROL [UNDEF]:
> 'PUSH_REPLY,route 10.1.16.1,topology net30,ping 10,ping-restart 60,route
> 10.1.0.0 255.255.0.0,ifconfig 10.1.16.18 10.1.16.17' (status=3D1)
> Thu Nov  4 08:24:45 2010 MULTI: Learn: 10.2.0.2 -> XX.148.40.117:39056
> Thu Nov  4 08:24:57 2010 XX.148.40.117:46554 [UNDEF] Inactivity timeout
> (--ping-restart), restarting
> Thu Nov  4 08:24:57 2010 XX.148.40.117:46554 SIGUSR1[soft,ping-restart]
> received, client-instance restarting
> Thu Nov 04 08:24:57 2010 XX.148.40.117:46554 openvpn_scripts: (CN=3Djavie=
r)
> start client-disconnect
> Thu Nov  4 08:24:57 2010 TCP/UDP: Closing socket
> Thu Nov  4 08:24:57 2010 XX.148.40.117:39056 MULTI: Learn: 10.2.0.2 ->
> XX.148.40.117:39056
>
> After this happens the VPN is still up and working but because of the out=
 of
> sequence call to the scripts the routes have been deleted and no traffic
> flows.
>
> Looking at the source code (but not having debugged it), I see that as the
> username is blank and that becomes the commonname, the call to
> tls_common_name=20
> in multi_delete_dup will returns NULL and the iteration to close the
> instances do not get executed. Changing the second parameter of the two
> tls_common_name call to false may do the trick but I do not know  what ot=
her
> side effects may have.
>
> I am going to avoid the whole issue by changing my scripts and dropping t=
he
> username-as-common-name option as it is a bit flaky especially when used =
as
> I do where some connections have usernames/password authentications and
> other don=B4t and end up with blank common names.
>
> Regards
> Carlos
>
>
> -------------------------------------------------------------------------=
-----
> The Next 800 Companies to Lead America's Growth: New Video Whitepaper
> David G. Thomson, author of the best-selling book "Blueprint to a=20
> Billion" shares his insights and actions to help propel your=20
> business during the next growth cycle. Listen Now!
> http://p.sf.net/sfu/SAP-dev2dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20=20=20



--------------ms030200000904080209050002
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIVSjCC
BIowggNyoAMCAQICECf06hH0eobEbp27bqkXBwcwDQYJKoZIhvcNAQEFBQAwbzELMAkGA1UE
BhMCU0UxFDASBgNVBAoTC0FkZFRydXN0IEFCMSYwJAYDVQQLEx1BZGRUcnVzdCBFeHRlcm5h
bCBUVFAgTmV0d29yazEiMCAGA1UEAxMZQWRkVHJ1c3QgRXh0ZXJuYWwgQ0EgUm9vdDAeFw0w
NTA2MDcwODA5MTBaFw0yMDA1MzAxMDQ4MzhaMIGuMQswCQYDVQQGEwJVUzELMAkGA1UECBMC
VVQxFzAVBgNVBAcTDlNhbHQgTGFrZSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5l
dHdvcmsxITAfBgNVBAsTGGh0dHA6Ly93d3cudXNlcnRydXN0LmNvbTE2MDQGA1UEAxMtVVRO
LVVTRVJGaXJzdC1DbGllbnQgQXV0aGVudGljYXRpb24gYW5kIEVtYWlsMIIBIjANBgkqhkiG
9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsjmFpPJ9q0E7YkY3rs3BYHW8OWX5ShpHornMSMxqmNVN
NRm5pELlzkniii8efNIxB8dOtINknS4p1aJkxIW9hVE1eaROaJB7HHqkkqgX8pgV8pPMyaQy
lbsMTzC9mKALi+VuG6JG+ni8om+rWV6lL8/K2m2qL+usobNqqrcuZzWLeeEeaYji5kbNoKXq
vgvOdjp6Dpvq/NonWz1zHyLmSGHGTPNpsaguG7bUMSAsvIKKjqQOpdeJQ/wWWq8dcdcRWdq6
hw2v+vPhwvCkxWeM1tZUOt4KpLoDd7NlyP0e03RiqhjKaJMeoYV+9Udly/hNVyh00jT/MLbu
9mIwFIws6wIDAQABo4HhMIHeMB8GA1UdIwQYMBaAFK29mHo0tCb3+sQmVO8DveAky1QaMB0G
A1UdDgQWBBSJgmd9xJ0mcABLtFBIfN49rgRufTAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/
BAUwAwEB/zB7BgNVHR8EdDByMDigNqA0hjJodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9BZGRU
cnVzdEV4dGVybmFsQ0FSb290LmNybDA2oDSgMoYwaHR0cDovL2NybC5jb21vZG8ubmV0L0Fk
ZFRydXN0RXh0ZXJuYWxDQVJvb3QuY3JsMA0GCSqGSIb3DQEBBQUAA4IBAQAZ2IkRbyispgCi
54fBm5AD236hEv0e8+LwAamUVEJrmgnEoG3XkJIEA2Z5Q3H8+G+v23ZF4jcaPd3kWQR4rBz0
g0bzes9bhHIt5UbBuhgRKfPLSXmHPLptBZ2kbWhPrXIUNqi5sf2/z3/wpGqUNVCPz4FtVbHd
WTBK322gnGQfSXzvNrv042n0+DmPWq1LhTq3Du3Tzw1EovsEv+QvcI4l+1pUBrPQxLxtjftz
Mizpm4QkLdZ/kXpoAlAfDj9N6cz1u2fo3BwuO/xOzf4CjuOoEwqlJkRl6RDyTVKnrtw+ymsy
XEFs/vVdoOr/0fqbhlhtPZZH5f4ulQTCAMyOofK7MIIE2jCCA8KgAwIBAgIQXf9Q6v4PU0aI
n4BBj+dCyDANBgkqhkiG9w0BAQUFADCBrjELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAlVUMRcw
FQYDVQQHEw5TYWx0IExha2UgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3Jr
MSEwHwYDVQQLExhodHRwOi8vd3d3LnVzZXJ0cnVzdC5jb20xNjA0BgNVBAMTLVVUTi1VU0VS
Rmlyc3QtQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBFbWFpbDAeFw0wOTA1MTgwMDAwMDBa
Fw0yODEyMzEyMzU5NTlaMEQxCzAJBgNVBAYTAk5MMQ8wDQYDVQQKEwZURVJFTkExJDAiBgNV
BAMTG1RFUkVOQSBlU2NpZW5jZSBQZXJzb25hbCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAMS8JX3N71kEq3QnKbZjiu/ENXChRgivblCbG3F4lwKFwDX/kBgRZvozORSe
pBL3Pe4FLIHn9y0uNnhDDjm2f3p0w8tVPy+zy8M3auGVAyMbsyKYE4NYMF+sPJFF020LLsvR
kWGyynH6wokMewnWkr+jgRcRVSDfN4GfHiYJHdIXGUPLi5kldEFb5jIq0KdT3NIhjc2Rz3ts
9Mn+0OXSBmsaYUIbgJEH3BRJJzsKirLiO2kIhMuBmde6FB/YfpJjvfYtMfqVTs02DZnvEbqt
SvuoxHi5fFo+yPUIMsCpBceMGiiPMLoXo/G54genuPtVv59iWtUUDwi0E5nSEnla8P0CAwEA
AaOCAVswggFXMB8GA1UdIwQYMBaAFImCZ33EnSZwAEu0UEh83j2uBG59MB0GA1UdDgQWBBTI
iXOZp11RFlNFVHyjwjl8y9eqgTAOBgNVHQ8BAf8EBAMCAQYwEgYDVR0TAQH/BAgwBgEB/wIB
ADAmBgNVHSAEHzAdMA0GCysGAQQBsjEBAgIdMAwGCiqGSIb3TAUCAgUwWAYDVR0fBFEwTzBN
oEugSYZHaHR0cDovL2NybC51c2VydHJ1c3QuY29tL1VUTi1VU0VSRmlyc3QtQ2xpZW50QXV0
aGVudGljYXRpb25hbmRFbWFpbC5jcmwwbwYIKwYBBQUHAQEEYzBhMDgGCCsGAQUFBzAChixo
dHRwOi8vY3J0LnVzZXJ0cnVzdC5jb20vVVROQUFBQ2xpZW50X0NBLmNydDAlBggrBgEFBQcw
AYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQUFAAOCAQEACBekHPkV
a7AZYW+gSON6JO9BVZqgUHDYI9VThkpnjujaVhYYLBsYIYm6mCTuVjTjF4YmvSFa1BmTSuph
dE22xISNR+7KLmVtNpOYseKSZojiTnt1x15EaSHcEmow/GGA/g/wndLcfq7lwlNNC3CDYVZF
+z3fcvYCQnXriIqYV2D1n6JySbF6PkFnNcNVKw0HNejGK9W6h3mAdOeSNr1GgXouKeJqvuEX
EzV8FqQlMy9h7s7JUuBA29O+OVrPz0wU5X/FQ1eLTblajsIPBk3eyEmdgXO65D+YpZM8WU7b
mzXf/k2/VaHpZMNFfKyPfEfROvFOddmQZ0DosS+eFy9cNTCCBeswggTToAMCAQICEQDqd027
X/SkNzhCJGqZvKSVMA0GCSqGSIb3DQEBBQUAMEQxCzAJBgNVBAYTAk5MMQ8wDQYDVQQKEwZU
RVJFTkExJDAiBgNVBAMTG1RFUkVOQSBlU2NpZW5jZSBQZXJzb25hbCBDQTAeFw0xMDA1MDMw
MDAwMDBaFw0xMTA2MDIyMzU5NTlaMIGNMRMwEQYKCZImiZPyLGQBGRYDb3JnMRYwFAYKCZIm
iZPyLGQBGRYGdGVyZW5hMRMwEQYKCZImiZPyLGQBGRYDdGNzMQswCQYDVQQGEwJOTDEPMA0G
A1UEChMGTmlraGVmMSswKQYDVQQDFCJKYW4gSnVzdCBLZWlqc2VyIGphbmp1c3RAbmlraGVm
Lm5sMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwy8BUSJ6rNqx5yZDsjVNHvSw
ksD7EcOzDBMrfKBIDv1jeqfMDGL86CFjgVzHxhMBtox2ajCpBylpzT/jDjclAIeaAd73wjPX
OTHAdQWxV730+jAhhDT1ghUt/0T61p++F5acu7C9cd7HaceuPYYWj8fMN1AVU5TyToLG/O1l
LN7cKc2MJn/SSEIMzTUAALwkx4KHN1f3m4Z3rVi+37ptWv6vVUXcgjMTnfJR/q1DJDnvIrvV
rqKIKNIsxUeATP62o2TnVtaY874y8u4NwZrZR2qnskM0EfSHKpvmP3HIgbTsztrElHuU/OFc
uLXMgsWEBBCIliFgFjQ2PtmWhyTmmgeJCw20fOAcvzzkKdVgi8j4RiUAMwFyTBIrqIRJdtxD
iem2kMrqeUg3fI62Oo0fD4A1Zun5YdgQ0rWysczV+JpbyFkX8ZT6DMApAv3XkygwtUcb1TTx
xLoR2s2e/Lq+qz195SPqChoZnYkyhMJgAA/4yHjzBNoI+iRT0lh4jhXyG+ClYiqknsY56kI/
RzBMTBxnHWKV5V1W0l0MKKu9Lvbw+dwsV9GlUCV1J7qHr4/wCaT8VTFlt7q0kWekEAkBYRte
5St/5O9p3K/hV55Lb3ESMPKZ0EUfKhYgKLFWp2wXSQ80Rp6ODeGLqU17iIE2FkcoQTK+cHJl
TAdlN5uVv70CAwEAAaOCAYwwggGIMB8GA1UdIwQYMBaAFMiJc5mnXVEWU0VUfKPCOXzL16qB
MB0GA1UdDgQWBBSBc9tCj21ppWOnq8KN9EpNjGaBPjAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0T
AQH/BAIwADAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwJgYDVR0gBB8wHTANBgsr
BgEEAbIxAQICHTAMBgoqhkiG90wFAgIFMEcGA1UdHwRAMD4wPKA6oDiGNmh0dHA6Ly9jcmwu
dGNzLnRlcmVuYS5vcmcvVEVSRU5BZVNjaWVuY2VQZXJzb25hbENBLmNybDB6BggrBgEFBQcB
AQRuMGwwQgYIKwYBBQUHMAKGNmh0dHA6Ly9jcnQudGNzLnRlcmVuYS5vcmcvVEVSRU5BZVNj
aWVuY2VQZXJzb25hbENBLmNydDAmBggrBgEFBQcwAYYaaHR0cDovL29jc3AudGNzLnRlcmVu
YS5vcmcwHAYDVR0RBBUwE4ERamFuanVzdEBuaWtoZWYubmwwDQYJKoZIhvcNAQEFBQADggEB
AJSWpXBQbPhSQE2S2VT07sEkiqcUQzecT8uHS486mekNCVIBUIV6DmvYzvPOif4oVSzcSxRy
J3y/Ozl5TGQBhxnkSmuMyRzYHir/6uLzqc6CzOqCTldH1P+jpAvccjOWKaZsvwhhuBlc79DQ
H/MaAcMxTS68Wzd57C5zeMPO053Rwvaf7MZ7BmPh+L7EcncFubf+o17JQmN0D5LbBo4UxfNe
YmLJ8vNVzVZwjCARy5vnl5Dp2pF0ndcCK4FfYRTw7lsGJrxG/276PIiKrUs+nOxlc6Kdu3vR
RiwPDsjKFdgd96DOJ9gQ+P9PDl8GV7pVx5z31QcUu08eiNiYHy8x7cQwggXrMIIE06ADAgEC
AhEA6ndNu1/0pDc4QiRqmbyklTANBgkqhkiG9w0BAQUFADBEMQswCQYDVQQGEwJOTDEPMA0G
A1UEChMGVEVSRU5BMSQwIgYDVQQDExtURVJFTkEgZVNjaWVuY2UgUGVyc29uYWwgQ0EwHhcN
MTAwNTAzMDAwMDAwWhcNMTEwNjAyMjM1OTU5WjCBjTETMBEGCgmSJomT8ixkARkWA29yZzEW
MBQGCgmSJomT8ixkARkWBnRlcmVuYTETMBEGCgmSJomT8ixkARkWA3RjczELMAkGA1UEBhMC
TkwxDzANBgNVBAoTBk5pa2hlZjErMCkGA1UEAxQiSmFuIEp1c3QgS2VpanNlciBqYW5qdXN0
QG5pa2hlZi5ubDCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAMMvAVEieqzasecm
Q7I1TR70sJLA+xHDswwTK3ygSA79Y3qnzAxi/OghY4Fcx8YTAbaMdmowqQcpac0/4w43JQCH
mgHe98Iz1zkxwHUFsVe99PowIYQ09YIVLf9E+tafvheWnLuwvXHex2nHrj2GFo/HzDdQFVOU
8k6CxvztZSze3CnNjCZ/0khCDM01AAC8JMeChzdX95uGd61Yvt+6bVr+r1VF3IIzE53yUf6t
QyQ57yK71a6iiCjSLMVHgEz+tqNk51bWmPO+MvLuDcGa2Udqp7JDNBH0hyqb5j9xyIG07M7a
xJR7lPzhXLi1zILFhAQQiJYhYBY0Nj7Zlock5poHiQsNtHzgHL885CnVYIvI+EYlADMBckwS
K6iESXbcQ4nptpDK6nlIN3yOtjqNHw+ANWbp+WHYENK1srHM1fiaW8hZF/GU+gzAKQL915Mo
MLVHG9U08cS6EdrNnvy6vqs9feUj6goaGZ2JMoTCYAAP+Mh48wTaCPokU9JYeI4V8hvgpWIq
pJ7GOepCP0cwTEwcZx1ileVdVtJdDCirvS728PncLFfRpVAldSe6h6+P8Amk/FUxZbe6tJFn
pBAJAWEbXuUrf+Tvadyv4VeeS29xEjDymdBFHyoWICixVqdsF0kPNEaejg3hi6lNe4iBNhZH
KEEyvnByZUwHZTeblb+9AgMBAAGjggGMMIIBiDAfBgNVHSMEGDAWgBTIiXOZp11RFlNFVHyj
wjl8y9eqgTAdBgNVHQ4EFgQUgXPbQo9taaVjp6vCjfRKTYxmgT4wDgYDVR0PAQH/BAQDAgWg
MAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMCMCYGA1UdIAQf
MB0wDQYLKwYBBAGyMQECAh0wDAYKKoZIhvdMBQICBTBHBgNVHR8EQDA+MDygOqA4hjZodHRw
Oi8vY3JsLnRjcy50ZXJlbmEub3JnL1RFUkVOQWVTY2llbmNlUGVyc29uYWxDQS5jcmwwegYI
KwYBBQUHAQEEbjBsMEIGCCsGAQUFBzAChjZodHRwOi8vY3J0LnRjcy50ZXJlbmEub3JnL1RF
UkVOQWVTY2llbmNlUGVyc29uYWxDQS5jcnQwJgYIKwYBBQUHMAGGGmh0dHA6Ly9vY3NwLnRj
cy50ZXJlbmEub3JnMBwGA1UdEQQVMBOBEWphbmp1c3RAbmlraGVmLm5sMA0GCSqGSIb3DQEB
BQUAA4IBAQCUlqVwUGz4UkBNktlU9O7BJIqnFEM3nE/Lh0uPOpnpDQlSAVCFeg5r2M7zzon+
KFUs3EsUcid8vzs5eUxkAYcZ5EprjMkc2B4q/+ri86nOgszqgk5XR9T/o6QL3HIzlimmbL8I
YbgZXO/Q0B/zGgHDMU0uvFs3eewuc3jDztOd0cL2n+zGewZj4fi+xHJ3Bbm3/qNeyUJjdA+S
2waOFMXzXmJiyfLzVc1WcIwgEcub55eQ6dqRdJ3XAiuBX2EU8O5bBia8Rv9u+jyIiq1LPpzs
ZXOinbt70UYsDw7IyhXYHfegzifYEPj/Tw5fBle6Vcec99UHFLtPHojYmB8vMe3EMYIEGDCC
BBQCAQEwWTBEMQswCQYDVQQGEwJOTDEPMA0GA1UEChMGVEVSRU5BMSQwIgYDVQQDExtURVJF
TkEgZVNjaWVuY2UgUGVyc29uYWwgQ0ECEQDqd027X/SkNzhCJGqZvKSVMAkGBSsOAwIaBQCg
ggGUMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTEwMTEwNDA5
MDY1NFowIwYJKoZIhvcNAQkEMRYEFHGgTjj51jYObjJpAwkhd2ZTOP4NMF8GCSqGSIb3DQEJ
DzFSMFAwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG
9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDBoBgkrBgEEAYI3EAQxWzBZMEQxCzAJ
BgNVBAYTAk5MMQ8wDQYDVQQKEwZURVJFTkExJDAiBgNVBAMTG1RFUkVOQSBlU2NpZW5jZSBQ
ZXJzb25hbCBDQQIRAOp3Tbtf9KQ3OEIkapm8pJUwagYLKoZIhvcNAQkQAgsxW6BZMEQxCzAJ
BgNVBAYTAk5MMQ8wDQYDVQQKEwZURVJFTkExJDAiBgNVBAMTG1RFUkVOQSBlU2NpZW5jZSBQ
ZXJzb25hbCBDQQIRAOp3Tbtf9KQ3OEIkapm8pJUwDQYJKoZIhvcNAQEBBQAEggIAk5fPk7/B
rPjQWQrSKbZVeB3PRHxd5PUOAPrzTj1i+flQqsP+AbgtLiLOhm5JNhsLBBj2azjNE1ybLm77
ahbYrCV68upemfR97XHezV47xpjfvtjLtnD9zJ9p6Z6MQIObnlfbzUvY8Dhdp8kPWeAG6gE2
lz4wXMzyzQ3syiHu/5r0Zkc4RGehJS3jLciNUrVZXzdaBWeFR1LzXOhMPMhvTrZX6pbv3HKR
Kp4oPnDUfohXp3j45U2vu+sbsaaia1h60ag/nGDjkQCv/eOsSC8jcki+5GJ/lX9TXis5iJss
0tMum7w1evXYvH7Hwg0GUtFRfmZ1ElX4kExd+tDyi8y7WjadGw0PutLokI2Oc90JfkBGGj68
zattbIp3otu8W/n5rFPdsZr5u7SNjBuq2MBx7cgIIKHApcqVLDhtcDxpQACsxR4ZH0laRv0A
3Wi3eAldodbM7iqc5Gss31VPBhYvnohQtPqSweDVu5CU4PydCM4K+iiupyMEijKdOFoHiryj
qrQfeRprY6weE3TgQig3bevOjVfj2A0MglurGeCSyoCImkTDxxnU0Ji6y+4FnnsrXmCAmTUA
8XhzJy+1xZlPOZCt94nTPwYBPTHrDidyCJLRXHuWjT/r2W3uKWD2US05eBzzpWQd5CUBNgaB
54540x8UMAU+p0OjXoWBcxhpMzMAAAAAAAA=
--------------ms030200000904080209050002--


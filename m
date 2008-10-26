Content-class: urn:content-classes:message
Date: Sun, 26 Oct 2008 15:57:03 -0600
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_01B4_01C93794.409CDFC0"
MIME-Version: 1.0
Message-ID: <750B64C66078B34D918257A1AC004DB205454E@...1132...>
In-Reply-To: <9e0cf0bf0810261339i1abdd932q6e02b0dddc9293bb@...278...>
References: <9e0cf0bf0810200840p7e5b3743p940be6e27bea9ca9@...278...>
	<750B64C66078B34D918257A1AC004DB2054510@...1132...>
	<9e0cf0bf0810200851o2a8c2df5t652424be88649457@...278...>
	<750B64C66078B34D918257A1AC004DB2054511@...1132...>
	<9e0cf0bf0810200926m5ec4de48l1677893b50178cdc@...278...>
	<9e0cf0bf0810261339i1abdd932q6e02b0dddc9293bb@...278...>
From: "Jason R. Coombs" <jaraco@...1130...>
Subject: Re: [Openvpn-devel] [WINDOWS] Request for test win64
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn devel <openvpn-devel@lists.sourceforge.net>

This is a multipart message in MIME format.

------=_NextPart_000_01B4_01C93794.409CDFC0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

Alon,
	Looks good.  I was able to run the help text as well as connect using my 
.ovpn file, and confirmed that the connection was properly established with a 
ping to a server only accessible via the VPN.

	Nice work!

Jason

PS C:\Users\jaraco\Desktop\openvpn64> 
C:\Users\jaraco\Desktop\openvpn64\openvpn.exe 'C:\Program Files 
(x86)\OpenVPN\conf
ig\IMC.ovpn'
Sun Oct 26 17:52:54 2008 OpenVPN 2.1_rc13 x86_64-pc-mingw32 [SSL] [LZO2] 
[PKCS11] built on Oct 26 2008
Sun Oct 26 17:52:54 2008 IMPORTANT: OpenVPN's default port number is now 1194, 
based on an official port number assignment by IANA.  OpenVPN 2.0-beta16 and 
earlier used 5000 as the default port.
Sun Oct 26 17:52:54 2008 WARNING: normally if you use --mssfix 
and/or --fragment, you should also set --tun-mtu 1500 (currently it is 1400)
...
Sun Oct 26 17:52:56 2008 TAP-WIN32 device [OpenVPN Tunnel Adapter] opened: 
\\.\Global\{FA7DF305-A290-462F-AFE2-D55760BB2797}.tap
Sun Oct 26 17:52:56 2008 TAP-Win32 Driver Version 9.4
Sun Oct 26 17:52:56 2008 TAP-Win32 MTU=1500
...
Sun Oct 26 17:53:01 2008 Route addition via IPAPI succeeded [adaptive]
Sun Oct 26 17:53:01 2008 Initialization Sequence Completed

> -----Original Message-----
> From: Alon Bar-Lev [mailto:alon.barlev@...277...]
> Sent: Sunday, 26 October, 2008 16:40
> To: Jason R. Coombs
> Cc: openvpn devel
> Subject: Re: [Openvpn-devel] [WINDOWS] Request for test win64
>
> Hello,
>
> Can you please test [1]?
>
> Thanks!
> Alon
>
> [1] http://alon.barlev.googlepages.com/openvpn-win64.tar.bz2
>
> On 10/20/08, Alon Bar-Lev <alon.barlev@...277...> wrote:
> > Thank you!
> >  So we have an issue OpenSSL.
> >
> >
> >  On 10/20/08, Jason R. Coombs <jaraco@...1130...> wrote:
> >  > Below is the crash event when I tried to run openvpn --help; I
> cleared the PATH environment variable to remove any links to other
> openssl libraries... then ran .\openvpn --help.  It seems odd that the
> event is reporting libeay32.dll as version 6.0.6001.1800 -- when I look
> at the details of the local dll, it shows 0.9.9.0.  And the timestamp
> 0x4791adec corresponds to 2008-01-19 07:59:40.
> >  >
> >  >  Is that any help?
> >  >
> >  >  Log Name:      Application
> >  >  Source:        Application Error
> >  >  Date:          20-Oct-2008 11:56:38
> >  >  Event ID:      1000
> >  >  Task Category: (100)
> >  >  Level:         Error
> >  >  Keywords:      Classic
> >  >  User:          N/A
> >  >  Computer:      drake.jaraco.com
> >  >  Description:
> >  >  Faulting application openvpn.exe, version 0.0.0.0, time stamp
> 0x48fc8c5d, faulting module LIBEAY32.dll! , version 6.0.6001.18000,
> time stamp 0x4791adec, exception code 0xc0000139, fault offset
> 0x00000000000b1188, process id 0x1458, application start time
> 0x01c932cc6fa3b754.
> >  >  Event Xml:
> >  >  <Event
> xmlns="http://schemas.microsoft.com/win/2004/08/events/event">
> >  >   <System>
> >  >     <Provider Name="Application Error" />
> >  >     <EventID Qualifiers="0">1000</EventID>
> >  >     <Level>2</Level>
> >  >     <Task>100</Task>
> >  >     <Keywords>0x80000000000000</Keywords>
> >  >     <TimeCreated SystemTime="2008-10-20T15:56:38.000Z" />
> >  >     <EventRecordID>45520</EventRecordID>
> >  >     <Channel>Application</Channel>
> >  >     <Computer>drake.jaraco.com</Computer>
> >  >     <Security />
> >  >   </System>
> >  >   <EventData>
> >  >     <Data>openvpn.exe</Data>
> >  >     <Data>0.0.0.0</Data>
> >  >     <Data>48fc8c5d</Data>
> >  >     <Data>LIBEAY32.dll! </Data>
> >  >     <Data>6.0.6001.18000</Data>
> >  >     <Data>4791adec</Data>
> >  >     <Data>c0000139</Data>
> >  >     <Data>00000000000b1188</Data>
> >  >     <Data>1458</Data>
> >  >     <Data>01c932cc6fa3b754</Data>
> >  >   </EventData>
> >  >  </Event>
> >  >
> >  >
> >  >  > -----Original Message-----
> >  >  > From: Alon Bar-Lev [mailto:alon.barlev@...277...]
> >  >
> >  > > Sent: Monday, 20 October, 2008 11:52
> >  >  > To: Jason R. Coombs
> >  >  > Cc: openvpn devel
> >  >  > Subject: Re: [Openvpn-devel] [WINDOWS] Request for test win64
> >  >  >
> >  >  > Current distribution is 32bit (except for the driver), which
> can run
> >  >  > also on 64bit.
> >  >  > The attached files are 64bit.
> >  >  > Can you please at least just try to run openvpn.exe --help and
> see if
> >  >  > it runs?
> >  >  >
> >  >  > On 10/20/08, Jason R. Coombs <jaraco@...1130...> wrote:
> >  >  > > Is that AMD64 or IA64?
> >  >  > >
> >  >  > >  I'm guessing it's AMD64.  If I understand correctly, the
> currently-
> >  >  > released
> >  >  > >  build is for 32-bit and AMD 64-bit systems.  How is this
> build
> >  >  > different?
> >  >  > >  Does it build the client executables and GUI as native 64-
> bit apps?
> >  >  > >
> >  >  > >  Sorry to ask so many questions, but I want to make sure I'm
> setting
> >  >  > up the
> >  >  > >  environment correctly to perform a reasonable test.
> >  >  > >
> >  >  > >  Jason
> >  >  > >
> >  >  > >
> >  >  > >  > -----Original Message-----
> >  >  > >  > From: Alon Bar-Lev [mailto:alon.barlev@...277...]
> >  >  > >  > Sent: Monday, 20 October, 2008 11:41
> >  >  > >  > To: openvpn devel
> >  >  > >  > Subject: [Openvpn-devel] [WINDOWS] Request for test win64
> >  >  > >  >
> >  >  > >  > Hello,
> >  >  > >  >
> >  >  > >  > Just installed experimental win64 mingw, I don't have
> 64bit
> >  >  > machine
> >  >  > >  > and not Windows...
> >  >  > >  > So if someone can test if [1] actually works...
> >  >  > >  >
> >  >  > >  > Thanks!
> >  >  > >  > Alon.
> >  >  > >  >
> >  >  > >  > [1] http://alon.barlev.googlepages.com/openvpn-
> win64.tar.bz2
> >  >  > >  >
> >  >  > >
> >  >  > > > -----------------------------------------------------------
> --------
> >  >  > ----
> >  >  > >  > --
> >  >  > >  > This SF.Net email is sponsored by the Moblin Your Move
> Developer's
> >  >  > >  > challenge
> >  >  > >  > Build the coolest Linux based applications with Moblin SDK
> & win
> >  >  > great
> >  >  > >  > prizes
> >  >  > >  > Grand prize is a trip for two to an Open Source event
> anywhere in
> >  >  > the
> >  >  > >  > world
> >  >  > >  > http://moblin-contest.org/redirect.php?banner_id=100&url=/
> >  >  > >  > _______________________________________________
> >  >  > >  > Openvpn-devel mailing list
> >  >  > >  > Openvpn-devel@lists.sourceforge.net
> >  >  > >  > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >  >  > >
> >  >  > > -------------------------------------------------------------
> --------
> >  >  > ----
> >  >  > >  This SF.Net email is sponsored by the Moblin Your Move
> Developer's
> >  >  > challenge
> >  >  > >  Build the coolest Linux based applications with Moblin SDK &
> win
> >  >  > great prizes
> >  >  > >  Grand prize is a trip for two to an Open Source event
> anywhere in
> >  >  > the world
> >  >  > >  http://moblin-contest.org/redirect.php?banner_id=100&url=/
> >  >  > > _______________________________________________
> >  >  > >  Openvpn-devel mailing list
> >  >  > >  Openvpn-devel@lists.sourceforge.net
> >  >  > >  https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >  >  > >
> >  >  > >
> >  >  > >
> >  >
> >
> > > -------------------------------------------------------------------
> ------
> >
> > >  This SF.Net email is sponsored by the Moblin Your Move Developer's
> challenge
> >  >  Build the coolest Linux based applications with Moblin SDK & win
> great prizes
> >  >  Grand prize is a trip for two to an Open Source event anywhere in
> the world
> >  >  http://moblin-contest.org/redirect.php?banner_id=100&url=/
> >  > _______________________________________________
> >  >  Openvpn-devel mailing list
> >  >  Openvpn-devel@lists.sourceforge.net
> >  >  https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >  >
> >  >
> >  >
> >

------=_NextPart_000_01B4_01C93794.409CDFC0
Content-Type: application/x-pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIW+DCCB0Ew
ggYpoAMCAQICAR0wDQYJKoZIhvcNAQEFBQAwgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFy
dENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgw
NgYDVQQDEy9TdGFydENvbSBDbGFzcyAzIFByaW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQTAe
Fw0wNzEyMDcxNzM4MzhaFw0wODEyMDYxNzM4MzhaMIHFMQswCQYDVQQGEwJVUzEdMBsGA1UECBMU
RGlzdHJpY3Qgb2YgQ29sdW1iaWExEzARBgNVBAcTCldhc2hpbmd0b24xGDAWBgNVBAoTD0phc29u
IFIuIENvb21iczEsMCoGA1UECxMjU3RhcnRDb20gVHJ1c3RlZCBDZXJ0aWZpY2F0ZSBNZW1iZXIx
GDAWBgNVBAMTD0phc29uIFIuIENvb21iczEgMB4GCSqGSIb3DQEJARYRamFyYWNvQGphcmFjby5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDqVOCEUYdhoLaXe3GxyAon++VJGqcn
xZbAjBjkCd8QyK/hK/KC534yJ5oJZ/he0Fsb9H2FjQNFpW0pwADLTsBlIn47/xCpROiNdhsmuO60
YYkcsbxRZhcWw5ugaQQFjq7csUklJGSY5ol+URM5PuLxj6X6GhiPtDzOs9zP6N5JzinFC2q5WS/J
EAoZlEsk1IekP5fzQeEhjhJfdMR6EtdulUKDITcXptB6zdCIm3w4ACdVD6GR4ZYloQqnghyWbv4E
JQNK2cemdndsQSADXkjkvexFhSlm9ksjBMU5c3VvTJs07EiakQyNapHaIt86L5c6Lj/Jii9xVTVE
X83RE5ejAgMBAAGjggNxMIIDbTAMBgNVHRMEBTADAgEAMAsGA1UdDwQEAwIEsDAdBgNVHSUEFjAU
BggrBgEFBQcDAgYIKwYBBQUHAwQwHQYDVR0OBBYEFOI1kYi3Q0sIINHsg3XwkR+MIY5QMIGoBgNV
HSMEgaAwgZ2AFHuJnJKXJKGERwLLdPwu9KzcMuXzoYGBpH8wfTELMAkGA1UEBhMCSUwxFjAUBgNV
BAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNp
Z25pbmcxKTAnBgNVBAMTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5ggEPMIIBSgYD
VR0gBIIBQTCCAT0wggE5BgsrBgEEAYG1NwEBBDCCASgwNQYIKwYBBQUHAgEWKWh0dHA6Ly9jZXJ0
LnN0YXJ0Y29tLm9yZy9pbnRlcm1lZGlhdGUucGRmMC8GCCsGAQUFBwIBFiNodHRwOi8vY2VydC5z
dGFydGNvbS5vcmcvcG9saWN5LnBkZjCBvQYIKwYBBQUHAgIwgbAwFBYNU3RhcnRDb20gTHRkLjAD
AgEBGoGXTGltaXRlZCBMaWFiaWxpdHksIHJlYWQgdGhlIHNlY3Rpb24gKkxlZ2FsIExpbWl0YXRp
b25zKiBvZiB0aGUgU3RhcnRDb20gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgUG9saWN5IGF2YWls
YWJsZSBhdCBodHRwOi8vY2VydC5zdGFydGNvbS5vcmcvcG9saWN5LnBkZjBjBgNVHR8EXDBaMCug
KaAnhiVodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9jcnR1My1jcmwuY3JsMCugKaAnhiVodHRwOi8v
Y3JsLnN0YXJ0c3NsLmNvbS9jcnR1My1jcmwuY3JsMIGOBggrBgEFBQcBAQSBgTB/MDkGCCsGAQUF
BzABhi1odHRwOi8vb2NzcC5zdGFydHNzbC5jb20vc3ViL2NsYXNzMy9jbGllbnQvY2EwQgYIKwYB
BQUHMAKGNmh0dHA6Ly93d3cuc3RhcnRzc2wuY29tL2NlcnRzL3N1Yi5jbGFzczMuY2xpZW50LmNh
LmNydDAjBgNVHRIEHDAahhhodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS8wDQYJKoZIhvcNAQEFBQAD
ggEBAKTguF54SVP4Vy2X6GEJ596M3BtB/n6C9xoOVAh1TtDMlqoNiCmqVXhE3685AEmH6JRrjNV9
0bgoYwWVKcuaELv1H4zoHdr+odwvBZxPNGFjJvgerBSB4dXmD4hC4A2FG5OEhPDjsOuOtL5Z26nL
3qHr1suyCNP6Aschr93m+fwQbXEz70hPiPdQNr60J3F77F61lRocZaCQsu3DZ3sNClor/R9FpWf1
KSUvNV+A6eZ3eCJvj7Zp0MUe78rjhYDSnPyf9+B15sxVVPa8tq4EG1KiHpJn5Mr0RAZbeZnidh5i
1l9KfAO36O+xTJrD3EquXrrKlnvPX7oIIcxf3FHfWFwwggfJMIIFsaADAgECAgEBMA0GCSqGSIb3
DQEBBQUAMH0xCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJT
ZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMSkwJwYDVQQDEyBTdGFydENvbSBDZXJ0
aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0wNjA5MTcxOTQ2MzZaFw0zNjA5MTcxOTQ2MzZaMH0xCzAJ
BgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRh
bCBDZXJ0aWZpY2F0ZSBTaWduaW5nMSkwJwYDVQQDEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1
dGhvcml0eTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAMGI2wm8bEZ8eJ+Ve7UzkPJy
YtbBNiAiJF7O6XfyQwqiBmSkzI42+DjmI/BubbE83XKjhRyh0z20MyvTL6/+6rBBWWe2xAZ9Cp50
hdZ5TIA3et85BVJZ9/QbRkOk0oWF0sNx83ViNLosin8ej+7tNNARx5bNUj26M9bdTd4LO0pLn8Im
L/q1FhxyNXfKPF3myuEmixo2dlwB23QUJf7ttaCID914yi0fB5cwAS1yefpG1hMqqLmmq4NJHeXy
793kAY4YCo9jUxaFYqkOGTrMtWamwmt0B+Qr4XY+tG3Y9kThc2IfO8S+oFNWJWxRCfeqq8q/dv1t
m/Od2789ZrwMVqqvmEiVOkvfp1hQ2Th1qVvqQwwC/5nr6GxNcFspZZzdql3MrwEx7Azr0o3o6px7
5m73J2YMGkjXbkLjP94hPnvhDXD7Y6qobBpUtFwlesmiyYsWprssfhdeBU1YbhIdAe4SEA3GMn8Y
//z0+s1ukeg2Sb4aSGmLwpZNGhKyaRfBCpDW+nkiSL+6e2n4cMf6ejfY2A3Sdk9X/5C345HS3e/C
YLdnOt3+qpzw1It/ciLOxp+XtviviqAQqNn7GMa2tVxSPIm2GSpzAQoPA7MSYPJ6L4Hbo27/JjCX
9YvdiVe2rT2zryvFt3YC8KXWK5qGFCpy9uMzjF0JSxPfu4x0E1JLAgMBAAGjggJSMIICTjAMBgNV
HRMEBTADAQH/MAsGA1UdDwQEAwIBrjAdBgNVHQ4EFgQUTgvvGqRAW6UXaYcwyjRoQ9BBrvIwZAYD
VR0fBF0wWzAsoCqgKIYmaHR0cDovL2NlcnQuc3RhcnRjb20ub3JnL3Nmc2NhLWNybC5jcmwwK6Ap
oCeGJWh0dHA6Ly9jcmwuc3RhcnRjb20ub3JnL3Nmc2NhLWNybC5jcmwwggFdBgNVHSAEggFUMIIB
UDCCAUwGCysGAQQBgbU3AQEBMIIBOzAvBggrBgEFBQcCARYjaHR0cDovL2NlcnQuc3RhcnRjb20u
b3JnL3BvbGljeS5wZGYwNQYIKwYBBQUHAgEWKWh0dHA6Ly9jZXJ0LnN0YXJ0Y29tLm9yZy9pbnRl
cm1lZGlhdGUucGRmMIHQBggrBgEFBQcCAjCBwzAnFiBTdGFydCBDb21tZXJjaWFsIChTdGFydENv
bSkgTHRkLjADAgEBGoGXTGltaXRlZCBMaWFiaWxpdHksIHJlYWQgdGhlIHNlY3Rpb24gKkxlZ2Fs
IExpbWl0YXRpb25zKiBvZiB0aGUgU3RhcnRDb20gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgUG9s
aWN5IGF2YWlsYWJsZSBhdCBodHRwOi8vY2VydC5zdGFydGNvbS5vcmcvcG9saWN5LnBkZjARBglg
hkgBhvhCAQEEBAMCAAcwOAYJYIZIAYb4QgENBCsWKVN0YXJ0Q29tIEZyZWUgU1NMIENlcnRpZmlj
YXRpb24gQXV0aG9yaXR5MA0GCSqGSIb3DQEBBQUAA4ICAQAWbJn0Zgw09dCFXn0K7NoQTjgcXt+m
JQVLkTLB6DvxPd1ECVsHSYopy2YCt7Ga9yWYCTyOG+HdNocrS7to0zlmPaAmx/I5kR1Rq4J7ftXO
WuTiA1dwaZcI+V5YpgrfjAaaRRYWOApeV/Zix3oCBea8HrXynvSpKYP4shTjbiiHRMOQGt44qTys
Q01kRc7dKKlc8nN7BPgX6Kux8y5cZG5zMToSuLyzEeR9j4FRmjuNifRNk2Z7PAPt05odmvNlUPWg
0HWfL6/w6oJDmPhpnIl5xEOORnLjZDYSr/clHjiJkHd+w2tqucPLREuseJCL58csHksRRMg0UifN
Cl2fhcGJ1Rp48pUQUzLdgIRmddm1aCj7YS6+hKg4wJkShqUeZ2StBi4vqXCFx5YPfIll9Y5DVA6r
3aWAOZRgwDTJlnAsoxL1H0h7vRx+a7edkPQiO674/CrK+oJSoO+vS1WT68G18CKLrDROJiIEoYcs
dUq35X0T17gMZMA20skvhhKMIwnBG4I7c0mjaleHlOXWeMWZQ2PjTeB3LeFlmXJpBBpHCeYPAVYk
+x+/DnmpWC65xAkBfpW6bQAGPrLqShA52NAr9b/sdb+XAsUJGwjcVTfigfs3hENiIMrnVktl6v5s
wSSTJKE06wX/miKum30/8WVRCqYwarP0iByADfxyiuiDXjCCB+IwggXKoAMCAQICAQ8wDQYJKoZI
hvcNAQEFBQAwfTELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsT
IlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxKTAnBgNVBAMTIFN0YXJ0Q29tIENl
cnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTA3MTAyNDIxMDMzMloXDTEyMTAyMjIxMDMzMlowgYwx
CzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGln
aXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFydENvbSBDbGFzcyAzIFByaW1h
cnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
ALmjSW4SPiDKlAinvVeLZOVfItiuP1aRHL530E7QUc9icCwL33+PH+Js1HAh8CgWFl34sOxx1FJy
S/C4VLPRsqDfP72jtzCVUAL0DAxZ7wgzQvFz7x61jGxfhYhqYb1+PPOLkYBbkRIrPMg3dLEdKmXI
YJYXDH+mB/V/jLo73/Kb7h/rNoNg/oHHSv5Jolyvp5IY2btfcTBfW/telEFj5rDTX2juTvZ3Qhf3
XQX5ca3Q7A10zrUV/cWJOJ7F5RltbEIaboZmX5JBUb3FhUiAdBotehAX6DbDOuYoJtVxmGof6GuV
GcPo98K4TJf8FHo+UA9EOVDp/W7fCqKT4sXk/XkCAwEAAaOCA1swggNXMAwGA1UdEwQFMAMBAf8w
CwYDVR0PBAQDAgGmMB0GA1UdDgQWBBR7iZySlyShhEcCy3T8LvSs3DLl8zCBqAYDVR0jBIGgMIGd
gBROC+8apEBbpRdphzDKNGhD0EGu8qGBgaR/MH0xCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFy
dENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMSkw
JwYDVQQDEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eYIBATAJBgNVHRIEAjAAMD0G
CCsGAQUFBwEBBDEwLzAtBggrBgEFBQcwAoYhaHR0cDovL3d3dy5zdGFydHNzbC5jb20vc2ZzY2Eu
Y3J0MGAGA1UdHwRZMFcwLKAqoCiGJmh0dHA6Ly9jZXJ0LnN0YXJ0Y29tLm9yZy9zZnNjYS1jcmwu
Y3JsMCegJaAjhiFodHRwOi8vY3JsLnN0YXJ0c3NsLmNvbS9zZnNjYS5jcmwwggFdBgNVHSAEggFU
MIIBUDCCAUwGCysGAQQBgbU3AQEEMIIBOzAvBggrBgEFBQcCARYjaHR0cDovL2NlcnQuc3RhcnRj
b20ub3JnL3BvbGljeS5wZGYwNQYIKwYBBQUHAgEWKWh0dHA6Ly9jZXJ0LnN0YXJ0Y29tLm9yZy9p
bnRlcm1lZGlhdGUucGRmMIHQBggrBgEFBQcCAjCBwzAnFiBTdGFydCBDb21tZXJjaWFsIChTdGFy
dENvbSkgTHRkLjADAgEBGoGXTGltaXRlZCBMaWFiaWxpdHksIHJlYWQgdGhlIHNlY3Rpb24gKkxl
Z2FsIExpbWl0YXRpb25zKiBvZiB0aGUgU3RhcnRDb20gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkg
UG9saWN5IGF2YWlsYWJsZSBhdCBodHRwOi8vY2VydC5zdGFydGNvbS5vcmcvcG9saWN5LnBkZjAR
BglghkgBhvhCAQEEBAMCAAcwUAYJYIZIAYb4QgENBEMWQVN0YXJ0Q29tIENsYXNzIDMgUHJpbWFy
eSBJbnRlcm1lZGlhdGUgRnJlZSBTU0wgRW1haWwgQ2VydGlmaWNhdGVzMA0GCSqGSIb3DQEBBQUA
A4ICAQBSlwQN2woVELEUHFxKb7ygxNN+lLt9tmTFYfHl8cOO8CBoFD6hjS2TjG1sPpXF4diPEjrf
6GPyMgKep5Vc97fgG75fN6QifZOWuc8JChsp1AXannZCBS8jFJRF53SNwFoIFXbYNIppSoM7MP9P
HpVDLvzOluVeNEfs4AsT/4ePMlWayl2cFRS1A4tiA+j3bjGTFHblUN2C0QTm8Bdr+DagJ5mHLRkQ
7g1uAhrIBgIlwlEPPSF0PYCF5zrkrDosHc3tVcSOJFHn9agrAf9C15HM8lsUNzWyiasCmObZzKD7
mdubVEd4UjP4bFeW5Gs/O2+E1xvLQ+0COrBjW3GLixbRHpkk+5nYNnX93NySgWHJmAXI5fdISQ1d
UuV2NPOd4UkWdVLMNtzvbS+rXziNHuligj35/lAn3prSIvEQAbxInlq4HBcj/DYWYqbCZ0y8nz/X
v4HiwwIhGtesNCXbHOlVeH9ByaTmd/7DwcWaoBMbLU5QBBteBrsDJIBRpiG+8WTnS7Rs7kOJQbDO
sk7dOvC9oLYSLgQVoGYhWAbtN9TlNppj0hwlIJDsAZRgTdEVJGmws6gDcOzE/jZgRGBL83HDb35i
pm0+g7ZA9s2kjvGcdUJ80FpvHegMh/jfycV+/yynDkFCoFJsQXWLMkDnt4TrgLMee3uUHbQ4UPXV
q9iinDGCBCMwggQfAgEBMIGSMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRk
LjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMv
U3RhcnRDb20gQ2xhc3MgMyBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0ECAR0wCQYFKw4D
AhoFAKCCAmUwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMDgxMDI2
MjE1NzAzWjAjBgkqhkiG9w0BCQQxFgQUMwS9heXEEnXAuxYYo0pXA9Dc0xcwgaMGCSsGAQQBgjcQ
BDGBlTCBkjCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsT
IlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENs
YXNzIDMgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBAgEdMIGlBgsqhkiG9w0BCRACCzGB
laCBkjCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNl
Y3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNz
IDMgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBAgEdMIG3BgkqhkiG9w0BCQ8xgakwgaYw
CwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggqhkiG9w0DBzALBglghkgBZQMEAQIwDgYIKoZI
hvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMAcGBSsOAwIa
MAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwCwYJYIZIAWUDBAIBMAoGCCqGSIb3DQIFMA0GCSqG
SIb3DQEBAQUABIIBAK6ZCieiRxE8PxfYAUZECHiqvpO3EQd2eHm+8rXDixJsJTEakSPuJZDnXv8c
dshMnyu1xIxVjBzCkkdRi66MG7sGITOIjkbJQzZIz3WNV6etuohBmIx48mYsd/gtNMbqoQT870bc
AQVU1H2+l6A4qwck14Cj/HWuBMnZH/+veSvjy13K45XtOI5F7QACBe71m/Qo1JbExPKihuN5PbNw
Uo25EIq/0kozc+GxV4i8ELRg5aKNexb1rv1K9YXSiPoGD7lhbmqblUNxCu1xeG/79DHM2WAJiY9A
stXgu3T0X1umBHUGS/PwOD0FreKke0pUfumXGX09WL6K/216Fj5Bxt4AAAAAAAA=

------=_NextPart_000_01B4_01C93794.409CDFC0--


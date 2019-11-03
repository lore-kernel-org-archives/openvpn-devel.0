From: Simon Rozman <simon@...2293...>
Date: Sun, 3 Nov 2019 16:18:58 +0000
Message-ID: <AD1D828E-B77F-4D08-BB7E-722AE9545CA1@...2293...>
References: <6a1b6995-67c1-e30b-bdc1-af1d5485fda5@...515...>
 <d34d5974-30ac-6949-9be4-7f4a55126564@...515...>
 <bf866bdc-4be0-fea9-92d1-61d27ce7ecda@...277...>
 <df929876-8c63-0934-02f6-4ac7186d986e@...515...>
 <e4b61969-aac3-a5cd-6642-b65e3a9f0256@...277...>
 <7d23f054-2ab4-d6f2-77b0-5cb76c2ec2df@...515...>
In-Reply-To: <7d23f054-2ab4-d6f2-77b0-5cb76c2ec2df@...515...>
Content-Language: en-GB
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha256; boundary="B_3655646338_2016612899"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN 2.4.8 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?utf-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>, Ton van Vliet <epposan@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--B_3655646338_2016612899
Content-type: text/plain;
	charset="UTF-8"
Content-transfer-encoding: 7bit

Hi Ton,

You can also use pnputil.exe (in an elevated command prompt) to check version, uninstall, and/or install TAP driver manually. The pnputil is a stock command line utility for driver management on all Windows.

I advise you use pnputil to list all your installed TAP-Windows6 drivers - yes, there may be more than one version installed.  Carefully uninstall all TAP-Windows6 drivers. "Carefully" in a sense that you pay extra attention to delete oem<nn>.inf entries corresponding to the TAP-Windows6, and not your graphics card or disk controller.  Note that network interface settings are stored elsewhere in registry and uninstalling the driver will not delete them. Your TAP interfaces will just disappear for a while. You already noticed that phenomena before.

Next, install the latest driver - you can use the official installer. Or - if you already have it installed - find a copy of the driver in C:\Program Files\TAP-Windows6\driver (your path may vary) and use pnputil to install the driver. Or - right click on the .inf file and select Install. Your TAP interfaces should reappear.

Also, since you're troubleshooting, I'd strongly advise you to reboot in between.

Best regards,
Simon

--B_3655646338_2016612899
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIILkQYJKoZIhvcNAQcCoIILgjCCC34CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0B
BwGgggl6MIIFWTCCBEGgAwIBAgIEO0oNLjANBgkqhkiG9w0BAQUFADA9MQswCQYDVQQGEwJz
aTEbMBkGA1UEChMSc3RhdGUtaW5zdGl0dXRpb25zMREwDwYDVQQLEwhzaWdlbi1jYTAeFw0x
NjAyMTkxNzU0NDFaFw0yMTAyMTkyMTM4MTVaMIGAMQswCQYDVQQGEwJTSTEbMBkGA1UEChMS
c3RhdGUtaW5zdGl0dXRpb25zMREwDwYDVQQLEwhzaWdlbi1jYTEUMBIGA1UECxMLaW5kaXZp
ZHVhbHMxKzATBgNVBAMTDFNpbW9uIFJvem1hbjAUBgNVBAUTDTIzNDU2Nzk1MTIwNDIwggEi
MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQD+LEVulmN6fPkadqe82V8M1xrQ52BYGDka
xqVw/tEwalpKEiMR6DO8VfCpkjj1Ka5JEoU21Srm1MFg6Tkot9b8ykHAGEWGakBRBSgJGBBQ
AqiO8knjtQuohXSAFeUWjLMfA3mOZG8rJbGrCyg39Fmm1jeezWYuB/7s2xrqK7Stc/GzIheq
sYE0Pw1FhqtECA52JuzoItOX368d31tN/O1ynkH7F0TXy48GFncmq5Yid3d3QVOk1qQC68lo
ILwSSkLA5xOV6mHz/XlAAb/jfNLfsIyxT1RO4+rPlOulTYVex/bfxlbKGXN4qfK/o84TFqXW
1dbDUK7jS9PzMxthWpTfAgMBAAGjggIbMIICFzAOBgNVHQ8BAf8EBAMCBaAwSwYDVR0gBEQw
QjA2BgsrBgEEAa9ZAgIDAzAnMCUGCCsGAQUFBwIBFhlodHRwOi8vd3d3LmNhLmdvdi5zaS9j
cHMvMAgGBgQAizABAjAYBggrBgEFBQcBAwQMMAowCAYGBACORgEBMBoGA1UdEQQTMBGBD3Np
bW9uQHJvem1hbi5zaTCB7gYDVR0fBIHmMIHjMFagVKBSpFAwTjELMAkGA1UEBhMCc2kxGzAZ
BgNVBAoTEnN0YXRlLWluc3RpdHV0aW9uczERMA8GA1UECxMIc2lnZW4tY2ExDzANBgNVBAMT
BkNSTDQ1NTCBiKCBhaCBgoZXbGRhcDovL3g1MDAuZ292LnNpL291PXNpZ2VuLWNhLG89c3Rh
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

--B_3655646338_2016612899--


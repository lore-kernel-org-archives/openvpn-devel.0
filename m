Message-ID: <5436B36A.1050105@...1147...>
Date: Thu, 09 Oct 2014 18:10:18 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <CAPd-S-PVJzdHKfOhMuJMmUG8kEETKweTW46owhAJa6aS4Ny+Qg@...278...>	<5433CFD5.5060901@...515...>	<CAPd-S-OgUuuFJwkz0Unmszyi1Vmv2WEgBaG+RCJ-bWXBvfNzxg@...278...>
	<5433FD92.7020400@...1227...>
In-Reply-To: <5433FD92.7020400@...1227...>
Subject: Re: [Openvpn-devel] Paid Engagement
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi *,

Arne Schwabe wrote:
> Am 07.10.14 16:32, schrieb Sio Poh Tan:
> > Hi Samuli,
>
> >
>
> > Thanks for your reply. I've checked on the link that you
> provided. However, it does not mention whether the Windows Crypto
> API integration supports TLS 1.2 implementation. I understand that
> it does support TLS 1.0 implementation, similar to the OpenVPN
> community version. If the OpenVPN Connect client is based on the
> community version, then I doubt it supports TLS 1.2 using
> cryptoapicert as I've tested with the community version. Please
> correct me if I'm wrong.
>
> >
>
> > I hope someone will be interested to work on this
> implementation as my team is having a tight schedule implementing
> this for a project.
>
>
> Probably it uses the management-api and the external-key-management 
> API of the management interface. My Android client (OpenVPN for 
> Android) uses that API to work with the Android keystore and does TLS 
> 1.2 just fine. That OpenVPN Connect can use the MAC Crypto store which 
> OpenVPN does not support kind of confirms that theory.
>
> For anyone who wants to pick up  this work. This probably only 
> replacing the api calls which do RSA signing of the SHA1 checksum with 
> an API call that can do signing of SHA1 + SHA* variants (basicialy 
> signing longer bitstrings).

I've been looking into this one a bit - looks trickier than that.
For clarity's sake:
- openvpn 2.3.4 on Windows works with 'cryptoapicert' "as always"
- openvpn 2.3.4 on Windows works whith external cert/key pair (.crt/.key 
file) in combination with tls-version-min 1.2

combine the two and it breaks, i.e. tls-version-min 1.2 + cryptoapicert 
goes bust with a mediocre OpenSSL error related to
  RSA_EAY_Sign & message length

If I use a pkcs11 shim in front of the ms-capi library (e.g. 
p11capi_w32.dll) so that I can access the cryptostore keys via a pkcs#11 
interface then it also breaks , again on the rsa_sign process.

So, it looks like running rsa_sign with a cert/key pair coming out of 
the cryptostore store is causing some low level openssl problems. Don't 
know how easy it is fix, but most likely it's not inside the OpenVPN code...

HTH,

JJK
 



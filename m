References: <CAKuzo_gJK_1jU5juC1YQzKzm=25Cm+c-3X7-pT1DW_fkkW_9dQ@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <b789e1b3-8ed2-f4d9-b311-b76d063b79a8@...1227...>
Date: Wed, 3 Jan 2018 09:05:20 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gJK_1jU5juC1YQzKzm=25Cm+c-3X7-pT1DW_fkkW_9dQ@...278...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] openvpn segfaults on --management-external-key
 with ECC certificate
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 03.01.18 um 03:22 schrieb Selva Nair:
> Hi,
> 
> I expected an error message saying only RSA certs are supported for
> --management-external-key, but openvpn appears to segfault if a cert
> with an ECC key is used with that option.
> 
> A stack trace shows it fails in ssl_openssl.c line 1117 when trying to
> copy n and e. In fact the call
> 
> pub_rsa = EVP_PKEY_get0_RSA(pkey);
> 
> before that (line 1104) should have failed and the code does correctly
> check its return value. But that call succeeds for some reason.
> Instead, RSA_get0_key() returns invalid n and e pointers and passing
> those to BN_dup() fails.
> 
> This is with openssl 1.0.1 and that could be the problem -- it may not
> have EVP_PKEY_get0_RSA() in which case the compatibility interface in
> use is probably not smart enough...
> 
> Is this a known issue or is it just me?

There in acked patch from me for that issue that got commited
(bb23eca/4b8d654) that introduces the first check. So the question is
what strange certificate/config do you have so that the first call
succeeds. Also might be OpenSSL 1.0.1 that does not behave correctly.

Arne


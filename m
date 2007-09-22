Message-ID: <46F5630E.3000208@...334...>
Date: Sat, 22 Sep 2007 21:46:38 +0300
From: Faidon Liambotis <paravoid@...334...>
MIME-Version: 1.0
References: <20070922172545.GA6614@...997...>
	<9e0cf0bf0709221104s79c10d18x426d8b29351b7720@...278...>
In-Reply-To: <9e0cf0bf0709221104s79c10d18x426d8b29351b7720@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] Use CryptoAPI CA store
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Alon Bar-Lev wrote:
> Why not use SSL_CTX_add_client_CA and add all CAPI root store into
> OpenSSL context?
My initial approach (v1) was that (albeit not with
SSL_CTX_add_client_CA but with X509_STORE_add_cert).
This was flawed, for the reasons I mentioned in v2 changelog (which btw,
you have seen and commented on :-):
- CRLs are not handled that way.
- It is hard, if not impossible, to build proper chains from the
imported CAs. e.g. you can have an intermediate CA in Windows
Certificate Store that is *not* trusted by Windows because the root CA
doesn't exist in the respective store.
- It felt like a gross hack.

It seems that is much better to ask Windows to check whether the
presented certificate is trusted or not than try to build the trust path
yourself and import it to OpenSSL.

Regards,
Faidon


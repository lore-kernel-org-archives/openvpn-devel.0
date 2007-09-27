Message-ID: <46FBA4F1.4040809@...334...>
Date: Thu, 27 Sep 2007 15:41:21 +0300
From: Faidon Liambotis <paravoid@...334...>
MIME-Version: 1.0
References: <20070922172545.GA6614@...997...>	<9e0cf0bf0709221104s79c10d18x426d8b29351b7720@...278...>	<46F5630E.3000208@...334...>	<9e0cf0bf0709221206s41b73819mc864b81217d822b8@...278...>	<46F56B70.30009@...334...>	<9e0cf0bf0709221226t671805a5kc29e4e04a49e6be@...278...>
	<20070923081720.GA14627@...997...>
In-Reply-To: <20070923081720.GA14627@...997...>
Subject: Re: [Openvpn-devel] [PATCH v4] Use CryptoAPI CA store (was Re:
 [PATCH v3] Use CryptoAPI CA store)
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Faidon Liambotis wrote:
> Alon Bar-Lev wrote:
>> You need to use both, one for create the chain and the other to verify
>> that it meets with system CTL for SSL.
> Seems that you are right. Below you will find -v4 of the patch that does
> that.
> 
> Also, my previous version didn't actually check for revocations,
> contrary to what I documented.
> I added CERT_CHAIN_REVOCATION_CHECK_CHAIN_EXCLUDE_ROOT to the dwFlags of
> CertGetCertificateChain.
> 
> Let me know what you think.
Alon, ping?

I'd really like to have this patch merged this time.

If you have any more comments or objections, just say so so I can fix them.

If you don't, just say so, so it can get merged.

Thanks,
Faidon


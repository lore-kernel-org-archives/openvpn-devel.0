Message-ID: <9e0cf0bf0709221206s41b73819mc864b81217d822b8@...278...>
Date: Sat, 22 Sep 2007 21:06:18 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <46F5630E.3000208@...334...>
MIME-Version: 1.0
References: <20070922172545.GA6614@...997...>
	<9e0cf0bf0709221104s79c10d18x426d8b29351b7720@...278...>
	<46F5630E.3000208@...334...>
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
Content-Disposition: inline
To: Faidon Liambotis <paravoid@...334...>
Cc: openvpn-devel@lists.sourceforge.net

On 9/22/07, Faidon Liambotis <paravoid@...334...> wrote:
> It seems that is much better to ask Windows to check whether the
> presented certificate is trusted or not than try to build the trust path
> yourself and import it to OpenSSL.

OK...
So you need to use CertVerifyCertificateChainPolicy() with CERT_CHAIN_POLICY_SSL

Alon.


Message-ID: <9e0cf0bf0709221226t671805a5kc29e4e04a49e6be@...278...>
Date: Sat, 22 Sep 2007 21:26:32 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <46F56B70.30009@...334...>
MIME-Version: 1.0
References: <20070922172545.GA6614@...997...>
	<9e0cf0bf0709221104s79c10d18x426d8b29351b7720@...278...>
	<46F5630E.3000208@...334...>
	<9e0cf0bf0709221206s41b73819mc864b81217d822b8@...278...>
	<46F56B70.30009@...334...>
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
> Alon Bar-Lev wrote:
> > So you need to use CertVerifyCertificateChainPolicy() with CERT_CHAIN_POLICY_SSL
> I'm no Microsoft developer (adn I don't want to be to be honest) but if
> I understand it right, it's better to call CertGetCertificateChain() as
> I am doing.

You need to use both, one for create the chain and the other to verify
that it meets with system CTL for SSL.

Alon.


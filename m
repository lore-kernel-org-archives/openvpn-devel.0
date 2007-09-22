Message-ID: <46F56B70.30009@...334...>
Date: Sat, 22 Sep 2007 22:22:24 +0300
From: Faidon Liambotis <paravoid@...334...>
MIME-Version: 1.0
References: <20070922172545.GA6614@...997...>	
	<9e0cf0bf0709221104s79c10d18x426d8b29351b7720@...278...>	
	<46F5630E.3000208@...334...>
	<9e0cf0bf0709221206s41b73819mc864b81217d822b8@...278...>
In-Reply-To: <9e0cf0bf0709221206s41b73819mc864b81217d822b8@...278...>
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
> So you need to use CertVerifyCertificateChainPolicy() with CERT_CHAIN_POLICY_SSL
I'm no Microsoft developer (adn I don't want to be to be honest) but if
I understand it right, it's better to call CertGetCertificateChain() as
I am doing.

MSDN for CertVerifyCertificateChainPolicy()[1] says on the remarks:
"Use the CertGetCertificateChain function to enable and perform
certificate revocation checking. The CertVerifyCertificateChainPolicy
function does not check if certificates in the certificate chain are
revoked."

I could be far off in reading the documentation; my tests however
suggest that I got it right.

If you disagree, can you explain in more words your objection? :)

Thanks,
Faidon

1: http://msdn2.microsoft.com/en-us/library/aa377163.aspx



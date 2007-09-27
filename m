Message-ID: <9e0cf0bf0709271357y4eeefa8fi4a823bb8805df09b@...278...>
Date: Thu, 27 Sep 2007 23:57:19 +0300
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <46FBA4F1.4040809@...334...>
MIME-Version: 1.0
References: <20070922172545.GA6614@...997...>
	<9e0cf0bf0709221104s79c10d18x426d8b29351b7720@...278...>
	<46F5630E.3000208@...334...>
	<9e0cf0bf0709221206s41b73819mc864b81217d822b8@...278...>
	<46F56B70.30009@...334...>
	<9e0cf0bf0709221226t671805a5kc29e4e04a49e6be@...278...>
	<20070923081720.GA14627@...997...> <46FBA4F1.4040809@...334...>
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
Content-Disposition: inline
To: Faidon Liambotis <paravoid@...334...>
Cc: openvpn-devel@lists.sourceforge.net

On 9/27/07, Faidon Liambotis <paravoid@...334...> wrote:
> Alon, ping?

Oh... missed your post.
Please don't keep change the subject line.
And replay all to every correction.

> I'd really like to have this patch merged this time.
> If you don't, just say so, so it can get merged.

Only James can merge patches...
I only review this as I can help you improve it.

> If you have any more comments or objections, just say so so I can fix them.

Some more notes:
1. For CertGetCertificateChain() you should use the following flags:
CERT_CHAIN_REVOCATION_CHECK_CHAIN
So that CA may suicide.

2. CertVerifyCertificateChainPolicy()

PolicyPara extra should be set:
fdwChecks should be SECURITY_FLAG_IGNORE_CERT_CN_INVALID
as we check subject name within OpenVPN.

dwAuthType should be AUTHTYPE_CLIENT or AUTHTYPE_SERVER depending on
the configuration. I think that peer-to-peer should be
AUTHTYPE_SERVER.

3. I am not sure you require:
ChainPara.RequestedUsage = <something>
Have you tried to leave it zero?

4. I guess a cleaner code would load crypt32.dll once in the module,
moving the LoadLibrary and GetProcAddress to a single function,
calling it from initialization code.
Also if you already mess with this module, I guess a cleanup code
should be added to free the library during termination... :)

Best Regards,
Alon Bar-Lev.


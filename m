Message-ID: <9e0cf0bf0701031135ye497473tf9b18cc2037fbca5@...278...>
Date: Wed, 3 Jan 2007 21:35:51 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <20070103073706.GA11588@...997...>
MIME-Version: 1.0
References: <20070103073706.GA11588@...997...>
Subject: Re: [Openvpn-devel] [PATCH v2] Use CryptoAPI to verify certificates
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Faidon Liambotis <paravoid@...334...>
Cc: openvpn-devel@lists.sourceforge.net

On 1/3/07, Faidon Liambotis <paravoid@...334...> wrote:
> Ok, here's another try, even though I didn't get any comments on the
> first one :-)
>
> This is a totally different approach; the previous one was flawed in at
> least two aspects:

This is better.
But you should use CertVerifyCertificateChainPolicy in order to verify
chain, you should have two policies, one for server and one for
client...

I think you can remove the global variable you added to ssl.c and put
it in the session.

Another thing... I think the MinGW specific code should be dropped, I
know it was in the previous source... But there should be no problem
in creating one code which runs on both.

Best Regards,
Alon Bar-Lev.


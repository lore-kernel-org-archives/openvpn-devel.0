Message-ID: <9e0cf0bf0701041007x675e4d5cobbe2e8e5fae143c9@...278...>
Date: Thu, 4 Jan 2007 20:07:57 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <459CD3BD.4010506@...334...>
MIME-Version: 1.0
References: <20070103073706.GA11588@...997...>
	<9e0cf0bf0701031135ye497473tf9b18cc2037fbca5@...278...>
	<459CD3BD.4010506@...334...>
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

On 1/4/07, Faidon Liambotis <paravoid@...334...> wrote:
> Hi,
> Thank you for your comments.
>
> Alon Bar-Lev wrote:
> > On 1/3/07, Faidon Liambotis <paravoid@...334...> wrote:
> >> Ok, here's another try, even though I didn't get any comments on the
> >> first one :-)
> >>
> >> This is a totally different approach; the previous one was flawed in at
> >> least two aspects:
> >
> > This is better.
> > But you should use CertVerifyCertificateChainPolicy in order to verify
> > chain, you should have two policies, one for server and one for
> > client...
> I've thought about it but didn't implement it because the only policy I
> could think of was the nsCertType checking which is already being done
> by OpenSSL if the user requested it.

If you integrate into Microsoft trust providers, you should also
support CTL and such. So that the Domain/Computer policy will be
applied to OpenVPN.
But this is just my opinion... :)

Best Regards,
Alon Bar-Lev.


Message-ID: <9e0cf0bf0709101323l568ec5e9ge28dcd0bec1ff437@...278...>
Date: Mon, 10 Sep 2007 23:23:20 +0300
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <2d460de70709100322m6cdd770bh566d825af7a33c7c@...278...>
MIME-Version: 1.0
References: <2d460de70709100322m6cdd770bh566d825af7a33c7c@...278...>
Subject: Re: [Openvpn-devel] Revisit of a possible compile-time enabled
	pkcs11-pin option
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
To: Richard Hartmann <richih.mailinglist@...277...>
Cc: openvpn-devel@lists.sourceforge.net

You can always provide your own management interface program that
supply static PIN. No need to change anything in OpenVPN.

Alon.

On 9/10/07, Richard Hartmann <richih.mailinglist@...277...> wrote:
> Hi all,
>
>
> as most, if not all, of you will be aware, there is an option to pass
> the certificate passphrase into OpenVPN if you compile OpenVPN with the
> correct option, yourself. This Molly Guard enables people who know what
> they are doing to automate the process a little bit more than would be
> possible, otherwise.
>
> My request is that the same thing should be offered for the PKCS#11
> interface of 2.1. The discussion about the relative merits of the
> management console and compiling your own OpenVPN binaries
> notwithstanding, I feel that this approach is more secure, less prone to
> failure and eases the overall process a _lot_. Furthermore, this
> question has already been discussed in the mailing list archives and,
> back then, it was decided to go the path of Bake Your Own to safeguard
> people against themselves, at least for the passphrase.
>
> Is there any chance that this feature sees the light of day and if yes,
> is anyone able and/or willing to venture a guess as to when this might
> be the case?
>
>
> Thank you for all the work on OpenVPN!
> Richard
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


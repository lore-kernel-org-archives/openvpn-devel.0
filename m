MIME-Version: 1.0
In-Reply-To: <b9a70fef-feda-053c-bd96-c2b0e74c576a@...2080...>
References: <b9a70fef-feda-053c-bd96-c2b0e74c576a@...2080...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Sat, 6 May 2017 07:46:11 -0400
Message-ID: <CAEsd45TO_15AxKCuRS7qZRugrT_k8t8cbEx_p6y55JmJZ1_J8g@...278...>
Subject: Re: [Openvpn-devel] The future of contrib/keychain-mcd
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: David Sommerseth <davids@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi.

Several weeks ago "kaloprominat" submitted PR #369 [1] to Tunnelblick.
It incorporates the keychain-mcd code into Tunnelblick. (I don't know
if that triggered your scrutiny of keychain-mcd or if that is a
coincidence.)

I have not finished reviewing the PR, but it includes fixes for
several problems that were found in the keychain-mcd code. When I
finished my review I was going to suggest that kaloprominat submit the
fixes as patches to OpenVPN.

I would like to add this feature to Tunnelblick (assuming it is fully
fixed, of course), particularly because it will allow Tunnelblick
users to use security tokens that are integrated into the macOS
Keychain. Currently, Tunnelblick uses pkcs11-helper for this, but the
Tunnelblick implementation is broken, so this would fix an outstanding
issue for Tunnelblick users.

So although I can't commit to maintaining this code, I would like to
encourage someone else to do so : )

Best regards,

Jon Bullard

[1] https://github.com/Tunnelblick/Tunnelblick/pull/369

On Fri, May 5, 2017 at 7:21 PM, David Sommerseth
<openvpn@...2080...> wrote:
>
> Hi,
>
> We have had the contrib/keychain-mcd code under a more thorough code
> review lately.  And there are several issues found during that review
> which really needs to be improved.
>
> Basically most of the functions handling memory management have a very
> ambitious coding style.  The result of functions allocating memory is
> never checked, just presumes it is fine.  That will in most scenarios
> work perfectly fine, until the day where one of these allocations fails
> and the rest of the code starts tries to use a NULL pointer instead.
>
> I have tried to get in touch with the contributor (on Cc) directly two
> times in April (12th and 21st) already and have not heard anything at all.
>
> We in the core team would like to see this issue resolved, but it can't
> drag out forever.  So I propose that unless someone who is interested in
> this code shows up within the end of May 2017, that code is in high risk
> of being completely removed from our source tree.
>
> Please do get in touch ASAP if you use this code and would like to help
> improving it.
>
>
> --
> kind regards,
>
> David Sommerseth
> OpenVPN Technologies, Inc
>
>
>
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


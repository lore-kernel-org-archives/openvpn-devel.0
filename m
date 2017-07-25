MIME-Version: 1.0
In-Reply-To: <20170725130314.12919-1-davids@...515...>
References: <20170725130314.12919-1-davids@...515...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Tue, 25 Jul 2017 09:37:02 -0400
Message-ID: <CAEsd45RcNtD+f3p_yBwr9X1gXaVCQ_-_cM+sf_NZjRBXft+0bw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] contrib: Remove keychain-mcd code
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: David Sommerseth <davids@...515...>

On Tue, Jul 25, 2017 at 9:03 AM, David Sommerseth <davids@...515...> wrote:
> After the security audits performed by Cryptography Engineering the
> spring of 2017 [1], there were several concerns about the contrib code
> for the macOS keychain support.  After more careful review of this
> code base, it was considered to be in such a bad shape that it will
> need a massive overhaul.  There were more issues than what the security
> audit revealed.
>
> It was attempted several times to get in touch with the contributor
> of this code; with no response at all [2].  There has however
> been some discussions with the Tunnelblick project [3]. There is one
> person there willing to go through this and improve the situation.
> The main Tunnelblick maintainer is also willing to include the improved
> code to their project instead of having this as a contrib code in
> the upstream OpenVPN project.
>
> So this patch just removes the code which we will no longer
> ship as part of OpenVPN - and the Tunnelblick project will take
> over the responsibility for this code base on their own.  And since
> this code base is purely macOS specific, this seems to be a far
> better place for this code to reside.

ACK to removing this code.

I will add the code to the Tunnelblick project if/when it is fixed.

It should be noted, however, that what is added to Tunnelblick will
have many modifications and will be integrated into Tunnelblick's
existing code for the OpenVPN management interface. It will not have
the separate "keychain-mcd" daemon which is in the keychain-mcd code
that is being removed from OpenVPN.

And: thanks, David, for your work on this.

Best regards,

Jon Bullard


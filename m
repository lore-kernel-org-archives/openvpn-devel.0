MIME-Version: 1.0
In-Reply-To: <CAEsd45TNByqmFtmY54eB8506SyE=te7S89WLD3YpwdbLY7-mLA@...278...>
References: <CAEsd45TNByqmFtmY54eB8506SyE=te7S89WLD3YpwdbLY7-mLA@...278...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Fri, 29 May 2015 11:54:20 -0400
Message-ID: <CAEsd45TCOgEOYzf3rYq5GrpXWHaL37Mn_4gwtjGrhxH3EjicCw@...278...>
Subject: Re: [Openvpn-devel] [Patch] Fail if options have extra parameters
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Sorry, forgot to add a link to the ticket for this:

https://community.openvpn.net/openvpn/ticket/557

On Fri, May 29, 2015 at 11:38 AM, Jonathan K. Bullard
<jkbullard@...277...> wrote:
> The attached patch causes an error if an option has are extra
> parameters; previously they were ignored.
>
> This feature was discussed on the openvpn-devel mailing list:
> http://thread.gmane.org/gmane.network.openvpn.devel/9599
>
> The patch is for the master branch only -- the consensus of the
> mailing list discussion was that the patch should not be included in
> the 2.3 branch.
>
> The (modified) message "Unrecognized option or missing or extra
> parameter(s)" is used except for a few options:
>
>      * The --help option: An extra parameter for --help generates a
> specific error message after showing the syntax message. This is done
> to help a user who tries "--help tls-cipher" or similar, hoping to get
> more information about the "tls-cipher" option.
>
>      * The --dhcp-option option: It has its own similar message, into
> which " or extra" has been inserted.
>
>      * Ten options such as --up that accept a command (instead of a
> path) already detect extra parameters and generate specific error
> messages that mention double-quoting commands which contain imbedded
> spaces.


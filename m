Message-ID: <556E9FA7.7090703@...1227...>
Date: Wed, 03 Jun 2015 08:33:11 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <CAEsd45RvRfmqetu-EoFjSdyBk5F9X1K5muPGu-+_+30TMNOU_A@...278...>
In-Reply-To: <CAEsd45RvRfmqetu-EoFjSdyBk5F9X1K5muPGu-+_+30TMNOU_A@...278...>
Subject: Re: [Openvpn-devel] [Patch] Version 2: Fail if options have extra
 parameters
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: "Jonathan K. Bullard" <jkbullard@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>



Am 02.06.15 um 14:43 schrieb Jonathan K. Bullard:
> This is a new thread with version 2 of the patch; the first submission
> included the wrong .patch file and was withdrawn.
>
> The attached patch causes an error if an option has extra
> parameters; previously they were ignored (ticket #557 at
> https://community.openvpn.net/openvpn/ticket/557).
>
> This feature was discussed on the openvpn-devel mailing list (
> http://thread.gmane.org/gmane.network.openvpn.devel/9599).
>
> The patch is for the master branch only -- the consensus of the
> mailing list discussion was that the patch should not be included in
> the 2.3 branch.
>
> The (modified) message "Unrecognized option or missing or extra
> parameter(s)" is used except for a few options:
>
>  
ACK. But some things I noticed (should go into separate patch)

We do not catch

--connection foo, it is silently ignored

Arne



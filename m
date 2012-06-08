Message-ID: <4FD237E3.2030605@...1227...>
Date: Fri, 08 Jun 2012 19:35:31 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1338642223-20324-1-git-send-email-arne@...1227...>
	<1338642223-20324-9-git-send-email-arne@...1227...>
	<CAHyOtRkFiz0aKO=FPLPsFXQg1EcxBMRwytVXt=6jfaP8jkgcrQ@...278...>
In-Reply-To: <CAHyOtRkFiz0aKO=FPLPsFXQg1EcxBMRwytVXt=6jfaP8jkgcrQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH 8/8] Android platform specific changes.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Adriaan de Jong <adriaan@...1475...>
Cc: openvpn-devel@lists.sourceforge.net

Am 07.06.12 18:44, schrieb Adriaan de Jong:
> Hi Arne,
>
> Could you please split this patch up a little further? As it is, it
> performs a number of functions, which, although related to Android
> would be easier to ack if they were separate. 
>
> Am I correct in noting that you use  management_query_user_pass() to
> send queries across the management interface? If so, that begs an open
> question to the community: is there a better way of communicating
> across the management interface?
>
Yes. At the moment almost all information is passed with
management_query_user_pass, I have no split up the patch further since
we should first discussed the best way to pass information around. (See
also the lengthy discussion when I first submitted an Android patch)

Arne


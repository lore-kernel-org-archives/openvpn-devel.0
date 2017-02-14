MIME-Version: 1.0
In-Reply-To: <20170214200042.GX93896@...1296...>
References: <CAOAUwZF0LYNAYESg1fKeNUhJr70pLcf89HTyxTQmf2S3RnoUBA@...278...>
	<0cdcbed7-801c-9cec-cd03-1252c06b4466@...1856...>
	<CAOAUwZEiSjAEmTka=w-4TePAoGEZBZG1r_5gS-wpXL+TLX7qCQ@...278...>
	<20170213083137.GK93896@...1296...>
	<CAOAUwZF2-KXfMTwOuLj-B3wzWtD-i-8NytNkbS3gyvexaCpWGw@...278...>
	<20170213175000.GU93896@...1296...>
	<b38fcbe0-fc2b-1bd5-ac98-f930334b6925@...2080...>
	<CAOAUwZGs4934tC9P3zvmrN6qp-L9vkSMOi3_UwXT4Q7NCvdp5w@...278...>
	<CAKuzo_gwjVdfLbqAQH=4PyvKU2Hha6cd3dJZGkRBTkDTCiB7aQ@...278...>
	<CAOAUwZHAuSdL6q5z40maNPCQQmN0715c1+go0NNmPAvmJZwkFw@...278...>
	<20170214200042.GX93896@...1296...>
From: Olivier W <olivierw.ml@...277...>
Date: Tue, 14 Feb 2017 21:14:42 +0100
Message-ID: <CAOAUwZHcXW2rniBSz_5zzqfVcSFtzeqigSwHeLXiXZ8kJ4EWZQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix building with LibreSSL 2.5.1 by
 cleaning a hack.
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
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hey :-)

2017-02-14 21:00 GMT+01:00 Gert Doering <gert@...1296...>:
> Funny enough, I was already subscribed to that bug... :)

:-)

> I find it a bit weird that this not addressed upstream in git itself,
> but is burdened on the operating system maintainers...  but most likely,
> I'm missing half the story.

Of course it should be addressed upstream, I've composed the patch
from a pull request I had found: https://github.com/git/git/pull/251
dating from last June.
From what I understood, they didn't merge it yet because it uses a too
recent version of Net::SMTP, which isn't included in Travis-CI... :-/
So for now, we have to use a patch for FreeBSD, and probably others
BSD/Linux use a patch until it's upstreamed.

> whatever - it works now!  :-) - and now to address your actual patch!
>
> Steffan...?

Yeah, that would be cool! ;-)

Best Regards,
Olivier


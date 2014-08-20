MIME-Version: 1.0
In-Reply-To: <CAFLxGvy77WaHhrsqSfm2Va4fbD_y5Ta5ykMsczCQ=-Z9AkNjnQ@...278...>
References: <CAFLxGvy77WaHhrsqSfm2Va4fbD_y5Ta5ykMsczCQ=-Z9AkNjnQ@...278...>
Date: Wed, 20 Aug 2014 18:42:11 +0600
Message-ID: <CAFHpkQFLz5P2_F0U=ED7My5a0WfEc3T9GR_VrDxQ-XSZe1pCWA@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Subject: Re: [Openvpn-devel] Ongoing Windoes 8 issues
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
To: Richard Weinberger <richard.weinberger@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

when "some hacks work, some not" , it looks like assumtion that
variables should be initialized with zero.
have a look around, maybe youl'll find another uninitialized variable :-)

2014-08-20 13:32 GMT+06:00 Richard Weinberger <richard.weinberger@...277...>:
> Hi!
>
> This bug exists for almost 14 months (!!) without a solution.
> Some hacks work some not.
> https://community.openvpn.net/openvpn/ticket/316
>
> I really wonder why this issue is ignored by the OpenVPN developers.
>
> --
> Thanks,
> //richard
>
> ------------------------------------------------------------------------------
> Slashdot TV.
> Video for Nerds.  Stuff that matters.
> http://tv.slashdot.org/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


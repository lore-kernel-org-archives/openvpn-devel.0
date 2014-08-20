MIME-Version: 1.0
In-Reply-To: <CAFLxGvy77WaHhrsqSfm2Va4fbD_y5Ta5ykMsczCQ=-Z9AkNjnQ@...278...>
References: <CAFLxGvy77WaHhrsqSfm2Va4fbD_y5Ta5ykMsczCQ=-Z9AkNjnQ@...278...>
Date: Wed, 20 Aug 2014 18:38:06 +0600
Message-ID: <CAFHpkQEs1uuBRSJm_+rqML9iAiY6xBtTfhcYAWU7fNYC3CX-Ww@...278...>
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

we have a lot of users on Windows 8, no issue at all.
well, I recall some issue (it was different than
https://community.openvpn.net/openvpn/ticket/316)

couple of early adopters installed Windows 8 preview, openvpn doesn't
work on that windows edition (due to improper variable initialization
within openvpn),
I reported that bug (and even a patch applied), however, nobody agreed
to include that patch.

http://comments.gmane.org/gmane.network.openvpn.devel/8091

I couldn't find win 8.1 preview since than, it was removed from
everywhere, but I confirm my patch helped our early adopters.


the date of https://community.openvpn.net/openvpn/ticket/316 is
somewhat like "win 8.1 preview", if you want to be really helpful, you
can find which edition of windows was described there (or try 8.1
preview, for example).

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


MIME-Version: 1.0
In-Reply-To: <CAEsd45SF1fcVPJfOmhmm6GzB7=WvnBg95k=+nX25aRwKf2X-kQ@...278...>
References: <528B8225.3040206@...515...>
	<1384882574-28242-1-git-send-email-heiko.hund@...1489...>
	<529EF77C.5020603@...68...>
	<CAEsd45SF1fcVPJfOmhmm6GzB7=WvnBg95k=+nX25aRwKf2X-kQ@...278...>
Date: Wed, 4 Dec 2013 18:22:04 +0600
Message-ID: <CAFHpkQFx+3QHie71FTGKk6ieKMwC-7X8M=O58qbtnj8-99MVYA@...278...>
From: =?KOI8-R?B?6czY0SD7ydDJw8nO?= <chipitsine@...277...>
Subject: Re: [Openvpn-devel] English language? Re: [PATCH] Support non-ASCII
 characters in Windows tmp path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: Matthias Andree <matthias.andree@...68...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

I've looked through the code and I do not understand why do we need
that temporary directory on windows platfrom ?
anyone can explain idea behind initializing tmp-dir ? especially on
Windows platform.

2013/12/4 Jonathan K. Bullard <jkbullard@...277...>:
> On Wed, Dec 4, 2013 at 4:35 AM, Matthias Andree <matthias.andree@...68...>
> wrote:
>>
>> Am 19.11.2013 18:36, schrieb Heiko Hund:
>> > +      msg (M_WARN, "Could not get temporary directory. Path is too
>> > long."
>> > +          "  Consider to use --tmp-dir");
>>
>> I think when touching the code, we ought to change all occurrences to
>> "Consider using --tmp-dir".
>>
>> Native speakers or linguists correct me, but since most usage references
>> I found were "consider + object" (object often a noun), the -ing form
>> would have to be used here.
>
>
> As a native English speaker, I agree; "Consider using --tmp-dir" is correct.
>
> (As an American, I have almost no formal knowledge of grammar or diction, so
> I can't cite why :-)
>
> ------------------------------------------------------------------------------
> Sponsored by Intel(R) XDK
> Develop, test and display web and hybrid apps with a single code base.
> Download it for free now!
> http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


MIME-Version: 1.0
In-Reply-To: <5374780.EoPQ9uqcdy@...1526...>
References: <1329413441-22538-1-git-send-email-heiko.hund@...1489...>
	<1329413441-22538-5-git-send-email-heiko.hund@...1489...>
	<CAOazyz3q3iCDAaxaQbmWYmTx=wHDv5TDxzJhmXMmC82VOEcA3w@...278...>
	<5374780.EoPQ9uqcdy@...1526...>
Date: Fri, 17 Feb 2012 11:55:19 +0200
Message-ID: <CAOazyz15xpgFxzqQFaotZSmS2=-gSmUsMMwy=SZay6bi3EEMAg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 4/4] make MSVC link against shell32 as
	well
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
To: Heiko Hund <heiko.hund@...1489...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Fri, Feb 17, 2012 at 11:51 AM, Heiko Hund <heiko.hund@...1489...> wrote:
> Alon,
>
> On Thursday 16 February 2012 18:37:21 Alon Bar-Lev wrote:
>> On Thu, Feb 16, 2012 at 7:30 PM, Heiko Hund <heiko.hund@...1489...> wrote:
>> > Windows API CommandLineToArgvW(), introduced in Windows unicode path
>> > commit 71bbbd76c62630c88441237d72fe5b61f0b45b2a, is defined therein.
>>
>> Usually this should be avoided and get command-line from wmain().
>
> the general idea is to make Unicode things happen without changing the openvpn
> code too much in a very Windows specific way. Converting UCS-2 to UTF-8
> directly where input and output is happening and passing it through the rest
> of openvpn as char* does that. I don't see any benefit in converting openvpn
> into a native unicode binary.

I agree.
Compiling entry point as wmain and not main is not bigger change than
any other change in the unicode patch.
Anyway as it seem we have an opportunity window to cleanup the mess,
so apply whatever needed in orderer to make it work and then we revise
it.
Personally, I don't think this unicode patch was ready to be merged...

Alon.


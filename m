References: <1514540857-19290-1-git-send-email-steffan.karger@...1435...>
 <CAFHpkQG56wpZzN2KD3BYmcSDFFLi8Jpq0e-ZN-=9yJH4VWybiQ@...278...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <f6271a6e-0a17-a678-05c8-9b3b7912766d@...1435...>
Date: Fri, 29 Dec 2017 11:23:01 +0100
MIME-Version: 1.0
In-Reply-To: <CAFHpkQG56wpZzN2KD3BYmcSDFFLi8Jpq0e-ZN-=9yJH4VWybiQ@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] --with-mem-check, what to do with it?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 29-12-17 11:11, Илья Шипицин wrote:
> thank for the patch.
> 
> not directly related to the patch itself, but openvpn is shipped with
> several memory debugging options
> 
> --with-mem-check=TYPE   build with debug memory checking
> 
> 
> should we get rid of them (in favour of sanitizers) ? or, maybe add to
> tests instead ?

I've tried to use those in the past, but found them hard to use.  I
think they're a remnant of the past.  I would personally prefer to get
rid of them and use the (nowadays much better) fully external memory
checking tools instead (sanitizers, valgrind, etc).

-Steffan


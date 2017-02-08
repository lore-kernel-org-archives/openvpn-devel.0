References: <CAOAUwZH8aRg-5XLJaYjpzw6y9yptx-ma7QJVPJT-yKFE7cmUrw@...278...>
	<20170207041451.GA11922@...2182...>
	<CAFHpkQESrLYrnVPUOeNf7kbHe27=1w5x8uc=ATynTNnPvezpkw@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <135121b9-fe6f-aed9-7b0e-452e57913d27@...1856...>
Date: Wed, 8 Feb 2017 23:18:30 +0100
MIME-Version: 1.0
In-Reply-To: <CAFHpkQESrLYrnVPUOeNf7kbHe27=1w5x8uc=ATynTNnPvezpkw@...278...>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 07-02-17 09:45, Илья Шипицин wrote:
>     I have a question (sorry if I couldn't check myself): did you check that
>     SSL_get_privatekey() and SSL_free() won't crash when ssl is NULL ?
> 
> what if we involve clang static analyzer for such things ? can we count
> on it ?
> 
> it is capable of detecting "Argument with 'nonnull' attribute passed null"
> 
> and, as I can see, after applying patch it didn't find new issues
> 
> http://chipitsine.github.io/without-patch/
> http://chipitsine.github.io/with-patch/
> 
> 
> also, it might be even automated, run clang static analyzer before and
> after applying patch and compare the result

Static analyzers are useful, but do not and probably never will replace
review by someone who knows the code.  They complement each other;
neither will detect all mistakes.

In relation to that, please stop making statements like 'it passes
travis, so the patch must be okay'.  That's pertinently not true.

-Steffan


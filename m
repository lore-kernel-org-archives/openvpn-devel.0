References: <1474109679-4982-1-git-send-email-chipitsine@...277...>
	<CAA1AbxKesOCWi2gD6D9nOYVFB2ZyNzYnQsP-NNjWbzPGdG6SPg@...278...>
	<CAFHpkQHNbXW293tp3ua9fr5SwvuLgZh+nJKMR_yioUUVm0QUkg@...278...>
	<8a59c1b0-7bf5-47b8-68ed-ce36e4438c55@...515...>
	<CAFHpkQHMJ7onodTWaEaeE+Ve4kOpbB3V99YqKpwfmbNJsq0r5Q@...278...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <f7b2542a-d691-47b3-0b24-be86cef78a83@...1435...>
Date: Mon, 26 Sep 2016 11:04:37 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQHMJ7onodTWaEaeE+Ve4kOpbB3V99YqKpwfmbNJsq0r5Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH] enable "--disable-crypto" build
 configuration
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

On 26-09-16 10:26, Илья Шипицин wrote:
> 
> 2016-09-26 12:37 GMT+05:00 Samuli Seppänen <samuli@...515...
> <mailto:samuli@...515...>>:
>     All the pieces (ACK, fixed commit message) seem to be present. Maybe
>     it would be easiest to fix the commit message just before the push:
> 
> 
> it would be easiest, but it is not required.
> as Steffan Karger wrote "Could you please include such descriptions in
> future patches?"
>
>     ---
> 
>     Enable "--disable-crypto" build configuration
> 
> 
>     Previously, 'make test' failed for --disable-crypto builds.  Since
>     that is not fixed, we should no longer accept --disable-crypto builds
>     to fail 'make test' on travis.

The committer (David or Gert) can probably just include this text into
the commit message when applying the patch.  I think that's what Samuli
suggested.

Committer:  if you do so, could you please fix my typo from 'not fixed'
to 'now fixed'?  ;-)

Thanks,
-Steffan


References: <1568019436-28527-1-git-send-email-lstipakov@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <63face96-065e-630b-0efe-b8dd155dac1b@...2080...>
Date: Tue, 10 Sep 2019 00:24:40 +0200
MIME-Version: 1.0
In-Reply-To: <1568019436-28527-1-git-send-email-lstipakov@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] tun.h: remove TUN_PASS_BUFFER define
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net

On 09/09/2019 10:57, Lev Stipakov wrote:
> Since the very beginning this define has only
> been used together with _WIN32 and code wrapped into it
> uses Win32 API, so it could be safely removed and
> replaced with _WIN32.
> 
> Signed-off-by: Lev Stipakov <lstipakov@...277...>
> ---
>  src/openvpn/forward.c | 4 ++--
>  src/openvpn/tun.h     | 2 --
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
I've only glared at the code, and it makes sense.  It removes a macro only
enabled when _WIN32 is anyhow defined.  When this macro doesn't even give much
extra clarity, swapping out TUN_PASS_BUFFER with _WIN32 makes more sense.

Acked-By: David Sommerseth <davids@...515...>

-- 
kind regards,

David Sommerseth
OpenVPN Inc



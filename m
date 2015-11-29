MIME-Version: 1.0
In-Reply-To: <1448808959-10565-1-git-send-email-arne@...1227...>
References: <1448808959-10565-1-git-send-email-arne@...1227...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Sun, 29 Nov 2015 10:52:37 -0500
Message-ID: <CAEsd45QjsjNDWFkoHG2O0ycO2pNGxj115TH+SLiUD__jf=WWpQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Remove --enable-password-save option
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
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi.

On Sun, Nov 29, 2015 at 9:55 AM, Arne Schwabe <arne@...1227...> wrote:
> This options is enabled in virtually all distributions and gives no real security benefit.
> ---
>  configure.ac       | 8 --------
>  src/openvpn/misc.c | 8 --------
>  src/openvpn/misc.h | 2 +-
>  src/openvpn/ssl.c  | 8 ++++----
>  4 files changed, 5 insertions(+), 21 deletions(-)

Feature ACK. (I was just about to add "--enable-password-save" when
building Tunnelblick from git-master because of the new "username
only" in file feature; this will save me the trouble. : )

But please update the man page, too; it references
"--enable-password-save". (Then again, the man page doesn't mention
allowing username-only files, so it is already inaccurate.


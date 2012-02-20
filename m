MIME-Version: 1.0
In-Reply-To: <1949591.2ys3ZyyMoG@...1526...>
References: <1329594252-5257-1-git-send-email-heiko.hund@...1489...>
	<4F421C32.1040403@...1114...>
	<CAOazyz3-M4_tqhW0wdBjMsCM5HDBYNGVj4h-1BHTurAqfocvsA@...278...>
	<1949591.2ys3ZyyMoG@...1526...>
Date: Mon, 20 Feb 2012 16:27:13 +0200
Message-ID: <CAOazyz08kLGKyq-Wcd1KTQ9akdQCAYPP9b1aMVne-b9TArMKDQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] define access mode flag X_OK as 0 on
	Windows
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

On Mon, Feb 20, 2012 at 4:22 PM, Heiko Hund <heiko.hund@...1489...> wrote:
> Defining them makes code more readable, but without X_OK being 0 on Windows
> openvpn crashes. See my commit message again and read the MSDN page about
> _access at http://msdn.microsoft.com/en-us/library/1w06ktdy%28v=vs.100%29.aspx
> Hence the change for the MSVC buildsystem only. Mingw handles the situation
> internally already.
>
> Hope that made it clear.

Yes, it is clear.
Still, it is not correct to override well defined constants.
Windows is windows, it is inappropriate to have one constant value for
mingw and another for msvc.
I will submit a different patch.

Alon.


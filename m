References: <1445380656-20654-1-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <56274654.1090608@...1227...>
Date: Wed, 21 Oct 2015 10:01:24 +0200
MIME-Version: 1.0
In-Reply-To: <1445380656-20654-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] hardening: add insurance to exit on a
 failed ASSERT()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net



Am 21.10.15 um 00:37 schrieb Steffan Karger:
> The code behind our ASSERT() macro is pretty complex.  Although it seems
> to be correct, make it trivially clear we will never return from a failed
> assert by adding an _exit(1) call.  As was suggested by Sebastian Krahmer
> of the SuSE security team.
>
> A secondary benefit is that tools like clang static analyzer and coverity
> can now understand our ASSERT() macros too.  To make sure they do, change
> assert_failed() to a static inline function.
>
This change makes absolute sense. ACK from me.

Arne


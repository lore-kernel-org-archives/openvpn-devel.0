MIME-Version: 1.0
In-Reply-To: <1329413441-22538-5-git-send-email-heiko.hund@...1489...>
References: <1329413441-22538-1-git-send-email-heiko.hund@...1489...>
	<1329413441-22538-5-git-send-email-heiko.hund@...1489...>
Date: Thu, 16 Feb 2012 20:37:21 +0200
Message-ID: <CAOazyz3q3iCDAaxaQbmWYmTx=wHDv5TDxzJhmXMmC82VOEcA3w@...278...>
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
Cc: openvpn-devel@lists.sourceforge.net

On Thu, Feb 16, 2012 at 7:30 PM, Heiko Hund <heiko.hund@...1489...> wrote:
> Windows API CommandLineToArgvW(), introduced in Windows unicode path
> commit 71bbbd76c62630c88441237d72fe5b61f0b45b2a, is defined therein.

Usually this should be avoided and get command-line from wmain().


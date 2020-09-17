MIME-Version: 1.0
References: <20200916131349.27668-1-themiron@...2010...>
 <20200916141755.1923-1-themiron@...2010...>
In-Reply-To: <20200916141755.1923-1-themiron@...2010...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 17 Sep 2020 09:45:09 +0300
Message-ID: <CAGyAFMWZTsomdQ02odYdUz=bx--PqfC7jvjBFHwA1B4kJiBfXg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Fix fatal error at switching remotes
 (#629)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Vladislav Grishenko <themiron@...2010...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

> If remote server has been resolved to multiple addresses, at
> least one connection attemt

typ0

> Fix this behaviour by cleaning stale addinfo objects.

Stared at code and it looks fine - same cleanup logic as in
do_close_link_socket().
Built and tested with MSVC - reproduced assert without patch and no
assert with patch.

Acked-by: Lev Stipakov <lstipakov@...277...>


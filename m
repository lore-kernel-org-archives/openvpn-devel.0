MIME-version: 1.0
Message-id: <AC0D1768260B41DB9B09FFBD4A66B5EC@...139...>
From: Gisle Vanem <gvanem@...139...>
References: <1313588569-18927-1-git-send-email-heiko.hund@...1489...>
	<1313588569-18927-2-git-send-email-heiko.hund@...1489...>
	<CAOazyz0gdd6+367C94OnsWPfmaAKtBXO0-OAttXSna2mAVX6OQ@...278...>
Date: Wed, 17 Aug 2011 16:28:42 +0200
Subject: Re: [Openvpn-devel] [PATCH 1/3] add MinGW WinHTTP
	compatibility	layer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: text/plain; CHARSET=US-ASCII; charset="US-ASCII"; format=flowed;
 reply-type=original
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>, Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

"Alon Bar-Lev" <alon.barlev@...277...> wrote:

> These macros are soooooooo ugly!

I tend to agree; had to read the code closely. But this hack was cool:

 union { 
  FUNC ## _fn *type; 
  FARPROC *ptr; 
  } u = { .type = &(LIB ## _ ## FUNC) }; 
...
 *(u.ptr) = GetProcAddress (lib, (#FUNC)); 

Where did you get that Heiko?

--gv



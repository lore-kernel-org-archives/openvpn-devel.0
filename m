Sender: marko@...1042...
References: <483DA4E4.1030308@...1104...>
	<m3skw240d8.fsf@...1043...> <483DC794.3090302@...1104...>
Date: 29 May 2008 00:57:30 +0300
In-Reply-To: <483DC794.3090302@...1104...>
Message-ID: <m3od6q3xdh.fsf@...1043...>
MIME-Version: 1.0
From: Marko Rauhamaa <marko@...1042...>
Subject: Re: [Openvpn-devel] Memory of server keeps increasing
	with	key	negotiations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: Martin Gadbois <martin.gadbois@...1104...>
Cc: openvpn-devel@lists.sourceforge.net

Martin Gadbois <martin.gadbois@...1104...>:

> I've looked at the code (Yeah! Open Source) and could not see any
> lists, or code that accumulates data, apart from gc_*().

There's this weird scheme by which you prepare a memory pool with
gc_new(). Memory keeps on accumulating in the pool with alloc_buf_gc()
(in print_sockaddr_ex(), for example). The memory is not freed until the
whole pool is destroyed with gc_free().

See if there are repeated messages in your log file. It was those log
messages that caused my router to run out of memory over a couple of
weeks, although there must be other similar problem sources.


Marko


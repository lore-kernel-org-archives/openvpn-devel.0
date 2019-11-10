References: <20191110195622.28177-1-a@...2181...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <4782966f-082f-a154-60b3-ce5518d761b7@...2181...>
Date: Sun, 10 Nov 2019 21:07:52 +0100
MIME-Version: 1.0
In-Reply-To: <20191110195622.28177-1-a@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] travis: fix CFLAGS assignment error and
 add -Werror only when compiling on Linux for Linux
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
To: openvpn-devel@lists.sourceforge.net

NAK to myself!

Even though travis was green, this patch does not properly activate
-Werror......

v2 incoming..

Cheers,

-- 
Antonio Quartulli


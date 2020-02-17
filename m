MIME-Version: 1.0
References: <20200217082942.173-1-lstipakov@...277...>
 <bf6eab71-8ec4-70b5-b4de-3b19de8bff6e@...2181...>
In-Reply-To: <bf6eab71-8ec4-70b5-b4de-3b19de8bff6e@...2181...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 17 Feb 2020 11:17:22 +0200
Message-ID: <CAGyAFMVc=GhtcwNRj9KWo3+c9r-A+Hq1uNpDeLgdqNRqQuNycw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] ssl.c: refactor
 tls_item_in_cipher_list() code
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

> In the future I suggest splitting unrelated changes like these in
> different patches.
>

Ok, will send v2 with first change only.

> This expression simply checks that token contains a value different from
> NULL. It's like a simple "a != 0" - it doesn't matter where that address
> points to, because the pointer is not dereferenced.

While it works, I think it is cleared to have a flag, rather than check the
address of a dangling pointer.


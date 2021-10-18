MIME-Version: 1.0
References: <20211015175330.15760-1-selva.nair@...277...>
 <20211015184733.16988-1-selva.nair@...277...>
In-Reply-To: <20211015184733.16988-1-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 18 Oct 2021 10:56:27 +0300
Message-ID: <CAGyAFMWXUCG0iEw2S2L1O8R3_hjkae3hVEoKASZCH3A_EjvL1g@...278...>
Subject: Re: [Openvpn-devel] [PATCH for 2.5] Fix some more wrong defines in
 config-msvc.h
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
To: Selva <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Looks good (I commented already in 2.5 version) apart from

> -#define ENABLE_DEBUG 1
> +#define ENABLE_DEBUG 0

which doesn't undef it.

If cron2 can fix it during commit, consider this as ack.

-- 
-Lev


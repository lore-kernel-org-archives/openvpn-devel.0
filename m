MIME-Version: 1.0
References: <20211213135814.265-1-lstipakov@...277...>
In-Reply-To: <20211213135814.265-1-lstipakov@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 13 Dec 2021 16:03:24 +0200
Message-ID: <CAGyAFMUtRwwniG_XPNSYYP=qjwyLMYeWBT+NgySgPRzuoFYDvQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2.5] config-msvc.h: indicate key
 material export support
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Cc: Lev Stipakov <lev@...515...>

Hi,

I just realized that tls-ekm is a 2.6 feature, which means that
while patch is still valid for 2.5, the last sentence in the commit message
is not.

-- 
-Lev


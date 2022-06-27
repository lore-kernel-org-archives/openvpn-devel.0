MIME-Version: 1.0
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-23-a@...2181...>
In-Reply-To: <20220624083809.23487-23-a@...2181...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 27 Jun 2022 13:38:37 +0300
Message-ID: <CAGyAFMVKekys-2H259ayDKgZrF0JOrn078PxCV-KAj3htYKfXg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 22/25] dco-win: introduce low-level code
 for handling ovpn-dco-win in Windows
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

Hi,

> +        if (dco_get_overlapped_result(handle, ov, &transferred, poll_interval_ms, FALSE) != 0)

With the removal of mingw compat patch ("dco-win: implement
GetOverlappedResultEx for mingw32"), this needs to be changed to
GetOverlappedResultEx (signature is the same).

-Lev


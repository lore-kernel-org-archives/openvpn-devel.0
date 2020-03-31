MIME-Version: 1.0
References: <20200309131728.380-1-simon@...2293...>
 <20200309131728.380-11-simon@...2293...>
 <CAGyAFMVAebWYLKohd5LFLC9Z11rxjqbys8jSd3CQun0ogSjWjg@...278...>
 <A975CEB0-C46B-4A03-A862-C1B321A26D07@...2293...>
In-Reply-To: <A975CEB0-C46B-4A03-A862-C1B321A26D07@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 31 Mar 2020 10:39:06 +0300
Message-ID: <CAGyAFMUNytnwd=W7zckH0tHBinaUw-eBOQ3uVo0_vMR2+YL=Sw@...278...>
Subject: Re: [Openvpn-devel] [PATCH 11/12] openvpnmsica: Merge
 FindTUNTAPAdapters into FindSystemInfo
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
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

> To summarize: the return value of find_adapters() call is ignored on purpose.

Shouldn't return type be void if return value is not used?

I'll ack it to not to further delay 2.5 release, but it would be good
to get a follow-up
patch with either void or return value being not ignored.

Acked-by: Lev Stipakov <lstipakov@...277...>


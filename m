MIME-Version: 1.0
References: <20210608152434.1403999-1-arne@...1227...>
In-Reply-To: <20210608152434.1403999-1-arne@...1227...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 9 Jun 2021 09:20:58 +0300
Message-ID: <CAGyAFMXugZMP5c8z3i8Mqcbci1qp5h-JywGp8fW6Bi5s_tjAKw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add github actions
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Looks good, all builds passed:
https://github.com/schwabe/openvpn/actions/runs/918610289

If those two patches will be acked (none of them touches C code) and merged:

 - https://patchwork.openvpn.net/patch/1815/
 - https://patchwork.openvpn.net/patch/1850/

one could add MSVC github actions as well.

Acked-by: Lev Stipakov <lstipakov@...277...>


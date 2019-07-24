References: <1563442503-11119-1-git-send-email-lstipakov@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <e074afd3-b448-2588-a3a7-1aafd280acc4@...1227...>
Date: Wed, 24 Jul 2019 12:29:36 +0200
MIME-Version: 1.0
In-Reply-To: <1563442503-11119-1-git-send-email-lstipakov@...277...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH] crypto.c: fix Visual Studio build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net

Am 18.07.19 um 11:35 schrieb Lev Stipakov:
> From: Lev Stipakov <lev@...515...>
> 
> Commit fb4e8ab added variable-length array which
> is C99 feature and is not supported by Visual Studio.
> 
> This removes VLA and writes data directly into passed buffer.
> 

After some confusion of the various buffer related function on my side,
this looks good.

Acked-By: Arne Schwabe <arne@...1227...>


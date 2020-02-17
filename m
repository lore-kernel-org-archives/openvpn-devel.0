References: <20200217092009.238-1-lstipakov@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <8e6a9a66-f123-007a-981f-a514dc78fbed@...1227...>
Date: Mon, 17 Feb 2020 10:55:02 +0100
MIME-Version: 1.0
In-Reply-To: <20200217092009.238-1-lstipakov@...277...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH] ssl.c: remove unneeded local variable
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
To: Lev Stipakov <lstipakov@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 17.02.20 um 10:20 schrieb Lev Stipakov:
> From: Lev Stipakov <lev@...515...>
> 
> Remove unneeded _orig variable, which stores
> pointer to tokenized string. Unlike strsep(), strtok()
> doesn't modify pointer itself, only string, so it is safe
> to call free() on that pointer.
> 

Can we just wait with style patches like that that create conflicts with
 a large patchset like my NCP patchset until those larger patches are
handled?

Arne


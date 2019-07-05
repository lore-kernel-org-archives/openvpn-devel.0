References: <20190705130001.30741-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <647cf498-553a-5f06-844e-6388e54ae8cc@...1227...>
Date: Fri, 5 Jul 2019 15:16:37 +0200
MIME-Version: 1.0
In-Reply-To: <20190705130001.30741-1-gert@...1296...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH] repair windows builds (2.4)
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 05.07.19 um 15:00 schrieb Gert Doering:
> commit 0c1cc8d65539f removed "DWORD len;" from service_enable_dhcp(),
> but that variable is far from "unused" - breaking compilation.
> 
> The problem here was that it's a larger "cleanup compiler warnings"
> patch which was fully correct for master, but this particular function
> looks different in release/2.4 because the whole iservice call
> refactoring patch isn't in release/2.4 - so master does not need the
> DWORD len, but release/2.4 does.
> 
> More care needed with "warning cleanup"...

Acked-By: Arne Schwabe <arne@...1227...>

I have neither compile tested nor tested the patch itself but since len
is really used here, the patch will improve things for the better.

Arne


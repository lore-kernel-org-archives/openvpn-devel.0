MIME-Version: 1.0
References: <CAGyAFMUHqDObKdOPD37T-Qau+CXyb-oCQu-NLHYtJKnwhse80g@...278...>
 <CAKuzo_hv8H6zRbvCx_g680TNhHEvoP=OvB_FbGOZAy=jmHvPvQ@...278...>
 <CAGyAFMXpBRGHsTZQjRsr2ByoGx2G2isoqUwaZnwYX6NWWwZBpA@...278...>
 <CAKuzo_ggddGKgDewDWbjv3pNGAC-SK0dmD+Ay-c2HOHcVX5psA@...278...>
 <YZwNiBRC+V/E9OeI@...1296...>
 <CAKuzo_jicUu50x-CxGYE2DJjW0pwf06DCfMkhFn5vKz1AHCrcA@...278...>
 <YZyPoyofdC4M1CqU@...1296...>
 <CAGyAFMXE61tbhW=74jvoQLwegU2SjbFi8V-5JFGcEgO5=7OK2w@...278...>
 <YZzCbiezMd/zkrAO@...1296...>
 <CAGyAFMXZ9OJQJXxkOm6qVDEN4a9ZiMufgX5FTF2Bg9GtHrq4hA@...278...>
 <YZzXtauc1RuVvCGr@...1296...>
In-Reply-To: <YZzXtauc1RuVvCGr@...1296...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 23 Nov 2021 16:30:57 +0200
Message-ID: <CAGyAFMXt4zN182f4womhiHFLtxhfhVU7fgxfZ4GAevhwKbAS0w@...278...>
Subject: Re: [Openvpn-devel] OpenSSL build on Windows: OPENSSLDIR and
 MODULESDIR
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

> > On startup we could read the installation path from
> > HKLM\SOFTWARE\OpenVPN and assume
> > something like <installation-path>\ssl\openssl.cnf ?
>
> To me, this feels like the least annoying way forward... and then we can
> also stop worrying about any future changes on the vcpkg side (even if
> they accept the PR now, they might rebuild their build script, breaking
> things again).

See https://patchwork.openvpn.net/patch/2083/

I only tested with procmon that openvpn.exe tries to load openssl.cnf
from a trusted location.

-- 
-Lev


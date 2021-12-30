References: <20211214150901.4118886-1-arne@...1227...>
 <202112301638.1BUGcEMp081228@...2054...>
 <b421c495-f4ac-f85c-0493-32d4cc835978@...1227...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <a44c2a5c-8ed1-80a3-79c4-3131d6015963@...1856...>
Date: Thu, 30 Dec 2021 19:16:25 +0100
MIME-Version: 1.0
In-Reply-To: <b421c495-f4ac-f85c-0493-32d4cc835978@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Decouple MSS fix
 calculation from frame calculation
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
To: openvpn-devel@lists.sourceforge.net

Hi,

On 30-12-2021 18:28, Arne Schwabe wrote:
> That BF-CBC seems have an extra 8 bytes that I somehow missed. CBC is a
> odd since it always gives you a multiple of the blocksize (64 bit or 8
> byte) and if you evenly divide by the blocksize you get an extra block
> just for the padding. I need to reinvestigate that code and send a fixup
> patch for it.

You probably know this, but for clarity: this is how CBC padding works,
not just for BF. It is easier to trigger with BF though, because of the
smaller (64-bit) block, compared to AES (128-bit block).

-Steffan


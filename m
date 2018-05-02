References: <20180316164059.9120-1-xiaoningning@...109...>
 <CAKuzo_h9=+BeTmg5t=H9nUQbqqi8r4DFd7oPrSBOSArQepj3_w@...278...>
 <1783935013.3421880.1521493221569@...2084...>
 <CAKuzo_jpgG8V-Y5ikxW1uwGNvoQoTJeCca=Wosg9UC_dPGJj6Q@...278...>
 <2645433.792870.1522082204205@...2084...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <7694eb51-64cb-44ba-4333-280b2cab76f8@...1856...>
Date: Wed, 2 May 2018 20:30:19 +0200
MIME-Version: 1.0
In-Reply-To: <2645433.792870.1522082204205@...2084...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Increase TLS Control Channel Buffer Size
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 26-03-18 18:36, Ning Wei via Openvpn-devel wrote:
> Both of key_method_2_write and key_method_2_read take
> TLS_Channel_Bug_Size as buffer size.  The current size, 2048 is not
> enough to read/write a long password response.  I have notice the
> management interface has a much smaller than 2048 buffer size to
> read/write.  Currently, if the management interface is not used,
> increasing tls channel buffer size will serve the need.
> 
> As token provider, the size of token can be bigger or smaller. 
> Sometime, it has more than 1600 as a token.  To accommodate that, a
> bigger buffer size will be needed.

I don't think this is achieving what you want.  The username/password
size on the OpenVPN protocol are fixed at 128 bytes max, and can not be
changes without introducing a new protocol version or interoperability
problems.  See the USER_PASS_LEN variable used in key_method_2_read.

So, NAK to this patch.

-Steffan


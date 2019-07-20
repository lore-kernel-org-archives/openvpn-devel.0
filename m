References: <20190218153129.3818-1-bengen@...2496...>
 <09cfba8a-d023-c294-9338-8cc664b835a0@...2080...>
 <E1hKg23-0005ZD-6M@...2487...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <3591488f-a227-83f6-1efa-68b092b3a62f@...1856...>
Date: Sat, 20 Jul 2019 12:16:16 +0200
MIME-Version: 1.0
In-Reply-To: <E1hKg23-0005ZD-6M@...2487...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Do not set pkcs11-helper "safe fork
 mode"
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

On 28-04-19 11:23, Steffan Karger wrote:
> Together with the pkcs11-helper fixes, I do think this is the right fix.
> I'll try to experiment a bit with it myself too.

Finally got to some testing and staring at code. The patch resolves the
issue for me, and I didn't find any other issues. Our code seems to be
in good shape to disable safe fork mode as far as I can tell.

I replied to the github thread on
https://github.com/OpenVPN/openvpn/pull/121 with my conclusions:

"The initialization order has been changed around 2015. Since then,
OpenVPN initializes the crypto - including pkcs11 - always after
daemonizing. Any PIN / password is always queried before that point.
Since this patch will only be applied to release/2.4 and master, we're
good in that aspect.

With respect to slot events, I believe we're good too. If I understand
the code correctly (@alonbl, please correct me if I'm wrong), slot
events are only used if someone calls pkcs11h_setSlotEventHook(), which
OpenVPN doesn't do.

Summarizing, unless @alonbl tells me I'm wrong I think this patch is
good and should be merged."

-Steffan


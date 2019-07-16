Date: Tue, 16 Jul 2019 11:34:44 -0400
From: Nathan Stratton Treadway <nathanst@...1517...>
Message-ID: <20190716153444.GG27773@...1518...>
References: <1562069242-29559-1-git-send-email-lstipakov@...277...>
 <1563290085-9219-1-git-send-email-lstipakov@...277...>
MIME-Version: 1.0
In-Reply-To: <1563290085-9219-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v5] Wintun - experimental support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Noticed a typo in a comment:


On Tue, Jul 16, 2019 at 18:14:45 +0300, Lev Stipakov wrote:
> diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
[...]
> +/**
> + * Reads a single packet from wintun buffer.
> + * It is caller's responsibility to advance buffer
> + * over the end padding after processing packet.
> + *
> + * @param c          - The context structure of the VPN tunnel associated with
> + *                     the packet.
> + *
> + * @returns size of packet, 0 of packet cannot be read.

                              "0 if packet"


							Nathan

----------------------------------------------------------------------------
Nathan Stratton Treadway  -  nathanst@...1517...  -  Mid-Atlantic region
Ray Ontko & Co.  -  Software consulting services  -   http://www.ontko.com/
 GPG Key: http://www.ontko.com/~nathanst/gpg_key.txt   ID: 1023D/ECFB6239
 Key fingerprint = 6AD8 485E 20B9 5C71 231C  0C32 15F3 ADCD ECFB 6239


From: Heiko Hund <heiko@...2662...>
Date: Tue, 18 Oct 2022 01:44:50 +0200
Message-ID: <8169211.NyiUUSuA9g@...2664...>
In-Reply-To: <20220909195902.2011798-1-arne@...1227...>
References: <20220909195902.2011798-1-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 1/3] Allows renegotiation only to start
 if session is fully established
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Freitag, 9. September 2022 21:59:00 CEST Arne Schwabe wrote:
> This change makes the state machine more strict in terms of transation

*transitions

> Signed-off-by: Arne Schwabe <arne@...1227...>

Acked-by: Heiko Hund <heiko@...2662...>

For those who wonder what this is/does, my take on it: basically shields the 
calls to key_state_soft_reset() on both the sending and receiving side, and 
ensures both ends have completed the control channel negotiation fully (i.e. 
are in state S_GENERATED_KEYS). At that time pushed options are guaranteed to 
be processed/active, which was the main motivation for this change, as I 
understand it.




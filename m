From: Heiko Hund <heiko@...2662...>
Date: Wed, 14 Sep 2022 17:13:35 +0200
Message-ID: <3221672.44csPzL39Z@...2664...>
In-Reply-To: <20220819123853.111196-1-arne@...1227...>
References: <9aa6d1f8-642f-dd5b-d7cd-ac607f9ee774@...1227...>
 <20220819123853.111196-1-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v3] Implement exit notification via
 control channel
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

On Freitag, 19. August 2022 14:38:53 CEST Arne Schwabe wrote:
> Current exit notification relies on data channel messages with specific
> prefix. Adding these to new data channel modules (DCO) adds unncessary
> complexity for the data for messages that from their idea belong to the
> control channel anyway.
> 
> This patch adds announcing support for control channel and sending/receving
> it. We use the simple EXIT message for this.
> 
> Patch V2: add comment about protocol-flags to be not a user visible option,
>           fix various grammar mistakes, remove unused argument to
>           receive_exit_message
> 
> Patch V3: rename data_channel_crypto_flags to imported_protocol_flags
>           add tls-ekm to protocol-flags.

Hunks #2 and #3 in push.c do not apply to master anymore, thus some rebase 
action is needed. Besides that:

Acked-by: Heiko Hund <heiko@...2662...>




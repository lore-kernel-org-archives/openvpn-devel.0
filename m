Date: Tue, 10 Jan 2023 13:42:25 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y71dMcb+kLwK237+@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
References: <20220909195902.2011798-1-arne@...1227...>
 <20221212112746.1719605-1-arne@...1227...>
 <Y7wsTTgS7oYV0acO@...2685...>
 <8c76e266-6622-0e65-6b7b-f1697c3b2b13@...1227...>
MIME-Version: 1.0
In-Reply-To: <8c76e266-6622-0e65-6b7b-f1697c3b2b13@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v4] Introduce dynamic tls-crypt for
 secure soft_reset/session renegotiation
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Jan 09, 2023 at 05:36:06PM +0100, Arne Schwabe wrote:
> Am 09.01.23 um 16:01 schrieb Frank Lichtenheld:
> > On Mon, Dec 12, 2022 at 12:27:45PM +0100, Arne Schwabe wrote:
> > > Currently we have only one slot for renegotiation of the session/keys.
> > > If a replayed/faked packet is inserted by a malicous attacker, the
> > > legimate peer cannot renegotiate anymore.
> > > 
> > > This commit introduces dynamic tls-crypt. When both peer support this
> > > feature, both peer create a dynamic tls-crypt key using TLS EKM (export key
> > 
> > "peers"
> > 
> > > material) and will enforce using that key and tls-crypt for all
> > > renegotiations. This also add an additional protection layer for
> > 
> > General question about this feature:
> > We trigger using this key on key_id > 0, so if I understand the code
> > correctly, it will be used first when we want to renegotiate.
> > But will it then continued to be used? What exactly is the state after
> > the successful renegotiation?
> 
> That is one of this hidden logic things of OpenVPN again. We ensure that the
> keyid will go to 1 instead 0 on key rollover, so only initial keyids are 0.
> So key-ids for renegotiations will be 1 to 7 and then rollover to 1 instead
> of 0.
> 
> 
>     /*
>      * key_id increments to KEY_ID_MASK then recycles back to 1.
>      * This way you know that if key_id is 0, it is the first key.
>      */
>     ++session->key_id;
>     session->key_id &= P_KEY_ID_MASK;
>     if (!session->key_id)
>     {
>         session->key_id = 1;
>     }

Okay, so it does roughly what I assumed it does. But strictly speaking this
is not a renegotiation key then. Once the first renegotiation happens the key
will be used for ALL control channel packets, is that correct?

So how does that avoid the replay attack? I mean it obviously avoids it for the
first renegotiation, but could you replay the first renegotiation afterwards?
Or does that not work due to increasing key_id/packet_id?

Regards,
-- 
  Frank Lichtenheld


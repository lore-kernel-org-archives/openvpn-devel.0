From: Heiko Hund <heiko@...2662...>
Date: Tue, 11 Oct 2022 15:07:04 +0200
Message-ID: <4195890.Lt9SDvczpP@...2664...>
In-Reply-To: <Yrlr8uhcV0rUMhT6@...2678...>
References: <20220625234150.3398864-1-arne@...1227...>
 <20220625234150.3398864-4-arne@...1227...>
 <Yrlr8uhcV0rUMhT6@...2678...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v3 4/5] Implement a function to
 calculate the default MTU
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

On Montag, 27. Juni 2022 10:36:02 CEST Frank Lichtenheld wrote:
> As mentioned this is true for the specific options configured above.
> But you can easily also get different values out of this function by
> changing the options because frame_calculate_payload overhead does
> not always return the same value.

I don't get it. It produces the same output for the same input reliably. Do 
you want to see a test which forces something different to 1420 by modifying 
the inputs accordingly?

Heiko




MIME-Version: 1.0
In-Reply-To: <CAKuzo_gqnssD6g3bP3o8VWWanALiLHFpAKiMBQB3iyMHNupkNw@...278...>
References: <1465388443-15484-1-git-send-email-steffan@...1856...>
	<1465388443-15484-5-git-send-email-steffan@...1856...>
	<CAKuzo_jskO41boC19osX6tQaVYHio4XFPUyROEWeQuFmuLCf7Q@...278...>
	<CAA1AbxKN5AJAmXjjZxLEkiEsFbCAQTXnjPGB6s7MLrMc1t8KNQ@...278...>
	<CAKuzo_gqnssD6g3bP3o8VWWanALiLHFpAKiMBQB3iyMHNupkNw@...278...>
From: Steffan Karger <steffan@...1856...>
Date: Wed, 8 Jun 2016 18:55:28 +0200
Message-ID: <CAA1AbxKYYyWOowA6+QH_QqPbps738X4CWxCcGvoyzBqwNv8Fdg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 4/5] Add options to restrict cipher
	negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Wed, Jun 8, 2016 at 6:47 PM, Selva Nair <selva.nair@...277...> wrote:
> But, in general, its better to use register signal for setting signals
> inside the context struct. That is, when all that one has is a pointer to a
> context which could be in a multi_instance, or the top context of the server
> or a the context of a client, throw_signal_soft may not be what one wants.

Thanks. register_signal() it is.

-Steffan


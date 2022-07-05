From: Heiko Hund <heiko@...2662...>
Date: Tue, 05 Jul 2022 14:31:59 +0200
Message-ID: <5014411.ky3J9OlI6s@...2664...>
In-Reply-To: <20220624083809.23487-22-a@...2181...>
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-22-a@...2181...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 21/25] do_open_tun: restyle "can
 preserve TUN" check
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

On Freitag, 24. Juni 2022 10:38:05 CEST Antonio Quartulli wrote:
> The current condition checking if the TUN interface was preserved is
> dependant on the platform being Android or not. This makes the code
> reasonably ugly, especially because uncrustify can't indent properly.
> 
> On top of that, we will require an extra condition only for windows+DCO,
> which will make the check even uglier.
> 
> For this reason, factor out the check in a separate function which can
> keep the ifdefs craziness well hidden, while do_open_tun becomes
> (a bit) cleaner.
> 
> Signed-off-by: Antonio Quartulli <a@...2181...>

Looks mighty, but is rather trivial. Two things:

I think the code could benefit from factoring out the call to run_up_down() 
and block_outside_dns into two simple functions. Currently it's pretty much 
duplicated in the if and else branch. Besides that:

Acked-by: Heiko Hund <heiko@...2662...>




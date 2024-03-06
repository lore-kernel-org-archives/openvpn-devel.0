Date: Wed, 6 Mar 2024 12:11:26 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZehPXl3vAKaXSISC@...2685...>
References: <20230830130502.1029-1-sandro.trianni@...277...>
 <ac830908-d0db-0d85-c32f-4f1a67704e1b@...2181...>
 <CAOMrfw+OH6_nMKdSNL3-+OQweyXnx45Jft3PiOGURJmz-fH1pw@...278...>
MIME-Version: 1.0
In-Reply-To: <CAOMrfw+OH6_nMKdSNL3-+OQweyXnx45Jft3PiOGURJmz-fH1pw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Implement server_poll_timeout for socks
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
Content-Disposition: inline
To: Sandro Trianni <sandro.trianni@...277...>
Cc: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

On Wed, Aug 30, 2023 at 10:56:41PM +0200, Sandro Trianni wrote:
> Thanks for your feedback! I'm used to describing my patches in pull
> requests. Submitting it via mailing list was new to me, sorry. I hope this
> reply ends up in the right thread. The patch is regarding this 10 year old
> Bug https://community.openvpn.net/openvpn/ticket/328
> Hardcoded 5 sec timeout is too low for slow proxies, especially over Tor.
> The server-poll-timeout option was supposed to fix it, but was only
> implemented for http proxies.
> Cheers
> 
> On Wed, Aug 30, 2023 at 10:31 PM Antonio Quartulli <a@...2181...> wrote:
> 
> > Hi Sandro,
> >
> > at a first glance the patch looks reasonable.
> > However, we truly need you to write some commit message explaining what
> > your patch is fixing/implementing, why it is doing so and what problem
> > it solves.
> >
> > Cheers,

Hi.

This patch has lingered too long, found it when reviewing the issue
list in Github.

Seems we have a patch and a explanation, now we just need to combine
them. Could you resend the patch with the commit message included?
If you can't do it for whatever reason I can also take care of it
but it would be preferred if the original submitter does it :)

Regards,
-- 
  Frank Lichtenheld


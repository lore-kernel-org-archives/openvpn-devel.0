References: <1514972448-7010-1-git-send-email-steffan.karger@...1435...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <db281ea5-7fe9-af22-2258-d3a89eb1c30f@...1227...>
Date: Wed, 3 Jan 2018 15:02:00 +0100
MIME-Version: 1.0
In-Reply-To: <1514972448-7010-1-git-send-email-steffan.karger@...1435...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH] reliable: remove reliable_unique_retry()
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
To: Steffan Karger <steffan.karger@...1435...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 03.01.18 um 10:40 schrieb Steffan Karger:
> This function has been in the code since 2005, and enabled since 2010, but
> it's not clear why we'd want this behaviour.
> 
> Running some simple tests, where I simulate an server->client link of
> 1mbit with 30ms delay and 1% packet loss, and a client->server link of
> 200kbit, 200ms delay, I get the following connection setup times over
> 100 runs when pushing ~100kb of options (e.g. a lot of routes):
> 
> With reliable_unique_retry:    Mean: 14.9 s, Std dev: 9.1 s
> Without reliable_unique_retry: Mean: 11.8 s, Std dev: 5.8 s
> 
> For more standard push sizes (~1kb), the effect is of course smaller:
> 
> With reliable_unique_retry:    Mean: 2.7 s, Std dev: 0.6 s
> Without reliable_unique_retry: Mean: 2.6 s, Std dev: 0.7 s
> 
> This shows that this mechanism hurts performance under packet loss
> conditions.  (Without packet loss, there are no retransmissions and this
> has no influence, of course.)  Querying the openvpn collective memory
> (read: James, David and Gert) did not yield any arguments to keep it.
> James even mentioned that OpenVPN 3 doesn't include this mechanism.
> 
> So, improve our connection setup performance by removing some code :)
>

Probably coming from an Internet age where connections were modems and
scaling down even to really low speed was a good and standard approach.
TCP for example can scale to to 1 packet per 300s

Arne


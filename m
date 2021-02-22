References: <a32b8037-2e77-ac39-fc2e-05ff6f0c4b97@...1147...>
 <0b595687-c79d-e95e-fc0c-adfe226e15c2@...1227...>
 <3d90ed3d-3ef8-1bc1-141c-3cb63de16a00@...1227...>
 <30b5d0f8-75c0-4d94-da2c-65e7810b4742@...1147...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <ea584106-ff06-6636-7f62-3d5502905e37@...1227...>
Date: Mon, 22 Feb 2021 15:31:47 +0100
MIME-Version: 1.0
In-Reply-To: <30b5d0f8-75c0-4d94-da2c-65e7810b4742@...1147...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] weird issue with server failover when *Not*
 using keepalive
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
To: Jan Just Keijser <janjust@...1147...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> fails with the observed behaviour  if the tcp server does not have
> keepalive se.
> 
> Also, if 'keepalive' is a *requirement* then it should be set
> mandatorily in server mode with sane defaults (like 'keepalive 10 60' ) .
> 
> The original bug still stands:
> 
> If I have a working setup, e.g.  server mode+TCP with no keepalive
> (which makes sense) and on the client side I add a line
>   remote server 1194 udp
> 
> then the *TCP* server config should continue to work instead of
> restarting every 120 seconds, regardless of how I configurd my UDP server.

Btw. coming back to this. Did you have any time to check if my posted
patch set that I posted back then to address problem fixes the problem
for you? (https://patchwork.openvpn.net/project/openvpn2/list/?series=997)

Arne


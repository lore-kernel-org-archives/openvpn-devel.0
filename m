References: <a32b8037-2e77-ac39-fc2e-05ff6f0c4b97@...1147...>
 <0b595687-c79d-e95e-fc0c-adfe226e15c2@...1227...>
 <3d90ed3d-3ef8-1bc1-141c-3cb63de16a00@...1227...>
 <30b5d0f8-75c0-4d94-da2c-65e7810b4742@...1147...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <06fd655a-6b8e-0e01-0ed6-cc1e71e76562@...1227...>
Date: Wed, 9 Dec 2020 13:09:59 +0100
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

Am 09.12.20 um 09:42 schrieb Jan Just Keijser:
> Hi,
> 
> On 04/12/20 16:24, Arne Schwabe wrote:
>>>> If I change the client config to list only a single
>>>>    remote <server> 1194 udp
>>>> line then this reconnect behavior does NOT occur ?!?!?!?
>>>>
>>> This might be a bug in the initialisation order. That the ping timer is
>>> armed before next_connection_entry is called. If you force it reconnect
>>> by restarting server or kill -USR1, does it then also show the
>>> disconnect after 120s behaviour?
>>
>> Following up to myself here. There are probably three problems here
>> mixed together:
>>
>> a) --pull implies --ping-restart and --ping pushed by the server for UDP
>> but the next_connection entry/update currently does not work correctly
>> so it is not working all the time.
> where is this implied in the code? I couldn't find it in the 2.4.9 codebase

The code that you pasted implies that. And the overall design of the
timeouts used in the that p2mp part of openvpn.

>> b) the ping related options are missing in the options_pre_pull, so they
>> also get applied to connections after an UDP setting.
>>
>> c) the warning for keepalive in server mode + UDP should be a lot
>> stronger as the timeout after 120s+UDP is intended behaviour.
>>
> if 'keepalive' is a *requirement* for server mode + UDP but not for
> server mode + TCP then it's still a bug, as a config file with entries
> 
> remote server 1194 udp
> remote server 1194 tcp
> 
> fails with the observed behaviour  if the tcp server does not have
> keepalive se.

See b)
> Also, if 'keepalive' is a *requirement* then it should be set
> mandatorily in server mode with sane defaults (like 'keepalive 10 60' ) .

Yeah, maybe. But what is a sane default?

> The original bug still stands:
> 
> If I have a working setup, e.g.  server mode+TCP with no keepalive
> (which makes sense) and on the client side I add a line
>   remote server 1194 udp
> 
> then the *TCP* server config should continue to work instead of
> restarting every 120 seconds, regardless of how I configurd my UDP server.

yeah b) is a bug that is not fixed at the moment.

Arne


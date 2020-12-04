From: Arne Schwabe <arne@...1227...>
References: <a32b8037-2e77-ac39-fc2e-05ff6f0c4b97@...1147...>
 <0b595687-c79d-e95e-fc0c-adfe226e15c2@...1227...>
Message-ID: <3d90ed3d-3ef8-1bc1-141c-3cb63de16a00@...1227...>
Date: Fri, 4 Dec 2020 16:24:53 +0100
MIME-Version: 1.0
In-Reply-To: <0b595687-c79d-e95e-fc0c-adfe226e15c2@...1227...>
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

>> If I change the client config to list only a single
>>   remote <server> 1194 udp
>> line then this reconnect behavior does NOT occur ?!?!?!?
>>
> This might be a bug in the initialisation order. That the ping timer is
> armed before next_connection_entry is called. If you force it reconnect
> by restarting server or kill -USR1, does it then also show the
> disconnect after 120s behaviour?


Following up to myself here. There are probably three problems here
mixed together:

a) --pull implies --ping-restart and --ping pushed by the server for UDP
but the next_connection entry/update currently does not work correctly
so it is not working all the time.

b) the ping related options are missing in the options_pre_pull, so they
also get applied to connections after an UDP setting.

c) the warning for keepalive in server mode + UDP should be a lot
stronger as the timeout after 120s+UDP is intended behaviour.

Arne


References: <a32b8037-2e77-ac39-fc2e-05ff6f0c4b97@...1147...>
 <0b595687-c79d-e95e-fc0c-adfe226e15c2@...1227...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <6f34b68c-5588-bc0e-65ef-993e044e7cc6@...1147...>
Date: Fri, 4 Dec 2020 16:56:32 +0100
MIME-Version: 1.0
In-Reply-To: <0b595687-c79d-e95e-fc0c-adfe226e15c2@...1227...>
Content-Language: en-US
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
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 04/12/20 15:38, Arne Schwabe wrote:
> Am 04.12.20 um 11:59 schrieb Jan Just Keijser:
>> hey guys,
>>
>> I'm posting this on behalf of the eduVPN team. François Kooman spent a
>> long time debugging an issue and finally managed to find the piece of
>> code that causes the weird behavior.
>> Let me explain:
>>
>> For eduVPN, multiple openvpn instances are offered , both on UDP and TCP
>> ports and the client config that is used lists all of these instances.
>> The client can then do automatic roll-over to a TCP based setup if UDP
>> is not working (blocked) for some reason.
>> Now François had *not* set the keepalive option in the TCP setup, as a
>> TCP connection has a keepalive of its own, more or less and this caused
>> some very odd behaviour:
>>
>> 1) the client tries to connect to a UDP based server; server is
>> down/blocked, hence openvpn does a failover to the next client
>> 2) openvpn connects but after exactly 2 minutes the connection is restarted
>> 3) the reconnects keep happening every 2 minutes suggesting it is a
>> ping-restart/keepalive setting
>>
>> We've tracked this down to the following piece of code, which has been
>> present in the OpenVPN code base since v2.1 (which was the first version
>> to support connection entries). File is init.c, here from v2.4.9:
>>
>>   188 static void
>>   189 update_options_ce_post(struct options *options)
>>   190 {
>>   191 #if P2MP
>>   192     /*
>>   193      * In pull mode, we usually import --ping/--ping-restart
>> parameters from
>>   194      * the server.  However we should also set an initial default
>> --ping-restart
>>   195      * for the period of time before we pull the --ping-restart
>> parameter
>>   196      * from the server.
>>   197      */
>>   198     if (options->pull
>>   199         && options->ping_rec_timeout_action == PING_UNDEF
>>   200         && proto_is_dgram(options->ce.proto))
>>   201     {
>>   202         options->ping_rec_timeout = PRE_PULL_INITIAL_PING_RESTART;
>>   203         options->ping_rec_timeout_action = PING_RESTART;
>>   204     }
>>   205 #endif
>>   206 }
>>
>> When failing over, this function 'update_options_ce_post' is called and
>> for UDP based connections, the ping_rec_timeout is updated.
>> *Why?*
>> Note that ping_rec_timeout is a GLOBAL option and affects all connection
>> entries, both TCP and UDP based. Comment out the call to
>> 'update_options_ce_post' and the restarts are gone.
>> Shall we just comment out/remove this particular piece of code altogether?
> No it still serves a purpose in normal/other setups. It just breaks
> *your* setup. Without this a client can be stuck forever if the
> connection times out after the control channel has been established but
> not received a PUSH_REPLY if my quick analysis here is correct.
No, this happens even without ANY control channel establishment.... if 
that were the case we should change the logic to set a ping-rec timer 
for UDP connections after the control channel has been established (or 
whenever we've received ANY reply from the server). My example shows 
that this timer is set even if the first server never responds at all.
> But the logic of is_dgram and how it is set is strange, I definitively
> grant you that. This might also a bug that got more exposed by my
> removal of the non-connection logic in OpenVPN 2.4. Before OpenVPN 2.4
> we had completely different code paths for profiles containing
> <connection> and profiles without for handling those.
>
This code path is present from 2.1 on, in more or less unaltered form....

JJK

>> JJK
>>
>> PS This leads me to think that perhaps the ping-* options should be made
>> connection-entry specific.  That way, you can have different behavior
>> for TCP based setups and UDP based setups. Also note (see below) that
>> this problem also affect failover from one UDP based server to the next
>> , if --keepalive is disabled, so it's not "just" UDP vs TCP.
> Normally keepalive settings should be by the server since a mismatching
> keepalive between client and server is not a good idea anyway.
yes but like you said, sometimes it may be wise to set keepalive timers 
*before* the connection has been established. Also, with server 
failover, the keepalive timers should be reset from connection entry to 
connection entry.

>> I managed to recreate this setup and I can even get the same odd
>> behaviour in a 100% UDP based setup.
>> Server config:
>> ###############
>> proto udp
>> port 1194
>> dev tun
>> server 10.200.0.0 255.255.255.0
>> dh       dh2048.pem
>> ca       ca.crt
>> cert     server.crt
>> key      server.key
>> persist-key
>> persist-tun
>> topology subnet
>> user  nobody
>> group nobody  # use "group nogroup" on some distros
>> cipher aes-256-cbc
>> auth   sha256
>> ###############
>>
>> (yes, I know the server blurts out
>>    WARNING: --keepalive option is missing from server config
>> on startup)
>>
>> Client config:
>> ###############
>> client
>> remote <server> 1195 udp  ## use a non available port first
>> remote <server> 1194 udp
>> ### remote <server> 1195 tcp
>> dev tun
>> nobind
>> remote-cert-tls server
>> ca       ca.crt
>> cert     client1.crt
>> key      client1.key
>> cipher aes-256-cbc
>> auth   sha256
>> ################
>>
>> So the client first connects to a (non-existent) server, and then fails
>> over to the second entry, and we get a connection. Then, every 2 minutes
>> we get a connection restart.
>>
>> If I change the client config to list only a single
>>    remote <server> 1194 udp
>> line then this reconnect behavior does NOT occur ?!?!?!?
>>
> This might be a bug in the initialisation order. That the ping timer is
> armed before next_connection_entry is called. If you force it reconnect
> by restarting server or kill -USR1, does it then also show the
> disconnect after 120s behaviour?
sent 'kill -USR1' to the client after it connected; it reconnected and 
then 2 minutes later:

WrWrWrWrWrWFri Dec  4 16:51:05 2020 us=720177 [server] Inactivity 
timeout (--ping-restart), restarting

next, restarted the server with the client still connected and waited again:

WrWrWrWrWrWFri Dec  4 16:55:18 2020 us=136090 [server] Inactivity 
timeout (--ping-restart), restarting


so with my example config you end in a state where the client has set 
ping_rec_timeout but the server is not sending any pings and neither a 
cliehnt -USR1 or a server reset fixes it..

JJK


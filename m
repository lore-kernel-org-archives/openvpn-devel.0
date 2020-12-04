From: Jan Just Keijser <janjust@...1147...>
Message-ID: <a32b8037-2e77-ac39-fc2e-05ff6f0c4b97@...1147...>
Date: Fri, 4 Dec 2020 11:59:13 +0100
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------E7A9AC5073E9784288165CE5"
Content-Language: en-US
Subject: [Openvpn-devel] weird issue with server failover when *Not* using
 keepalive
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------E7A9AC5073E9784288165CE5
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

hey guys,

I'm posting this on behalf of the eduVPN team. François Kooman spent a 
long time debugging an issue and finally managed to find the piece of 
code that causes the weird behavior.
Let me explain:

For eduVPN, multiple openvpn instances are offered , both on UDP and TCP 
ports and the client config that is used lists all of these instances. 
The client can then do automatic roll-over to a TCP based setup if UDP 
is not working (blocked) for some reason.
Now François had *not* set the keepalive option in the TCP setup, as a 
TCP connection has a keepalive of its own, more or less and this caused 
some very odd behaviour:

1) the client tries to connect to a UDP based server; server is 
down/blocked, hence openvpn does a failover to the next client
2) openvpn connects but after exactly 2 minutes the connection is restarted
3) the reconnects keep happening every 2 minutes suggesting it is a 
ping-restart/keepalive setting

We've tracked this down to the following piece of code, which has been 
present in the OpenVPN code base since v2.1 (which was the first version 
to support connection entries). File is init.c, here from v2.4.9:

  188 static void
  189 update_options_ce_post(struct options *options)
  190 {
  191 #if P2MP
  192     /*
  193      * In pull mode, we usually import --ping/--ping-restart 
parameters from
  194      * the server.  However we should also set an initial default 
--ping-restart
  195      * for the period of time before we pull the --ping-restart 
parameter
  196      * from the server.
  197      */
  198     if (options->pull
  199         && options->ping_rec_timeout_action == PING_UNDEF
  200         && proto_is_dgram(options->ce.proto))
  201     {
  202         options->ping_rec_timeout = PRE_PULL_INITIAL_PING_RESTART;
  203         options->ping_rec_timeout_action = PING_RESTART;
  204     }
  205 #endif
  206 }

When failing over, this function 'update_options_ce_post' is called and 
for UDP based connections, the ping_rec_timeout is updated.
*Why?*
Note that ping_rec_timeout is a GLOBAL option and affects all connection 
entries, both TCP and UDP based. Comment out the call to 
'update_options_ce_post' and the restarts are gone.
Shall we just comment out/remove this particular piece of code altogether?

JJK

PS This leads me to think that perhaps the ping-* options should be made 
connection-entry specific.  That way, you can have different behavior 
for TCP based setups and UDP based setups. Also note (see below) that 
this problem also affect failover from one UDP based server to the next 
, if --keepalive is disabled, so it's not "just" UDP vs TCP.

-------------------------
For completeness:

I managed to recreate this setup and I can even get the same odd 
behaviour in a 100% UDP based setup.
Server config:
###############
proto udp
port 1194
dev tun
server 10.200.0.0 255.255.255.0
dh       dh2048.pem
ca       ca.crt
cert     server.crt
key      server.key
persist-key
persist-tun
topology subnet
user  nobody
group nobody  # use "group nogroup" on some distros
cipher aes-256-cbc
auth   sha256
###############

(yes, I know the server blurts out
   WARNING: --keepalive option is missing from server config
on startup)

Client config:
###############
client
remote <server> 1195 udp  ## use a non available port first
remote <server> 1194 udp
### remote <server> 1195 tcp
dev tun
nobind
remote-cert-tls server
ca       ca.crt
cert     client1.crt
key      client1.key
cipher aes-256-cbc
auth   sha256
################

So the client first connects to a (non-existent) server, and then fails 
over to the second entry, and we get a connection. Then, every 2 minutes 
we get a connection restart.

If I change the client config to list only a single
   remote <server> 1194 udp
line then this reconnect behavior does NOT occur ?!?!?!?


--------------E7A9AC5073E9784288165CE5
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    hey guys,<br>
    <br>
    I'm posting this on behalf of the eduVPN team. François Kooman spent
    a long time debugging an issue and finally managed to find the piece
    of code that causes the weird behavior. <br>
    Let me explain:<br>
    <br>
    For eduVPN, multiple openvpn instances are offered , both on UDP and
    TCP ports and the client config that is used lists all of these
    instances. The client can then do automatic roll-over to a TCP based
    setup if UDP is not working (blocked) for some reason.<br>
    Now François had *not* set the keepalive option in the TCP setup, as
    a TCP connection has a keepalive of its own, more or less and this
    caused some very odd behaviour:<br>
    <br>
    1) the client tries to connect to a UDP based server; server is
    down/blocked, hence openvpn does a failover to the next client<br>
    2) openvpn connects but after exactly 2 minutes the connection is
    restarted<br>
    3) the reconnects keep happening every 2 minutes suggesting it is a
    ping-restart/keepalive setting <br>
    <br>
    We've tracked this down to the following piece of code, which has
    been present in the OpenVPN code base since v2.1 (which was the
    first version to support connection entries). File is init.c, here
    from v2.4.9:<br>
    <br>
     188 static void
    <br>
     189 update_options_ce_post(struct options *options)
    <br>
     190 {
    <br>
     191 #if P2MP
    <br>
     192     /*
    <br>
     193      * In pull mode, we usually import --ping/--ping-restart
    parameters from
    <br>
     194      * the server.  However we should also set an initial
    default --ping-restart
    <br>
     195      * for the period of time before we pull the --ping-restart
    parameter
    <br>
     196      * from the server.
    <br>
     197      */
    <br>
     198     if (options-&gt;pull
    <br>
     199         &amp;&amp; options-&gt;ping_rec_timeout_action ==
    PING_UNDEF
    <br>
     200         &amp;&amp; proto_is_dgram(options-&gt;ce.proto))
    <br>
     201     {
    <br>
     202         options-&gt;ping_rec_timeout =
    PRE_PULL_INITIAL_PING_RESTART;
    <br>
     203         options-&gt;ping_rec_timeout_action = PING_RESTART;
    <br>
     204     }
    <br>
     205 #endif
    <br>
     206 }
    <br>
    <br>
    When failing over, this function 'update_options_ce_post' is called
    and for UDP based connections, the ping_rec_timeout is updated.<br>
    <b>Why?</b><br>
    Note that ping_rec_timeout is a GLOBAL option and affects all
    connection entries, both TCP and UDP based. Comment out the call to
    'update_options_ce_post' and the restarts are gone.<br>
    Shall we just comment out/remove this particular piece of code
    altogether?<br>
    <br>
    JJK<br>
    <br>
    PS This leads me to think that perhaps the ping-* options should be
    made connection-entry specific.  That way, you can have different
    behavior for TCP based setups and UDP based setups. Also note (see
    below) that this problem also affect failover from one UDP based
    server to the next , if --keepalive is disabled, so it's not "just"
    UDP vs TCP.<br>
    <br>
    -------------------------<br>
    For completeness:<br>
    <br>
    I managed to recreate this setup and I can even get the same odd
    behaviour in a 100% UDP based setup.<br>
    Server config:<br>
    ###############<br>
    proto udp<br>
    port 1194<br>
    dev tun<br>
    server 10.200.0.0 255.255.255.0<br>
    dh       dh2048.pem<br>
    ca       ca.crt<br>
    cert     server.crt<br>
    key      server.key<br>
    persist-key<br>
    persist-tun<br>
    topology subnet<br>
    user  nobody<br>
    group nobody  # use "group nogroup" on some distros<br>
    cipher aes-256-cbc<br>
    auth   sha256<br>
    ###############<br>
    <br>
    (yes, I know the server blurts out <br>
      WARNING: --keepalive option is missing from server config<br>
    on startup)<br>
    <br>
    Client config:<br>
    ###############<br>
    client<br>
    remote &lt;server&gt; 1195 udp  ## use a non available port first<br>
    remote &lt;server&gt; 1194 udp<br>
    ### remote &lt;server&gt; 1195 tcp<br>
    dev tun<br>
    nobind<br>
    remote-cert-tls server<br>
    ca       ca.crt<br>
    cert     client1.crt<br>
    key      client1.key<br>
    cipher aes-256-cbc<br>
    auth   sha256<br>
    ################<br>
    <br>
    So the client first connects to a (non-existent) server, and then
    fails over to the second entry, and we get a connection. Then, every
    2 minutes we get a connection restart.<br>
    <br>
    If I change the client config to list only a single <br>
      remote &lt;server&gt; 1194 udp<br>
    line then this reconnect behavior does NOT occur ?!?!?!?<br>
    <br>
  </body>
</html>

--------------E7A9AC5073E9784288165CE5--


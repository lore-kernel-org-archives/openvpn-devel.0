MIME-Version: 1.0
In-Reply-To: <1450743146-9050-1-git-send-email-fukawi2@...277...>
References: <1450743146-9050-1-git-send-email-fukawi2@...277...>
From: Steffan Karger <steffan@...1856...>
Date: Fri, 25 Dec 2015 10:26:18 +0100
Message-ID: <CAA1Abx+uOPsdvvjOTKFrbfiHM94xHbUDkk5O8yHvR8ty=etMTQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Use bob.example.com and
 alice.example.com to improve clarity of documentation
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
To: Phillip Smith <fukawi2@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Tue, Dec 22, 2015 at 1:12 AM, Phillip Smith <fukawi2@...277...> wrote:
> This patch uses generic "bob.example.com" and "alice.example.com" hostnames to
> replace the current "may" and "june" examples. Generic names chosen rather than
> other names like "server"/"client" or "head-office"/"remote-office" etc which
> may create other unintended or implicit meanings to the reader.
> The example.com domain is set aside defined by IANA for use as documentation
> examples. Refer to: http://www.iana.org/domains/reserved
> Using this well-known domain makes comprehension of documentation easier.
> This patch incorporates feedback from Gert Doering and Selva Nair.
>
> Signed-off-by: Phillip Smith <fukawi2@...277...>
> ---
>  doc/openvpn.8 | 74 +++++++++++++++++++++++++++++------------------------------
>  1 file changed, 37 insertions(+), 37 deletions(-)
>
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 94b5222..368bd4c 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -6601,13 +6601,13 @@ for use with OpenVPN.
>  .SS VPN Address Setup:
>  For purposes
>  of our example, our two machines will be called
> -.B may.kg
> +.B bob.example.com
>  and
> -.B june.kg.
> +.B alice.example.com.
>  If you are constructing a VPN over the internet, then replace
> -.B may.kg
> +.B bob.example.com
>  and
> -.B june.kg
> +.B alice.example.com
>  with the internet hostname or IP address that each machine will use
>  to contact the other over the internet.
>
> @@ -6615,8 +6615,8 @@ Now we will choose the tunnel endpoints.  Tunnel endpoints are
>  private IP addresses that only have meaning in the context of
>  the VPN.  Each machine will use the tunnel endpoint of the other
>  machine to access it over the VPN.  In our example,
> -the tunnel endpoint for may.kg
> -will be 10.4.0.1 and for june.kg, 10.4.0.2.
> +the tunnel endpoint for bob.example.com
> +will be 10.4.0.1 and for alice.example.com, 10.4.0.2.
>
>  Once the VPN is established, you have essentially
>  created a secure alternate path between the two hosts
> @@ -6625,16 +6625,16 @@ control which network
>  traffic passes between the hosts
>  (a) over the VPN or (b) independently of the VPN, by choosing whether to use
>  (a) the VPN endpoint address or (b) the public internet address,
> -to access the remote host. For example if you are on may.kg and you wish to connect to june.kg
> +to access the remote host. For example if you are on bob.example.com and you wish to connect to alice.example.com
>  via
>  .B ssh
>  without using the VPN (since
>  .B ssh
>  has its own built-in security) you would use the command
> -.B ssh june.kg.
> +.B ssh alice.example.com.
>  However in the same scenario, you could also use the command
>  .B telnet 10.4.0.2
> -to create a telnet session with june.kg over the VPN, that would
> +to create a telnet session with alice.example.com over the VPN, that would
>  use the VPN to secure the session rather than
>  .B ssh.
>
> @@ -6649,21 +6649,21 @@ you will get a weird feedback loop.
>  .\"*********************************************************
>  .SS Example 1: A simple tunnel without security
>  .LP
> -On may:
> +On bob:
>  .IP
> -.B openvpn \-\-remote june.kg \-\-dev tun1 \-\-ifconfig 10.4.0.1 10.4.0.2 \-\-verb 9
> +.B openvpn \-\-remote alice.example.com \-\-dev tun1 \-\-ifconfig 10.4.0.1 10.4.0.2 \-\-verb 9
>  .LP
> -On june:
> +On alice:
>  .IP
> -.B openvpn \-\-remote may.kg \-\-dev tun1 \-\-ifconfig 10.4.0.2 10.4.0.1 \-\-verb 9
> +.B openvpn \-\-remote bob.example.com \-\-dev tun1 \-\-ifconfig 10.4.0.2 10.4.0.1 \-\-verb 9
>  .LP
>  Now verify the tunnel is working by pinging across the tunnel.
>  .LP
> -On may:
> +On bob:
>  .IP
>  .B ping 10.4.0.2
>  .LP
> -On june:
> +On alice:
>  .IP
>  .B ping 10.4.0.1
>  .LP
> @@ -6676,7 +6676,7 @@ program.  Omit the
>  option to have OpenVPN run quietly.
>  .\"*********************************************************
>  .SS Example 2: A tunnel with static-key security (i.e. using a pre-shared secret)
> -First build a static key on may.
> +First build a static key on bob.
>  .IP
>  .B openvpn \-\-genkey \-\-secret key
>  .LP
> @@ -6685,39 +6685,39 @@ This command will build a random key file called
>  (in ascii format).
>  Now copy
>  .B key
> -to june over a secure medium such as by
> +to alice over a secure medium such as by
>  using the
>  .BR scp (1)
>  program.
>  .LP
> -On may:
> +On bob:
>  .IP
> -.B openvpn \-\-remote june.kg \-\-dev tun1 \-\-ifconfig 10.4.0.1 10.4.0.2 \-\-verb 5 \-\-secret key
> +.B openvpn \-\-remote alice.example.com \-\-dev tun1 \-\-ifconfig 10.4.0.1 10.4.0.2 \-\-verb 5 \-\-secret key
>  .LP
> -On june:
> +On alice:
>  .IP
> -.B openvpn \-\-remote may.kg \-\-dev tun1 \-\-ifconfig 10.4.0.2 10.4.0.1 \-\-verb 5 \-\-secret key
> +.B openvpn \-\-remote bob.example.com \-\-dev tun1 \-\-ifconfig 10.4.0.2 10.4.0.1 \-\-verb 5 \-\-secret key
>  .LP
>  Now verify the tunnel is working by pinging across the tunnel.
>  .LP
> -On may:
> +On bob:
>  .IP
>  .B ping 10.4.0.2
>  .LP
> -On june:
> +On alice:
>  .IP
>  .B ping 10.4.0.1
>  .\"*********************************************************
>  .SS Example 3: A tunnel with full TLS-based security
>  For this test, we will designate
> -.B may
> +.B bob
>  as the TLS client and
> -.B june
> +.B alice
>  as the TLS server.
>  .I Note that client or server designation only has meaning for the TLS subsystem.  It has no bearing on OpenVPN's peer-to-peer, UDP-based communication model.
>
>  First, build a separate certificate/key pair
> -for both may and june (see above where
> +for both bob and alice (see above where
>  .B \-\-cert
>  is discussed for more info).  Then construct
>  Diffie Hellman parameters (see above where
> @@ -6732,21 +6732,21 @@ client.crt and server.crt.  For Diffie Hellman
>  parameters you can use the included file dh1024.pem.
>  .I Note that all client, server, and certificate authority certificates and keys included in the OpenVPN distribution are totally insecure and should be used for testing only.
>  .LP
> -On may:
> +On bob:
>  .IP
> -.B openvpn \-\-remote june.kg \-\-dev tun1 \-\-ifconfig 10.4.0.1 10.4.0.2 \-\-tls\-client \-\-ca ca.crt \-\-cert client.crt \-\-key client.key \-\-reneg\-sec 60 \-\-verb 5
> +.B openvpn \-\-remote alice.example.com \-\-dev tun1 \-\-ifconfig 10.4.0.1 10.4.0.2 \-\-tls\-client \-\-ca ca.crt \-\-cert client.crt \-\-key client.key \-\-reneg\-sec 60 \-\-verb 5
>  .LP
> -On june:
> +On alice:
>  .IP
> -.B openvpn \-\-remote may.kg \-\-dev tun1 \-\-ifconfig 10.4.0.2 10.4.0.1 \-\-tls\-server \-\-dh dh1024.pem \-\-ca ca.crt \-\-cert server.crt \-\-key server.key \-\-reneg\-sec 60 \-\-verb 5
> +.B openvpn \-\-remote bob.example.com \-\-dev tun1 \-\-ifconfig 10.4.0.2 10.4.0.1 \-\-tls\-server \-\-dh dh1024.pem \-\-ca ca.crt \-\-cert server.crt \-\-key server.key \-\-reneg\-sec 60 \-\-verb 5
>  .LP
>  Now verify the tunnel is working by pinging across the tunnel.
>  .LP
> -On may:
> +On bob:
>  .IP
>  .B ping 10.4.0.2
>  .LP
> -On june:
> +On alice:
>  .IP
>  .B ping 10.4.0.1
>  .LP
> @@ -6766,12 +6766,12 @@ option to use OpenVPN's default key renegotiation interval of one hour.
>  .SS Routing:
>  Assuming you can ping across the tunnel,
>  the next step is to route a real subnet over
> -the secure tunnel.  Suppose that may and june have two network
> +the secure tunnel.  Suppose that bob and alice have two network
>  interfaces each, one connected
>  to the internet, and the other to a private
>  network.  Our goal is to securely connect
> -both private networks.  We will assume that may's private subnet
> -is 10.0.0.0/24 and june's is 10.0.1.0/24.
> +both private networks.  We will assume that bob's private subnet
> +is 10.0.0.0/24 and alice's is 10.0.1.0/24.
>  .LP
>  First, ensure that IP forwarding is enabled on both peers.
>  On Linux, enable routing:
> @@ -6782,11 +6782,11 @@ and enable TUN packet forwarding through the firewall:
>  .IP
>  .B iptables \-A FORWARD \-i tun+ \-j ACCEPT
>  .LP
> -On may:
> +On bob:
>  .IP
>  .B route add \-net 10.0.1.0 netmask 255.255.255.0 gw 10.4.0.2
>  .LP
> -On june:
> +On alice:
>  .IP
>  .B route add \-net 10.0.0.0 netmask 255.255.255.0 gw 10.4.0.1
>  .LP
> --
> 2.6.4

ACK

Thanks for the patch, and for processing our comments.

-Steffan


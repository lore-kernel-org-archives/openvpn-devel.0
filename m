Date: Sat, 24 Jul 2010 21:56:14 +0100
From: Davide Brini <dave_br@...1278...>
Message-ID: <20100724215614.4ebcfee9@...1391...>
In-Reply-To: <4C4B3F41.6090302@...1390...>
References: <4C4B3F41.6090302@...1390...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] features
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Sat, 24 Jul 2010 12:30:09 -0700 Alex T <alex@...1390...> wrote:

> I have 2 suggestions regarding openvpn (client mode):
> - the use of SHA512 with the TLS ciphers

OpenVPN does not implement any encryption; it relies on OpenSSL. So, if
the OpenSSL library used by OpenVPN supports it, so does OpenVPN.

> - some kind of route / firewall manipulation for the Windows client.
> If the client is set up to route all Internet traffic via the VPN,
> sometimes when the internet (especially the wireless connection) is lost,
> all the internet traffic is using the local link, not the VPN ... this
> might become a security issue. I saw a different VPN client (paid
> version, NCP secure IPSEC client is called) that , on startup, if the
> current profile is set to route all traffic via the VPN, manipulates the
> Windows routes , deleting the default gateway and routing only the VPN
> server ip to the local gateway. If the VPN tunnel is not up, then the
> Internet won't work.

If I understand you correctly, you may try pushing

redirect-gateway

instead of

redirect-gateway def1

to the client. The former overwrites the default gateway rather than
creating the two /1 routes.

However, I'm not sure about what happens if the VPN goes down (ie, leave
routing table as it is - which is what you want - or restore old default
gateway?) You can find out quite easily by just trying.

-- 
D.


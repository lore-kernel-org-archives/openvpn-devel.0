From: ValdikSS <valdikss@...277...>
Message-ID: <d0cc2a54-cd65-9ebd-1e6f-8d2b75bfb223@...277...>
Date: Sun, 16 Apr 2017 01:41:32 +0300
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="------------963B036FAD59763CA330521D"
Content-Language: en-GB
Subject: [Openvpn-devel] Windows 10 Creators Update broke --block-outside-dns
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------963B036FAD59763CA330521D
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

I hope this message would finally receive everyone. Sorry for spamming mail list.


Windows 10 Creators Update changed the way DNS works. It used to resolve DNS address using all available adapters and IP addresses in parallel, now it still resolves addresses using all available adapters but in sequence, beginning with random adapter.
This interfere with how --block-outside-dns currently work. Sometimes OS chooses VPN TAP adapter and things work as intended, sometimes the other adapter and user have to wait until DNS request times out and DNS resolution goes via VPN.
This behaviour introduces significant lag for web browsing.

Another thing is that Windows always prefers IPv6, just as any other OS. Some home routers give IPv6 Unique local address with DNS server to the computers using DHCPv6, even if there's no IPv6 connectivity from the provider.

More importantly, DisableSmartNameResolution switch, which didn't work in previous Windows 10 versions, now works correctly.

*Workaround #1*, If VPN infrastructure is IPv6-enabled and pushes IPv6 address and DNS and route to the client:

 1. Apply DisableSmartNameResolution registry patch: https://files.catbox.moe/vng9wm.reg



*Workaround #2*, if VPN infrastructure is not IPv6-enabled:

 1. Apply DisableSmartNameResolution registry patch: https://files.catbox.moe/vng9wm.reg
 2. If there's IPv6 DNS from the router, set static IPv6 DNS to ::2 (alternative to 127.0.0.2 in IPv4) or just disable IPv6 completely on internet interface.



*Workaround #3*, if VPN infrastructure is not IPv6-enabled and client's infrastructure is not IPv6-enabled:

 1. Apply DisableSmartNameResolution registry patch: https://files.catbox.moe/vng9wm.reg
 2. Push IPv6 Unique local address and DNS server to the client, but do not push any routes. Client would use DNS over IPv6 but would not route anything else.

    *Note*: it would route IPv6 traffic over internet interface (not via VPN) if client's ISP is IPv6-enabled.



*Question*: Fixing registry with --block-outside-dns is simple, but what should we do with IPv6 in OpenVPN? Should we introduce an option to disable IPv6 DNS on other interfaces if there's no IPv6 DNS pushed from the VPN?


--------------963B036FAD59763CA330521D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    I hope this message would finally receive everyone. Sorry for
    spamming mail list.<br>
    <br>
    <br>
    Windows 10 Creators Update changed the way DNS works. It used to
    resolve DNS address using all available adapters and IP addresses in
    parallel, now it still resolves addresses using all available
    adapters but in sequence, beginning with random adapter.<br>
    This interfere with how --block-outside-dns currently work.
    Sometimes OS chooses VPN TAP adapter and things work as intended,
    sometimes the other adapter and user have to wait until DNS request
    times out and DNS resolution goes via VPN.<br>
    This behaviour introduces significant lag for web browsing.<br>
    <br>
    Another thing is that Windows always prefers IPv6, just as any other
    OS. Some home routers give IPv6 Unique local address with DNS server
    to the computers using DHCPv6, even if there's no IPv6 connectivity
    from the provider.<br>
    <br>
    More importantly, DisableSmartNameResolution switch, which didn't
    work in previous Windows 10 versions, now works correctly.<br>
    <br>
    <b>Workaround #1</b>, If VPN infrastructure is IPv6-enabled and
    pushes IPv6 address and DNS and route to the client:<br>
    <ol>
      <li>Apply DisableSmartNameResolution registry patch: <a
          class="moz-txt-link-freetext"
          href="https://files.catbox.moe/vng9wm.reg">https://files.catbox.moe/vng9wm.reg</a></li>
    </ol>
    <br>
    <br>
    <b>Workaround #2</b>, if VPN infrastructure is not IPv6-enabled:<br>
    <ol>
      <li>Apply DisableSmartNameResolution registry patch: <a
          class="moz-txt-link-freetext"
          href="https://files.catbox.moe/vng9wm.reg">https://files.catbox.moe/vng9wm.reg</a></li>
      <li>If there's IPv6 DNS from the router, set static IPv6 DNS to
        ::2 (alternative to 127.0.0.2 in IPv4) or just disable IPv6
        completely on internet interface.</li>
    </ol>
    <br>
    <br>
    <b>Workaround #3</b>, if VPN infrastructure is not IPv6-enabled and
    client's infrastructure is not IPv6-enabled:<br>
    <ol>
      <li>Apply DisableSmartNameResolution registry patch: <a
          class="moz-txt-link-freetext"
          href="https://files.catbox.moe/vng9wm.reg">https://files.catbox.moe/vng9wm.reg</a></li>
      <li>Push IPv6 Unique local address and DNS server to the client,
        but do not push any routes. Client would use DNS over IPv6 but
        would not route anything else.<br>
        <br>
        <b>Note</b>: it would route IPv6 traffic over internet interface
        (not via VPN) if client's ISP is IPv6-enabled.</li>
    </ol>
    <br>
    <br>
    <b>Question</b>: Fixing registry with --block-outside-dns is simple,
    but what should we do with IPv6 in OpenVPN? Should we introduce an
    option to disable IPv6 DNS on other interfaces if there's no IPv6
    DNS pushed from the VPN?<br>
    <br>
  </body>
</html>

--------------963B036FAD59763CA330521D--


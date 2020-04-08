From: =?UTF-8?Q?Bruno_Tr=c3=a9guier?= <bruno-sourceforge@...2553...>
Message-ID: <f98cdb16-55ce-b4e6-13de-163c5f352cdf@...2553...>
Date: Wed, 8 Apr 2020 13:23:17 +0200
MIME-Version: 1.0
Content-Language: fr
Subject: [Openvpn-devel] Openvpn3: hardware address of connecting client not
 being reported on Linux ?
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
To: openvpn-devel@lists.sourceforge.net

Hello there,

I've been a long time user of openvpn. Until now I used openvpn 2 as a
client, on my Linux box, and I wanted to switch to openvpn 3, but I've
got a problem with the reported peer info.

More specifically, I'd like the MAC address of the connecting interface
on my client, to be reported to the server.

The relevant source code portion is located in the following file:

openvpn3-core/openvpn/client/cliopt.hpp

And the lines of code are those ones:

      // MAC address
      if (pcc.pushPeerInfo())
        {
          std::string hwaddr = get_hwaddr();
          if (!config.hw_addr_override.empty())
            pi->emplace_back("IV_HWADDR", config.hw_addr_override);
          else if (!hwaddr.empty())
            pi->emplace_back("IV_HWADDR", hwaddr);
          pi->emplace_back ("IV_SSL", get_ssl_library_version());

          if (!config.platform_version.empty())
            pi->emplace_back("IV_PLAT_VER", config.platform_version);
        }


"setenv PUSH_PEER_INFO" is of course defined in my config file. What I
can see on my server is that, for example, IV_SSL is reported, but
IV_PLAT_VER is not (probably because it is empty, but I don't care for
this one), and IV_HWADDR isn't either, which annoys me a little more.
The only reason why it wouldn't be reported seems to be that it cannot
be determined by the call to "get_hwaddr()"...

This function is itself defined in the following file:

openvpn3-core/openvpn/netconf/hwaddr.hpp

But it seems that on a Linux platform, the different #if, #elif and
#endif statements lead to a situation where almost all code is excluded
from compilation, and an empty string is returned at the end of the
function. So in short, nothing seems to be done on the Linux side, and
so the whole thing simply cannot work.

Is my assumption right ? Any clues regarding this ?

Thank very much in advance.

Regards,

Bruno


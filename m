MIME-Version: 1.0
References: <20230105230755.1662053-1-selva.nair@...277...>
 <20230106005438.1664046-1-selva.nair@...277...>
In-Reply-To: <20230106005438.1664046-1-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 6 Jan 2023 13:52:13 +0200
Message-ID: <CAGyAFMVfQHCOMK6Dm733u024vsRLW_G9_E6Y7GajBvTUAfApWg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v4 4/5] Fix signal handling on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

Looks good,

Tested with an unresolvable hostname - I was able to break during
restart pause, unlike before.

2023-01-06 13:49:53 us=46000 SIGUSR1[soft,Could not determine
IPv4/IPv6 protocol] received, process restarting
2023-01-06 13:49:53 us=46000 Restart pause, 16 second(s)
<pressed F4>
C:\Users\lev\Projects\openvpn-build\src\openvpn\ARM64-Output\Debug\openvpn.exe
(process 11476) exited with code 0.

Acked-by: Lev Stipakov <lstipakov@...277...>


References: <20190815072855.21232-1-fkooman@...2318...>
 <aca20c96-e81b-19b7-beec-631e165868f8@...2080...>
From: =?UTF-8?Q?Fran=c3=a7ois_Kooman?= <fkooman@...2318...>
Message-ID: <856f12bf-5507-94c7-fe10-442463d0f500@...2318...>
Date: Thu, 15 Aug 2019 19:23:37 +0200
MIME-Version: 1.0
In-Reply-To: <aca20c96-e81b-19b7-beec-631e165868f8@...2080...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] More specific syslog process name with
 systemd
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
To: David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net

On 15.08.19 14:31, David Sommerseth wrote:
> Could you please provide a rationale to why this is needed?  How things works
> now, is that the systemd-journal picks up everything; including various
> additional meta-data which syslog does not support.

The rationale was that when viewing the log with journalctl you only see
the syslog identifier, i.e. "openvpn" and not the full unit name.

> Now you get the log data with: `journalctl -u openvpn-{client,server}@CONFIG}`
> And this also provides filtering possibilities as well, like '-b' (only log
> entries since last boot) or '--since yesterday'.

That's much better actually, there's also the journalctl -o verbose that
shows the _SYSTEMD_UNIT.

Thanks!

Please ignore the patch!

Cheers,
François


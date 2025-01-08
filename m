Date: Wed, 8 Jan 2025 16:17:45 +0100
From: Ben Boeckel <ben.boeckel@...2851...>
Message-ID: <Z36XGZAHaUkj0tSw@...2852...>
References: <20241231204629.1210040-1-ben.boeckel@...2851...>
 <20241231204629.1210040-2-ben.boeckel@...2851...>
 <0cb90930-1491-41bd-b577-dbf3a44b57a4@...2108...>
MIME-Version: 1.0
In-Reply-To: <0cb90930-1491-41bd-b577-dbf3a44b57a4@...2108...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] console_systemd: remove the timeout
 when using `systemd-ask-password`
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: David Sommerseth <dazo+openvpn@...2108...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, Jan 08, 2025 at 15:59:42 +0100, David Sommerseth wrote:
> Given that the oldest Linux distro with systemd which supports the
> --timeout argument in systemd-ask-password, this can get my ACK.

Thanks. I thought to look at when it was introduced. It has been there
(manpage documentation was added in commit
f3bc7fdc7bf47193a9f8618a7d22a6ceec2df6f7) since 2011, released with
systemd v25. I think we can assume anything using a modern openvpn is
also using something newer than this as well.

--Ben


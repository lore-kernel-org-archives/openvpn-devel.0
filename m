MIME-Version: 1.0
References: <20220813204224.22576-6-a@...2181...>
 <20220813213920.18959-1-a@...2181...>
In-Reply-To: <20220813213920.18959-1-a@...2181...>
From: Lev Stipakov <lstipakov@...277...>
Date: Sun, 14 Aug 2022 11:18:30 +0300
Message-ID: <CAGyAFMX+Xb=XO8jAyjSbD8NrSJ7FnLJEoscL_xPwUf2YHrR5yw@...278...>
Subject: Re: [Openvpn-devel] [PATCH v102 6/7] dco-win: ensure the DCO API is
 not used when running on Windows
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

> On Windows the high level API should still use the link_socket object to
> read and write packets. For this reason, even if dco_installed is true,
> we still need to rely on the classic link_socket object.

This is true.

>
> + *
> + * Windows DCO needs control packets to be sent via the normal
> + * Socket API.

This is a bit confusing IMHO. What does "Socket API" mean here?
To read/write control packets we use what Windows calls "Overlapped I/O",
basically asynchronous IO with Write/ReadFile and events. We do not use
Winsock API, even though the OpenVPN function we use is called
"link_socket_write_win32()".

I would change the above mentioned comment to "normal Overlapped I/O".
Maybe this could be done at commit.

Also, as mentioned in chat, this should be merged before 3/7
("dco-win: implement ovpn-dco support in P2P Windows code path").

Acked-by: Lev Stipakov <lstipakov@...277...>

-Lev


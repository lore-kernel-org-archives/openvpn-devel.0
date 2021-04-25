MIME-Version: 1.0
References: <mailman.44934.1619368532.1299.openvpn-devel@lists.sourceforge.net>
In-Reply-To: <mailman.44934.1619368532.1299.openvpn-devel@lists.sourceforge.net>
From: Christian Nilsson <nikize+ovpn@...277...>
Date: Sun, 25 Apr 2021 18:44:34 +0200
Message-ID: <CAHhAHvhNmyRKYuMA8b2cWgL9MvRbo62QPVh34AZLOyVKfcQ9Jw@...278...>
Subject: [Openvpn-devel] Windows openvpnserv2 default reg values instead of
 crash
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
To: openvpn-devel@lists.sourceforge.net

Hi,

I have been wondering if there is any particular reason that
crashes in openvpnserv2 should be preferred over
having default values if missing from the registry?

Before knowing about proper communication channels for
openvpn development I opened https://github.com/OpenVPN/openvpnserv2/issues/13

There is also code written to change this which I currently use,
and intend to send in as long as there is no good reason for it not to
be included.

Looking forward to any information and feedback on the topic.
Thanks!

/Christian

